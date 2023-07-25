#!/bin/bash



mkdir -p ~/.config || true

# Remove Old Nvim Config
rm -rf ~/.config/nvim || true

cp -r ./nvim ~/.config/

# Additional Step to install Packer
[ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ] && git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim


# Add Tmux Conf
rm -rf ~/.config/tmux/tmux.conf || true
cp -r ./tmux/tmux.conf ~/.config/tmux/tmux.conf

[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


# Add Kitty conf
rm -rf ~/.config/kitty || true
cp -r ./kitty ~/.config/kitty
