#!/bin/bash

# this is a script that aids in updating blacklists for the pihole
# dns blocking utility

# cleanup leftovers from previous run
rm -rf /root/blacklist-script/*
mkdir /root/blacklist-script/mesd /root/blacklist-script/shalla
echo $(date)

# download and extract mesd blacklist
cd /root/blacklist-script/mesd
wget -nv squidguard.mesd.k12.or.us/blacklists.tgz
tar xzvf blacklists.tgz

# pipe relevant blacklisted domains into a single master list
echo "running cat commands on mesd blacklist"
cat ./blacklists/ads/domains >> ../myblauto
cat ./blacklists/aggressive/domains >> ../myblauto
cat ./blacklists/porn/domains >> ../myblauto
cat ./blacklists/proxy/domains >> ../myblauto
cat ./blacklists/spyware/domains >> ../myblauto
cat ./blacklists/redirector/domains >> ../myblauto
cat ./blacklists/suspect/domains >> ../myblauto
cat ./blacklists/violence/domains >> ../myblauto
cat ./blacklists/warez/domains >> ../myblauto

# do the same thing for the shalla blacklist
cd /root/blacklist-script/shalla
wget -nv www.shallalist.de/Downloads/shallalist.tar.gz 
tar xzvf shallalist.tar.gz

echo "running cat commands on shall blacklist"
cat ./BL/adv/domains >> ../myblauto
cat ./BL/aggressive/domains >> ../myblauto
cat ./BL/anonvpn/domains >> ../myblauto
cat ./BL/costtraps/domains >> ../myblauto
cat ./BL/dynamic/domains >> ../myblauto
cat ./BL/models/domains >> ../myblauto
cat ./BL/porn/domains >> ../myblauto
cat ./BL/sex/lingerie/domains >> ../myblauto
cat ./BL/spyware/domains >> ../myblauto
cat ./BL/tracker/domains >> ../myblauto
cat ./BL/violence/domains >> ../myblauto
cat ./BL/warez/domains >> ../myblauto

# now the french lists
echo "running cat commands on french blacklist"
cd /root/blacklist-script
wget -nv ftp://ftp.ut-capitole.fr/pub/reseau/cache/squidguard_contrib/redirector.tar.gz
tar xzvf redirector.tar.gz
cat ./redirector/domains >> ./myblauto

wget -nv ftp://ftp.ut-capitole.fr/pub/reseau/cache/squidguard_contrib/malware.tar.gz
tar xzvf malware.tar.gz
cat ./phishing/domains >> ./myblauto

wget -nv ftp://ftp.ut-capitole.fr/pub/reseau/cache/squidguard_contrib/adult.tar.gz
tar xzvf adult.tar.gz
cat ./adult/domains >> ./myblauto

cd /root/blacklist-script

# create a duplicate blacklist with 'www' before each domain
echo "sed 's/^/www./' ./myblauto > ./myblautowww"
sed 's/^/www./' ./myblauto > ./myblautowww

# copy blacklist into proper location and update pihole
echo "cp ./myblauto ./myblautowww -t /var/www/html/admin/blacklists"
cp ./myblauto ./myblautowww -t /var/www/html/admin/blacklists

# restart pihole
pihole -g

# cleanup
rm -rf /root/blacklist-script/*

echo $(date) 

exit 0
