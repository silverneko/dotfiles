# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Look in ~/.oh-my-zsh/themes/
ZSH_THEME="bnz"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

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

# zsh-autosuggestions color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=64"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colorful-man
  colorize
  command-not-found
  gitfast
  pip
  pylint
  repo
  rsync
  z
  zsh-autosuggestions
  fast-syntax-highlighting
)

# User configuration

ZSH_COLORIZE_STYLE=monokai

# export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

source $ZSH/oh-my-zsh.sh

# END OF OH-MY-ZSH

export LANG="en_US.UTF-8"
export EDITOR="vim"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# golang
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

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

alias untar="tar -xvf"
alias unexport="unset"
alias gti="git"
alias less="less -R"

alias :quit="exit"
alias :q=:quit

# So that sudo can work on aliases
alias sudo='sudo '

umask 022

fast-theme "${HOME}/.dotfiles/fsh_overlay.ini" >/dev/null

function lf-cd {
  local tmp="$(mktemp)"
  command lf -last-dir-path="$tmp" "${@:-$(pwd)}"
  if [ -f "$tmp" ]; then
    local dir="$(cat "$tmp")"
    rm -f -- "$tmp"
    if [ -d "$dir" ] && [ "$(pwd)" != "$dir" ]; then
      cd -- "$dir"
    fi
  fi
}

alias lf=lf-cd

function ranger-cd {
  local tmp="$(mktemp)"
  command ranger --choosedir="$tmp" "${@:-$(pwd)}"
  if [ -f "$tmp" ]; then
    local dir="$(cat "$tmp")"
    rm -f -- "$tmp"
    if [ -d "$dir" ] && [ "$(pwd)" != "$dir" ]; then
      cd -- "$dir"
    fi
  fi
}

alias ranger=ranger-cd
alias ran=ranger

if [ -e "$(command -v fd)" ]; then
  FDFIND="fd"
elif [ -e "$(command -v fdfind)" ]; then
  FDFIND="fdfind"
fi

alias fd="$FDFIND"

if [ -n "$FDFIND" ]; then
  export FZF_DEFAULT_COMMAND="$FDFIND --type file --hidden --follow --exclude .git"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FDFIND --type directory --hidden --follow --exclude .git"
fi

function fvim {
  local query="$@"
  local IFS=$'\n'
  local files=($(fzf --query="$query" --multi --select-1 --exit-0))
  for f in "${files[@]}"; echo "$f"
  [ -n "$files" ] && vim -p "${files[@]}"
}

function fcd {
  local query="$@"
  local dir="$(eval "$FZF_ALT_C_COMMAND" | fzf --query="$query" +m --exit-0)"
  [ -n "$dir" ] && cd "$dir"
}

[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

[ -f "$HOME/.dotfiles/zshrc.google" ] && source "$HOME/.dotfiles/zshrc.google"

function extract-zip {
  if [[ "$1" =~ ".zip$" ]]; then
    unzip -o "$1" -d "${1%.zip}"
  else
    echo "File name does not look like a zip archive:" "$1"
  fi
}

alias sort="LC_ALL=C sort"

# Do keep there at the end of .zshrc
unsetopt inc_append_history_time
unsetopt share_history
setopt   inc_append_history

# Remove duplicate entries in $path ($PATH is mirror of $path)
typeset -U path
