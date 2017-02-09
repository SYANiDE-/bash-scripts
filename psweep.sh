#!/bin/bash

NARGS=3

if [[ $# -ne $NARGS ]]; then echo -e "Usage: $0 [first 3 octets] [octet 4 start] [octet 4 end]\n"; exit; fi

if [[  $(echo $1 |grep -e "\.$" |wc -l) -eq 1 ]]; then 
    echo -ne "[#] Trying: "
    IPS=($(for i in $(seq $2 $3); do echo -ne "$i, " >&2; ping -c1 -W1 $1$i |grep -B1 "1 received" |grep ping |cut -d ' ' -f 2; done))
else
    echo -ne "[#] Trying: "
    IPS=($(for i in $(seq $2 $3); do echo -ne "$i, " >&2; ping -c1 -W1 $1.$i |grep -B1 "1 received" |grep ping |cut -d ' ' -f 2; done))
fi

:> ./$1.ips

echo -e "\n[#] Uphosts: "${#IPS[@]}"" && for j in "${IPS[@]}"; do echo $j |tee -a ./$1.ips; done && echo "[#] Output saved to ./$1.ips"
