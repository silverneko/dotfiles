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
unset -f link-dot
```

Shell completion file of `rg` has a wrong name on debian, rename it back:
```sh
mkdir ~/.zprompts
ln -s /usr/share/zsh/vendor-completions/rg.zsh ~/.zprompts/_rg
```


## Shell and utilities

### Fzf

Installing and upgrading:
```sh
[ -e ~/.fzf ] || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
cd ~/.fzf && git pull && ./install
```

### Utilities

```sh
sudo apt install lsd fd-find bat
```

### vim-plug
Update plugins:
```
:PlugUpdate
```

Update vim-plug itself:
```
:PlugUpgrade
```


## Vim

### Mapped function keys
- `<F8>`                Yank all
- `]t`                  Go to next tab
- `[t`                  Go to previous tab
- `]T`                  Go to last tab
- `[T`                  Go to first tab
- `<Ctrl-Alt-Right>`    Move tab to the right
- `<Ctrl-Alt-Left>`     Move tab to the left
- `<Ctrl-C>`            [Visual mode] Copy selected text into system clipboard.


### Dependencies
- vim 9+


### Hexmode
Simply editing a file in binary mode (eg. `vim -b some_file.jpg`)
will automatically convert it into hex.
Or use `:Hexmode` to switch between hex editing and normal editing.
