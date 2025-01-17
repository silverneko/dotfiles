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
- \<F6\>                Stop search highlight
- \<F7\>                Yank all
- \<F8\>                Toggle Tagbar
- \<Tab\>               Tab next
- \<S-Tab\>             Tab previous
- \<Ctrl-Right\>        Tab next
- \<Ctrl-Left\>         Tab previous
- \<Alt-Right\>         Move tab position right
- \<Alt-Left\>          Move tab position left
- \<Ctrl-C\>            [Visual mode] Copy selected text into system clipboard.


### Dependencies
- tagbar: Exuberant ctags
- neocomplete: Vim 7.3.885+ compiled with `if_lua`. If `:echo has("lua")` returns `1` then we're good.


### Hexmode
Simply editing a file in binary mode (eg. `vim -b some_file.jpg`)
will automatically convert it into hex.
Or use `:Hexmode` to switch between hex editing and normal editing.
