#!/bin/bash

echo $(date)

apt autoremove -y

apt update

apt upgrade -y

apt dist-upgrade -y

echo $(date) 

exit 0
