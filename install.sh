#!/bin/bash

echo "Installing symlinks..."

links=(
  "ghostty:$HOME/.config/ghostty"
  "tmux:$HOME/.config/tmux"
  "nvim:$HOME/.config/nvim"
)

for entry in "${links[@]}"; do
  IFS=":" read -r src dst <<< "$entry"
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$PWD/$src" "$dst"
  echo "$dst → $src"
done

TPM_PATH="$HOME/.tmux/plugins/tpm"

if [ ! -d "$TPM_PATH" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"
  echo "TPM installed to $TPM_PATH"
else
  echo "TPM already installed"
fi

echo
echo "Done. Launch tmux and press prefix + I to install plugins."
