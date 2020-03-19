#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo ERROR: Please enter the name of the file you wish to convert.
	echo NOTE: If your input does not work, try including it in quotation marks!
fi

file="${1}"
set -euo pipefail

if [[ ! -e $file ]]; then
	echo WARNING: The file you entered does not exist! Please check the path you inputted.
fi

name="$( \
		basename "$file" \
		| tr '[:upper:]' '[:lower:]' \
		| sed -e 's/-/_/g' -e "s/[\(|\)|:|\?|\"|'| ]//g"
	)"

echo The file produced will be: $name
echo The name you should include in index.rst should be: ${name%.md}