<!-- ### Page Linked from setup-git-aliases.md ### -->
* `git qstash [<msg>]` - Stash all changes (staged, unstaged, and untracked) in a new commit.  Commit subject will begin with "WIP!" with optional `<msg>` appended.  Following this command, the working copy will be clean.
* `git checkpoint [<msg>]` - Same functionality as `git qstash`, but commit subject will begin with "CHECKPOINT!"
* `git qunstash [--all]` - Unstash a previous qstash.  This will move all qstash-ed changes and staged changes to unstaged/untracked.  The qstash commit will be thrown away and the staging area will be reset.
    * If the HEAD commit is not a qstash commit, then command will abort
    * `--all` will roll back consecutive qstash commits, back to first non-qstash commit
    * qstash commits are determined by the commit message starting with "WIP!" or "CHECKPOINT!"

## `~/.gitconfig`
```
[alias]
    qstash = "!f() { ~/bin/git-qstash.sh STASH $@ ;}; f"
    checkpoint = "!f() { ~/bin/git-qstash.sh CHECKPOINT $1 ;}; f"
    qunstash = "!f() { ~/bin/git-qstash.sh UNSTASH $1 ;}; f"
```

## `~/bin/git-qstash.sh`
```bash
#!/bin/bash

WIP="WIP!"
CHECKPOINT="CHECKPOINT!"

git-stash() {
    local ARGS="$@"
    MSG=`echo "${ARGS}" | sed -r 's/^STASH ?//'`
    stash-files "${WIP} ${MSG}"
}

git-checkpoint() {
    local ARGS="$@"
    MSG=`echo "${ARGS}" | sed -r 's/^CHECKPOINT ?//'`
    stash-files "${CHECKPOINT} ${MSG}"
}

stash-files() {
    git add -A
    git commit -qm "${1}"
    git log --color=always HEAD~1..HEAD --pretty="%C(dim)%h%C(reset) %s%n%nFiles stashed:"
    git --no-pager log --color=always HEAD~1..HEAD --pretty="" --stat
}

git-unstash() {
    if ! [ "$(is-wip)" = "true" ]; then
        echo -e "\e[1;31mERROR!\e[0m: HEAD is not a qstash-ed commit!"
        return
    fi
    unstash

    if [ "${1}" = "--all" ]; then
        while [ "$(is-wip)" = "true" ]
        do
            unstash
        done
    fi

    echo ""
    git -c color.status=always status | grep --color=always -v "^[a-zA-Z].*[^:]$" | sed -r '/\(use "git (pull|add|checkout)/d' | sed 's/ for commit:$/:/' | sed '/^\s*$/d'
}

MARKER="##!##!##!##!##"
unstash() {
    MSG=`git log --color=always HEAD~1..HEAD --pretty="%C(dim)%h%C(reset) %C(bold green)${MARKER}%ad${MARKER}%C(reset) %s" | sed -r "s/${MARKER}(.{16}).*${MARKER}/\1/"`
    git reset HEAD~1 >> /dev/null
    echo -e "Unstashed: ${MSG}"
}

is-wip() {
    HEADMSG=`git log HEAD~1..HEAD --pretty='%s'`
    HEAD_IS_WIP=`echo "${HEADMSG}" | sed -n "/^${WIP}/p" | wc -l`
    HEAD_IS_CHECKPOINT=`echo "${HEADMSG}" | sed -n "/^${CHECKPOINT}/p" | wc -l`
    if ! [ "${HEAD_IS_WIP}" = "0" ] || ! [ "${HEAD_IS_CHECKPOINT}" = "0" ]; then
        echo "true"
    else
        echo "false"
    fi
}

if [ "${1}" = "STASH" ]; then
    git-stash "$@"
elif [ "${1}" = "CHECKPOINT" ]; then
    git-checkpoint "$@"
elif [ "${1}" = "UNSTASH" ]; then
    git-unstash "${2}"
fi
```
