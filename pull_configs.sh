#!/bin/bash


# Sync NVIM dir here
echo "Syncing NVIM Conf.."
rsync -avz --delete --exclude 'packer_compiled.lua' ~/.config/nvim ./

