#!/bin/bash



mkdir -p ~/.config || true

# Remove Old Nvim Config
rm -rf ~/.config/nvim || true

cp -r ./nvim ~/.config/

# Add Tmux Conf
rm -rf ~/.config/tmux/tmux.conf || true
mkdir -p ~/.config/tmux || true
cp -r ./tmux/tmux.conf ~/.config/tmux/tmux.conf

[ ! -d ~/.config/tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm


# Add Kitty conf
rm -rf ~/.config/kitty || true
cp -r ./kitty ~/.config/kitty

# Add Envyr Aliases
mkdir -p ~/.envyr || true
cp ./envyr/aliases.json ~/.envyr/aliases.json
