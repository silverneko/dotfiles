# Dotfiles
## Overview
```
git clone --depth 1 git@github.com:silverneko/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

May need to put `xmonad.desktop` into somewhere like `/usr/share/Xsession/` and set the permission to `root:root 644`.

Remember to install:
- xmonad
- xmobar (`cabal install xmobar --flags="all_extensions"`)
- stalonetray
- synapse (`sudo add-apt-repository ppa:synapse-core/ppa`)
- xfce4-terminal (for better transparency than cinnamon-terminal)
- glipper (clipboard manager)
- git (`sudo add-apt-repository ppa:git-core/ppa`)
- xcompmgr
- feh

## Vim
### Mapped function keys
- \<F2\>      Toggle Nerdtree
- \<F3\>      GoDoc / GhcModCheckAndLint
- \<F4\>      GoLint / GhcModLint
- \<F5\>      GoInfo / GhcModType
- \<F6\>      Clear search pattern (and GhcModTypePattern)
- \<F7\>      Yank all
- \<F8\>      Toggle Tagbar
- \<C-Right\> Tab next
- \<C-Left\>  Tab previous
- \<Tab\>     Autocomplete (neocomplete)

### Dependencies
- tagbar: Exuberant ctags
- neocomplete: Vim 7.3.885+ compiled with `if_lua`. If `:echo has("lua")` returns `1` then we're good.
- ghcmod-vim, neco-ghc:
  * ghc-mod 5.5+, `cabal install ghc-mod`
  * vimproc, `cd ~/.vim/bundle/vimproc.vim && make`

### Pathogen
Invoke `:Helptags` in vim to generate documentation.

### vim-go
Invoke `:GoInstallBinaries` to install binaries.
Ref: https://github.com/fatih/vim-go

### Hexmode
Simply editing a file in binary mode (eg. `vim -b some_file.jpg`)
will automatically convert it into hex.
Also, you can use `:Hexmode` to switch between hex editing and normal editing.

