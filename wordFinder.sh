#!/bin/bash
d='pwd'
array=($@)
numOfEle=${#array[@]}
erorrnum=0
re='?[0-9a-zA-Z.]'
files=$(( $numOfEle - 2 ))

if [ $numOfEle -ge 3 ];
then

		
	if [[ "${array[$numOfEle-2]}" =~ $re  || "${#array[$numOfEle-2]}" -gt 1 ]]; then
		>&2 echo "Only one char needed : ${array[$numOfEle-2]}"
		erorrnum=1

	fi
	
	if [[ "${array[$numOfEle-1]} " -le 0 ]]; then
		>&2 echo "Not a positive number : ${array[$numOfEle-1]}"
		erorrnum=1
			
	fi
		if (($erorrnum !=0)); then 
		echo "Usage : wordFinder.sh <valid file name> [More Files] ... <char> <length>"
		exit 
	fi
	
	for ((i=0; i< $files ;i++)) ; do
		if [[ ! -e "${array[i]}" || ! -f "${array[i]}" ]]; then 
			>&2 echo "File does not exist : "${array[i]}
			erorrnum=1
		fi
	done
	if (($erorrnum !=0)); then 
		echo "Usage : wordFinder.sh <valid file name> [More Files] ... <char> <length>"
		exit 
	fi
char=${array[$numOfEle-2]}
len=$(( ${array[$numOfEle-1]} - 1 ))
	for ((i=0; i< $files ;i++)) ; do
		cat ${array[i]} >> total.txt

	done
	cat total.txt |tr ' ' '\n'|tr "'" ' '|tr '[:punct:][ ]' '\n'|tr "A-Z" "a-z"|grep -i "\b$char.\{$len\}"|sort|uniq -c|sort -n
	rm total.txt
else
	>&2 echo "Number of parameters received : $numOfEle"
	echo "Usage : wordFinder.sh <valid file name> [More Files] ... <char> <length>"
	exit 
fi

