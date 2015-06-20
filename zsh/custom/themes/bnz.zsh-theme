# Set prompt colors
P_RED="[01;38;5;160m" #$fg[red]
P_GREEN="[01;38;5;148m" #$fg[green]
P_BLUE="[01;38;5;153m" #$fg[blue]
P_YELLOW="[01;38;5;226m" #$fg[yellow]
P_ORANGE="[01;38;5;214m" #$fg[magenta]
P_CYAN="[01;38;5;81m" #$fg[cyan]
P_WHITE=$fg[white]
P_BLACK="[01;38;5;235m" #$fg[black]

local prompt_character="λ%(!.#.➤)"
# local prompt_character="%(!.#.➜)"
local ret_status="%{%(?:$P_GREEN:$P_RED)%}${prompt_character}"
PROMPT='%B%{%(!:$P_RED:$P_GREEN)%}%n%{$P_CYAN%}@%M: %{$P_BLUE%}${PWD/#$HOME/~} $(git_prompt_info)%{$P_BLUE%}
${ret_status} % %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$P_ORANGE%}git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$P_YELLOW%}[✗]"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$P_GREEN%}[✓]"


#  P_RED=$fg[red]
#  P_GREEN=$fg[green]
#  P_BLUE=$fg[blue]
#  P_YELLOW=$fg[yellow]
#  P_ORANGE=$fg[magenta]
#  P_CYAN=$fg[cyan]
#  P_WHITE=$fg[white]
#  P_BLACK=$fg[black]

