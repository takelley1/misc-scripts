#!/bin/bash

echo $(date)

export BORG_REPO=/mnt/backup/borgbackup-repo

borg break-lock /mnt/backup/borgbackup-repo

echo "running borg create"
borg create                         \
    --list                          \
    --verbose                       \
    --stats                         \
    --show-rc                       \
    --compression lz4               \
    --exclude-caches                \
    --exclude '/home/*/.cache/*'    \
    --exclude '/home/*/logfile_storage' \
    --exclude '/root/logfile_storage' \
                                    \
    ::'odroid+share'-$(date +%Y-%m-%d_%H-%M) \
    /mnt/share                      \
    /etc                            \
    /home                           \
    /root                           

echo "running borg prune"
borg prune                          \
    --verbose                       \
    --list                          \
    --debug                         \
    --prefix 'odroid+share'         \
    --show-rc                       \
    --keep-daily    14              \
    --keep-weekly   5               \
    --keep-monthly  10              \
    --keep-yearly   2               

echo "running borg check"
borg check                     \
    --show-rc                  \
    --last 1                   \
    --prefix 'odroid+share'    

echo $(date) 

exit 0
