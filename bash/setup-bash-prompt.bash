# Add to ~/.bashrc

# 1) Execute:
# ln -s ~/wc/technotes/bash/setup-bash-prompt.bash ~/.bash-prompt.bash
#
# 2) Add to ~/.bashrc:
# if [ -f ~/.bash-prompt.bash ]; then
#     . ~/.bash-prompt.bash
# fi
#
# # add default prompt (gps, gpss, gpb, or gpq)
# gpb

DEFAULT_PS1=$PS1

# For Servers:
# username@hostname dir
# export PS1="\[\033]0;\${_TT}\u@\h \w\007\]\n\[\033[01;35m\]\${_TT}\[\033[01;32m\]\u@\h\[\033[m\] \[\033[01;33m\]\w\[\033[m\]\n$ "

# For development workstation:
_PS1_PRE_="\[\033]0;\${_TT}\w\007\]\[\033[01;35m\]\${_TT}\[\033[01;33m\]\w\[\033[01;36m\]"
_PS1_POST_='\[\033[0m\]\n$ '

_PS1_NO_BRANCH_="$_PS1_PRE_$_PS1_POST_"
_PROMPT_COMMAND_GIT_PS1_='__git_ps1 "\n$_PS1_PRE_" "$_PS1_POST_" '
_PROMPT_COMMAND_GIT_STATUS_='__git_status_cmd_for_prompt'
_PROMPT_COMMAND_GIT_SHORT_STATUS_='__git_status_cmd_for_prompt SHORT'
_PROMPT_COMMAND_NOTHING_='echo ""'

alias gpq='PS1=$_PS1_NO_BRANCH_       PROMPT_COMMAND=$_PROMPT_COMMAND_NOTHING_'    # Git Prompt Quiet (no git info)
alias gpb='PS1=                       PROMPT_COMMAND=$_PROMPT_COMMAND_GIT_PS1_'    # Git Prompt Branch (include branch name - similar to default git prompt)
alias gps='PS1=$_PS1_NO_BRANCH_       PROMPT_COMMAND=$_PROMPT_COMMAND_GIT_STATUS_' # Git Prompt Status (include short git status)
alias gpss='PS1=$_PS1_NO_BRANCH_      PROMPT_COMMAND=$_PROMPT_COMMAND_GIT_SHORT_STATUS_' # Git Prompt branch Status and file count

gps

# Helpful aliases that run git status, and not run git status a second time as part of the prompt
alias s='skip-prompt-command-once && git s'
alias sv='skip-prompt-command-once && git sv'
alias gitq='skip-prompt-command-once && git'
alias reset-prompt-command='echo "" && PROMPT_COMMAND=${PROMPT_COMMAND_TMP} && unset PROMPT_COMMAND_TMP'
alias skip-prompt-command-once='PROMPT_COMMAND_TMP=$PROMPT_COMMAND PROMPT_COMMAND=reset-prompt-command'


# Bash Prompt Notes:
# Remove '\[\033]0;\w\007\]' at beginning to not change window title

# Replace '\w' with '${PWD//[^[:ascii:]]/?}' to avoid beeps on non-printable chars
# https://github.com/msysgit/msysgit/issues/128

# Create custom Bash prompts: http://ezprompt.net/

bt() { # bash title
  if [ "$1" == "" ]; then
    export _TT=
  else
    export _TT="[$1] "
  fi

}

__git_status_cmd_for_prompt() {
  local type="$1"
  local g="$(git rev-parse --git-dir 2> /dev/null)";

  echo ""
  if [ -z "$g" ]; then
    return 0;
  fi;

  local OUTPUT=`git -c color.status=always -c color.status.localBranch="cyan" status --short --branch 2> /dev/null`
  if [ "$type" == "SHORT" ]; then
    esc=$(printf '\033')
    local RED_BOLD="${esc}[1;31m"
    local RESET_COLOR="${esc}[0m"
    OUTPUT=`echo -e "$OUTPUT" | sed "s/^[^#][^#].*$/Files Changed/" | uniq -c | sed -e "s/^ *1 ##/##/" -e "s/^ *//" -e "s/^1 Files/1 File/" -e "s/^\([0-9]\+\) \(.*\)/ ${RED_BOLD}\1${RESET_COLOR} \2 /"`
  fi

  echo -e -n "\033[01;31m"
  # Derived from __git_ps1
  /bin/ls -1 "$(git rev-parse --git-dir 2>/dev/null)" 2>/dev/null | sed -n -re "s/^rebase-(merge|apply)$/*** REBASING ***/p" -re "s/^MERGE_HEAD$/*** MERGING ***/p" -re "s/^CHERRY_PICK_HEAD$/*** CHERRY-PICKING ***/p" -re "s/^REVERT_HEAD$/*** REVERTING ***/p" -re "s/^BISECT_LOG$/*** BISECTING ***/p"

  echo -e -n "\033[01;36m" # Change color to bold cyan (which affects the ## in the git status line because git status apparently doesn't reset bold before outputting the branch name - To anyone reading this - please don't fix this "feature" in git - I like it  :-)
  echo -e -n "$OUTPUT"
  echo -e "\033[0m"
}
