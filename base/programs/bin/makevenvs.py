#!/usr/bin/env python3.11
import itertools
import subprocess
import sys
from pathlib import Path

VENVBASE = (Path.home() / ".myvenvs").absolute()
PYTHONCMD = "python3.11"
MYPROJECTBASE = (Path.home() / "code" / "projects").absolute()


def is_python_base(d: Path):
    """
    Checks whether the given folder is the base for a python project
    """
    return d.is_dir() and (
        (d / "setup.cfg").is_file()
        or (d / "setup.py").is_file()
        or (d / "pyproject.toml").is_file()
    )


def make_venv(
    d: Path,
    venv_base: Path = VENVBASE,
    python_cmd: str = PYTHONCMD,
    full_path: bool = False,
) -> Path | None:
    d = d.absolute()
    if full_path:
        relative = d.relative_to(Path.home().absolute())
        path = (venv_base / relative).absolute()
    else:
        path = (venv_base / d.name).absolute()
    if path.exists():
        return None
    try:
        proc = subprocess.run(
            ["mkdir", "-p", str(path.parent)],
            check=True,
            capture_output=True,
            text=True,
            shell=False,
        )
        print(proc.stderr)
    except subprocess.CalledProcessError as e:
        print(f"ERROR in making venv parent dir {str(path.parent)}: {str(e)}")
        return None
    try:
        proc = subprocess.run(
            [python_cmd, "-m", "venv", str(path)],
            check=True,
            capture_output=True,
            text=True,
            shell=False,
        )
        print(proc.stderr)
    except subprocess.CalledProcessError as e:
        print(f"ERROR in creating venv at {str(path)}: {str(e)}")
        return None
    return path


def activate_venv(path: Path, python_cmd: str = PYTHONCMD) -> bool:
    try:
        proc = subprocess.run(
            ["source", str(path / "bin" / "activate")],
            check=True,
            capture_output=True,
            text=True,
            shell=False,
        )
        print(proc.stderr)
    except subprocess.CalledProcessError as e:
        print(f"ERROR in activating venv at {str(path)}: {str(e)}")
        return False
    return True


def prepare_venv(
    src: Path,
    python_cmd: str = PYTHONCMD,
    use_local_packages: bool = True,
    local_packages_base: Path | list[Path] = MYPROJECTBASE,
):
    for f in src.glob("requirements*.txt"):
        print(f"\t[{src.name}] Installing {f.relative_to(src)}", end="", flush=True)
        try:
            proc = subprocess.run(
                [python_cmd, "-m", "pip", "install", "-r", str(f)],
                check=True,
                capture_output=True,
                text=True,
                shell=False,
            )
            print(proc.stderr)
        except subprocess.CalledProcessError as e:
            print(f"\tERROR in pip installing {str(f)}: {str(e)}")
            return False
        print("Done")
    if is_python_base(src):
        print(f"\t[{src.name}] Installing {src.name}", end="", flush=True)
        try:
            proc = subprocess.run(
                [python_cmd, "-m", "pip", "install", "-e", str(src)],
                check=True,
                capture_output=True,
                text=True,
                shell=False,
            )
            print(proc.stderr)
        except subprocess.CalledProcessError as e:
            print(f"\tERROR in pip installing the project at {str(src.name)}: {str(e)}")
            return False
    if use_local_packages:
        if isinstance(local_packages_base, Path):
            packages = zip(
                get_local_packages(local_packages_base),
                itertools.repeat(local_packages_base),
            )
        else:
            packages = []
            for d in local_packages_base:
                packages += zip(get_local_packages(d), itertools.repeat(d))
        for package, path in packages:
            if use_local_package(package, path):
                print(f"\tReplaced {package} with local version under {str(src.name)}")
    return True


def use_local_package(package: str, path: Path, python_cmd: str = PYTHONCMD):
    try:
        proc = subprocess.run(
            [python_cmd, "-m", "pip", "list"],
            check=True,
            capture_output=True,
            text=True,
            shell=False,
        )
        print(proc.stderr)
    except subprocess.CalledProcessError as e:
        print(f"\tERROR in pip listing: {str(e)}")
        return False
    output = proc.stdout.split("\n")
    found = False
    for line in output:
        if package in line and path.name not in line:
            found = True
            break
    if not found:
        return True
    try:
        proc = subprocess.run(
            [python_cmd, "-m", "pip", "uninstall", package],
            check=True,
            capture_output=True,
            text=True,
            shell=False,
        )
        print(proc.stderr)
    except subprocess.CalledProcessError as e:
        print(f"\tERROR in pip uninstalling {package}: {str(e)}")
        return False

    try:
        proc = subprocess.run(
            [python_cmd, "-m", "pip", "install", "-e", str(path / package)],
            check=True,
            capture_output=True,
            text=True,
            shell=False,
        )
        print(proc.stderr)
    except subprocess.CalledProcessError as e:
        print(f"\tERROR in pip installing {package}: {str(e)}")
        return False


def get_local_packages(base: Path = MYPROJECTBASE) -> list[str]:
    base = base.absolute()
    return [_.name for _ in base.glob("*") if is_python_base(_)]

def process(path: Path) -> Path | None:
    venv_path = make_venv(path)
    if venv_path is None:
        return None

    if not activate_venv(path):
        print(f"Activation Failure: {str(venv_path)}")
        return None
    if not prepare_venv(path):
        print(f"Installation Failure: {str(venv_path)}")
        return None
    return venv_path


def main(base: Path):
    base = base.absolute()
    if not base.is_dir():
        print(f"{base} NOT FOUND")
    if is_python_base(base):
        print(f"Working on {str(base)}")
        process(base)
        return
    for path in base.glob("**/*"):
        if not is_python_base(path):
            print(f"Ignoring {str(path)}")
            continue
        print(f"Working on {str(path)}")
        process(path)


if __name__ == "__main__":
    bases = [MYPROJECTBASE]
    if len(sys.argv) > 1:
        bases = [Path(_).absolute() for _ in sys.argv[1:]]
    for base in bases:
        main(base)

