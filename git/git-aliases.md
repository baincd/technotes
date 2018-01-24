## `~/.gitconfig`
```
[alias]
	ffup = merge --ff-only @{u}
	ff = merge --ff-only
	logd = log --decorate
	logg = log --graph --oneline --date=relative --format=format:'%C(bold blue)%h%C(reset) %C(bold green)%ad%C(reset) %C(bold cyan)%<(8,trunc)%an%C(reset) %s%C(bold yellow)%d%C(reset)'
	logv = log --graph --oneline --date=local --format=format:'%C(bold blue)%h%C(reset) %C(bold green)%ad%C(reset) %C(bold cyan)%an%C(reset) %s%C(bold yellow)%d%C(reset) %n%w(0,8,8)%+b'
	pullr = pull --rebase
	pullm = pull
	pullf = pull --ff-only
	br = checkout -b
	track = branch -u
	untrack = branch --unset-upstream
	addall = add -A -v
```

## `~/.bashrc`
```bash
# Cache SSH credentials
alias ssh-cache='eval `ssh-agent` && ssh-add'
```
---
`git-pushtr:  ` **git** **push** origin same-branch-name & **tr**ack \
`git-pushtrpr:` **git** **push** origin same-branch-name & **tr**ack & create **p**ull **r**equest \
`git-pushpr:  ` **git** **push** & create **p**ull **r**equest
```bash
alias git-pushtr="git push -u origin \`git branch | sed -n 's/^\* //p'\`"
git-pushptpr() {
	gitOutput=`git-pushtr "$@" 2>&1 | tee /dev/tty`
	__git_open_pr "$gitOutput"
}
git-pushpr() {
	gitOutput=`git push "$@" 2>&1 | tee /dev/tty`
	__git_open_pr "$gitOutput"
}
__git_open_pr() {
    # Bitbucket example:
    # remote: Create pull request for mybranch:
    # remote   https://bitbucket.org/myapp/myrepo/compare/commits?sourceBranch=refs/heads/mybranch
	PRurl=`echo "$1" | sed -rn '\|Create pull request|,\|https?://|s|^.*remote: *(https?://)|\1|p'`
	if ! [ "$PRurl" = "" ]; then
        echo Opening Pull Request ${PRurl}
        # Linux
		firefox $PRurl
        # Windows: Create ~/bin/firefox.bat
        #     @"c:\Program Files (x86)\Mozilla Firefox\firefox.exe" %*
        firefox.bat $PRurl
	fi
}

```
