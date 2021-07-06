# brew reinstall libffi
# cd /export/home/yasser/.pyenv/plugins/python-build/../.. && git pull && cd -
# yes | pyenv install 3.8.11
# unlink /export/home/yasser/.pyenv/versions/neovim2
# unlink /export/home/yasser/.pyenv/versions/neovim3
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
#yes | pyenv virtualenv 3.8.11 neovim3
mkdir -p ~/virtualenvs
cd ~/virtualenvs
rm -r neovim3
rm -r neovim2
python3 -m venv neovim3
python3 -m venv neovim2
source neovim3/bin/activate
python3 -m pip install -U pip wheel
python3 -m pip install neovim-remote pynvim black isort pylint flake8
source neovim2/bin/activate
python -m pip install -U pip wheel
python -m pip install neovim-remote pynvim black isort pylint flake8
source neovim3/bin/activate
