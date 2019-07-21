zsh-togglecursor
================

This plugin toggles cursor when switching between the vi command (vicmd) and
insert (usually main) keymaps.

# Requirements

## zsh

Version 5.3 or higher is required.

## Terminal

The terminal application that understands `DECSCUSR`, which fixes the style of
the cursor. Terminator, Konsole, iTerm2, Apple Terminal, and Konsole are known
to support the feature.

## tmux

This plugin also works inside tmux if it is properly configured. Add
`terminal-overrides` to your `tmux.conf` as follows:

```tmux
set -ga terminal-overrides ',*:Ss=\E[%p1%d q:Se=\E[2 q'
```

Note: This was taken from [FAQ · neovim/neovim Wiki](https://github.com/neovim/neovim/wiki/FAQ)
