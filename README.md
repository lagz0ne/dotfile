# dotfile

Personal tmux-focused dotfiles for `lagz0ne`.

This repository is public so I can bootstrap another machine, but it is not an
open contribution project. Issues, discussions, wiki, and pull requests should
stay disabled on GitHub.

## What is included

- `~/.tmux.conf` compatibility shim
- `~/.config/tmux/tmux.conf`
- `~/.config/tmux/help.sh`
- `~/.config/starship.toml`

## Install

Clone the repo, then run:

```sh
./install.sh
```

The installer symlinks the tracked files into `$HOME` and backs up existing
regular files before replacing them. It also bootstraps TPM at
`~/.config/tmux/plugins/tpm` if TPM is not already installed.

After installing tmux config, open tmux and run:

```tmux
prefix + I
```

That installs TPM plugins. The configured prefix is `Ctrl-Space`.

## opensessions local customization

The `opensessions` UI customization is kept as a local source patch, not as a
vendored plugin checkout. Do not commit plugin binaries, release downloads,
`target/`, or the whole `~/.config/tmux/plugins/opensessions` directory.

To capture the current local customization on the source machine:

```sh
mkdir -p ~/dotfile/patches
git -C ~/.config/tmux/plugins/opensessions diff \
  -- apps/server-rs/src/lib.rs \
     integrations/tmux-plugin/scripts/focus.sh \
     packages/runtime-rs/src/tmux_provider.rs \
     packages/sidebar-core-rs/src/app.rs \
     packages/sidebar-core-rs/src/input.rs \
     packages/sidebar-core-rs/src/lib.rs \
     packages/sidebar-core-rs/src/renderer.rs \
  > ~/dotfile/patches/opensessions-local.patch
```

On a new machine, first install TPM plugins, then apply the patch and rebuild
the local opensessions binaries:

```sh
~/dotfile/scripts/apply-opensessions-local.sh
```

The tracked patch lives at `patches/opensessions-local.patch`.

## Main tmux shortcuts

- `Alt-1` .. `Alt-9`: switch to visible opensessions session by index
- `Alt-s`: focus the opensessions sidebar
- `Ctrl-Space r`: reload tmux config
- `Ctrl-Space H`: show the local help popup
- `Ctrl-Space F`: open tmux-fzf
- `Ctrl-Space h/j/k/l`: move between panes

## Notes

This repo intentionally does not vendor local plugin checkouts, downloaded
binaries, histories, caches, API tokens, or machine-local agent state.
