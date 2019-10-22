# Set prompt colors
local orange=214

PROMPT='%B%F{%(!:red:green)}%n%F{cyan}@%m:%b %F{blue}%~%f $(my_git_prompt_info)%E
%B%F{%(?:green:red)}λ%(!.#.>)%f%b '

ZSH_THEME_GIT_PROMPT_PREFIX="%F{$orange}git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{yello}[✗]"
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}[✓]"

function my_git_prompt_info {
  git_prompt_info
}
