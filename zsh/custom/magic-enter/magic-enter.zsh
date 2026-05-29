# *Magic enter* shows some useful info about cwd.

d() {
  builtin dirs -v
  if [[ $(builtin dirs -p | command wc -l) -le 1 ]]; then
    print "(directory stack empty)"
  fi
}

_in_git() {
  # NOTE: Doing this is much faster than calling git-rev-parse
  local git_root="${PWD}"
  while [[ ! -e "${git_root}/.git" ]]; do
    if [[ "${git_root}" == / ]]; then
      return 1
    else
      git_root="${git_root:h}"
    fi
  done
  return 0
}

_prompt_magic_enter() {
  if [[ -z ${BUFFER} && ${CONTEXT} == start ]]; then
    local -i a_files=$(command ls -Aq | command wc -l)
    local -i v_files=$(command ls -q | command wc -l)
    local -i h_files=$(( a_files - v_files ))
    print "[${a_files} files, ${h_files} hidden]"
    d
    if _in_git; then
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

function pushd { builtin pushd "$@" >/dev/null; d }
function popd { builtin popd "$@" >/dev/null && d }

_my_popd_widget() {
  zle push-line     # Clears the current line. Auto-restore after next line.
  BUFFER="popd"
  zle accept-line
  zle reset-prompt  # Restore original line.
}

zle -N my-popd-widget _my_popd_widget
