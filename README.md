# dotfiles
My dotfiles

Type `./install.sh` in the command line to use.

May need to put `default-session.desktop` into somewhere like `/usr/share/Xsession/` and set the permission to `root:root 644`.

Remember to install:
- zsh
- vim
- xmonad
- xmobar (`cabal install xmobar --flags="all_extensions"`)
- stalonetray
- synapse (`sudo add-apt-repository ppa:synapse-core/ppa`)
- xfce4-terminal (for better transparency than cinnamon-terminal)
- glipper (clipboard manager)
- git (`sudo add-apt-repository ppa:git-core/ppa`)
- xcompmgr
- feh

## vim cheatsheet

- mapped function keys
  - \<F3\>      Switch compiler collection
  - \<F4\>      Compile / Run code
  - \<F5\>      Toggle Nerdtree
  - \<F6\>      Clear search pattern
  - \<F7\>      Yank all
  - \<F8\>      Toggle Tagbar
  - \<F9\>      Read default code
  - \<C-Right\> Tab next
  - \<C-Left\>  Tab previous
  - \<Tab\>     Autocomplete

