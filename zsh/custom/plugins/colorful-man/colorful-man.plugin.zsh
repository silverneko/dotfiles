alias man='cman'

function cman() {
COLOR_OPT=(
  LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
  LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
  LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
  #LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
  LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
  LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
  LESS_TERMCAP_ue=$'\E[0m'        # reset underline
  GROFF_NO_SGR=1                  # for konsole and gnome-terminal
)
env ${COLOR_OPT} man "$@"
}
