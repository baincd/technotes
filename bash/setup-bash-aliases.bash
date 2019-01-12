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
function pushd() { pushdX "$@" > /dev/null && dirs; }
function popd() { popdX "$@" > /dev/null && dirs; }
function sd() { # swap dir
  if [ ! "$1" = "" ]; then
    echo "ERROR: sd should not be passed any params!"
    return 1
  fi
  pushdX > /dev/null;
}

_LAST_CD_TS=0
function cd() {
  local PREV_CD_TS=$_LAST_CD_TS
  export _LAST_CD_TS=`date +%s` # Seconds since the epoch
  if [ `expr $_LAST_CD_TS - $PREV_CD_TS` -gt "10" ]; then # if more than 10 seconds since last cd, push onto stack
    pushdX "$@" > /dev/null
  else
    cdX "$@"
  fi
}


alias atom-clean="rm -rf ~/.atom/compile-cache && rm -rf ~/.atom/storage && atom"

# Do not add commands that start with a space to the bash history
HISTCONTROL=ignorespace

PATH=$PATH:~/bin
