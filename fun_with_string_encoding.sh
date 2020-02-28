#!/bin/bash

this=$(echo "$1" |xxd -p |tr -d '\n' |base64 - |tr -d '\n' | xxd -c 1 -g 1 |cut -d ' ' -f 2 |tr "\n" ' ' |sed -re 's/^.*/ &/g'  -e 's/ /\\x/g' -e 's/\\x$//g')


echo '''
echo -ne "'''$this'''" |base64 -d |xxd -r -p
'''
