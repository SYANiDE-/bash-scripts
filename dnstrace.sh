#!/bin/bash
recs=($(cat lookup.txt))
function recurse (){
    target=$(echo $1 |grep -E "IN\s+CNAME"|sed -n -e "s/^.*IN.*CNAME[[:space:]]\{0,10\}//p")
    if [[ $(echo $target |wc -c) -gt 0 ]]; then
        lookup $target $2
    fi
}
function lookup (){
    IFS=$'\n' results=($(dig $1 |grep -E "$1\s+(\d+\s+)?IN\s+(A|CNAME)"))
    for item in ${results[@]}; do
        echo $2 $item
        recurse $item "$2#"
    done
}
for rec in ${recs[@]}; do
    pretext=""
    echo -e "\n\n##### $rec #####"
    lookup $rec "$pretext"
done
