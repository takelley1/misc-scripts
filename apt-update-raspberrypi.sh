#!/bin/bash

echo $(date)

# remove 'archive' from regex list so box can pull from repos
sed -i '/archive/d' /etc/pihole/regex.list

# wait for pihole to accept the change
pihole restartdns
sleep 15m

apt autoremove -y

apt update -y

apt upgrade -y

apt dist-upgrade -y

# add the regex back
echo ".*archive.*" >> /etc/pihole/regex.list

pihole restartdns

echo $(date)

exit 0
