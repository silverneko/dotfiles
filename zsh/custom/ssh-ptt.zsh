function ptt
{
  if [[ -z "$1" ]] ; then
    port=5050
  elif ! [[ "$1" =~ "^[0-9]+$" ]] ; then
    port=5050
  else
    port=$1
  fi
  ssh -f -N -L $port:ptt.cc:22 b03902082@linux9.csie.org
  TUNNEL_PID=`ps aux | grep -F "ssh -f -N -L $port:ptt.cc" | grep -v -F 'grep' | awk '{ print $2 }'`
  ssh -p $port bbsu@localhost
  kill $TUNNEL_PID
}
