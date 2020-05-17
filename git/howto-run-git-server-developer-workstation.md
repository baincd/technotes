# Stand up a git server

References
* https://railsware.com/blog/2013/09/19/taming-the-git-daemon-to-quickly-share-git-repository/
* https://git-scm.com/docs/git-daemon#git-daemon---export-all

```bash
git daemon --base-path=/files/wc/ --export-all --reuseaddr --informative-errors --verbose
```

Clone URL: `git://ip-address/path-to-repo-from-base-path`


# Fetch seems to work better increasing compression
```bash
git -c core.compression=9 fetch
```
