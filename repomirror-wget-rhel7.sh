#!/bin/bash

# use wget to create a local repository mirror on a rhel7 host since reposync is unreliable

# update repos
cd /mirror
wget --recursive --level=100 --no-host-directories --no-parent --timestamp --no-cache --no-cookies --no-dns-cache --inet4-only -o /repolog https://mirror.umd.edu/centos/7/os/
wget --recursive --level=100 --no-host-directories --no-parent --timestamp --no-cache --no-cookies --no-dns-cache --inet4-only -a /repolog https://mirror.umd.edu/centos/7/centosplus/
wget --recursive --level=100 --no-host-directories --no-parent --timestamp --no-cache --no-cookies --no-dns-cache --inet4-only -a /repolog https://mirror.umd.edu/centos/7/extras/
wget --recursive --level=100 --no-host-directories --no-parent --timestamp --no-cache --no-cookies --no-dns-cache --inet4-only -a /repolog https://mirror.umd.edu/centos/7/updates/
wget --recursive --level=100 --no-host-directories --no-parent --timestamp --no-cache --no-cookies --no-dns-cache --inet4-only -a /repolog https://mirror.umd.edu/centos/7/sclo/

wget --recursive --level=100 --no-host-directories --no-parent --timestamp --no-cache --no-cookies --no-dns-cache --inet4-only -a /repolog https://mirror.umd.edu/centos/6/os/
wget --recursive --level=100 --no-host-directories --no-parent --timestamp --no-cache --no-cookies --no-dns-cache --inet4-only -a /repolog https://mirror.umd.edu/centos/6/centosplus/
wget --recursive --level=100 --no-host-directories --no-parent --timestamp --no-cache --no-cookies --no-dns-cache --inet4-only -a /repolog https://mirror.umd.edu/centos/6/extras/
wget --recursive --level=100 --no-host-directories --no-parent --timestamp --no-cache --no-cookies --no-dns-cache --inet4-only -a /repolog https://mirror.umd.edu/centos/6/updates/
wget --recursive --level=100 --no-host-directories --no-parent --timestamp --no-cache --no-cookies --no-dns-cache --inet4-only -a /repolog https://mirror.umd.edu/centos/6/sclo/

# docker repo requires special config
cd /mirror/centos/7/docker
wget --recursive --level=100 --cut-dirs=4 --no-host-directories --no-parent --timestamp --no-cache --no-cookies --no-dns-cache --inet4-only -a /repolog https://download.docker.com/linux/centos/7/x86_64/stable/
sleep 1s
mv /mirror/centos/7/docker/stable /mirror/centos/7/docker/x86_64

# rhel
cd /mirror/rhel/7
reposync --newest-only --delete --downloadcomps --plugins --download-metadata &>> /repolog

# create repos
cd /mirror/centos/7/os/x86_64
createrepo --workers 20 -v /mirror/centos/7/os/x86_64/ &>> /repolog

cd /mirror/centos/7/centosplus/x86_64
createrepo --workers 20 -v /mirror/centos/7/centosplus/x86_64/ &>> /repolog

cd /mirror/centos/7/extras/x86_64
createrepo --workers 20 -v /mirror/centos/7/extras/x86_64/ &>> /repolog

cd /mirror/centos/7/updates/x86_64
createrepo --workers 20 -v /mirror/centos/7/updates/x86_64/ &>> /repolog

cd /mirror/centos/7/sclo/x86_64/rh
createrepo --workers 20 -v /mirror/centos/7/sclo/x86_64/rh/ &>> /repolog

cd /mirror/centos/7/sclo/x86_64/sclo
createrepo --workers 20 -v /mirror/centos/7/sclo/x86_64/sclo/ &>> /repolog

cd /mirror/centos/6/os/x86_64
createrepo --workers 20 -v /mirror/centos/6/os/x86_64/ &>> /repolog

cd /mirror/centos/6/centosplus/x86_64
createrepo --workers 20 -v /mirror/centos/6/centosplus/x86_64/ &>> /repolog

cd /mirror/centos/6/extras/x86_64
createrepo --workers 20 -v /mirror/centos/6/extras/x86_64/ &>> /repolog

cd /mirror/centos/6/updates/x86_64
createrepo --workers 20 -v /mirror/centos/6/updates/x86_64/ &>> /repolog

cd /mirror/centos/6/sclo/x86_64/rh
createrepo ---workers 20 -v /mirror/centos/6/sclo/x86_64/rh/ &>> /repolog

cd /mirror/centos/6/sclo/x86_64/sclo
createrepo --workers 20 -v /mirror/centos/6/sclo/x86_64/sclo/ &>> /repolog

cd /mirror/centos/7/docker/x86_64
createrepo --workers 20 -v /mirror/centos/7/docker/x86_64 &>> /repolog

cd /mirror/rhel/7/rhel-7-server-rpms
createrepo --workers 20 -v /mirror/rhel/7/rhel-7-server-rpms/ &>> /repolog

cd /mirror/rhel/7/rhel-7-server-extras-rpms
createrepo --workers 20 -v /mirror/rhel/7/rhel-7-server-extras-rpms/ &>> /repolog

cd /mirror/rhel/7/rhel-7-server-optional-rpms
createrepo --workers 20 -v /mirror/rhel/7/rhel-7-server-optional-rpms/ &>> /repolog

# get rid of index
rm -f /mirror/centos/7/index.html

# sign repos
gpg --yes --detach-sign --armor /mirror/centos/7/os/x86_64/repodata/repomd.xml
gpg --yes --detach-sign --armor /mirror/centos/7/centosplus/x86_64/repodata/repomd.xml
gpg --yes --detach-sign --armor /mirror/centos/7/extras/x86_64/repodata/repomd.xml
gpg --yes --detach-sign --armor /mirror/centos/7/updates/x86_64/repodata/repomd.xml
gpg --yes --detach-sign --armor /mirror/centos/7/sclo/x86_64/sclo/repodata/repomd.xml
gpg --yes --detach-sign --armor /mirror/centos/7/sclo/x86_64/rh/repodata/repomd.xml

gpg --yes --detach-sign --armor /mirror/centos/6/os/x86_64/repodata/repomd.xml
gpg --yes --detach-sign --armor /mirror/centos/6/centosplus/x86_64/repodata/repomd.xml
gpg --yes --detach-sign --armor /mirror/centos/6/extras/x86_64/repodata/repomd.xml
gpg --yes --detach-sign --armor /mirror/centos/6/updates/x86_64/repodata/repomd.xml
gpg --yes --detach-sign --armor /mirror/centos/6/sclo/x86_64/sclo/repodata/repomd.xml
gpg --yes --detach-sign --armor /mirror/centos/6/sclo/x86_64/rh/repodata/repomd.xml

gpg --yes --detach-sign --armor /mirror/centos/7/docker/x86_64/repodata/repomd.xml

gpg --yes --detach-sign --armor /mirror/rhel/7/rhel-7-server-rpms/repodata/repomd.xml
gpg --yes --detach-sign --armor /mirror/rhel/7/rhel-7-server-optional-rpms/repodata/repomd.xml
gpg --yes --detach-sign --armor /mirror/rhel/7/rhel-7-server-extras-rpms/repodata/repomd.xml

exit 0
