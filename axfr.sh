#!/bin/bash
function usage(){ echo "USAGE: $0 [{ ,subdomain.}domainname.tld]"; exit; }
NARGS=1

if [[ $# -ne $NARGS ]]; then usage; fi

NSs=($(host -t ns $1 |grep -i "name server" | cut -d ' ' -f4 |sed 's/\.$//g'))

if [[ ${#NSs[@]} -eq 0 ]]; then echo "No name servers found for $1." && usage; fi

IFS=$'\n' OUTput=($(for item in ${NSs[@]}; do echo -e "*** *** *** $1 AXFR via $item *** *** ***"; host -l $1 $item; echo -e "\n"; done))

echo "${OUTput[*]}" |grep " has address " | sed 's/\ has\ address\ /:/g' |sort -u > "./$1.subdomains"

for line in "${OUTput[@]}"; do echo $line |sed 's/^\*\*\*.*/\n&/g'; done && echo -e "\n\n[#] Subdomains written to ./$1.subdomains"
