# Dotfiles

```sh
git clone --depth 1 git@github.com:silverneko/dotfiles.git ~/.dotfiles
# or
git clone --depth 1 https://github.com/silverneko/dotfiles.git ~/.dotfiles
```

```sh
echo '. "${HOME}/.dotfiles/zshenv"' >> ~/.zshenv
[ -d ~/.vim ] && (set -x; mv ~/.vim ~/.vim.old)
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/wezterm.lua ~/.wezterm.lua
ln -s ~/.dotfiles/ghostty.config ~/.config/ghostty/config
```

## Shell and utilities

### Fzf

Installing:
```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
```

Upgrading
```sh
cd ~/.fzf
git pull
./install
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
- \<F2\>                Toggle Nerdtree
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
