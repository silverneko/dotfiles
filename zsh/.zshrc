#zstyle ':zim:zmodule' use 'degit'

# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

fpath+=("${HOME}/.zprompts")

zstyle ':zim:duration-info' threshold 0

export LANG="en_US.UTF-8"
export EDITOR="vim"

path=(
  "${HOME}/bin"
  "${HOME}/.local/bin"
  "${HOME}/platform-tools"
  $path
)

path+=(
  "/usr/local/games"
  "/usr/games"
  "${HOME}/.fzf/bin"
)

# golang
export GOPATH="${HOME}/go"
path+=(
  "/usr/local/go/bin"
  "${GOPATH}/bin"
)
# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
#for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
#for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} up-line-or-beginning-search
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} down-line-or-beginning-search
#for key ('k') bindkey -M vicmd ${key} history-substring-search-up
#for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# Print error for bad glob patterns.
setopt nomatch no_extended_glob

# Job controls that are similar to bash.
setopt clobber hup check_jobs
setopt no_pushd_silent no_pushd_to_home pushd_minus

fast-theme -q safari
fast-theme -q "${HOME}/.dotfiles/fsh_overlay.ini"

typeset -gA FAST_BLIST_PATTERNS
FAST_BLIST_PATTERNS[/mnt/c]=1
FAST_BLIST_PATTERNS[/mnt/c/*]=1

alias d="dirs -v"
alias l="ll -A"
alias la="ll -A"
alias lsa="ll -a"

alias rg="rg --hidden"
alias fd="${(k)commands[fd]:-${(k)commands[fdfind]}}"
alias bat="${(k)commands[bat]:-${(k)commands[batcat]}}"
alias cat="bat"

export BAT_THEME="zenburn"
export HISTSIZE=110000
export SAVEHIST=100000
setopt extended_history inc_append_history_time no_inc_append_history no_share_history

typeset -U path
