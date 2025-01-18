#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

# Input/output
# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# expand-or-complete  Expands variables and then complete word.
# complete-word       Just complete word. Leave the variables alone.
# Need to be binded *before* fzf integration.
for map (emacs viins) bindkey -M $map '^I' complete-word

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

export LANG="en_US.UTF-8"
export EDITOR="vim"
export PAGER="less"
export GOPATH="${HOME}/go"

# Filter out WSL paths. They would cause jank of fast-syntax-highlight.
filtered_path=()
for p ($path) [[ "$p" != /mnt/c/* ]] && filtered_path+=("$p")
path=($filtered_path)
unset filtered_path p

path=(
  "${HOME}/bin"
  "${HOME}/.local/bin"
  "${HOME}/platform-tools"
  $path
  "/usr/local/games"
  "/usr/games"
  "/usr/local/go/bin"
  "${GOPATH}/bin"
  "${HOME}/.fzf/bin"
)

# -----------------
# Zim configuration
# -----------------

# fpath must be added *before* compinit (Zim init does compinit).
fpath+=("${HOME}/.zprompts")

# Always show command duration.
zstyle ':zim:duration-info' threshold 0

# Expand `...` => `../..`
zstyle ':zim:input' double-dot-expand yes

# Completion is case *in*sensitive; Globbing is case sensitive.
zstyle ':zim:glob' case-sensitivity sensitive

# --------------------
# Module configuration
# --------------------

# smartcase
ZSHZ_CASE=smart
# Save symlinks as is.
ZSHZ_NO_RESOLVE_SYMLINKS=1
# Display $HOME as ~.
ZSHZ_TILDE=1
# Make it so that a search pattern ending in `/` can match the final element in a path.
ZSHZ_TRAILING_SLASH=1
# Jump first uncommon segment. https://github.com/agkozak/zsh-z/blob/master/README.md#zshz_uncommon
ZSHZ_UNCOMMON=1

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' show-group brief
zstyle ':fzf-tab:*' prefix ''

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

# "magic-enter" should clear unaccepted suggestions. Must be added *after* Zim init.
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty)

fast-theme -q safari
fast-theme -q "${DOTFILES}/fsh_overlay.ini"

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} up-line-or-beginning-search
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} down-line-or-beginning-search
for key ('k') bindkey -M vicmd ${key} up-line-or-beginning-search
for key ('j') bindkey -M vicmd ${key} down-line-or-beginning-search
unset key

# History
export HISTSIZE=110000
export SAVEHIST=100000

# NO BEEP! STFU!!!
setopt no_beep

# Remove older command from the history if a duplicate is to be added.
setopt hist_ignore_all_dups extended_history
setopt inc_append_history_time no_inc_append_history no_share_history

# Print error for bad glob patterns.
setopt nomatch no_extended_glob

# Job control logic that are similar to bash.
setopt clobber hup check_jobs
setopt no_pushd_silent no_pushd_to_home pushd_minus

#
# Utility aliases and settings
#

for map (emacs viins) {
  # Ctrl-E to *E*dit the command line.
  bindkey -M $map '^E' edit-command-line

  # fzf-tab took over the original ^I key bindings. I'd rather fzf-tab binds to its own key
  # and leave ^I alone. Alas they don't provide the option to customize the key bindings.
  # Restore Ctrl-I (tab) back to fzf-complete, which wraps the original "complete" widget.
  # Bind Ctrl-F (Fuzzy *F*ind completion) to fzf-tab-complete.
  bindkey -M $map '^F' ${$(bindkey -M $map '^I')[2]}
  bindkey -M $map '^I' fzf-completion
}

export ZSHRC="${ZDOTDIR}/.zshrc"
export ZIMRC="${ZDOTDIR}/.zimrc"
export VIMRC="${HOME}/.vim/vimrc"

export LESS_TERMCAP_mb=$'\E[1;31m'  # Begins blinking.
export LESS_TERMCAP_md=$'\E[1;31m'  # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'     # Ends mode.
export LESS_TERMCAP_ue=$'\E[0m'     # Ends underline.
export LESS_TERMCAP_us=$'\E[1;32m'  # Begins underline.
export LESS='--ignore-case --jump-target=4 --LONG-PROMPT --quit-if-one-screen --RAW-CONTROL-CHARS'
export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43'
# :help manpager.vim
export MANPAGER="vim +MANPAGER --not-a-term -"

alias d="dirs -v"
alias sort="LC_ALL=C sort"
alias grep='grep --color=auto'

alias ls='ls --group-directories-first --color=auto'
if [ "${(k)commands[lsd]}" ]; then
  alias ls="lsd --group-directories-first --git"
  alias lt="lsd --tree --group-directories-first"
fi
alias ll="ls -lh"
alias l="ll -A"
alias la="ll -A"
alias lsa="ll -a"

# By default `fd` and `rg` are both smartcase (vim :h smartcase) and searches hidden files.
# However .gitignore rules are still respected. To ignore .gitignore, pass `--no-ignore`.
alias rg="rg --smart-case --hidden -g '!.git/'"
FD_CMD="${(k)commands[fd]:-${(k)commands[fdfind]}}"
[ "$FD_CMD" != fd ] && alias fd="${FD_CMD} --hidden"

BAT_CMD="${(k)commands[bat]:-${(k)commands[batcat]}}"
if [ "$BAT_CMD" ]; then
  export BAT_THEME="zenburn"
  [ "$BAT_CMD" != bat ] && alias bat="$BAT_CMD"
  alias cat="bat"
  alias batdiff="git diff --name-only --relative --diff-filter=d | xargs \"${BAT_CMD}\" --diff"
  alias bd="batdiff"
fi

for source_file (
  "${DOTFILES}/doge_cat.sh"
  "${DOTFILES}/zshrc.google"
) [ -f "$source_file" ] && . "$source_file"
unset FD_CMD BAT_CMD source_file

# No duplicate entries in $path & $PATH
typeset -U path
