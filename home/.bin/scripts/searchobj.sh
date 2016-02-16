#!/bin/bash
# Search for a string in all source files that have an existing object file.

[[ -z $1 ]] && echo Usage: $0 \<string\> && exit

for i in $(find . -name "*.o"); do
	file=$(echo $i | sed 's/\.o/.c/')
	if [ -f $file ]; then
		count=$(cat $file | grep -c $1)
		[[ $count -ne 0 ]] && echo $file has $count occurrence\(s\).
	fi
done
