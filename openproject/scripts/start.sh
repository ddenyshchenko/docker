#!/bin/bash
#check first start

STATUSFILE=/home/openproject/first.status

if [ -e $STATUSFILE ]
    then
        su openproject -c /home/openproject/initialize.sh && rm -f $STATUSFILE && /sbin/my_init
    else
        /sbin/my_init
fi
