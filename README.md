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

### tmux

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

* `Prefix + I` to *Install* plugins.
* `Prefix + U` to *Update* plugins.

### git

```sh
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


## Vim

### Dependencies

* `vim` 9.1+ (bleeding edge)

### vim-plug

Update plugins:
```vim
:PlugInstall  " Install new plugins only
:PlugUpdate
```

Update vim-plug itself:
```vim
:PlugUpgrade
```

### Key mappings

* Normal

    - `CTRL-P`              Pick file
    - `CTRL-B`              Pick buffer
    - `CTRL-E` `CTRL-6`     Edit alternate buffer
    - `CTRL-↑` `CTRL-U`     Scroll up
    - `CTRL-↓` `CTRL-D`     Scroll down
    - `-`                   [Dirvish] List parent dir of current file
    - `[t` / `]t`           Go to previous / next tab
    - `[T` / `]T`           Go to first / last tab
    - `<Alt-Right>`         Move tab to the right
    - `<Alt-Left>`          Move tab to the left

* Command

    - `CTRL-F`              Edit commandline
    - `:MRU`                Pick `:oldfiles`

* Insert

    - `CTRL-E`              Cancel autocomplete

* Visual

    - `CTRL-C`              Copy selected text into system clipboard.


### Hexmode
Simply editing a file in binary mode (eg. `vim -b some_file.jpg`)
will automatically convert it into hex.
Or use `:Hexmode` to switch between hex editing and normal editing.
