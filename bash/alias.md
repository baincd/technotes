## ~/.bashrc

```bash
alias grepsrc='grep --exclude-dir=".svn" --exclude-dir=".git" --exclude-dir="target" '
alias findsrc='find -not -path "*/.svn/*" -not -name .svn -not -path "*/.git/*" -not -name .git '
alias ll='ls -l'
alias ls='ls -F --color=auto --show-control-chars'
```
