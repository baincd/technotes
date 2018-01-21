# Set Bash Prompt from Command Line
```bash
# PWD (Git-branch)
export PS1="\n\[\e[01;33m\]\w\[\e[m\]\[\033[01;36m\]`__git_ps1`\[\033[0m\]\n$ "

# user@host PWD
export PS1="\n\[\e[01;32m\]\u@\h\[\e[m\] \[\e[01;33m\]\w\[\e[m\]\n$ "
```

# Set Bash Prompt for account
Add to `~/.bashrc`
```bash
DEFAULT_PS1=$PS1
PS1=<new prompt>
# Note - for the Git prompt, you will need to add \ before each `
```

# Website to create new Bash prompt
http://ezprompt.net/
