#!/bin/bash

# Sometimes I type parser instead of log-parser, need to comply with that

path="$1"

if [ -z "$path" ]; then
	echo "Usage: $0 <path>"
	exit 1
fi

if [ ! -d "$path" ]; then
	echo "Not a directory!"
	exit 1
fi

echo "Listing files in $path:"
for file in "$path"/*; do
	echo "$file"
done

echo "Path to change parser to log-parser is: $path"
for file in "$path"/*; do
	filename=$(basename "$file")
	if [[ "$filename" == *parser* && "$filename" != *log-parser* ]]; then
		newfilename="${filename/parser/log-parser}"
		echo "Renaming $filename -> $newfilename"
		mv "$path/$filename" "$path/$newfilename"
	fi
done
