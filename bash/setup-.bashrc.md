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
[http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html](http://web.archive.org/web/20200213230525/http://www.joshstaiger.org/archives/2005/07/bash_profile_vs.html)
https://apple.stackexchange.com/a/51038
