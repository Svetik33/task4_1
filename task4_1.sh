#!/bin/bash

exec 1> "$(pwd)"/task4_1.out

echo --- Hardware ---
echo CPU: $(sed -n 's/^model name[ \t]*: *//p' /proc/cpuinfo)
echo RAM: $(sed -n 's/^MemTotal[ \t]*: *//p' /proc/meminfo)
echo Motherboard: $(dmidecode -s baseboard-manufacturer) $(dmidecode -s baseboard-product-name || echo 'Unknown')
echo System Serial Number: $(dmidecode -s system-serial-number || echo 'Unknown')
echo --- System ---
echo OS Distribution: $( lsb_release -ds )
echo Kernel version: $( uname -r )
echo "Installation date:" $(ls -lact --full-time /etc |awk 'END {print $6}')
echo Hostname: $(hostname -f)
echo Uptime: $(uptime -p |  cut -d 'p' -f 2)
echo Processes running: $( ps -A | wc -l )
echo User logged in: $( who | wc -l )
echo --- Network ---
for var in $(cat /proc/net/dev | awk -F : '{if (NR>2) print $1}')
do 
	echo $var ":" $(ip -o -4 addr list $var | awk '{print $4}')
done