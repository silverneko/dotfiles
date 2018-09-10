# Path to your oh-my-zsh installation.
export ZSH=$HOME/.dotfiles/oh-my-zsh

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
ZSH_THEME="bnz"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.dotfiles/zsh/custom

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git cabal stack go command-not-found rake-fast bundler rsync)

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

source $ZSH/oh-my-zsh.sh

# END OF OH-MY-ZSH

export LANG="en_US.UTF-8"
export EDITOR="vim"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# RVM
if [[ -e "$HOME/.rvm/scripts/rvm" ]]; then
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
  source $HOME/.rvm/scripts/rvm
fi

# cabal
export PATH="$HOME/.cabal/bin:$PATH"

# stack
export PATH="$PATH:$HOME/.local/bin"

# golang
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:${GOPATH//://bin:}/bin"

# CUDA
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH"

export PATH="$HOME/bin:$PATH"

# When compiling python on opensuse, there may be some issues
# Compile with these flags may or may not solve the issues
#
# CFLAGS="-I/usr/include/ncurses5/ncurses" CPPFLAGS="$CFLAGS" LDFLAGS="-L/usr/lib64/ncurses5" pyenv install --verbose 2.7.14
#
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1 ; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

alias t="$COLORTERM"
alias untar="tar -xvf"
alias unexport="unset"
alias gti="git"

# Colorized cat
alias ccat='pygmentize'

alias :quit="exit"
alias :q=:quit


# Do keep there at the end of .zshrc
unsetopt inc_append_history_time
unsetopt share_history
setopt   inc_append_history
