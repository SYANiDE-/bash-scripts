#!/bin/bash
if [[ -z $4 ]]; then
    echo "USAGE:  $0 IP SID srange erange"
    echo -e "\n RPC SID cycling (enumerate users).  Give a base SID such as 'lookupnames root Administrator' might give, a start range, an end range."
    echo -e"\nBe aware, whole range queried in one go for speed.  Reasonably, do range in increments of about 100 at a time.  Any NT_* errors, your underlying query is TOO BIG.  Narrow the range."
    exit 1
fi


IP=$1
THIS="${2%-*}"-
progname=$0
srange=$3
erange=$4
RANGED=($(for i in $(seq $srange $erange); do echo "$THIS$i,"; done))
RANGED2=($(echo ${RANGED[@]:0:${#RANGED[@]}-1} ${RANGED[-1]%,}))  ### recreate array removing comma from last element.


### Do each in range one at a time...
# for i in "${RANGED2[@]}"; do rpcclient $IP -U "" -N -c "lookupsids ${i[@]%,}"; done

### OR do whole range in one go
rpcclient $IP -U "" -N -c "lookupsids $(echo ${RANGED2[@]})" |grep -v "_" |grep -v "(4)" |tee -a $IP.${progname[@]#./}.raw |cut -d ' ' -f 2 |tee -a $IP.${progname[@]#./}.users
