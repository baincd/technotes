## `~/.gitconfig`
```
[alias]
    feature-start = "!f() { ~/bin/git-feature.sh START $1 ;}; f"
    feature-push = "!f() { ~/bin/git-feature.sh PUSH $1 ;}; f"
    feature-pr = "!f() { ~/bin/git-feature.sh PR $1 ;}; f"
    feature-end = "!f() { ~/bin/git-feature.sh END $1 ;}; f"
```

## `~/bin/git-feature.sh`
```bash
#!/bin/bash

git-feature-start() {
    git fetch
    git checkout origin/develop -b $1
    git branch -D __NO_BRANCH__ 2&>1 > /dev/null
}

git-feature-end() {
    local BR=`git branch | grep "^* " | sed 's|^* (HEAD detached at .*||' | sed 's|^* \(.*\)|\1|'`
    if ! [ "${BR}" = "" ] && ! [ "${BR}" = "develop" ] && ! [ "${BR}" = "master" ]; then
        git checkout --no-track origin/develop -B __NO_BRANCH__
        git branch -D $BR
    else
        echo "ERROR: Not on a feature branch"
    fi
}

git-feature-bitbucket-pr() {
    local PROJECT=`git remote -v | sed -rn 's|^.*https://bitbucket.org/([^/]*)/([^/]*)\.git \(fetch\).*$|\1|p'`
    local    REPO=`git remote -v | sed -rn 's|^.*https://bitbucket.org/([^/]*)/([^/]*)\.git \(fetch\).*$|\2|p'`
    # Windows: Create ~/bin/firefox.bat, and change command to "firefox.bat"
    #     @"c:\Program Files (x86)\Mozilla Firefox\firefox.exe" %*
    firefox "https://bitbucket.org/${PROJECT}/${REPO}/branches/compare/${1}%0Ddevelop"
}

git-feature-github-pr() {
    # Setup:
    # * Change OWNER to the owner you can push to
    # * Add remote PR for the repo where Pull Requests will be opened against
    local OWNER=your_github_name
    local PROWNER=`git remote -v | sed -rn 's/(\.git)? \(fetch\).*$//p' | sed -rn 's|^PR\s.*https://github.com/([^/]*)/([^/]*)$|\1|p'`
    local  PRREPO=`git remote -v | sed -rn 's/(\.git)? \(fetch\).*$//p' | sed -rn 's|^PR\s.*https://github.com/([^/]*)/([^/]*)$|\2|p'`
    if [ "${PROWNER}" = "" ]; then
        echo "ERROR: PR remote not found!"
    else
        # Windows: Create ~/bin/firefox.bat, and change command to "firefox.bat"
        #     @"c:\Program Files (x86)\Mozilla Firefox\firefox.exe" %*
        firefox "https://github.com/${PROWNER}/${PRREPO}/compare/develop...${OWNER}:${1}"
    fi
}

git-feature-push() {
    local BR=`git branch | sed -n 's/^\* //p'`
    if ! [ "${2}" = "" ]; then
        local TR="${2}"
    else
        local TR=`git branch -vv | sed -n 's|^\*.*\[origin/||p' | sed 's/\].*$//' | sed -r 's/:( ahead [0-9]+)?,?( behind [0-9]+)?$//'`
        if [ "${TR}" = "" ] || [ "${TR}" = "develop" ] || [ "${TR}" = "master" ]; then
            TR="${BR}"
        fi
    fi
    # echo UpstreamBranch=$TR
    # echo CurrentBranch=$BR
    git push origin -u ${BR}:${TR}

    if [ "${1}" = "1" ]; then
        git-feature-github-pr $TR
    fi
}

if [ "${1}" = "START" ]; then
    git-feature-start $2
elif [ "${1}" = "END" ]; then
    git-feature-end $2
elif [ "${1}" = "PUSH" ]; then
    git-feature-push 0 $2
elif [ "${1}" = "PR" ]; then
    git-feature-push 1 $2
fi
```
