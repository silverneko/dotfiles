alias :help=zsh-reference-card
alias :h=:help

function zsh-reference-card
{
  cat <<EOF
zsh command line editing quick reference card
  ctrl + _  Undo the last change
  ctrl + ←  Move one word backward
  ctrl + →  Move one word forward
  ctrl + u  Clear the entire line
  ctrl + w  Delete one word backwards
  ctrl + k  Clear to end of line
  ctrl + y  Paste from Kill Ring
  ctrl + r  Search backwards in history
  ctrl + l  Clear screen
EOF
}
