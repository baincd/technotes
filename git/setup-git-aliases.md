## `~/.gitconfig`
```
[alias]
	diffw = diff --ignore-space-change --ignore-space-at-eol
	staged = diff --cached
	ffup = merge --ff-only @{u}
	ff = merge --ff-only
	logd = log --decorate
	logg = log --graph --oneline --date=relative --format=format:'%C(bold blue)%h%C(reset) %C(bold green)%ad%C(reset) %C(bold cyan)%<(8,trunc)%an%C(reset) %s%C(bold yellow)%d%C(reset)'
	logv = log --graph --oneline --date=local --format=format:'%C(bold blue)%h%C(reset) %C(bold green)%ad%C(reset) %C(bold cyan)%an%C(reset) %C(bold yellow)%d%C(reset)%n%w(0,8,8)%B'
	pullr = pull --rebase
	pullm = pull
	pullf = pull --ff-only
	br = checkout -b
	track = branch -u
	untrack = branch --unset-upstream
	addall = add -A -v
	# Based on alias from https://haacked.com/archive/2014/07/28/github-flow-aliases/
	wipe = !git add -A && git commit -qm 'WIPE SAVEPOINT' && git --no-pager log --color=always HEAD~1..HEAD --pretty='%C(dim)%h%C(reset) %s:' --stat && echo '' && git reset HEAD~1 --hard
```

## `~/.bashrc`
```bash
# Cache SSH credentials
alias ssh-cache='eval `ssh-agent` && ssh-add'
```

## Git flow aliases
[setup-gitflow-aliases.md](./setup-gitflow-aliases.md)

## Qstash aliases
[setup-git-qstash-aliases.md](./setup-git-qstash-aliases.md)
