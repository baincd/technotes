# Add to ~/.bashrc

# 1) Execute:
# ln -s ~/wc/technotes/bash/setup-bash-prompt.bash ~/.bash-prompt.bash
#
# 2) Add to ~/.bashrc:
# if [ -f ~/.bash-prompt.bash ]; then
#     . ~/.bash-prompt.bash
# fi
#
# 3) (optional) install awesome git prompt
# git clone https://github.com/magicmonty/bash-git-prompt ~/.bash-git-prompt

DEFAULT_PS1=$PS1

# For Servers:
# username@hostname dir
# export PS1="\[\033]0;\u@\h \w\007\]\n\[\e[01;32m\]\u@\h\[\e[m\] \[\e[01;33m\]\w\[\e[m\]\n$ "

# For development workstation:
# dir (gitbranch)
PS1='\[\033]0;\w\007\]\n\[\033[01;33m\]\w\[\033[01;36m\]`__git_ps1`\[\033[0m\]\n$ '

# Other development workstation variations:
# Do not change terminal window title
# export PS1="\n\[\e[01;33m\]\w\[\e[m\]\[\033[01;36m\]`__git_ps1`\[\033[0m\]\n$ "

# Use full path in terminal window title
# PS1='\[\033]0;${PWD//[^[:ascii:]]/?}\007\]\n\[\033[01;33m\]\w\[\033[01;36m\]`__git_ps1`\[\033[0m\]\n$ '

# Create custom Bash prompts: http://ezprompt.net/


GIT_PROMPT_ONLY_IN_REPO=1
GIT_PROMPT_START="\n\[\e[01;33m\]\w\[\e[m\]\[\033[0m\]"
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

if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
    source ~/.bash-git-prompt/gitprompt.sh
fi
