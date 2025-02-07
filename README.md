# Dotfiles

```sh
git clone --depth 1 git@github.com:silverneko/dotfiles.git ~/.dotfiles
# or
git clone --depth 1 https://github.com/silverneko/dotfiles.git ~/.dotfiles
```

```sh
link-dot() { [ -e "$2" ] && (set -x; mv "$2" "$2".old); mkdir -p $(dirname "$2"); (set -x; ln -s ~/.dotfiles/"$1" "$2") }
link-dot zsh/.zshenv ~/.zshenv
link-dot vim ~/.vim
link-dot tmux.conf ~/.tmux.conf
link-dot wezterm.lua ~/.wezterm.lua
link-dot ghostty.config ~/.config/ghostty/config
link-dot lfrc ~/.config/lf/lfrc
unset -f link-dot
```


## Shell and utilities

```sh
sudo apt install fd-find ripgrep bat lsd
```

### git

```
# Show untracked stash
git config --global stash.showIncludeUntracked true
# If git-status is slow, try this
git config --global core.untrackedCache true
```

### Fzf

Install and upgrade `fzf` with `vim-plug`.

```sh
# [ -e ~/.fzf ] || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# cd ~/.fzf && git pull && ./install
```

### vim-plug

Update plugins:
```
:PlugInstall  " Install new plugins only
:PlugUpdate
```

Update vim-plug itself:
```
:PlugUpgrade
```


## Vim

### Mapped keys

* `CTRL-E`              Cancel autocomplete
* `CTRL-F`              Edit commandline
* `CTRL-P`              Pick file
* `CTRL-B`              Pick buffer
* `:MRU`                Pick `:oldfiles`
* `-`                   [Dirvish] List parent dir of current file

- `]t`                  Go to next tab
- `[t`                  Go to previous tab
- `]T`                  Go to last tab
- `[T`                  Go to first tab
- `<Alt-Right>`         Move tab to the right
- `<Alt-Left>`          Move tab to the left
- `<Ctrl-C>`            [Visual mode] Copy selected text into system clipboard.


### Dependencies
- vim 9+


### Hexmode
Simply editing a file in binary mode (eg. `vim -b some_file.jpg`)
will automatically convert it into hex.
Or use `:Hexmode` to switch between hex editing and normal editing.
