#!/bin/bash

# Checking if we have 3 arguments
if [ "$#" -ne 3 ]; then
	echo "Usage: $0 <file> <string_to_replace> <replacement_value>"
	exit 1
fi

# ok, so we need the outputs.tf file location
foutput=$1
str_to_replace=$2
rep_val=$3

if [ ! -f $foutput ]; then
echo "File doesn't exist...exiting."
exit 1
fi

# ok, we need to look now for str_to_replace and replace with rep_val
#gawk -i inplace -v INPLACE_SUFFIX=.bak -v s="$str_to_replace" -v r="$rep_val" '{ gsub(s, r); print }' "$foutput"

# With sed
#sed -i.bak "s#$str_to_replace#$rep_val#g" "$foutput"

# With awk
awk -v s="$str_to_replace" -v r="$rep_val" '{ gsub(s, r); print}' "$foutput" > tmp && mv tmp outputs.tf



