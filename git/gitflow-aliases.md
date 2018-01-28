* `git feature-start <feature>` - create branch `feature` off of origin/develop
* `git feature-push [<upstream>]` - set upstream branch and push
    * Use `<upstream>` as upstream branch if passed
    * else use existing upstream branch if set and is not origin/develop or origin/master
    * else use branch name, chopping off ticket numbers ("-123", "-123-456") and version numbers ("-v2") off the end.
        * abc -> abc
        * abc123 -> abc123
        * abc-123 -> abc
        * abc-123-456 -> abc
        * abc-123-v4 -> abc
        * abc99-123 -> abc99
* `git feature-pr [<upstream>]` - execute git-featurepush, then open Pull Request
    * git-\*-pr functions may need to be updated to use correct URL for Pull Request
* `git feature-end [--force]` - checkout develop (create if necessary), fast forward to origin/develop, and delete the feature branch
    * Command will abort if there are unpushed commits.  --force will bypass this check

## `~/.gitconfig`
```
[alias]
    feature-start = "!f() { ~/bin/git-feature.sh START $1 ;}; f"
    feature-push = "!f() { ~/bin/git-feature.sh PUSH $1 ;}; f"
    feature-pr = "!f() { ~/bin/git-feature.sh PR $1 ;}; f"
    feature-end = "!f() { ~/bin/git-feature.sh END ;}; f"
```

## `~/bin/git-feature.sh`
```bash
#!/bin/bash

ORIGIN=origin # Upstream Remote
PR=PR # Pull Request Remote
MASTER_BRANCH=master
DEVELOP_BRANCH=develop

git-feature-start() {
    git fetch
    git checkout ${ORIGIN}/${DEVELOP_BRANCH} -b $1
}

git-feature-end() {
    local BR=`current-branch`
    local ON_FEATURE_BRANCH=`is-feature-branch ${BR}`
    if [ "${ON_FEATURE_BRANCH}" = "0" ]; then
        echo "ERROR: Not on a feature branch"
        return
    fi

    if ! [ "${1}" = "--force" ]; then
        local TR=`current-tracking-branch`
        local COMMITS_NOT_PUSHED=`git log --oneline \`git rev-parse ${BR}\` ^\`git rev-parse ${ORIGIN}/${TR}\` | wc -l`
        if ! [ "${COMMITS_NOT_PUSHED}" = "0" ]; then
            echo "ERROR: local feature branch has commits not pushed (use --force to delete anyway)"
            return
        fi
    fi

    local LOCAL_DEVELOP_BR=`git branch | sed -rn "s/^ *(${DEVELOP_BRANCH})$/\1/p"`
    git fetch
    if [ "${LOCAL_DEVELOP_BR}" = "${DEVELOP_BRANCH}" ]; then
        git checkout ${DEVELOP_BRANCH}
        git merge @{u} --ff-only
    else
        git checkout --track ${ORIGIN}/${DEVELOP_BRANCH} -b ${DEVELOP_BRANCH}
    fi

    git branch -D $BR
}

git-feature-pr() {
    local BR_REV=`git rev-parse HEAD`
    local TR_REV=`git rev-parse ${ORIGIN}/${1}`
    if ! [ "${BR_REV}" = "${TR_REV}" ]; then
        echo "ERROR: Push Failed"
    else
        # GitHub
        git-feature-github-pr $TR
        # BitBucket
        git-feature-bitbucket-pr $TR
    fi
}

git-feature-github-pr() {
    local OWNER=`get-github-remote-part ${ORIGIN} 1`
    local PROWNER=`get-github-remote-part ${PR} 1`
    local PRREPO=`get-github-remote-part ${PR} 2`
    if [ "${PROWNER}" = "" ]; then
        echo "ERROR: remote ${PR} not found!"
    else
        # Windows: Create ~/bin/firefox.bat, and change command to "firefox.bat"
        #     @"c:\Program Files (x86)\Mozilla Firefox\firefox.exe" %*
        firefox "https://github.com/${PROWNER}/${PRREPO}/compare/${DEVELOP_BRANCH}...${OWNER}:${1}"
    fi
}

get-github-remote-part() {
    local REMOTE_NAME=$1
    local PART_NUM=""\\${2}""
    git remote -v | sed -rn 's/(\.git)? \(fetch\).*$//p' | sed -rn "s|^${REMOTE_NAME}\s.*https://github.com/([^/]*)/([^/]*)$|${PART_NUM}|p"
}

git-feature-bitbucket-pr() {
    local PROJECT=`get-bitbucket-remote-part ${ORIGIN} 1`
    local REPO=`get-bitbucket-remote-part ${ORIGIN} 2`
    # Windows: Create ~/bin/firefox.bat, and change command to "firefox.bat"
    #     @"c:\Program Files (x86)\Mozilla Firefox\firefox.exe" %*
    firefox "https://bitbucket.org/${PROJECT}/${REPO}/branches/compare/${1}%0Ddevelop"
}

get-bitbucket-remote-part() {
    local REMOTE_NAME=$1
    local PART_NUM=""\\${2}""
    git remote -v | sed -rn "s|^${REMOTE_NAME}.*https://bitbucket.org/([^/]*)/([^/]*)\.git \(fetch\).*$|${PART_NUM}|p"
}

git-feature-push() {
    local BR=`current-branch`
    local ON_FEATURE_BRANCH=`is-feature-branch ${BR}`
    if [ "${ON_FEATURE_BRANCH}" = "0" ]; then
        echo "ERROR: Not on a feature branch"
        return
    fi
    if ! [ "${2}" = "" ]; then
        local TR="${2}"
    else
        local TR=`current-tracking-branch`
        local TR_IS_FEATURE_BRANCH=`is-feature-branch ${TR}`
        if [ "${TR_IS_FEATURE_BRANCH}" = "0" ]; then
            # Chop off -1234  or -1234-2  or -1234-v2 from branch name.
            # To disable chop off, change to TR="${BR}"
            TR=`echo ${BR} | sed -r 's/-[0-9-]*(-v[0-9]+)?$//'`
        fi
    fi
    # echo UpstreamBranch=$TR
    # echo CurrentBranch=$BR
    git push ${ORIGIN} -u ${BR}:${TR}

    if [ "${1}" = "1" ]; then
        git-feature-pr $TR
    fi
}

current-tracking-branch() {
    git branch -vv | sed -n "s|^\*.*\[${ORIGIN}/||p" | sed 's/\].*$//' | sed -r 's/:( ahead [0-9]+)?,?( behind [0-9]+)?$//'
}

current-branch() {
    git branch | grep "^* " | sed 's|^* (HEAD detached at .*||' | sed 's|^* \(.*\)|\1|'
}

is-feature-branch() {
    if [ "${1}" = "" ] || [ "${1}" = "${DEVELOP_BRANCH}" ] || [ "${1}" = "${MASTER_BRANCH}" ]; then
        echo 0
    else
        echo 1
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
