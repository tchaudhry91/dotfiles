#!/bin/bash


# Assume Nix-Env and install base packages
nix-env -i neovim git ripgrep

CONFDIR="~/.config"

cp -r ./nvim CONFDIR/

# Additional Step to install Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

vim -c PackerSync
