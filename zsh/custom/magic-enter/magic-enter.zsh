_prompt_magic_enter() {
  if [[ -z ${BUFFER} && ${CONTEXT} == start ]]; then
    local -i a_files=$(command ls -Aq | command wc -l)
    local -i v_files=$(command ls -q | command wc -l)
    local -i h_files=$(( a_files - v_files ))
    print "[${a_files} files, ${h_files} hidden]"
    dirs -v
    if command git rev-parse --show-toplevel >/dev/null 2>/dev/null; then
      print
      command git status -sb 2>/dev/null
    fi
    print -Pn ${PS1}
    zle redisplay
  else
    zle accept-line
  fi
}

zle -N magic-enter _prompt_magic_enter
