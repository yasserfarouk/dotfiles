#!/bin/sh
d="${1}"
d="${d%/}/"
pyver="${2:-11}"
savedwd="$(pwd)"
cd "${d}" || exit
name=$(basename "${d}")
venvbase="$HOME/myvenvs"
venv="$venvbase/${name:?}"
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
	*)
		python3.11 -m venv "$venv" 1>/dev/null || exit
		;;
esac
source "${venv}/bin/activate" 1>/dev/null
yes | python -m pip install -U pip wheel 1>/dev/null
if [ -f "${d}setup.py" ] || [ -f "${d}pyproject.toml" ] || [ -f "${d}setup.cfg" ] ; then
	pip install -e "${d}" 1>/dev/null
fi
for req in "${d}"requirements*.txt ; do
	yes | python -m pip install -r "${req}" 1>/dev/null
done
for package in scml negmas; do
	if [[ $(pip list | grep ${package}) ]]; then
		echo "------ Replacing ${package} with local version"
		yes | python -m pip uninstall "${package}" 1>/dev/null
		yes | python -m pip install -e "${base}/${package}" 1>/dev/null
	fi
done
deactivate 1>/dev/null
rm -rf "${d}.envrc" 1>/dev/null
echo  "source ${venv}/bin/activate" > "${d}.envrc"
cd "${savedwd}" || exit
