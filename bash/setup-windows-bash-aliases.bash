# Add to ~/.bashrc

# Convert bash filepath to Windows filepath
winpath() {
    realpath $1 | sed -r 's*^/([a-zA-Z])/*\1:/*' | sed 's*/*\\*g'
}

# Convert Windows filepath to Bash filepath
bashpath () {
     echo "${1}" | sed -r "s,^([a-zA-Z]):\\\\,/\L\1\E/," | sed -r "s,\\\\,/,g"
}

# Open bash filepath in Notepad++
notepad() {
    if ! [ "${1}" = "" ]; then
        WINPATH=`winpath ${1}`
    fi
    "c:\Program Files (x86)\Notepad++\notepad.exe" "${WINPATH}"
}

# Open bash filepath in Eclipse
eclipse() {
    if ! [ "${1}" = "" ]; then
        WINPATH=`winpath ${1}`
    fi
    "c:\Eclipse\ide\eclipse.exe" "${WINPATH}"
}

__fast_git_branch_name() {
  echo `git status --porcelain=2 --branch  2> /dev/null | sed -n 's/# branch.head //p' 2> /dev/null`
}

__fast_git_ps1() {
  pick() {
    if [ "$1" == "" ]; then
      echo `echo $2 | sed -n "s/# ${3} //p"`
    else
      echo $1
    fi
  }

  while read -r line; do
    local BRANCH=`pick "$BRANCH" "$line" "branch.head"`;
    local TRACKINGBR=`pick "$TRACKINGBR" "$line" "branch.upstream"`;
    local AB=`pick "$AB" "$line" "branch.ab"`;
  done <<< `git status --porcelain=2 --branch  2> /dev/null`

  local FILE_COUNT=`git status --porcelain=2 2> /dev/null | wc -l`

  if [ ! "$BRANCH" == "" ]; then
    local GIT_PS1="\033[01;36m ($BRANCH"
    if [ ! "$TRACKINGBR" == "" ]; then
        GIT_PS1="${GIT_PS1}..${TRACKINGBR}"
        AB=`echo "$AB" | sed -e 's/+0 \{0,1\}//' | sed -e 's/ \{0,1\}-0//'`
        if [ ! "$AB" == "" ]; then
          GIT_PS1="${GIT_PS1} \033[01;31m${AB}"
        fi
    fi
    if [ ! "$FILE_COUNT" == "0" ]; then
        GIT_PS1="${GIT_PS1}\033[0m | \033[01;31m■${FILE_COUNT}"
    fi
    GIT_PS1="${GIT_PS1}\033[01;36m)\033[0m"
  fi

  echo -e $GIT_PS1
}
