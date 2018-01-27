# Add to ~/.bashrc

alias grepsrc='grep --exclude-dir=".svn" --exclude-dir=".git" --exclude-dir="target" '
alias findsrc='find -not -path "*/.svn/*" -not -name .svn -not -path "*/.git/*" -not -name .git '
alias lss='/usr/bin/ls'
alias ls='ls -l -F --color=auto --show-control-chars'
alias less='less -S'
# Git aliases can be found in git/.gitconfig
