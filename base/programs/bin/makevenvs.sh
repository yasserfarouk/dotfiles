#!/bin/sh

base="$HOME/code/projects"
venvbase="$HOME/myvenvs"
mkdir -p "$venvbase"
savedwd="$(pwd)"
for d in "$base"/*/ ; do
	echo "Starting for ${name} ----------------------------------"
	makevenv.sh "${d}"
	echo "DONE for ${name} ----------------------------------"
done
cd "${savedwd}" || exit
