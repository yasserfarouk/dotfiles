#!/bin/bash
# Usage: uvenv.sh [project-dir] [python-version]
# Creates a venv at ~/myvenvs/<project-name>, symlinks it to <project-dir>/.venv,
# installs the project into it and writes an .envrc that activates it.
curdir="$(pwd)"
curdir="$(basename "${curdir}")"
mydir="${1:-$curdir}"
mydir="${mydir%/}" # remove trailing slash if any
pyver="${2:-12}"
savedwd="$(pwd)"
if [[ $curdir != "$mydir" ]]; then
	cd "${mydir}" || exit
fi
# Absolute project path, valid whether mydir was relative, absolute, or the cwd's own name.
projdir="$(pwd)"
name=$(basename "${projdir}")
venvbase="$HOME/myvenvs"
venv="$venvbase/${name:?}"
echo "Creating ${projdir} venv at ${venv}"
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
	"3.13" | "13")
		uv venv -p 3.13 "$venv" 1>/dev/null || exit
		;;
	"3.14" | "14")
		uv venv -p 3.14 "$venv" 1>/dev/null || exit
		;;
	*)
		uv venv -p "$pyver" "$venv" 1>/dev/null || exit
		;;
esac
rm -rf "${projdir}/.venv" 1>/dev/null
echo "ln -s ${venv} ${projdir}/.venv"
ln -s "${venv}" "${projdir}/.venv" || exit
export VIRTUAL_ENV="$venv"
if [ -f "setup.py" ] || [ -f "pyproject.toml" ] || [ -f "setup.cfg" ]; then
	uv sync --all-extras --dev --active
else
	for req in requirements*.txt; do
		if [ -f "${req}" ]; then
			uv pip install --python "$venv" -r "${req}" 1>/dev/null
		fi
	done
fi
base=$HOME/code/projects
for package in scml negmas; do
	if uv pip list --python "$venv" 2>/dev/null | grep -qi "^${package} "; then
		echo "------ Replacing ${package} with local version"
		uv pip uninstall --python "$venv" "${package}"
		uv pip install --python "$venv" -e "${base}/${package}"
	fi
done
rm -rf "${projdir}/.envrc" 1>/dev/null
# Uses use_venv from the global direnvrc when present, else checks itself.
cat >"${projdir}/.envrc" <<EOF
if type use_venv >/dev/null 2>&1; then
	use_venv ${venv}
else
	watch_file ${venv}/bin/activate
	if [ -f ${venv}/bin/activate ]; then source ${venv}/bin/activate; fi
fi
EOF
cd "${savedwd}" || exit
