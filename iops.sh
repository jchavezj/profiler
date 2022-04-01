#!/bin/sh
echo "+-------------------------------------------------------------------------------------------------------------------+"
echo "|Average:       DEV          tps   rd_sec/s  wr_sec/s  avgrq-sz  avgqu-sz     await     svctm     %util             |"
echo "+-------------------------------------------------------------------------------------------------------------------+"
for file in `ls -tr /var/log/sa/sa* | grep -v sar`
do
dat=`sar -f $file | head -n 1 | awk '{print $4}'`
echo -n $dat
sar -d -f $file  | grep -i Average | sed "s/Average://"
done
echo "+-------------------------------------------------------------------------------------------------------------------+"
