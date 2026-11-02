#!/usr/bin/env bash
# Installs the active dotfiles stack.
#
# Two profiles, because not every host has a display:
#
#   terminal  nvim, tmux, bin/            - every personal device, GUI or not
#   desktop   terminal + waybar, hyprland - only hosts with a graphical session
#
#     ./setup.sh                 # desktop (unchanged default behaviour)
#     ./setup.sh --profile terminal
#     ./setup.sh --profile desktop
#
# opsy's roles/dotfiles calls this with the profile implied by the host's
# membership of the `graphical` capability group, so the repo stays the single
# source of truth for what a machine gets.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOST="$(hostname | tr '[:upper:]' '[:lower:]')"
PROFILE="desktop"

usage() {
  cat <<'EOF'
Usage: setup.sh [--profile terminal|desktop]

  terminal   nvim, tmux, ~/.local/bin helpers
  desktop    the above plus waybar and hyprland (default)
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --profile)
      [ $# -ge 2 ] || { echo "error: --profile needs a value" >&2; exit 2; }
      PROFILE="$2"
      shift 2
      ;;
    --profile=*)
      PROFILE="${1#--profile=}"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "error: unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

case "$PROFILE" in
  terminal|desktop) ;;
  *) echo "error: --profile must be 'terminal' or 'desktop', got '$PROFILE'" >&2; exit 2 ;;
esac

# ---------------------------------------------------------------------------
# terminal - common to every personal device
# ---------------------------------------------------------------------------

# nvim  (rsync --delete mirrors the repo, removing stale files)
mkdir -p ~/.config/nvim
rsync -a --delete "$DOTFILES/nvim/" ~/.config/nvim/

# tmux  (config lives beside the TPM plugins under ~/.config/tmux)
mkdir -p ~/.config/tmux/plugins
[ -d ~/.config/tmux/plugins/tpm ] || \
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
cp "$DOTFILES/tmux/tmux.conf" ~/.config/tmux/tmux.conf
rm -f ~/.tmux.conf   # legacy location; tmux 3.1+ reads ~/.config/tmux/tmux.conf

# ~/.local/bin helpers referenced from the configs
mkdir -p ~/.local/bin
for f in "$DOTFILES"/bin/*; do
  [ -e "$f" ] || continue
  install -m 0755 "$f" ~/.local/bin/
done

if [ "$PROFILE" = "terminal" ]; then
  echo "Setup complete for host '$HOST' (profile: terminal)."
  exit 0
fi

# ---------------------------------------------------------------------------
# desktop - needs a graphical session
# ---------------------------------------------------------------------------

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

echo "Setup complete for host '$HOST' (profile: desktop)."
