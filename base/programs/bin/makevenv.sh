#!/bin/bash
curdir="$(pwd)"
curdir="$(basename "${curdir}")"
mydir="${1:-$curdir}"
mydir="${mydir%/}" # remove trailing dash if any
pyver="${2:-11}"
savedwd="$(pwd)"
if [[  $curdir != $mydir ]]; then
  cd "${mydir}"
fi
name=$(basename "${mydir}")
venvbase="$HOME/myvenvs"
venv="$venvbase/${name:?}"
echo "Creating ${mydir} venv at ${venv}"
mkdir -p "$venvbase"
rm -rf "$venv" 1>/dev/null
case $pyver in
	"3.8" | "8")
		python3.8 -m venv "$venv" 1>/dev/null || exit
		;;
	"3.9" | "9")
		python3.9 -m venv "$venv" 1>/dev/null || exit
		;;
	"3.10" | "10")
		python3.10 -m venv "$venv" 1>/dev/null || exit
		;;
	"3.11" | "11")
		python3.11 -m venv "$venv" 1>/dev/null || exit
		;;
	"3.12" | "12" | "")
		python3.12 -m venv "$venv" 1>/dev/null || exit
		;;
	*)
		python$pyver -m venv "$venv" 1>/dev/null || exit
		;;
esac
source "${venv}/bin/activate" 1>/dev/null
yes | pip install -U pip wheel 1>/dev/null
if [ -f "setup.py" ] || [ -f "pyproject.toml" ] || [ -f "setup.cfg" ] ; then
	pip install -e . 1>/dev/null
fi
for req in requirements*.txt; do
	if [ -f "${req}" ]; then
		yes | pip install -r "${req}" 1>/dev/null
	fi
done
base=$HOME/code/projects
for package in scml negmas; do
	if [[ $(pip list | grep ${package}) ]]; then
		echo "------ Replacing ${package} with local version"
		yes | pip uninstall "${package}" 1>/dev/null
		yes | pip install -e "${base}/${package}" 1>/dev/null
	fi
done
deactivate 1>/dev/null
rm -rf ".envrc" 1>/dev/null
echo  "source ${venv}/bin/activate" > ".envrc"
cd "${savedwd}" || exit

