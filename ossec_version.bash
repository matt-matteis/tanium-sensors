#!/bin/sh

file='/var/ossec/etc/ossec-init.conf'
if [ -f $file ];
then
        vers=`cat /var/ossec/etc/ossec-init.conf | grep VERSION | cut -d"=" -f 2 | sed 's/"//g'`
        echo ${vers#?}
fi
