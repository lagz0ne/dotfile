#!/usr/bin/env bash
cat <<'EOF'
tmux shortcuts

opensessions
  Alt-1 .. Alt-9      switch to visible session by index
  Alt-s               reveal and focus sidebar
  Ctrl-Shift-e        reveal and focus sidebar
  Ctrl-Space s        reveal and focus sidebar
  Ctrl-Space o s      reveal and focus sidebar
  Ctrl-Space o t      toggle sidebar
  Ctrl-Space o e      spread panes even-horizontal
  Ctrl-Space o 1..9   switch to visible session by index

Navigation
  Ctrl-Space F        fuzzy TUI: sessions, windows, panes, clipboard, keys
  Ctrl-Space h/j/k/l  move between panes
  Ctrl-Space Tab      last pane
  mouse click         select pane

Copy / paste
  Ctrl-Space [        copy/scroll mode
  v                   start selection
  y or Enter          copy selection
  mouse drag          in copy mode: release to copy
  Ctrl-Space ]        paste tmux buffer

Windows / panes
  Ctrl-Space c        new window in current directory
  Ctrl-Space "        split down in current directory
  Ctrl-Space %        split right in current directory
  Ctrl-Space z        zoom current pane

Maintenance
  Ctrl-Space r        reload tmux config
  Ctrl-Space I        install TPM plugins
  Ctrl-Space U        update TPM plugins
  Ctrl-Space ?        full tmux key list
  Ctrl-Space H        this help

Press q or Esc to close.
EOF
