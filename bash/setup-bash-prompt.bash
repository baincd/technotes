# Add to ~/.bashrc

# 1) Execute:
# ln -s ~/wc/technotes/bash/setup-bash-prompt.bash ~/.bash-prompt.bash
#
# 2) Add to ~/.bashrc:
# if [ -f ~/.bash-prompt.bash ]; then
#     . ~/.bash-prompt.bash
# fi
#
# # add default prompt (gps, gpss, gpb, or gpq)
# gpb

DEFAULT_PS1=$PS1

# For Servers:
# username@hostname dir
# export PS1="\[\033]0;\u@\h \w\007\]\n\[\033[01;32m\]\u@\h\[\033[m\] \[\033[01;33m\]\w\[\033[m\]\n$ "

# For development workstation:
_PS1_PRE_='\[\033]0;\w\007\]\[\033[01;33m\]\w\[\033[01;36m\]'
_PS1_POST_='\[\033[0m\]\n$ '

_PS1_NO_BRANCH_="$_PS1_PRE_$_PS1_POST_"
_PROMPT_COMMAND_GIT_PS1_='__dirs_prompt && __git_ps1 "\n$_PS1_PRE_" "$_PS1_POST_" '
_PROMPT_COMMAND_GIT_STATUS_='__dirs_prompt && __git_status_cmd_for_prompt'
_PROMPT_COMMAND_GIT_SHORT_STATUS_='__dirs_prompt && __git_status_cmd_for_prompt SHORT'
_PROMPT_COMMAND_NOTHING_='__dirs_prompt && echo ""'

alias gpq='PS1=$_PS1_NO_BRANCH_       PROMPT_COMMAND=$_PROMPT_COMMAND_NOTHING_'    # Git Prompt Quiet (no git info)
alias gpb='PS1=                       PROMPT_COMMAND=$_PROMPT_COMMAND_GIT_PS1_'    # Git Prompt Branch (include branch name - similar to default git prompt)
alias gps='PS1=$_PS1_NO_BRANCH_       PROMPT_COMMAND=$_PROMPT_COMMAND_GIT_STATUS_' # Git Prompt Status (include short git status)
alias gpss='PS1=$_PS1_NO_BRANCH_      PROMPT_COMMAND=$_PROMPT_COMMAND_GIT_SHORT_STATUS_' # Git Prompt branch Status and file count

gps

# Helpful aliases that run git status, and not run git status a second time as part of the prompt
alias s='skip-prompt-command-once && git s'
alias sv='skip-prompt-command-once && git sv'
alias gitq='skip-prompt-command-once && git'
alias reset-prompt-command='echo "" && PROMPT_COMMAND=${PROMPT_COMMAND_TMP} && unset PROMPT_COMMAND_TMP'
alias skip-prompt-command-once='PROMPT_COMMAND_TMP=$PROMPT_COMMAND PROMPT_COMMAND=reset-prompt-command'


# Bash Prompt Notes:
# Remove '\[\033]0;\w\007\]' at beginning to not change window title

# Replace '\w' with '${PWD//[^[:ascii:]]/?}' to avoid beeps on non-printable chars
# https://github.com/msysgit/msysgit/issues/128

# Create custom Bash prompts: http://ezprompt.net/
_PROMPT_DIRS_ENABLED="true"

dirspr-on() { # dirs prompt on
  export _PROMPT_DIRS_ENABLED="true"
}

dirspr-off() { # dirs priompt off
  export _PROMPT_DIRS_ENABLED="false"
}

__dirs_prompt() {
  if [ "$_PROMPT_DIRS_ENABLED" = "true" ]; then
    #  dirs -v : List all dirs in stack, one per line
    #  sed ... : Show rows 2-6 only (first 5 in stack not including current dir) and format like "/path/to/dir (1) | "
    #  tr ...  : Chomp off all new lines, making entire string a single line
    #  sed ... : Remove final " | "
    #  cut ... : Chomp off at terminal width (do not wrap)
    local OUT=`dirs -v | sed -ne '2,6s/^ \([0-9]\)\+ *\(.*\)/\2 (\1) | /p' | tr -d '\n' | sed 's/ | $//' | cut -b -$(tput cols)`
    if [ "$OUT" ]; then
      echo -e "\e[2m" # dim
      echo -n "$OUT" # Show only first 5, move row number to end, and reverse order
      echo -en "\e[0m" # reset
    fi
  fi
}


__git_status_cmd_for_prompt() {
  local type="$1"
  local g="$(git rev-parse --git-dir 2> /dev/null)";

  echo ""
  if [ -z "$g" ]; then
    return 0;
  fi;

  local OUTPUT=`git -c color.status=always -c color.status.localBranch="cyan" status --short --branch 2> /dev/null`
  if [ "$type" == "SHORT" ]; then
    OUTPUT=`echo -e "$OUTPUT" | sed "s/^[^#][^#].*$/Files Changed/" | uniq -c | sed -e "s/^ *1 ##/##/" -e "s/^ *//" -e "s/^1 Files/1 File/"`
  fi

  local r=`__git_repo_status`
  if [ -n "$r" ]; then
    echo -e -n "\033[01;31m"
    echo "*** $r ***"
  fi;

  echo -e -n "\033[01;36m" # Change color to bold cyan (which affects the ## in the git status line because git status apparently doesn't reset bold before outputting the branch name - To anyone reading this - please don't fix this "feature" in git - I like it  :-)
  echo -e -n "$OUTPUT"
  echo -e "\033[0m"
}

__git_repo_status() {
  # Adapted from __git_ps1 function
  local r="";
  local b="";
  local step="";
  local total="";
  if [ -d "$g/rebase-merge" ]; then
      __git_eread "$g/rebase-merge/head-name" b;
      __git_eread "$g/rebase-merge/msgnum" step;
      __git_eread "$g/rebase-merge/end" total;
      if [ -f "$g/rebase-merge/interactive" ]; then
          r="|REBASE-i";
      else
          r="|REBASE-m";
      fi;
  else
      if [ -d "$g/rebase-apply" ]; then
          __git_eread "$g/rebase-apply/next" step;
          __git_eread "$g/rebase-apply/last" total;
          if [ -f "$g/rebase-apply/rebasing" ]; then
              __git_eread "$g/rebase-apply/head-name" b;
              r="|REBASE";
          else
              if [ -f "$g/rebase-apply/applying" ]; then
                  r="|AM";
              else
                  r="|AM/REBASE";
              fi;
          fi;
      else
          if [ -f "$g/MERGE_HEAD" ]; then
              r="|MERGING";
          else
              if [ -f "$g/CHERRY_PICK_HEAD" ]; then
                  r="|CHERRY-PICKING";
              else
                  if [ -f "$g/REVERT_HEAD" ]; then
                      r="|REVERTING";
                  else
                      if [ -f "$g/BISECT_LOG" ]; then
                          r="|BISECTING";
                      fi;
                  fi;
              fi;
          fi;
      fi;
      # if [ -n "$b" ]; then
      #     :;
      # else
      #     if [ -h "$g/HEAD" ]; then
      #         b="$(git symbolic-ref HEAD 2>/dev/null)";
      #     else
      #         local head="";
      #         if ! __git_eread "$g/HEAD" head; then
      #             return $exit;
      #         fi;
      #         b="${head#ref: }";
      #         if [ "$head" = "$b" ]; then
      #             detached=yes;
      #             b="$(
      # case "${GIT_PS1_DESCRIBE_STYLE-}" in
      # (contains)
      #   git describe --contains HEAD ;;
      # (branch)
      #   git describe --contains --all HEAD ;;
      # (tag)
      #   git describe --tags HEAD ;;
      # (describe)
      #   git describe HEAD ;;
      # (* | default)
      #   git describe --tags --exact-match HEAD ;;
      # esac 2>/dev/null)" || b="$short_sha...";
      #             b="($b)";
      #         fi;
      #     fi;
      # fi;
  fi;

  if [ -n "$b" ]; then
      r="$r (${b##refs/heads/})";
  fi;
  if [ -n "$step" ] && [ -n "$total" ]; then
      r="$r $step/$total";
  fi;
  echo -n "$r" | sed "s/|//"
}
