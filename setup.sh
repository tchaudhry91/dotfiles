#!/usr/bin/env bash
# Installs the active dotfiles stack: nvim, tmux, waybar, hyprland.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOST="$(hostname | tr '[:upper:]' '[:lower:]')"

# nvim  (rsync --delete mirrors the repo, removing stale files)
mkdir -p ~/.config/nvim
rsync -a --delete "$DOTFILES/nvim/" ~/.config/nvim/

# tmux  (config lives beside the TPM plugins under ~/.config/tmux)
mkdir -p ~/.config/tmux/plugins
[ -d ~/.config/tmux/plugins/tpm ] || \
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
cp "$DOTFILES/tmux/tmux.conf" ~/.config/tmux/tmux.conf
rm -f ~/.tmux.conf   # legacy location; tmux 3.1+ reads ~/.config/tmux/tmux.conf

# waybar
mkdir -p ~/.config/waybar
cp "$DOTFILES"/waybar/* ~/.config/waybar/

# hyprland  (host-specific; fall back to the default template)
mkdir -p ~/.config/hypr
src="$DOTFILES/hypr/hyprland.lua"
if [ -f "$DOTFILES/hypr/hyprland.$HOST.lua" ]; then
  src="$DOTFILES/hypr/hyprland.$HOST.lua"
else
  echo "No hyprland config for host '$HOST'; using default template." >&2
fi
cp "$src" ~/.config/hypr/hyprland.lua

# ~/.local/bin helpers referenced from the configs
mkdir -p ~/.local/bin
for f in "$DOTFILES"/bin/*; do
  [ -e "$f" ] || continue
  install -m 0755 "$f" ~/.local/bin/
done

echo "Setup complete for host '$HOST'."
