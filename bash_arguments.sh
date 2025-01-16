#!/bin/bash

### An example of how to properly implement short/long arguments in a bash script

TEMP=$(getopt -o h --long help,credfile:,domain:,dc: -n "javawrap" -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$TEMP"

IFS='' read -r -d '' HELP <<EOF
USAGE: $0 
    -c|--credfile <credfile>  : credfile, username:password:hash format
                              : password and hash are optional, delims are
                              : not
    -d|--domain <domainfqdn>  : domain in fqdn format
    -D|--dc <dc_ip_or_host>   : dc ip/hostname in fqdn format
    -h|--help                 : this help
EOF

while true; do
    case "$1" in
        -c | --credfile ) credfile="$2"; shift 2 ;;
        -d | --domain ) domain="$2"; shift 2 ;;
        -D | --dc ) dcip="$2"; shift 2 ;; 
        -h | --help ) for item in "${HELP[@]}"; do echo -e "$item"; done; exit ;; 
        *) break ;;
    esac
done

echo -e """
domain=$domain
dc-ip=$dcip
credfile=$credfile
"""