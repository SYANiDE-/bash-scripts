#!/bin/bash - 
#===============================================================================
#
#          FILE: banner.sh
# 
#         USAGE: ./banner.sh 
# 
#   DESCRIPTION: Displays inputted word as a shameless ego-glorifying terminal bombing.
# 
#       OPTIONS: First argument to the script is the word that you want to add.
#  REQUIREMENTS: toilet  "apt-get toilet"
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Chase Hatch;  http://www.google.com/+ChaseHatch (), 
#  ORGANIZATION: 
#       CREATED: 02/16/2014 18:32
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
wank=$1
spank='toilet -t -f mono12 -F metal'
clear 
$spank $wank

exit
