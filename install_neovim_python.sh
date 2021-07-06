# brew reinstall libffi
cd /export/home/yasser/.pyenv/plugins/python-build/../.. && git pull && cd -
yes | pyenv install 3.8.11
unlink /export/home/yasser/.pyenv/versions/neovim2
unlink /export/home/yasser/.pyenv/versions/neovim3
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
yes | pyenv virtualenv 3.8.11 neovim3
pyenv activate neovim3
pip install -U pip wheel
pip install neovim-remote neovim black isort pylint flake8
yes | pyenv virtualenv 3.8.11 neovim2
pyenv activate neovim2
pip install -U pip wheel
pip install neovim-remote neovim black isort pylint flake8
pyenv activate neovim3
