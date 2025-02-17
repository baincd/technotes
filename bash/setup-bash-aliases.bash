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
alias killallX=`which killall`
alias nlX=`which nl`
alias columnX=`which column`
alias typeX='builtin type'

# Helpful defaults
alias grep='grep --color=auto '
alias ls='ls -l -F --color=auto --show-control-chars' # -F = append indicator (one of */=>@|) to entries
alias less='less -S' 	# Disable long line wrap
function mkdirs() {  if [ -d "${@: -1}" ]; then echo "ERROR: ${@: -1} already exists!"; else mkdir -p -v -- "$@"; fi } # make directory and subdirectories
alias killall='killall -v'
alias nl='nl -b a ' # Number all lines
alias column='column -t -e -s ' # Break input into columns, delimiting on first param
alias type='type -a'

# Helpful defaults with color always enabled (useful for piping into other commands)
# ex: `grepc -r searchterm * | lessc`
alias grepc='grep --color=always'
alias lsc='ls --color=always'
alias lessc='less -R'
alias gitc='git -c color.ui=always -c color.advice=always -c color.branch=always -c color.diff=always -c color.grep=always -c color.interactive=always -c color.push=always -c color.remote=always -c color.showBranch=always -c color.status=always -c color.transport=always '

# Strip common ANSI control sequences, including color output.
# Courtesy Dennis Kaarsemaker https://unix.stackexchange.com/a/55547
alias strip-ansi-control-seqs="sed -e 's/\x1B\[[0-9;]*[JKmsu]//g'"

# Commands for source code - ignore .svn/, .git/, target/, and node_modules/
alias grepsrc='grep --exclude-dir=".svn" --exclude-dir=".git" --exclude-dir="target" --exclude-dir="node_modules" '
alias grepsrcc='grepsrc --color=always'
alias findsrc='find -not -path "*/.svn/*" -not -name .svn -not -path "*/.git/*" -not -name .git -not -path "*/target/*" -not -name target -not -path "*/node_modules/*" -not -name node_modules '

# Directory Tools

## Make today temp directory (mkdirs ~/tmp/YYYY-MM-DD and set $ttmp variable to that directory)
function mkttmp() { export ttmp=~/tmp/`date +%Y-%m-%d`; mkdirs $ttmp; }

## Make and Change Directory
function mkcd() { mkdirs "$@" && cd "${@: -1}" ; }

# Bash Settings

## Do not add commands that start with a space to the bash history
HISTCONTROL=ignorespace

PATH=$PATH:~/bin

# Development tools

alias f='git f'
alias cd-git-root='cd ./$(git rev-parse --show-cdup)'

### Maven Aliases ###

## Make Maven Dirs (Create the maven directories and an empty pom.xml file)
function mkmvndirs() { mkdirs "${1:-.}/src/main/java" && mkdirs "${1:-.}/src/main/resources" && mkdirs "${1:-.}/src/test/java" && mkdirs "${1:-.}/src/test/resources" && touch "${1:-.}/pom.xml" ; }
# Alias to run mvn generate-sources from all poms that contain either plugin_one or plugin_two (using simple grep of pom.xml)
alias mvn-gen-all-sources='findsrc -name pom.xml -exec grep -q "plugin_one\|plugin_two" {} \; \( -exec ./mvnw clean generate-sources -f {} \; -o -quit \) '

function mvn-dep-tree() { 
  mvn dependency:tree --batch-mode "$@" | \
  stdbuf -o0 sed \
    -re '/^\[INFO\] [a-zA-Z0-9\._-]+(:[a-zA-Z0-9\._-]+){3}/,/^\[INFO\] -{72}?$/s/^\[INFO\] /»»»/' \
    -re '/^»»»/s/-{72}$//' \
    -re '/^»»»/s/\+- |\|  |\\- /   /g' \
    -re '/^(\[INFO\] BUILD FAILURE$|\[FATAL\])/,$s/^/»»/' \
    -nre '/^»»+/s/^»»+//p'
}

function mvn-dep-verbose() { 
  mvn -X -Dmaven.resources.skip=true -Dmaven.main.skip=true -Dmaven.test.skip=true -Dmaven.source.skip=true -Dmaven.install.skip=true -Dmaven.deploy.skip=true --batch-mode "$@" | \
  stdbuf -o0 sed \
    -re '/^\[DEBUG\] [a-zA-Z0-9\._-]+(:[a-zA-Z0-9\._-]+){3}/,/^\[(DEBUG|INFO)\] (\S|$)/s/^\[(DEBUG|INFO)\] /»»»/' \
    -re 's/^(»»»)\S.*\s\S.*/\1/' \
    -re '/^(\[INFO\] BUILD FAILURE$|\[FATAL\])/,$s/^/»»/' \
    -nre '/^»»+/s/^»»+//p'
}

function npm-dep-tree() { 
  npm ls --all "$@" | \
  sed \
    -re 's/[├─┬└│]/ /g' \
    -re 's/^  //' ; 
}

###

## Delete files and directories associated with Eclipse Java projects
### - This will delete these files and folders only from directories that contain a .project file
### - The filtering of "No such file or directory" in the output is to ignore that error due to the find command attempting to traverse a directory it previously deleted.
### - Does not delete .metadata/ (the Eclipse workspace)
### - (I know the target/ folder is from Maven and not Eclipse directly, but I still think it is helpful to delete it :-)  )
alias eclipse-clean='find -name .project -type f -execdir rm -rfv .project .classpath .wtpmodules bin/ .settings/ target/ \; 2>&1 | grep -v "No such file or directory"'

# Fix weird characters when pasting into vscode integrated Bash terminal
# References:
#    https://github.com/microsoft/vscode/issues/141879#issuecomment-1025950186
#    https://github.com/microsoft/vscode/issues/142677#issuecomment-1035049370
#    https://code.visualstudio.com/docs/editor/integrated-terminal#_i-see-1-or-201-when-i-paste-something
bind 'set enable-bracketed-paste off'

# Tool Helpers

alias gnucash-monthly-expense-report-to-spreadsheet="tac | tac | sed -re 's/^(Monthly Expense Report:)/##### \1 #####/' -re '/^Act\tAct\tAct/d' -re '/^(Big )?Expenses/d' -re 's/^[\t ]+//' -re 's/([^\t]*)\t\t/\1\t/' -re '4s/^/\t/' -re 's/\$//g'"

alias atom-clean="rm -rf ~/.atom/compile-cache && rm -rf ~/.atom/storage && atom"

function fullpath() { echo $(realpath `pwd`/$1) ; }
