#!/bin/bash - 
#===============================================================================
#
#          FILE: nocomments.sh
# 
#         USAGE: ./nocomments.sh 
# 
#   DESCRIPTION: This spanks (takes file input) all the comments out of a wank (into another file).
# 
#       OPTIONS: ---
#  REQUIREMENTS: At least one file as input that you'd like to spank all the comments out of.
#          BUGS: ---
#         NOTES: Please don't criticize my commenting &&/|| naming conventions. :)
#        AUTHOR: Chase Hatch;  http://www.google.com/+ChaseHatch (), 
#  ORGANIZATION: 
#       CREATED: 02/16/2014 20:12
#      REVISION: 14 	02/17/2014 10:26
#===============================================================================

##### I take no responsibility for what you might read in here... #####
#  You need to enter mandatorily a filename on invoke as first arg,
# and optionally a second file as second arg for stdout>>file.
#  Usage:  ./nocomments.sh file1 file2


# Variables:
spank=$1
wank=$2





# Functions
function echovar1 {
	echo -ne 
	echo Using COMMAND: 
	# First: Nulls all ^comment lines.  
	# Second: Nulls all comment lines that start with a tab.
	# Third: Removes tailing in-line comments. 
	# Fourth: Removes null lines.
	echo "sed "
	echo "	-e '/^#/,$ s/^#.*//'"
	echo "	-e 's/# [a-zA-Z1-9].*//'"
	echo "	-e 's/\t# ?[a-zA-Z1-9].*//'" 
	echo "	-e '/^$/ d'" 
	echo "<""$spank"
}

function echovar2 {
	echo -ne 
	echo -ne "\n" "PRINTING TO FILE: $wank" "\n" "\n"
	echo using command 
	# First: Nulls all ^comment lines.  
	# Second: Nulls all comment lines that start with a tab.
	# Third: Removes tailing in-line comments. 
	# Fourth: Removes null lines.
	echo "sed "
	echo "	-e '/^#/,$ s/^#.*//'"
	echo "	-e 's/# [a-zA-Z1-9].*//'"
	echo "	-e 's/\t# ?[a-zA-Z1-9].*//'" 
	echo "	-e '/^$/ d'" 
	echo "<""$spank" ">>""$wank"
}

function thesed1 {
	sed -e ' {
		/^#/,$ s/^#.*//
		s/\t# [a-zA-Z1-9].*//
		s/# ?[a-zA-Z1-9].*//
		/^$/ d
	} ' $spank |more
}

function thesed2 {
	sed -e ' {
		/^#/,$ s/^#.*// 
		s/\t# [a-zA-Z1-9].*// 
		s/# ?[a-zA-Z1-9].*//
		/^$/ d 
	} ' $spank | cat >>$wank
}





# Spank the wank if there's a wank to spank, else just spank, or even worse, ERROR:
# (You can't really expect to run this without something to spank, can you?)
if   [ "$wank" != "" ]; then
	echovar2
	thesed2
	echo -ne "\n""Additionally, here's what was printed to" "$wank"":" "\n" 
	thesed1
	exit 0
elif [ "$spank" != "" ]; then
	echovar1
	echo -ne "\n" "\n" "OUTPUT:" "\n" "\n"
	thesed1
	exit 0
else 
	echo "ERROR!!!!!  You need to enter at least one filename on invoke, "
	echo "and optionally a second if you'd like to print results to a file.  	Exiting..."
	exit 1
fi
exit 0

