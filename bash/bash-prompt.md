#### Set Bash Prompt for account
```bash
# add to `~/.bashrc`
DEFAULT_PS1=$PS1
PS1=<new prompt>
# Note - for the Git prompt, you will need to add \ before each `
```
## Servers
user@host PWD
```bash
export PS1="\n\[\e[01;32m\]\u@\h\[\e[m\] \[\e[01;33m\]\w\[\e[m\]\n$ "
```

## Development machines
PWD (git-branch)
```bash
export PS1="\n\[\e[01;33m\]\w\[\e[m\]\[\033[01;36m\]`__git_ps1`\[\033[0m\]\n$ "
```

## Windows Git Bash
&lt;Window Title = PWD&gt; | PWD (git-branch)
```bash
export PS1='\[\033]0;${PWD}//[^[:ascii:]]/?}\007\]\n\[\033[01;33m\]\w\[\033[01;36m\]`__git_ps1`\[\033[0m\]\n$ '
```

## Misc
#### Create custom Bash prompts
http://ezprompt.net/
