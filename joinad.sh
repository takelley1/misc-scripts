#!/bin/bash
 
# make sure server isn't joined already
realm leave

 # remove packages in order to start fresh
yum remove chrony ntp ntpdate krb5-workstation realmd oddjob oddjob-mkhomedir sssd samba-common-tools libsss_simpleifp sssd-tools dconf adcli -y

# install packages
yum install chrony ntp ntpdate krb5-workstation realmd oddjob oddjob-mkhomedir sssd samba-common-tools libsss_simpleifp sssd-tools dconf adcli -y

# sync ntp for kerberos
echo "syncing ntp with chrony"
systemctl enable chronyd
systemctl stop chronyd
# remove lines containing original server IPs
sed -i '/^server/d' /etc/chrony.conf
# add new server IPs to chrony config file
echo -e "server ip-of-dns1 iburst maxpoll 10\nserver ip-of-dns2 iburst maxpoll 10\n$(cat /etc/chrony.conf)" > /etc/chrony.conf
systemctl start chronyd

echo "disabling selinux"
setenforce 0

echo "whitelisting firewall ports"
systemctl start firewalld
#ntp
firewall-cmd --zone=public --permanent --add-port 123/udp

#dns
firewall-cmd --zone=public --permanent --add-port 53/tcp
firewall-cmd --zone=public --permanent --add-port 53/udp

#ldap
firewall-cmd --zone=public --permanent --add-port 389/tcp
firewall-cmd --zone=public --permanent --add-port 389/udp

#kerberos
firewall-cmd --zone=public --permanent --add-port 88/udp
firewall-cmd --zone=public --permanent --add-port 88/tcp

#kerberos
firewall-cmd --zone=public --permanent --add-port 464/udp
firewall-cmd --zone=public --permanent --add-port 464/tcp

#ldap global catalog
firewall-cmd --zone=public --permanent --add-port 3268/tcp

# stop firewall
echo "stopping firewall"
systemctl stop firewalld

# allow sssd to authenticate
echo "editing pam"
authconfig --update --enablesssd --enablesssdauth --disableldap --disableldapauth --disablekrb5

# join domain
echo "joining domain"
realm join -U username-here

# edit sssd file to remove requirement for fully qualified names
sed -i '/^use_fully_qualified/d' /etc/sssd/sssd.conf
echo -e "use_fully_qualified_names = False" >> /etc/sssd/sssd.conf

# permit user login
echo "permitting user login"
realm permit --all

# verify
echo "verifying domain"
realm list
echo ""
echo ""
id DOMAIN\\username
echo ""
echo ""
id DOMAIN\\username

echo "giving sudo access to sysadmin users in domain"
echo "%FQDN-of-DOMAIN\\\\groupname ALL=(ALL) ALL" >> /etc/sudoers

# get ip of local host and try to ssh in with ad account
echo "sshing in as domain user"

ssh -l DOMAIN\\username localhost

exit 0

