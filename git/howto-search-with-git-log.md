http://git-scm.com/docs/git-log

# Useful git log options
```
--graph
--decorate (show refs)
--oneline
--format=oneline|short|medium|full|fuller|<format> (default => medium)
--abbrev-commit
--date=relative|local|short|format:<format> (short is YYYY-MM-DD)
--all (all refs on command line)
```

# What branches contain a commit?
```
git branch --contains <commitish>
```

# Show all commits in A and not in B
```
git log A ^B
```


## Formatting options
(ex `--oneline`) work ok, but `--graph` output doesn't seem useful

`-p` - This prints the diff (includes the diff for the entire commit - but if piped into less you can search to highlight what you want)
