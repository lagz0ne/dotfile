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

ensure_tpm() {
  tpm_dir="$HOME/.config/tmux/plugins/tpm"

  if [ -x "$tpm_dir/tpm" ]; then
    return
  fi

  if ! command -v git >/dev/null 2>&1; then
    printf '%s\n' 'git is required to install TPM' >&2
    exit 1
  fi

  if [ -e "$tpm_dir" ]; then
    printf 'TPM path exists but is not usable: %s\n' "$tpm_dir" >&2
    exit 1
  fi

  mkdir -p "$(dirname -- "$tpm_dir")"
  git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
}

link_file "$repo_dir/.tmux.conf" "$HOME/.tmux.conf"
link_file "$repo_dir/.config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
link_file "$repo_dir/.config/tmux/help.sh" "$HOME/.config/tmux/help.sh"
link_file "$repo_dir/.config/starship.toml" "$HOME/.config/starship.toml"

chmod +x "$repo_dir/.config/tmux/help.sh"
ensure_tpm

printf '%s\n' 'dotfiles installed'
