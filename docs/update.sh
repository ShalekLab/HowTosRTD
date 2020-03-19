#!/bin/bash

if [[ $# -lt 2 ]]; then
	echo Ensure your current location is in the same directory as this script.
	echo As the first argument to this script, please enter the relative path to the git-cloned wiki repo folder.
	echo As the second argument, please enter the relative path to the plain old git-cloned repo folder.
	echo Example: ./update.sh ../../HowTos.wiki/ ../../HowTosRepo/
	echo To git clone the GitHub wiki to your pwd, run the following: git clone https://github.com/ShalekLab/HowTos.wiki.git
	echo Likewise, you can git clone https://github.com/ShalekLab/HowTos.git for the repo itself.
	exit
fi

wiki_repo="${1%/}"
repo="${2%/}"

set -euo pipefail

mkdir -p imgs/

if [[ ! -d $repo ]]; then
	echo ERROR: Relative path to the git-cloned master repo folder was not found. && exit
fi
if [[ ! -d $wiki_repo ]]; then
	echo ERROR: Relative path to the git-cloned wiki repo folder was not found. && exit
fi
if [[ ! -e index.rst ]]; then
	echo ERROR: Could not find index.rst from which to build whitelist
	exit
fi

whitelist=()
in_toc_tree="false"
while IFS='' read -r line; do
	line="$( echo $line | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' )"
	if [[ "$line" == ".. toctree::" ]]; then
		in_toc_tree="true"
	fi
	if [[ "$in_toc_tree" == "true" && ! -z "$line" && "$line" != ".."* && "$line" != ":"* ]]; then
		whitelist+=( $line )
	fi
done < index.rst

echo ---------------------------------------------------------------------------------------
for file in ${wiki_repo}/*.md; do
	
	rtd_doc="$( \
		basename "$file" \
		| tr '[:upper:]' '[:lower:]' \
		| sed -e 's/-/_/g' -e "s/[\(|\)|:|\?|\"|'| ]//g"
	)"	
	if [[ ! ${whitelist[@]} =~ (^| )${rtd_doc%.md}($| ) ]]; then
		echo WARNING: ${rtd_doc%.md} aka $file is not in index.rst! Continuing to next file.
		continue
	else 
		echo $rtd_doc passed for $file
	fi
	
	if [ -e $rtd_doc ]; then
		trash $rtd_doc
	fi

	# If the wiki doc does not have a markdown header1 on the first line, add one
	if [[ "$( head -n 1 $file )" != "# "* ]]; then
		title="$( basename -s .md "$file" | sed -e 's/-/ /g' )"
		printf "# ${title}\n" >> $rtd_doc
	else
		touch $rtd_doc
	fi
done

cp -n $repo/logo.png imgs/
cp -n ./_static/shrug.jpeg imgs/
cp -n ./_static/not_found.md .

GITHUB="https://github.com/ShalekLab/HowTos/blob/master/"
GITHUB_WIKI="https://github.com/ShalekLab/HowTos/wiki/"
for file in ${wiki_repo}/*.md; do
	
	rtd_doc="$( \
		basename "$file" \
		| tr '[:upper:]' '[:lower:]' \
		| sed -e 's/-/_/g' -e "s/[\(|\)|:|\?|\"|'| ]//g"
	)"	
	if [[ ! ${whitelist[@]} =~ (^| )${rtd_doc%.md}($| ) ]]; then
		continue
	fi
	while IFS='' read -r line; do
		# TODO: While exists in line.
		if [[ "$line" == *"["*"](${GITHUB_WIKI}"*")"* ]]; then
			
			article="$( \
				echo $line | sed -E "s@.*${GITHUB_WIKI}([^)]*)).*@\1@" \
				| tr '[:upper:]' '[:lower:]' \
			)"
			article="$( \
				python -c "import urllib.parse, sys; print(urllib.parse.unquote(sys.argv[1]))" $article \
				| sed -e 's/-/_/g' -e "s/[\(|\)|:|\?|\"|'| ]//g" \
			)"
			article_filename="$( echo "$article" | sed -e 's/#.*//' )"
			if [[ ! ${whitelist[@]} =~ (^| )${article_filename}($| ) ]]; then
				article_filename="not_found"
			fi
			if [[ "$article" == *"#"* ]]; then
				article_suffix="$( echo "$article" | sed -e 's/.*#/.html#/' -e 's/_/-/g' )"
				article="${article_filename}${article_suffix}"
			else 
				article="${article_filename}"
			fi
			if [[ ! -e "${article_filename}.md" ]]; then
				echo ---------------------------------------------------------------------------------------
				echo WARNING: Could not find $article_filename in the PWD. Article: $article
				echo Line: $line
				echo Input File: $file
				echo Output File: $rtd_doc
			fi

			line="$( echo $line | perl -pe "s@${GITHUB_WIKI}.*?\)@${article})@" )"
		fi
		# TODO: While exists in line
		if [[ "$line" == *"!["*"](${GITHUB}"*")"* ]]; then
			image="$( echo $line | sed -E "s@.*${GITHUB}([^)]*)).*@\1@")"
			image_path="imgs/$(basename $image)"
			if [[ ! -e ${repo}/$image ]]; then
				echo ---------------------------------------------------------------------------------------
				echo WARNING: Image $image does not exist at ${repo}/$image.
				echo If the name contains spaces, please rename it to not contain spaces.
				echo Line: $line
				echo Input File: $file
				echo Output File: $rtd_doc
			else
				cp "$repo/$image" $image_path
			fi
			line="$( echo $line | perl -pe "s@${GITHUB}.*?\)@${image_path})@")"
		fi
		echo "$line" >> $rtd_doc
	
	done < $file
done
