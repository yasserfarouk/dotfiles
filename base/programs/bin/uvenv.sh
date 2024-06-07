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
		uv venv -p 3.8 "$venv" 1>/dev/null || exit
		;;
	"3.9" | "9")
		uv venv -p 3.9 "$venv" 1>/dev/null || exit
		;;
	"3.10" | "10")
		uv venv -p 3.10 "$venv" 1>/dev/null || exit
		;;
	"3.11" | "11")
		uv venv -p 3.11 "$venv" 1>/dev/null || exit
		;;
	"3.12" | "12" | "")
		uv venv -p 3.12 "$venv" 1>/dev/null || exit
		;;
	*)
		uv venv -p "$pyver" "$venv" 1>/dev/null || exit
		;;
esac
source "${venv}/bin/activate" 1>/dev/null
yes | uv pip install -U pip wheel 1>/dev/null
if [ -f "setup.py" ] || [ -f "pyproject.toml" ] || [ -f "setup.cfg" ] ; then
	uv pip install -e . 1>/dev/null
fi
for req in requirements*.txt; do
	if [ -f "${req}" ]; then
		yes | uv pip install -r "${req}" 1>/dev/null
	fi
done
base=$HOME/code/projects
for package in scml negmas; do
	if [[ $(pip list | grep ${package}) ]]; then
		echo "------ Replacing ${package} with local version"
		yes | uv pip uninstall "${package}" 1>/dev/null
		yes | uv pip install -e "${base}/${package}" 1>/dev/null
	fi
done
deactivate 1>/dev/null
rm -rf ".envrc" 1>/dev/null
echo  "source ${venv}/bin/activate" > ".envrc"
cd "${savedwd}" || exit

