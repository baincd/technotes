<!-- ### Page Linked from setup-git-aliases.md ### -->
* `git qstash [<msg>]` - Stash all changes (staged, unstaged, and untracked) in a new commit.  Optional message will be appended to commit message.  Following this command, the working copy will be clean.
* `git qunstash [--all]` - Unstash a previous qstash.  This will move all qstash-ed changes and staged changes to unstaged/untracked.  The qstash commit will be thrown away and the staging area will be reset.
    * If the HEAD commit is not a qstash commit, then command will abort
    * `--all` will roll back consecutive qstash commits, back to first non-qstash commit
    * qstash commits are determined by the commit message starting with "WIP!"

## `~/.gitconfig`
```
[alias]
    qstash = "!f() { ~/bin/git-qstash.sh STASH $@ ;}; f"
    qunstash = "!f() { ~/bin/git-qstash.sh UNSTASH $1 ;}; f"
```

## `~/bin/git-qstash.sh`
```bash
#!/bin/bash

WIP="WIP!"

git-stash() {
    local ARGS="$@"
    MSG=`echo "${ARGS}" | sed -r 's/^STASH ?//'`

    git add -A
    git commit -qm "${WIP} ${MSG}"
    git log --color=always HEAD~1..HEAD --pretty="%C(dim)%h%C(reset) %s" --name-status  | sed '/^\s*$/d'
}

git-unstash() {
    if ! [ "$(git-is-wip)" = "true" ]; then
        echo -e "\e[1;31mERROR!\e[0m: HEAD is not a qstash-ed commit!"
        return
    fi
    git-do-unstash

    if [ "${1}" = "--all" ]; then
        while [ "$(git-is-wip)" = "true" ]
        do
            git-do-unstash
        done
    fi

    echo ""
    git -c color.status=always status | grep --color=always -v "^[a-zA-Z].*[^:]$" | sed -r '/\(use "git (pull|add|checkout)/d' | sed '/^\s*$/d'
}

MARKER="##!##!##!##!##"
git-do-unstash() {
    MSG=`git log --color=always HEAD~1..HEAD --pretty="%C(dim)%h%C(reset) %C(bold green)${MARKER}%ad${MARKER}%C(reset) %s" | sed -r "s/${MARKER}(.{16}).*${MARKER}/\1/"`
    git reset HEAD~1 >> /dev/null
    echo -e "Unstashed: ${MSG}"
}

git-is-wip() {
    HEADMSG=`git log HEAD~1..HEAD --pretty='%s'`
    HEAD_IS_WIP=`echo "${HEADMSG}" | sed -n "/^${WIP}/p" | wc -l`
    if ! [ "${HEAD_IS_WIP}" = "0" ]; then
        echo "true"
    else
        echo "false"
    fi
}

if [ "${1}" = "STASH" ]; then
    git-stash "$@"
elif [ "${1}" = "UNSTASH" ]; then
    git-unstash "${2}"
fi
```
