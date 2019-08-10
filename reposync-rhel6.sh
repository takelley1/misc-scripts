#!/bin/bash

# use the reposync utility to create a repo mirror on a rhel6 host
cd /rhel6mirror
reposync --newest-only --delete --downloadcomps --plugins --repoid=rhel-6-server-rpms &>> /repolog
reposync -n -d -m -l -r rhel-6-server-optional-rpms &>> /repolog
reposync -n -d -m -l -r rhel-6-server-extras-rpms &>> /repolog

cd /rhel6mirror/rhel-6-server-rpms
createrepo --verbose --workers 100 /rhel6mirror/rhel-6-server-rpms &>> /reposync.log 

cd /rhel6mirror/rhel-6-server-optional-rpms
createrepo --verbose --workers 20 /rhel6mirror/rhel-6-server-optional-rpms &>> /reposync.log 

cd /rhel6mirror/rhel-6-server-extras-rpms
createrepo --verbose --workers 20 /rhel6mirror/rhel-6-server-extras-rpms &>> /reposync.log 

gpg --yes --detach-sign --armor /rhel6mirror/rhel-6-server-rpms/repodata/repomd.xml
gpg --yes --detach-sign --armor /rhel6mirror/rhel-6-server-extras-rpms/repodata/repomd.xml
gpg --yes --detach-sign --armor /rhel6mirror/rhel-6-server-optional-rpms/repodata/repomd.xml

chown -R apache:apache /rhel6mirror

exit 0
