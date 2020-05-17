# Enhancements to Change Directory and pushd/popd functions
# Currently not in active use or maintenance

alias pushdX='builtin pushd'
alias popdX='builtin popd'
alias cdX='builtin cd'
alias dirsX='builtin dirs'



alias dirs='dirs -v'
function pushd() { pushdX "$@" > /dev/null; }
function popd() { popdX "$@" > /dev/null; }
function sd() { # swap dir
  if [ ! "$1" = "" ]; then
    echo "ERROR: sd should not be passed any params!"
    return 1
  fi
  pushdX > /dev/null;
}
function cdp() {
  local error=
  while :
  do
    if [ "$error" != "" ]; then
      echo "ERROR: $error"
      error=
    else
      dirs
    fi

    echo "#, rm #, rm #-#, or q"
    echo -n "> "
    read cmd
    if [[ $cmd == q* ]]; then # quit
      return 0
    elif [[ $cmd =~ ^rm\ [0-9]+$ ]]; then # remove single item from stack
      local num=`echo "$cmd" | sed -E 's/rm ([0-9]+)/+\1/'`
      popdX $num > /dev/null
    elif [[ $cmd =~ ^rm\ [0-9]+-[0-9]+$ ]]; then # remove range from stack
      local num=`echo "$cmd" | sed -E 's/rm ([0-9]+)-([0-9]+)/\1/'`
      local end_num=`echo "$cmd" | sed -E 's/rm ([0-9]+)-([0-9]+)/\2/'`
      for i in `seq $num $end_num`; do
        popdX "+$num"> /dev/null
      done
    elif [[ $cmd =~ ^[0-9]+$ ]]; then # pop items off top of stack up to #
      for i in `seq 2 $cmd`; do # Remove regardless of if dir exists
        popdX +1 > /dev/null
      done
      popdX > /dev/null
      return 0
    else
      error="I don't understand!"
    fi
  done
}

_LAST_CD_TS=0
function cd() {
  local PREV_CD_TS=$_LAST_CD_TS
  export _LAST_CD_TS=`date +%s` # Seconds since the epoch
  if [ `expr $_LAST_CD_TS - $PREV_CD_TS` -gt "0" ]; then # if more than 10 seconds since last cd
    local TOP_OF_STACK=`dirs -v | sed -ne '2s/^ \([0-9]\)\+ *\(.*\)/\2/p'`
    local CWD=`pwd | sed -E "s#^${HOME}(/.*)?\\$#~\1#"` # current dir, replacing $HOME with ~ so it matches the dirs output
    if [ "$CWD" != "$TOP_OF_STACK" ]; then # if the current directory is not the same as the top of the dirstack
      pushdX "$@" > /dev/null # push on dirstack
      return
    fi
  fi
  cdX "$@" # default to just a boring cd command
}
