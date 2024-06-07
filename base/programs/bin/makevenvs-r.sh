#!/bin/bash
base="$HOME/code/projects"
venvbase="$HOME/myvenvs"
mkdir -p "$venvbase"
savedwd="$(pwd)"
for d in "$base"/*/ ; do
	dst=$venvbase/$d
	if [[ -d $dst ]]; then
    echo "Folder ${dst} exists exists .... ignoring it"
else
		echo "Starting for ${name} ----------------------------------"
		makevenv.sh "${d}"
		echo "DONE for ${name} ----------------------------------"
fi
done
cd "${savedwd}" || exit
