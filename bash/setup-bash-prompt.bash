# Add to ~/.bashrc

# 1) Execute:
# ln -s ~/wc/technotes/bash/setup-bash-prompt.bash ~/.bash-prompt.bash
#
# 2) Add to ~/.bashrc:
# if [ -f ~/.bash-prompt.bash ]; then
#     . ~/.bash-prompt.bash
# fi
#
# # add default prompt (gps, gpb, or gpq)
# # use gpq (or leave off) if awesome git prompt (#3) is unstalled
# gpb
#
# 3) (optional) install awesome git prompt
# git clone https://github.com/magicmonty/bash-git-prompt ~/.bash-git-prompt

DEFAULT_PS1=$PS1

# For Servers:
# username@hostname dir
# export PS1="\[\033]0;\u@\h \w\007\]\n\[\033[01;32m\]\u@\h\[\033[m\] \[\033[01;33m\]\w\[\033[m\]\n$ "

# For development workstation:
_PS1_WITH_GIT_BRANCH_='\[\033]0;\w\007\]\[\033[01;33m\]\w\[\033[01;36m\]`__git_ps1`\[\033[0m\]\n$ '
_PS1_NO_BRANCH_='\[\033]0;\w\007\]\[\033[01;33m\]\w\[\033[0m\]\n$ '
_PROMPT_COMMAND_GIT_STATUS_='__git_status_cmd_for_prompt'
_PROMPT_COMMAND_GIT_SHORT_STATUS_='__git_status_cmd_for_prompt SHORT'
_PROMPT_COMMAND_NOTHING_='echo ""'

alias gpq='PS1=$_PS1_NO_BRANCH_       PROMPT_COMMAND=$_PROMPT_COMMAND_NOTHING_'    # Git Prompt Quiet (no git info)
alias gpb='PS1=$_PS1_WITH_GIT_BRANCH_ PROMPT_COMMAND=$_PROMPT_COMMAND_NOTHING_'    # Git Prompt Branch (include branch name - similar to default git prompt)
alias gpba='gpq && if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then source ~/.bash-git-prompt/gitprompt.sh; else echo "bash-git-prompt not installed!" && gpb; fi' # Git Prompt Branch AwesomeBash Verbose (fall back to gpb otherwise)
alias gps='PS1=$_PS1_NO_BRANCH_       PROMPT_COMMAND=$_PROMPT_COMMAND_GIT_STATUS_' # Git Prompt Status (include short git status)
alias gpss='PS1=$_PS1_NO_BRANCH_      PROMPT_COMMAND=$_PROMPT_COMMAND_GIT_SHORT_STATUS_' # Git Prompt branch Status and file count

gps

# Bash Prompt Notes:
# Remove '\[\033]0;\w\007\]' at beginning to not change window title

# Replace '\w' with '${PWD//[^[:ascii:]]/?}' to avoid beeps on non-printable chars
# https://github.com/msysgit/msysgit/issues/128

# Create custom Bash prompts: http://ezprompt.net/


GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_START="\[\033]0;\w\007\]\n\[\033[01;33m\]\w\[\033[m\]\[\033[0m\]"
GIT_PROMPT_PREFIX="("
GIT_PROMPT_SUFFIX=")"
GIT_PROMPT_END="\n$ "
GIT_PROMPT_SYMBOLS_PREHASH="commit:"
GIT_PROMPT_BRANCH="\[\033[01;36m\]" # Change from magenta to Bold Cyan
GIT_PROMPT_COMMAND_FAIL='\[\033[1;31m\]✘-_LAST_COMMAND_STATE_' # Change from red to bold red
# Make same as .gitconfig colors
GIT_PROMPT_STAGED=' \[\033[0;32m\]●' # Change from red to green
GIT_PROMPT_CONFLICTS=' \[\033[1;31m\]✖' # Change from red to bold red
GIT_PROMPT_CHANGED=' \[\033[1;31m\]✚' # Change from blue to bold red
GIT_PROMPT_UNTRACKED=' \[\033[0;33m\]…' # Change from cyan to yellow
# My New Values
GIT_PROMPT_SYMBOLS_PRETAG="tag:"
GIT_PROMPT_DETACHED_HEAD="\[\033[1;35m\]" # Set to [Bold Magenta]

__git_status_cmd_for_prompt() {
  local type="$1"
  local g="$(git rev-parse --git-dir 2> /dev/null)";

  echo ""
  if [ -z "$g" ]; then
    return 0;
  fi;

  local OUTPUT=`git -c color.status=always -c color.status.localBranch="cyan" status --short --branch 2> /dev/null`
  if [ "$type" == "SHORT" ]; then
    OUTPUT=`echo -e "$OUTPUT" | sed "s/^[^#][^#].*$/Files Changed/" | uniq -c | sed -e "s/^ *1 ##/##/" -e "s/^ *//" -e "s/^1 Files/1 File/"`
  fi

  echo -e -n "\033[01;36m" # Change color to bold cyan (which affects the ## in the git status line because git status apparently doesn't reset bold before outputting the branch name - To anyone reading this - please don't fix this "feature" in git - I like it  :-)
  echo -e -n "$OUTPUT"
  echo -e "\033[0m"
}
