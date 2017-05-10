#!/bin/bash
# russian_roulette.  Do you feel lucky, punk?

bang=\
""" ______   _______  _        _______  _ 
(  ___ \ (  ___  )( (    /|(  ____ \( )
| (   ) )| (   ) ||  \  ( || (    \/| |
| (__/ / | (___) ||   \ | || |      | |
|  __ (  |  ___  || (\ \) || | ____ | |
| (  \ \ | (   ) || | \   || | \_  )(_)
| )___) )| )   ( || )  \  || (___) | _ 
|/ \___/ |/     \||/    )_)(_______)(_)"""


 let this=$RANDOM%6; if [[ $this -eq 0 ]]; then echo "$bang"; else echo "close call"; fi
