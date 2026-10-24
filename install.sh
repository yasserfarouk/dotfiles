#!/usr/bin/env bash
# macOS setup. The Brewfile is the source of truth for packages.
# No sudo is used here. The only unavoidable root prompt is the Homebrew
# installer itself (it creates /opt/homebrew) when brew is not installed yet.
# Idempotent: safe to re-run. Does NOT remove packages that are not in the Brewfile.

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$(uname -s)" != "Darwin" ]; then
	echo "install.sh is the macOS installer. Use setup.sh (or linux-setup.sh / wsl-setup.sh) on this platform."
	exit 1
fi

# ----------------------------------------
# Homebrew
# ----------------------------------------
if ! command -v brew >/dev/null 2>&1; then
	for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
		[ -x "$b" ] && eval "$("$b" shellenv)" && break
	done
fi
if ! command -v brew >/dev/null 2>&1; then
	echo "Installing Homebrew (this is the one step that asks for your password)..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	for b in /opt/homebrew/bin/brew /usr/local/bin/brew; do
		[ -x "$b" ] && eval "$("$b" shellenv)" && break
	done
fi

echo "Installing packages from Brewfile (no cleanup: packages not in the Brewfile are left alone)..."
brew bundle --file="$SCRIPT_DIR/Brewfile" || echo "Warning: some Brewfile entries failed (re-run to retry)"

# ----------------------------------------
# Python tooling via uv (user level)
# ----------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# Tools to install via uv tool (replaces pipx)
uv_tool_packages=(
	"asciinema"
	"autoflake"
	"black"
	"cookiecutter"
	"copier"
	"doq"
	"isort"
	"pip-tools"
	"pre-commit"
	"proselint"
	"tiptop"
	"typer"
	"tox"
	"removestar"
	"pygments"
	"typer-cli"
	"ruff"
	"neovim-remote"
)
neovim_python_packages=(
	"neovim"
	"flake8"
)

echo "Installing uv tool packages"
echo "---------------------------"
installed_uv_tools="$(uv tool list 2>/dev/null || true)"
for i in "${uv_tool_packages[@]}"; do
	if printf '%s\n' "$installed_uv_tools" | grep -q "^$i "; then
		echo "  $i already installed"
	else
		uv tool install "$i" || echo "Warning: Failed to install $i"
	fi
done

echo "Setting up neovim2/3 python envs using uv"
echo "-----------------------------------------"
uv python install 3.12
for venv in neovim2 neovim3; do
	dir="$HOME/.local/share/uv/venvs/$venv"
	[ -x "$dir/bin/python" ] || uv venv "$dir" --python 3.12
	uv pip install --python "$dir/bin/python" -U "${neovim_python_packages[@]}"
done
uv pip install --python "$HOME/.local/share/uv/venvs/neovim3/bin/python" -U neovim-remote

# ----------------------------------------
# Node globals (node comes from brew, so the prefix is user-writable)
# ----------------------------------------
echo "Installing npm global packages"
echo "------------------------------"
# NOTE: real package names. (@anthropic/opencode does not exist; opencode is also in the Brewfile.)
npm_packages=(
	"neovim"
	"write-good"
	"tree-sitter-cli"
	"@anthropic-ai/claude-code"
)
for p in "${npm_packages[@]}"; do
	npm ls -g --depth=0 "$p" >/dev/null 2>&1 || npm install -g "$p" || echo "Warning: Failed to install $p"
done
command -v opencode >/dev/null 2>&1 || npm install -g opencode-ai || echo "Warning: Failed to install opencode"

echo "Installing neovim ruby provider"
gem list -i neovim >/dev/null 2>&1 || gem install --user-install neovim || echo "Warning: Failed to install neovim gem"

# ----------------------------------------
# Shell / tmux extras
# ----------------------------------------
echo "Installing tmux plugin manager (tpm)"
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
	git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
	echo "  tpm already installed"
fi
# Plugins listed in ~/.tmux.conf are fetched once the config is stowed:
#   ~/.tmux/plugins/tpm/bin/install_plugins   (or prefix + I inside tmux)

echo "Installing fzf key bindings / completion (does not touch your rc files)"
yes | "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc >/dev/null 2>&1 || true

echo "Installing antigen for zsh"
if [ ! -f "$HOME/antigen.zsh" ]; then
	curl -fsSL https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh -o "$HOME/antigen.zsh" \
		|| echo "Warning: Failed to download antigen"
fi

echo "Installing vim-plug for vim"
[ -f "$HOME/.vim/autoload/plug.vim" ] || curl -fsSLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || true

echo "Making nvim-in-kitty the default app for Markdown / text / LaTeX / CSV / source files"
"$(dirname "$0")/base/programs/bin/nvimkitty" install || echo "Warning: nvimkitty install failed"

echo "Making Preview the default app for PDFs"
command -v duti >/dev/null 2>&1 && duti -s com.apple.Preview com.adobe.pdf all || echo "Warning: could not set Preview for PDFs"

if [ -d "/Applications/Alfred 5.app" ]; then
	echo "Alfred: yazi / tmux / send-to file actions, note / proj / new / sendto / dl / shot keywords, kitty as terminal"
	"$(dirname "$0")/base/programs/bin/alfred-kitty" install || echo "Warning: alfred-kitty install failed"
fi

# Fonts come from the Brewfile casks (font-hack-nerd-font, font-jetbrains-mono-nerd-font, ...)

echo "----------------------"
echo "Installed prerequisites"
echo "----------------------"
echo "Next: run ./setup.sh (stow + git hooks) or ./quick-install.sh"
echo "Manual: install a LaTeX distribution (e.g. brew install --cask basictex) if you need latexmk."
