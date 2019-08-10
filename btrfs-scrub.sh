#!/bin/bash

echo $(date)

btrfs scrub start /mnt/share -BdR

btrfs device stats /mnt/share

echo $(date)

exit 0
