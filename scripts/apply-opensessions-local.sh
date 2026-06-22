#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
plugin="${OPENSESSIONS_PLUGIN_DIR:-$HOME/.config/tmux/plugins/opensessions}"
patch_file="$repo_dir/patches/opensessions-local.patch"

if [ ! -d "$plugin/.git" ]; then
  printf '%s\n' "opensessions plugin checkout not found: $plugin" >&2
  printf '%s\n' "Install TPM plugins first, then rerun this script." >&2
  exit 1
fi

if [ ! -r "$patch_file" ]; then
  printf '%s\n' "patch file not found: $patch_file" >&2
  exit 1
fi

if git -C "$plugin" apply --check "$patch_file"; then
  git -C "$plugin" apply "$patch_file"
elif git -C "$plugin" apply --reverse --check "$patch_file"; then
  printf '%s\n' "opensessions local customization already applied"
else
  printf '%s\n' "patch does not apply cleanly; inspect the opensessions checkout first" >&2
  exit 1
fi

cargo build -p opensessions-server -p opensessions-sidebar --release --manifest-path "$plugin/Cargo.toml"
install -m 0755 "$plugin/target/release/opensessions-server" "$plugin/bin/opensessions-server"
install -m 0755 "$plugin/target/release/opensessions-sidebar" "$plugin/bin/opensessions-sidebar"

if command -v tmux >/dev/null 2>&1; then
  if command -v pgrep >/dev/null 2>&1; then
    for pid in $(pgrep -f "$plugin/bin/opensessions-server" 2>/dev/null || true); do
      kill "$pid" 2>/dev/null || true
    done
  fi
  tmux source-file "$HOME/.config/tmux/tmux.conf" 2>/dev/null || true
  tmux run-shell "sh '$plugin/integrations/tmux-plugin/scripts/focus.sh'" 2>/dev/null || true
fi

printf '%s\n' "opensessions local customization applied"
