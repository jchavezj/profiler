#!/bin/bash
#
# Obtains Average CPU/Memory Utilization History from sysstat(sar) file in /var/log/sa/*
# Author: Johnny Chavez


for file in $(ls -la /var/log/sa/* | grep sa[0-9] | awk '{print $9}')
do
	# print sar header
        sar -f $file | head -n 1
        printf "\n"

        # Get CPU idle average .

        printf "%b" "\e[1;31mCPU average: \e[0m"
        sar -u -f $file | grep Average: | awk -F " " '{sum = (100 - $8) } END { print sum "%" }'

        # Get Average Memory utilization

        # This is the formula used to calculate memory to be a little more precise
        # Formula:
        # (kbmemused-kbbuffers-kbcached) / (kbmemfree + kbmemused) * 100
        # The reason behind this is Linux treats unused memory as a wasted resource and so uses as
        # much RAM as it can to cache process/kernel information

        printf "%b" "\e[1;31mMemory Average: \e[0m"
        sar -r -f $file | grep Average | awk -F " " '{ sum = ($3-$5-$6)/($2+$3) * 100   } END { print sum "%" }'

        printf "\n"
done
