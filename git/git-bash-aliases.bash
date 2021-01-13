#!/bin/bash

# See setup-git-aliases.gitconfig for how to setup this file

cmd=$1
args=(${@:2})

echoe="$(which echo) -e"

function conflict() {
  cd -- ${GIT_PREFIX:-.} && git conflicts | \
    sed -re 's/^[^ A-Z]*[DAU][DAU][^ A-Z]* //' | \
    ( if [[ $1 =~ ^[0-9]{1,2}$ ]]; then sed -ne ${1}p; else grep "${1}" | head -n 1; fi; )
}

function file-mod() {
  cd -- ${GIT_PREFIX:-.} && git status --short | \
    sed -e 's/^...//' | \
    ( if [[ $1 =~ ^[0-9]{1,2}$ ]]; then sed -ne ${1}p; else grep "${1}" | head -n 1; fi; )
}

function _find-nth-or-first-grepped-id() {
  if [[ $2 =~ ^[0-9]{1,2}$ ]]; then
    git $1 | sed -ne ${2}p | sed -re 's/^.*\x1b\[1;36m//' -re 's/\x1b\[m.*$//' ;
  else
    # find-first-id will use all but the last argument as a git cmd and args, then return first text matching the last argument (expanding it to the first space or colon)
    # Use Perl-compatible regular expressions in grep to regex match is non-greedy
    searchkey="${@: -1}" # Last argument is search key
    gitcmd=("${@:1:${#}-1}") # other arguments makeup git command
    git "${gitcmd[@]}" | sed -nre "s/^.*\x1b\[1;36m([^\x1b]*${searchkey}[^\x1b]*)\x1b\[m.*$/\1/p" | head -n 1
  fi;
}

function branches-co() {
  local lb=$(_find-nth-or-first-grepped-id branches "$@")
  git checkout "${lb}"
}

function rbranches-co() {
  local rb=$(_find-nth-or-first-grepped-id rbranches-all "$@")
  local lb=`echo "${rb}" | sed 's,^[^/]*/,,'`
  git checkout -b "${lb}" "${rb}"
}

function tags-co() {
  local tag=$(_find-nth-or-first-grepped-id tags-all "$@")
  git checkout -b "${tag}-branch" "${tag}"
}

function helpme-log-search() {
  $echoe "\033[1mSearch commit message\033[0m"
  $echoe "  --grep=<regex>"
  $echoe "    \033[2m* By default limits to commits that match any --grep=<regex> param\033[0m"
  $echoe "    \033[2m* Use --all-match to limit to commits that match all --grep=<regex> params\033[0m"
  $echoe "    \033[2m* Use --invert-grep to limit to commits that do not match <regex>\033[0m"
  $echoe ""
  $echoe "\033[1mSearch patches\033[0m"
  $echoe "  -G<regex>"
  $echoe ""
  $echoe "\033[1mSearch patches for change in number of occurrences\033[0m"
  $echoe "  -S<regex> --pickaxe-regex"
  $echoe "    \033[2m* Do not use --pickaxe-regex to search string instead of regex\033[0m"

  # [`-S and -G`](https://git-scm.com/docs/git-log#git-log--Sltstringgt) \
  # [`--grep`](https://git-scm.com/docs/git-log#git-log---grepltpatterngt)
}

function helpme-log-output() {
  $echoe "--graph"
  $echoe "--decorate (show refs)"
  $echoe "--oneline"
  $echoe "--format=oneline|short|medium|full|fuller|<format> (default => medium)"
  $echoe "--abbrev-commit"
  $echoe "--date=relative|local|short|format:<format> (short is YYYY-MM-DD)"
  $echoe "--all (all refs on command line)"
  $echoe "-p (print patches)"
}

function helpme-log-merge-diff() {
  $echoe "\033[1mCombined diff from each parent\033[0m"
  $echoe "  -c"
  $echoe "    \033[2mShow the differences from each of the parents to the merge result\033[0m"
  $echoe "    \033[2msimultaneously, listing only files which were modified from all parents\033[0m"
  $echoe ""
  $echoe "\033[1mCombined diff from each parent (interesting changes only)\033[0m"
  $echoe "  --cc"
  $echoe "    \033[2mSame as -c option but omitting uninteresting hunks\033[0m"
  $echoe ""
  $echoe "\033[1mSplit diff for each parent\033[0m"
  $echoe "  -p -m"
  $echoe "    \033[2mShow the full diff like regular commits for each merge parent. A separate\033[0m"
  $echoe "    \033[2mlog entry and diff is generated for each parent\\033[0m"
  $echoe ""
  $echoe "\033[1mDiff only with first parent (branch merged into)\033[0m"
  $echoe "  -p -m --first-parent"
  $echoe "    \033[2mShow only the changes the merge brought into the then-current branch\033[0m"
}


$cmd "${args[@]}"
