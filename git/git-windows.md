# Git for windows setup

### Set home to specific path
1) Create environment variable HOME to new home path
2) If exist, move `.gitconfig`, `.bash`, and `.ssh` from old home path to new home path

### Fix Git Bash command prompt and window title
1) If not setup, setup `<HOME>/.bash_profile` \
`if [ -f ~/.bashrc ]; then . ~/.bashrc; fi` \
2) See [bash/bash-prompt](https://github.com/baincd/technotes/blob/master/bash/bash-prompt.md) for ~/.bashrc setup

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
