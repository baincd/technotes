# Better git stash
I find git stash slow and hard to use.  I find a faster method is to use git reset.

I suggest reading https://git-scm.com/blog/2011/07/11/reset.html to understand git reset before using this method.  Be careful, and experiment safely before using this.  And *never use `git reset --hard`* unless you are sure you know what you are doing!

## Stash changes before moving to a new branches
```bash
# Add all files to staging directory
$ git add -A -v
# Commit with a message like WIP
$ git commit -m WIP
# Change to another branch you want to work on
$ git checkout -b hotfix-1234 origin/master
```

## Unstash changes
```bash
# Change to branch you were working on
$ git checkout oldbranch
# Confirm the top commit is a "WIP" commit that has not been pushed to a remote
$ git log
# If that is the case, then throw away the commit, but keep the changes in your working copy
$ git reset HEAD~1
```

## Move stashed changed to another branch
If you have created a WIP commit, and want to move those changes to another branch:
```bash
# Change to a new branch
$ git checkout -b cool-feature origin/develop
# Cherry-pick your WIP commit
$ git cherry-pick oldbranch
# Look at the status, make sure the cherry-pick was successful
$ git status
# If not successful, fix and use 'git add' and 'git cherry-pick --continue'

# Now throw away the commit, but keep the changes in you working copy and index
$ git reset --soft HEAD~1
# And do a new commit
$ git commit -m "Awesome feature I don't know how we lived without"

# You will likely want to throw away the commit on the old branch
$ git checkout oldbranch
# Confirm you want to completely throw away the commit at the head of this branch
$ git log
# Make sure your working copy and staging area are clean - the `reset --hard` will blow away any changes!!
$ git status
# Bye Bye commit
$ git reset --hard HEAD~1
```
