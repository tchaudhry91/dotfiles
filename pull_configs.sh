#!/bin/bash


# Sync NVIM dir here
echo "Syncing NVIM Conf.."
rsync -avz --delete --exclude 'packer_compiled.lua' ~/.config/nvim ./


# Sync tmux dir here
echo "Syncing TMUX Conf.."
rsync -avz --delete ~/.config/tmux/tmux.conf ./tmux/
