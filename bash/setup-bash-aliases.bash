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

# Helpful defaults
alias grep='grep --color=auto '
alias grepsrc='grep --exclude-dir=".svn" --exclude-dir=".git" --exclude-dir="target" --exclude-dir="node_modules" '
alias findsrc='find -not -path "*/.svn/*" -not -name .svn -not -path "*/.git/*" -not -name .git -not -path "*/node_modules/*" -not -name node_modules '
alias ls='ls -l -F --color=auto --show-control-chars' # -F = append indicator (one of */=>@|) to entries
alias less='less -S' 	# Disable long line wrap
alias killall='killall -v'

# Colorized versions
alias grepc='grep --color=always'
alias grepsrcc='grepsrc --color=always'
alias lsc='ls --color=always'
alias lessc='less -R'

alias s='skip-prompt-command-once && git s'
alias sv='skip-prompt-command-once && git status'
alias f='git fa'

alias reset-prompt-command='echo "" && PROMPT_COMMAND=${PROMPT_COMMAND_TMP} && unset PROMPT_COMMAND_TMP'
alias skip-prompt-command-once='PROMPT_COMMAND_TMP=$PROMPT_COMMAND PROMPT_COMMAND=reset-prompt-command'

alias atom-clean="rm -rf ~/.atom/compile-cache && rm -rf ~/.atom/storage && atom"

PATH=$PATH:~/bin
