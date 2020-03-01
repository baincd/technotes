# Add to ~/.bashrc

# 1) Execute:
# ln -s ~/wc/technotes/bash/setup-bash-aliases.bash ~/.bash-aliases.bash
#
# 2) Add to ~/.bashrc:
# if [ -f ~/.bash-aliases.bash ]; then
#     . ~/.bash-aliases.bash
# fi

# No options set versions
alias grepX=`which grep`
alias findX=`which find`
alias lsX=`which ls`
alias lessX=`which ls`
alias killallX=`which killall`
alias pushdX='builtin pushd'
alias popdX='builtin popd'
alias cdX='builtin cd'
alias mkdirX=`which mkdir`

# Helpful defaults
alias grep='grep --color=auto '
alias grepsrc='grep --exclude-dir=".svn" --exclude-dir=".git" --exclude-dir="target" --exclude-dir="node_modules" '
alias findsrc='find -not -path "*/.svn/*" -not -name .svn -not -path "*/.git/*" -not -name .git -not -path "*/node_modules/*" -not -name node_modules '
alias ls='ls -l -F --color=auto --show-control-chars' # -F = append indicator (one of */=>@|) to entries
alias less='less -S' 	# Disable long line wrap
alias killall='killall -v'
alias f='git f'
alias nl='nl -b a ' # Number all lines
alias column='column -t -e -s ' # Break input into columns, delimiting on first param

# Colorized versions
alias grepc='grep --color=always'
alias grepsrcc='grepsrc --color=always'
alias lsc='ls --color=always'
alias lessc='less -R'

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

function mkdir() {
  if [ -d "${@: -1}" ]; then echo "ERROR: ${@: -1} already exists!"; else mkdirX -p -v -- "$@"; fi
}
function mkttmp() { export ttmp=~/tmp/`date +%Y-%m-%d`; mkdir $ttmp; }
function mkcd() { mkdir "$@" && cd "${@: -1}" ; }

alias atom-clean="rm -rf ~/.atom/compile-cache && rm -rf ~/.atom/storage && atom"

# Do not add commands that start with a space to the bash history
HISTCONTROL=ignorespace

PATH=$PATH:~/bin

function mkmvndirs() { mkdir "$1/src/main/java" && mkdir "$1/src/main/resources" && mkdir "$1/src/test/java" && mkdir "$1/src/test/resources" && touch "$1/pom.xml" ; }

alias gnucash-monthly-expense-report-to-spreadsheet="tac | tac | sed -re 's/^(Monthly Expense Report:)/##### \1 #####/' -re '/^Act\tAct\tAct/d' -re '/^(Big )?Expenses/d' -re 's/^[\t ]+//' -re 's/([^\t]*)\t\t/\1\t/' -re '4s/^/\t/' -re 's/\$//g'"
