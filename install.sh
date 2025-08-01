#!/bin/bash

echo "📦 Installing symlinks..."

# Array in the format "src:dst"
links=(
  "ghostty:$HOME/.config/ghostty"
  "nvim:$HOME/.config/nvim"
)

for entry in "${links[@]}"; do
  IFS=":" read -r src dst <<< "$entry"

  # Create the directory if it doesn't exist
  mkdir -p "$(dirname "$dst")"

  # Create the symlink
  ln -sfn "$PWD/$src" "$dst"

  echo "✅ $dst → $src"
done

echo "🎉 Symlinks installed!"
