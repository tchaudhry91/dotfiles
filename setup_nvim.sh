#!/bin/bash


# Assume Nix-Env and install base packages
nix-env -i neovim git ripgrep


mkdir -p ~/.config || true

cp -r ./nvim ~/.config/

# Additional Step to install Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim || true

# Open vim and run PackerSync.
