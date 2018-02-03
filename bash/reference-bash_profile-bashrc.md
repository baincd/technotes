`~/.bash_profile` - login shells (when username/password entered) \
`~/.bashrc` - interactive non-login shells (new terminal, no login)

### Execute ~/.bashrc from ~/.bash_profile
```bash
# Add to bottom of ~/.bash_profile
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
```

### Reference
https://apple.stackexchange.com/a/51038
