#!/bin/bash

if [[ $? -eq 1 ]]; then
        echo "USAGE: $0 [hex string to prepend hex bytes with "'\x'"]"
        exit
fi


stri="$1"
strlen="${#stri}"

i=0
preamble='\x'

while [[ $(echo $i) -lt $strlen ]] 
do
        echo -n $preamble
        echo -ne "${stri:0:2}"
        stri="${stri:2}"
        let i=(i+2);
done;
echo ""
