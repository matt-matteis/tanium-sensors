#!/bin/bash

files=$(ls /var/ossec > /dev/null 2>&1)
filesExist=$?

processes=$(ps -ef | grep ossec | grep -v grep)
processesExist=$?

if [[ "$filesExist" == 0 && "$processesExist" == 0 ]]; then
    echo "Installed"
else
    echo "Not Installed"
fi
