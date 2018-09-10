# Dotfiles

## Overview

### Clone dotfiles
```
git clone --depth 1 git@github.com:silverneko/dotfiles.git ~/.dotfiles
```


### Install oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# or
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
```


### Create symbolic links for .zshrc, .vimrc
```
if [ -f ~/.zshrc ]; then
  mv ~/.zshrc ~/.zshrc.orig
fi
ln -s ~/.dotfiles/zshrc ~/.zshrc

ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vimrc ~/.vimrc
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


## Xmonad
May need to put `xmonad.desktop` into somewhere like `/usr/share/Xsession/` and set the permission to `root:root 644`.
