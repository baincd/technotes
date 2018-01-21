## ~/.bashrc

```bash
alias grepsrc='grep --exclude-dir=".svn" --exclude-dir=".git" --exclude-dir="target" '
alias findsrc='find -not -path "*/.svn/*" -not -name .svn -not -path "*/.git/*" -not -name .git '
alias ll='ls -l'
alias ls='ls -F --color=auto --show-control-chars'

# Mount and Unmount network drive
alias mediadrivemount='mkdir ~/mediadrive && sudo mount -t cifs "\\\\10.20.30.40\\Drive Name" ~/mediadrive -o username=chris,uid=1000,gid=1000'
alias mediadriveumount='sudo umount ~/mediadrive && rm -r ~/mediadrive'

alias mirrorscreen="xrandr --output HDMI1 --off && xrandr --output HDMI1 --auto --scale-from \`xrandr | sed -rn '1s/^.* current ([0-9]+) x ([0-9]+).*/\1x\2/p'\`"
```
