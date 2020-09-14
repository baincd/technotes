################################################################################
# # Chris' Awesome Bash Aliases and Commands                                   #
#                                                                              #
# Very useful and helpful Bash aliases.  View the file contents to see aliases #
# and commands defined.                                                        #
#                                                                              #
# ## Setup Option 1: Import into ~/.bashrc                                     #
#                                                                              #
# 1. Create `~/.bash-aliases.bash`                                             #
#    a. Create symbolic link with following command                            #
#     `ln -s ~/wc/technotes/bash/setup-bash-aliases.bash ~/.bash-aliases.bash` #
#    b. OR Save this file to `~/.bash-aliases.bash`                            #
#                                                                              #
# 2. Add to ~/.bashrc:                                                         #
# ```                                                                          #
# if [ -f ~/.bash-aliases.bash ]; then                                         #
#     . ~/.bash-aliases.bash                                                   #
# fi                                                                           #
# ```                                                                          #
#                                                                              #
# ## Setup Option 2: Copy contents directly into ~/.bashrc                     #
################################################################################

# Aliases to commands without my helpful defaults
alias grepX=`which grep`
alias lsX=`which ls`
alias lessX=`which ls`
alias mkdirX=`which mkdir`
alias killallX=`which killall`
alias nlX=`which nl`
alias columnX=`which column`
alias typeX='builtin type'

# Helpful defaults
alias grep='grep --color=auto '
alias ls='ls -l -F --color=auto --show-control-chars' # -F = append indicator (one of */=>@|) to entries
alias less='less -S' 	# Disable long line wrap
function mkdir() {  if [ -d "${@: -1}" ]; then echo "ERROR: ${@: -1} already exists!"; else mkdirX -p -v -- "$@"; fi } # make directory and subdirectories
alias killall='killall -v'
alias nl='nl -b a ' # Number all lines
alias column='column -t -e -s ' # Break input into columns, delimiting on first param
alias type='type -a'

# Helpful defaults with color always enabled (useful for piping into other commands)
# ex: `grepc -r searchterm * | lessc`
alias grepc='grep --color=always'
alias lsc='ls --color=always'
alias lessc='less -R'

# Strip common ANSI control sequences, including color output.
# Courtesy Dennis Kaarsemaker https://unix.stackexchange.com/a/55547
alias strip-ansi-control-seqs="sed -e 's/\x1B\[[0-9;]*[JKmsu]//g'"

# Commands for source code - ignore .svn/, .git/, target/, and node_modules/
alias grepsrc='grep --exclude-dir=".svn" --exclude-dir=".git" --exclude-dir="target" --exclude-dir="node_modules" '
alias grepsrcc='grepsrc --color=always'
alias findsrc='find -not -path "*/.svn/*" -not -name .svn -not -path "*/.git/*" -not -name .git -not -path "*/node_modules/*" -not -name node_modules '

# Directory Tools

## Make today temp directory (mkdir ~/tmp/YYYY-MM-DD and set $ttmp variable to that directory)
function mkttmp() { export ttmp=~/tmp/`date +%Y-%m-%d`; mkdir $ttmp; }

## Make and Change Directory
function mkcd() { mkdir "$@" && cd "${@: -1}" ; }

# Bash Settings

## Do not add commands that start with a space to the bash history
HISTCONTROL=ignorespace

PATH=$PATH:~/bin

# Development tools

alias f='git f'
alias cd-git-root='cd $(git rev-parse --show-toplevel)'

## Make Maven Dirs (Create the maven directories and an empty pom.xml file)
function mkmvndirs() { mkdir "${1:-.}/src/main/java" && mkdir "${1:-.}/src/main/resources" && mkdir "${1:-.}/src/test/java" && mkdir "${1:-.}/src/test/resources" && touch "${1:-.}/pom.xml" ; }

## Delete files and directories associated with Eclipse Java projects
### - This will delete these files and folders only from directories that contain a .project file
### - The filtering of "No such file or directory" in the output is to ignore that error due to the find command attempting to traverse a directory it previously deleted.
### - Does not delete .metadata/ (the Eclipse workspace)
### - (I know the target/ folder is from Maven and not Eclipse directly, but I still think it is helpful to delete it :-)  )
alias eclipse-clean='find -name .project -type f -execdir rm -rfv .project .classpath .wtpmodules bin/ .settings/ target/ \; 2>&1 | grep -v "No such file or directory"'

# Tool Helpers

alias gnucash-monthly-expense-report-to-spreadsheet="tac | tac | sed -re 's/^(Monthly Expense Report:)/##### \1 #####/' -re '/^Act\tAct\tAct/d' -re '/^(Big )?Expenses/d' -re 's/^[\t ]+//' -re 's/([^\t]*)\t\t/\1\t/' -re '4s/^/\t/' -re 's/\$//g'"

alias atom-clean="rm -rf ~/.atom/compile-cache && rm -rf ~/.atom/storage && atom"
