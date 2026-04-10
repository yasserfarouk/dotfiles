#!/usr/bin/env zsh
echo "Updating init files with replacements"
echo "-------------------------------------"
export PATH="$HOME/.local/bin:$PATH"
# uv venvs are automatically available, no init needed

# Neovim uses lazy.nvim - plugins auto-install on first run
echo "Neovim uses lazy.nvim - plugins will auto-install on first run"
echo "---------------------------------------------------------------"

echo "Changing to zsh"
chsh -s $(which zsh)


echo "You will need to log out for this to take effect"
echo "----------------------------------------------"


case "$(uname -s)" in
   Darwin)
     echo "running oxs defaults"
     ./osx.sh

     ;;

   Linux)
     echo 'Linux ... no osx defaults'

     ;;
esac

echo "Correcting group permissions"
echo "----------------------------"
compaudit | xargs chmod g-w 2>/dev/null || true

./qupdate

echo "------------------------------------------------------------"
echo "                             All done!                      "
echo "Change your terminal font to a Nerd Font (e.g. JetBrains Mono)"
echo "------------------------------------------------------------"
exit 0
