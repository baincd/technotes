<!-- ### Page Linked from setup-git-aliases.md ### -->
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
* `git feature-mergeable [<branch>]` - Check if the current branch is mergeable with another branch
    * Default to origin/develop if `<branch>`
    * else use local branch `<branch>` if exists
    * else use origin/<branch> if exists
    * else use PR/<branch> if exists
    * else abort
    * Command will abort if there are unpushed commits.

## `~/.gitconfig`
```
[alias]
    feature-start = "!f() { ~/bin/git-feature.sh START $1 ;}; f"
    feature-push = "!f() { ~/bin/git-feature.sh PUSH $1 ;}; f"
    feature-pr = "!f() { ~/bin/git-feature.sh PR $1 ;}; f"
    feature-end = "!f() { ~/bin/git-feature.sh END $1 ;}; f"
    feature-mergeable = "!f() { ~/bin/git-feature.sh MERGEABLE $1 ;}; f"
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
    if [ "$(is-feature-branch ${BR})" = "false" ]; then
        echo -e "\e[1;31mERROR!\e[0m: Not on a feature branch"
        return
    fi

    if ! [ "${1}" = "--force" ]; then
        local TR=`current-tracking-branch`
        local COMMITS_NOT_PUSHED=`git log --oneline \`git rev-parse ${BR}\` ^\`git rev-parse ${ORIGIN}/${TR}\` | wc -l`
        if ! [ "${COMMITS_NOT_PUSHED}" = "0" ]; then
            echo -e "\e[1;31mERROR!\e[0m: local feature branch has commits not pushed (use --force to delete anyway)"
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
        echo -e "\e[1;31mERROR!\e[0m: Push Failed"
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
        echo -e "\e[1;31mERROR!\e[0m: remote ${PR} not found!"
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
    if [ "$(is-feature-branch ${BR})" = "false" ]; then
        echo -e "\e[1;31mERROR!\e[0m: Not on a feature branch"
        return
    fi
    if ! [ "${2}" = "" ]; then
        local TR="${2}"
    else
        local TR=`current-tracking-branch`
        if [ "$(is-feature-branch ${TR})" = "false" ]; then
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

git-feature-mergeable() {
    # Param - branch to merge in
    if [ "$(is-working-copy-clean)" = "false" ]; then
        echo -e "\e[1;31mERROR!\e[0m: Working Copy is not clean"
        return
    fi
    if [ "$(current-branch)" = "" ]; then
        echo -e "\e[1;31mERROR!\e[0m: Not on a branch!"
        return
    fi

    if [ "${1}" = "" ]; then
        local MERGE_BRANCH="${ORIGIN}/${DEVELOP_BRANCH}"
    elif [ "$(does-branch-exist ${1})" = "true" ]; then
        local MERGE_BRANCH="${1}"
    elif [ "$(does-branch-exist ${ORIGIN}/${1})" = "true" ]; then
        local MERGE_BRANCH=${ORIGIN}/${1}
    elif [ "$(does-branch-exist ${PR}/${1})" = "true" ]; then
        local MERGE_BRANCH=${PR}/${1}
    else
        echo -e "\e[1;31mERROR!\e[0m: Unable to find branch ${1}"
        return
    fi

    local START_HEAD=`git rev-parse HEAD`
    git fetch
    git merge $MERGE_BRANCH >> /dev/null
    if [ "$(is-working-copy-clean)" = "true" ]; then
        echo -e "\e[1;32mOK!\e[0m $(current-branch) is mergeable with ${MERGE_BRANCH}"
    else
        echo -e "\e[1;31mERROR!\e[0m: $(current-branch) has merge conflicts with ${MERGE_BRANCH}"
        echo "The following files have conflicts:"
        echo -e "$(git diff --name-only | uniq | sed -r 's/^(.*)$/  \\e[1;31m\1\\e[0m/')"
    fi
    git reset --hard $START_HEAD >> /dev/null
}

current-tracking-branch() {
    git branch -vv | sed -n "s|^\*.*\[${ORIGIN}/||p" | sed 's/\].*$//' | sed -r 's/:( ahead [0-9]+)?,?( behind [0-9]+)?$//'
}

current-branch() {
    git branch | grep "^* " | sed 's|^* (HEAD detached at .*||' | sed 's|^* \(.*\)|\1|'
}

is-feature-branch() {
    if [ "${1}" = "" ] || [ "${1}" = "${DEVELOP_BRANCH}" ] || [ "${1}" = "${MASTER_BRANCH}" ]; then
        echo false
    else
        echo true
    fi
}

is-working-copy-clean() {
    if [ -z "$(git status --porcelain)" ]; then
      echo true
    else
      echo false
    fi
}

does-branch-exist() {
    if [ -z "$(git branch -a | awk '{$1=$1};1' | sed 's,^remotes/,,' | grep -x ${1})" ]; then
        echo false
    else
        echo true
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
elif [ "${1}" = "MERGEABLE" ]; then
    git-feature-mergeable $2
fi
```
