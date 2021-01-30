#!/bin/bash

# See setup-git-aliases.gitconfig for how to setup this file

cmd=$1
args=("${@:2}")

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
  # Uses colors from the output to search and parse:
  #   GREEN is start of line (others are filtered out)
  #   text between BOLD CYAN and RESET is refname
  # If output is changed in branches, rbranches, or tags output, this method will need to be fixed!
  local gitcmd=$1
  local searchkey=$2
  if [ -z "${searchkey}" ]; then
    # Note: Performance could be improved by only calling `git ${gitcmd}` once
    git ${gitcmd} > /dev/tty
    read -p "Line Number or Ref substr > " searchkey
  fi
  if [ -z "${searchkey}" ]; then
    echo "" # "Checkout aborted"
  elif [[ ${searchkey} =~ ^[0-9]{1,2}$ ]]; then
    git ${gitcmd} | sed -ne '/^\x1b\[32m/p' | sed -ne ${searchkey}p | sed -re 's/^.*\x1b\[1;36m//' -re 's/\x1b\[m.*$//' ;
  else
    git ${gitcmd} | sed -ne '/^\x1b\[32m/p' | sed -nre "s/^.*\x1b\[1;36m([^\x1b]*${searchkey}[^\x1b]*)\x1b\[m.*$/\1/p" | head -n 1
  fi
}

function branches-ref() {
  _find-nth-or-first-grepped-id branches "$@"
}

function branches-co() {
  local lb=$(branches-ref "$@")
  git checkout "${lb}"
}

function rbranches-ref() {
  _find-nth-or-first-grepped-id rbranches "$@"
}

function rbranches-co() {
  local rb=$(rbranches-ref "$@")
  local lb=`echo "${rb}" | sed 's,^[^/]*/,,'`
  if [ -z "$(git show-ref refs/heads/${lb})" ]; then
    git checkout -b "${lb}" "${rb}"
  else
    git checkout "${lb}" && git ffup
  fi
}

function tags-ref() {
  _find-nth-or-first-grepped-id tags "$@"
}

function tags-co() {
  local tag=$(tags-ref "$@")
  git checkout -b "${tag}-branch" "${tag}"
}

function alias-help() {
  local alias=$1
  local desc=$2
  local usages=("${@:3}")
  $echoe "\033[1m${alias}\033[0m: ${desc}"
  for usage in "${usages[@]}"
  do
    # Wrap any line that starts with $ with ANSI color codes to make dim
    # Replace !! with #, and make text dim green (for a comment)
    line=`echo $usage | sed -re 's/^(\\$.*)$/\x1b[2m\1\x1b[0m/' -re 's/!!/\x1b[32;2m#/'`
    $echoe "  ${line}"
  done
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
