#!/usr/bin/env bash
# Final setup after setup.sh (or on its own): picks the shell, makes it the login shell, runs the macOS
# defaults on a Mac, then ./qupdate (stow, links, fzf).
# Usage: ./quick-install.sh [--zsh | --bash | --shell=zsh|bash|auto]
#   no option = auto: zsh if installed, else install it when root is available, else bash.
set -u
MYDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/dotfiles-shell.sh
source "$MYDIR/lib/dotfiles-shell.sh"

SHELL_MODE=auto
while [ $# -gt 0 ]; do
    case $1 in
        --shell) SHELL_MODE=${2:-}; shift; parse_shell_arg "--shell=$SHELL_MODE" ;;
        -h|--help) sed -n '2,5p' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
        *) parse_shell_arg "$1" || { echo "Unknown option: $1" >&2; exit 2; } ;;
    esac
    shift
done

export PATH="$HOME/.local/bin:$PATH"

echo "Choosing the shell"
echo "------------------"
choose_shell "$SHELL_MODE" || exit 1
save_shell_choice
set_login_shell || true

# Neovim uses lazy.nvim - plugins auto-install on first run
echo "Neovim uses lazy.nvim - plugins will auto-install on first run"

case "$(uname -s)" in
    Darwin)
        echo "Running macOS defaults"
        "$MYDIR/osx.sh"
        ;;
    Linux)
        echo "Linux ... no macOS defaults"
        ;;
esac

if [ "$DOTFILES_SHELL" = zsh ]; then
    echo "Correcting group permissions for zsh completions"
    zsh -c 'autoload -Uz compaudit && compaudit 2>/dev/null | xargs chmod g-w 2>/dev/null' || true
fi

"$MYDIR/qupdate" --shell="$DOTFILES_SHELL"

echo "------------------------------------------------------------"
echo "                             All done!                      "
echo "Shell: $DOTFILES_SHELL (change with ./quick-install.sh --zsh / --bash)"
echo "Start a new login shell (or log out) to pick everything up."
echo "Change your terminal font to a Nerd Font (e.g. JetBrains Mono)"
echo "------------------------------------------------------------"
exit 0
