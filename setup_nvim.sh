#!/bin/bash

CONFDIR="~/.config"

cp -r ./nvim CONFDIR/

# Additional Step to install Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

vim -c PackerSync
