#!/bin/bash

# if command : 0 is true, 1 is false

# grep for error codes in btrfs check log
ERRORS=$(grep errs /var/log/btrfs-scrub.log | grep -v 0$)

# if there are no errors, exit script
if [ -z "$ERRORS" ]
then
	exit 0
# if there ARE errors, send them in an email
else
	(
	echo "Subject: ALERT! ERRORS detected in btrfs volume!"
	echo "The following errors were detected:"
	echo " "
	echo $ERRORS
	)	| msmtp email@email.com
	exit 0
fi
