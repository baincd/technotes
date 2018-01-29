<!-- ### Page Linked from setup-git-aliases.md ### -->
* `git qstash [<msg>]` - Stash all changes (staged, unstaged, and untracked) in a new commit.  Commit subject will begin with "WIP!" with optional `<msg>` appended.  Following this command, the working copy will be clean.
* `git checkpoint [<msg>]` - Same functionality as `git qstash`, but commit subject will begin with "CHECKPOINT!"
* `git qunstash [--all] [--wip-only]` - Unstash a previous qstash.  This will move all qstash-ed changes and staged changes to unstaged/untracked.  The qstash commit will be thrown away and the staging area will be reset.
    * If the HEAD commit is not a qstash commit, then command will abort
    * `--all` will roll back consecutive qstash commits, back to first non-qstash commit
    * qstash commits are determined by the commit message starting with "WIP!" or "CHECKPOINT!"
        * If `--wip-only` option is used, then only commit messages starting with "WIP!" will be considered qstash commits

## `~/.gitconfig`
```
[alias]
    qstash = "!f() { ~/bin/git-qstash.sh STASH $@ ;}; f"
    checkpoint = "!f() { ~/bin/git-qstash.sh CHECKPOINT $@ ;}; f"
    qunstash = "!f() { ~/bin/git-qstash.sh UNSTASH $@ ;}; f"
```

## `~/bin/git-qstash.sh`
```bash
#!/bin/bash

WIP="WIP!"
CHECKPOINT="CHECKPOINT!"

git-stash() {
    if [ "$(is-working-copy-clean)" = "true" ]; then
        echo -e "\e[1;31mERROR!\e[0m: No changes to stash!"
        return
    fi

    STASH_TYPE="${1}"
    shift
    local MSG_PARAM="$@"
    if [ "${STASH_TYPE}" = "CHECKPOINT" ]; then
        MSG="${CHECKPOINT} ${MSG_PARAM}"
    else
        MSG="${WIP} ${MSG_PARAM}"
    fi

    git add -A
    git commit -qm "${MSG}"
    git log --color=always HEAD~1..HEAD --pretty="%C(dim)%h%C(reset) %s%n%nChanges stashed:"
    git --no-pager log --color=always HEAD~1..HEAD --pretty="" --stat
}

git-unstash() {
    local WIP_ONLY="false"
    local ALL="false"
    for arg; do
       if [ "$arg" = "--all" ]; then
           ALL="true"
       elif [ "$arg" = "--wip-only" ]; then
           WIP_ONLY="true"
       elif ! [ "$arg" = "UNSTASH" ]; then
           echo -e "\e[1;31mERROR!\e[0m: Unknown argument: ${arg}"
           return
       fi
    done

    if ! [ "$(is-head-qstashed ${WIP_ONLY})" = "true" ]; then
        echo -e "\e[1;31mERROR!\e[0m: HEAD is not a qstash-ed commit!"
        return
    fi
    unstash

    if [ "${ALL}" = "true" ]; then
        while [ "$(is-head-qstashed ${WIP_ONLY})" = "true" ]
        do
            unstash
        done
    fi

    echo ""
    git -c color.status=always status | grep --color=always -v "^[a-zA-Z].*[^:]$" | sed -r '/\(use "git (pull|add|checkout)/d' | sed 's/ for commit:$/:/' | sed '/^\s*$/d'
}

MARKER="##!##!##!##!##"
unstash() {
    local MSG=`git log --color=always HEAD~1..HEAD --pretty="%C(dim)%h%C(reset) %C(bold green)${MARKER}%ad${MARKER}%C(reset) %s" | sed -r "s/${MARKER}(.{16}).*${MARKER}/\1/"`
    git reset HEAD~1 >> /dev/null
    echo -e "Unstashed: ${MSG}"
}

is-head-qstashed() {
    local HEADMSG=`git log HEAD~1..HEAD --pretty='%s'`
    local HEAD_IS_WIP=`echo "${HEADMSG}" | sed -n "/^${WIP}/p" | wc -l`
    if ! [ "${HEAD_IS_WIP}" = "0" ]; then
        echo "true"
        return
    elif [ "${1}" = "false" ]; then
        local HEAD_IS_CHECKPOINT=`echo "${HEADMSG}" | sed -n "/^${CHECKPOINT}/p" | wc -l`
        if ! [ "${HEAD_IS_CHECKPOINT}" = "0" ]; then
            echo "true"
            return
        fi
    fi

    echo "false"
}

is-working-copy-clean() {
    if [ -z "$(git status --porcelain)" ]; then
      echo true
    else
      echo false
    fi
}

if [ "${1}" = "STASH" ] || [ "${1}" = "CHECKPOINT" ]; then
    git-stash "$@"
elif [ "${1}" = "UNSTASH" ]; then
    git-unstash "$@"
fi
```
