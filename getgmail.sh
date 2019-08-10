#!/bin/bash

username="x"
password="x"
echo
curl -u $username:$password 'https://mail.google.com/mail/feed/atom' |  grep -oPm1 "(?<=<title>)[^<]+" | sed '1d'

# retrieve gmail, get ips of tor bridges, and output them to a file
#curl -u $username:$password --silent 'https://mail.google.com/mail/feed/atom' |  grep -oPm1 '[^<]++' | grep 'Here are your bridges' | sed 's/ /\n/g' | grep -Eo '^[0-9]*\.*[0-9]*\.*[0-9]*\.*[0-9]*\.*:.*' >> /home/x/msmtp-out.txt && sort -u --output=/home/x/msmtp-out.txt /home/x/msmtp-out.txt
