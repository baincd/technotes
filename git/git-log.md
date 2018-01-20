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

# Grep History
If you want to search through history to find all file differences that include specific text of a regex pattern:

`git log -p -G regex <tree>`

## Search options
`-G <regex>` - Search for file changes (additions or deletions) that include this &lt;regex&gt;.  
`-S <string>` - Search for file changes (additions or deletions) where the number of occurences of the &lt;string&gt; changes
`--grep=<regex>` - Search commit messages for &lt;regex&gt;

## Formatting options
(ex `--oneline`) work ok, but `--graph` output doesn't seem useful

`-p` - This prints the diff (includes the diff for the entire commit - but if piped into less you can search to highlight what you want)

## References
[`-S and -G`](https://git-scm.com/docs/git-log#git-log--Sltstringgt) \
[`--grep`](https://git-scm.com/docs/git-log#git-log---grepltpatterngt)
