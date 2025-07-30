#!/bin/bash

for file in *.yml;
	do
		# SO I want to change .yml to yaml
		# I will split name into two parts up to .yml
		# change second part to yaml and weld together
		[ "$file" = "*.yml" ] && continue

		newfilename="${file%.yml}.yaml"

		if [ -e "$newfilename" ]; then
			echo "$newfilename already exists, not overwriting"
		fi

		mv $file $newfilename
	done
