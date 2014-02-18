#! /bin/bash
#  logusers.sh

# My first bash script  :)
# This script shows the time and date, lists all logged in users, gives the current 
# system uptime, and then saves the information to a logfile. 
# The most recent modifications to a given file are then displayed via stdout (given it's
# a correct log file).



##### functions!

function stoutput
{
	echo -en "\n"
	date
	who
	uptime
} # end of logtooutput()

function logtofile
{
	if [ "$filename" = "" ]; then
		interactive=1
		response=
		echo "Please enter a filename to log this to (blank for stdout only) >"
		read response
		filename=$response
	fi
	if [ "$filename" = "" ]; then
		echo -en "\n"
		echo "No filename provided, defaulting to stdout only."
		has_displayed=1
		stoutput
	else
		echo -en "\n">>"$filename"
		date 1>>"$filename"
		who 1>>"$filename"
		uptime 1>>"$filename"
		has_written=1
	fi
} # end of logtofile()

function displog
{
	if [ "$filename" = "" ]; then
		interactive=1
		response=
		while [ "$response" = "" ]; do
			echo "Please enter the name of logfile >"
			read response
		done
		filename=$response
	fi
	echo -en "\n"
	tail -3 $filename
	has_displayed=1
} # end of displog()

function usage
{
	echo "Chase Hatch (2014). "
	echo "Handy utility to run date, who, uptime, and log the results (optional)."
	echo "usage: command [[[-f (filename)] [-i] [-h]] ]"
	echo -en "\n"
	echo "		-f | --file"
	echo "			 (declare a filename for output) (optional)"
	echo "		-i | --interactive"
	echo " 			(choose stdout, sdout+log, log, or recent in log>> )"
	echo "		-h | --help "
	echo " 			(help mode; shows these infos you see :)- )"
	echo -en "\n"
	echo "By default, this program will attempt to write to a log file (optional),"
	echo "or just display the requested query. Choose --interactive for more control."
	echo -en "\n"
	echo " --interactive possibilities:"
	echo " You can choose between stdout, stdout+log, log, or most recent in log."
} # end of usage()



#####  main below

interactive=
filename=
has_written=0
has_displayed=0

# handle arguments

while [ "$1" != "" ]; do
	case $1 in 
	-f | --file ) 		shift
				filename=$1
				;;
	-i | --interactive )	interactive=1
				;;
	-h | --help )		usage
				exit
				;;
	* )			usage
				exit 1
	esac
	shift
done # end of handling arguments


# do the work

if [ "$interactive" = "1"  ]; then
	response=
	echo "What would you like to do?"
	echo "	1. (Stdout) 		date, who, uptime.	"
	echo "	2. (Stdout & Log) 	date, who, uptime.	"
	echo "	3. (Log) 		date, who, uptime.	"
	echo "	4. (display last log filing, making NO APPEND)	"
	read response
	case $response in
		1 ) 	stoutput 							;;
		2 ) 	logtofile 
			if [ "$has_written" = "1" ]; then
				echo "Requested info written to file '"$filename"'. "
			fi
			if [ "$has_displayed" != "1" ]; then
				stoutput
			fi 								;;
		3 ) 	logtofile
			if [ "$has_written" = "1" ]; then
				echo "Requested info written to file '"$filename"'. "	
			fi								;;
		4 ) 	displog								;;
		* ) 	echo "Sorry, only options 1-4 allowed... exiting"
			exit 1								;;
	esac
else 	
	if [ "$has_written" != "1" ]; then
		logtofile
	fi
	if [ "$has_displayed" != "1" ]; then
		displog
	fi
fi

