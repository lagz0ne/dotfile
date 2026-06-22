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
regular files before replacing them.

After installing tmux config, open tmux and run:

```tmux
prefix + I
```

That installs TPM plugins. The configured prefix is `Ctrl-Space`.

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
