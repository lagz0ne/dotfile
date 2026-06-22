#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
stamp=$(date +%Y%m%d%H%M%S)

link_file() {
  src=$1
  dest=$2
  dest_dir=$(dirname -- "$dest")

  mkdir -p "$dest_dir"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$dest.backup.$stamp"
  fi

  ln -sfn "$src" "$dest"
}

link_file "$repo_dir/.tmux.conf" "$HOME/.tmux.conf"
link_file "$repo_dir/.config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
link_file "$repo_dir/.config/tmux/help.sh" "$HOME/.config/tmux/help.sh"
link_file "$repo_dir/.config/starship.toml" "$HOME/.config/starship.toml"

chmod +x "$repo_dir/.config/tmux/help.sh"

printf '%s\n' 'dotfiles installed'
