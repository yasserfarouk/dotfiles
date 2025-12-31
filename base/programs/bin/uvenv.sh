#!/bin/bash
curdir="$(pwd)"
curdir="$(basename "${curdir}")"
mydir="${1:-$curdir}"
mydir="${mydir%/}" # remove trailing dash if any
pyver="${2:-12}"
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
	"3.13" | "13" | "")
		uv venv -p 3.13 "$venv" 1>/dev/null || exit
		;;
	"3.14" | "14" | "")
		uv venv -p 3.14 "$venv" 1>/dev/null || exit
		;;
	*)
		uv venv -p "$pyver" "$venv" 1>/dev/null || exit
		;;
esac
rm -rf ${mydir}/.venv 1>/dev/null
echo "ln -s ${venvbase}/${name} ${mydir}/.venv"
ln -s ${venvbase}/${name} ${mydir}/.venv
# source "${venv}/bin/activate" 1>/dev/null
# yes | uv pip install -U pip wheel 1>/dev/null
# uv sync --all-extras --dev
if [ -f "setup.py" ] || [ -f "pyproject.toml" ] || [ -f "setup.cfg" ] ; then
	# uv pip install -e . 1>/dev/null
	uv sync --all-extras --dev  --active
	# uv pip install -e .
else
	for req in requirements*.txt; do
		if [ -f "${req}" ]; then
			yes | uv pip install -r "${req}" 1>/dev/null
		fi
	done
fi
base=$HOME/code/projects
for package in scml negmas; do
	if [[ $(pip list | grep ${package}) ]]; then
		echo "------ Replacing ${package} with local version"
		yes | uv pip uninstall "${package}"
		yes | uv pip install -e "${base}/${package}"
	fi
done
deactivate 1>/dev/null
rm -rf ".envrc" 1>/dev/null
echo  "source ${venv}/bin/activate" > ".envrc"
cd "${savedwd}" || exit
cd  $mydir
# uv sync
