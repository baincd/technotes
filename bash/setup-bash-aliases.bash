# Add to ~/.bashrc

# 1) Execute:
# ln -s ~/wc/technotes/bash/setup-bash-aliases.bash ~/.bash-aliases.bash
#
# 2) Add to ~/.bashrc:
# if [ -f ~/.bash-aliases.bash ]; then
#     . ~/.bash-aliases.bash
# fi

# No options set versions
alias grepX=`which grep`
alias findX=`which find`
alias lsX=`which ls`
alias lessX=`which ls`
alias killallX=`which killall`
alias pushdX='builtin pushd'
alias popdX='builtin popd'
alias cdX='builtin cd'
alias mkdirX=`which mkdir`

# Helpful defaults
alias grep='grep --color=auto '
alias grepsrc='grep --exclude-dir=".svn" --exclude-dir=".git" --exclude-dir="target" --exclude-dir="node_modules" '
alias findsrc='find -not -path "*/.svn/*" -not -name .svn -not -path "*/.git/*" -not -name .git -not -path "*/node_modules/*" -not -name node_modules '
alias ls='ls -l -F --color=auto --show-control-chars' # -F = append indicator (one of */=>@|) to entries
alias less='less -S' 	# Disable long line wrap
alias killall='killall -v'
alias f='git f'
alias nl='nl -b a ' # Number all lines
alias column='column -t -e -s ' # Break input into columns, delimiting on first param

# Colorized versions
alias grepc='grep --color=always'
alias grepsrcc='grepsrc --color=always'
alias lsc='ls --color=always'
alias lessc='less -R'

function mkdir() {
  if [ -d "${@: -1}" ]; then echo "ERROR: ${@: -1} already exists!"; else mkdirX -p -v -- "$@"; fi
}
function mkttmp() { export ttmp=~/tmp/`date +%Y-%m-%d`; mkdir $ttmp; }
function mkcd() { mkdir "$@" && cd "${@: -1}" ; }

alias atom-clean="rm -rf ~/.atom/compile-cache && rm -rf ~/.atom/storage && atom"

# Do not add commands that start with a space to the bash history
HISTCONTROL=ignorespace

PATH=$PATH:~/bin

function mkmvndirs() { mkdir "$1/src/main/java" && mkdir "$1/src/main/resources" && mkdir "$1/src/test/java" && mkdir "$1/src/test/resources" && touch "$1/pom.xml" ; }

# Delete files and directories associated with Eclipse Java projects
# - This will delete these files and folders only from directories that contain a .project file
# - The filtering of "No such file or directory" in the output is to ignore that error due to the find command attempting to traverse a directory it previously deleted.
# - Does not delete .metadata/ (the Eclipse workspace)
# - (I know the target/ folder is from Maven and not Eclipse directly, but I still think it is helpful to delete it :-)  )
alias eclipse-clean='find -name .project -type f -execdir rm -rfv .project .classpath .wtpmodules bin/ .settings/ target/ \; 2>&1 | grep -v "No such file or directory"'


alias gnucash-monthly-expense-report-to-spreadsheet="tac | tac | sed -re 's/^(Monthly Expense Report:)/##### \1 #####/' -re '/^Act\tAct\tAct/d' -re '/^(Big )?Expenses/d' -re 's/^[\t ]+//' -re 's/([^\t]*)\t\t/\1\t/' -re '4s/^/\t/' -re 's/\$//g'"
