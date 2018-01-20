# Git for windows setup

### Set home to specific path
- Create environment variable HOME to new home path
- If exist, move `.gitconfig`, `.bash`, and `.ssh` from old home path to new home path

### Fix Git Bash command prompt and window title
`<HOME>/.bash_profile`
```
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
```
`<HOME>/.bashrc`
```
PS1='\[\033]0;${PWD}//[^[:ascii:]]/?}\007\]\n\[\033[01;33m\]\w\[\033[01;36m\]`__git_ps1`\[\033[0m\]\n$ '
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
