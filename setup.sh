#!/bin/bash



mkdir -p ~/.config || true

# Remove Old Nvim Config
rm -rf ~/.config/nvim || true

cp -r ./nvim ~/.config/

[ ! -d ~/.config/tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
cp ./tmux/tmux.conf ~/.tmux.conf


# Add Kitty conf
# rm -rf ~/.config/kitty || true
# cp -r ./kitty ~/.config/kitty

# cp ./wezterm/wezterm.lua ~/.wezterm.lua

# Add Waybar and Hyprland
# mkdir -p ~/.config/waybar || true
# mkdir -p ~/.config/hypr || true

# cp -r ./waybar/* ~/.config/waybar/

# cp -r ./hypr/* ~/.config/hypr/
