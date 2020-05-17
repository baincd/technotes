# Git for windows setup options

These are useful options for configuring git bash on Windows.

### Set home to specific path
1) Create environment variable HOME to new home path
2) If exist, move `.gitconfig`, `.bash*`, and `.ssh/` from old home path to new home path

### Setup initial directory for Git Bash
Add to `~/.bashrc`
```bash
if [[ `pwd` = $HOME ]]; then
    cd /c/wc
fi
```

### Speed up git on windows
Source: http://Stackoverflow.com/a/24045966 \
Add to `.gitconfig`
```
[core]
    preloadindex = true
    fscache = true
[gc]
    auto = 256
```

<!--
## Old
#### <git>/etc/profile:
```bash
# At bottom of file
# To remove "MINGW64" from window title
MSYSTEM=
TITLEPREFIX=
# Set Home in Git Bash
HOME="$(cd "c:\cdb" ; pwd)"
# Set initial path for Git Bash
cd /c/wc
```
-->
