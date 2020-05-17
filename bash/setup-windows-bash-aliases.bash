################################################################################
# # Chris' Awesome Windows Bash Aliases                                        #
#                                                                              #
# Bash commands on Windows present extra challenges.  These commands make      #
# that experience a bit better.                                                #
#                                                                              #
# - `winpath <bashpath>` - Convert a bash file path to a Windows file path     #
#        ex: "winpath /c/Users/baincd/.m2/settings.xml"                        #
# - `bashpath <winpath>` - Convert a Windows file path to a bash file path     #
#        ex: "bashpath c:\\Users\\baincd\\.m2\\settings.xml"                   #
# - `notepad <bashpath>` - Open notepad++ using the bashpath                   #
#        ex: "notepad pom.xml"                                                 #
# - `eclipse <bashpath>` - Open Eclipse using the bashpath                     #
#        ex: "eclipse pom.xml"                                                 #
#                                                                              #
# NOTE: `notepad` and `eclipse` commands may need to be modified to work on    #
# your installation!                                                           #
#                                                                              #
# ## Setup Option 1: Import into ~/.bashrc                                     #
#                                                                              #
# 1. Create `~/.bash-win-aliases.bash`                                         #
#    a. Create symbolic link with following command                            #
#     `ln -s ~/wc/technotes/bash/setup-windows-bash-aliases ~/.bash-win-aliases.bash` #
#    b. OR Save this file to `~/.bash-win-aliases.bash`                        #
#                                                                              #
# 2. Add to ~/.bashrc:                                                         #
# ```                                                                          #
# if [ -f ~/.bash-win-aliases.bash ]; then                                     #
#     . ~/.bash-win-aliases.bash                                               #
# fi                                                                           #
# ```                                                                          #
#                                                                              #
# ## Setup Option 2: Copy contents directly into ~/.bashrc                     #
################################################################################

# Convert bash filepath to Windows filepath
winpath() {
    realpath $1 | sed -r 's*^/([a-zA-Z])/*\1:/*' | sed 's*/*\\*g'
}

# Convert Windows filepath to Bash filepath
bashpath () {
     echo "${1}" | sed -r "s,^([a-zA-Z]):\\\\,/\L\1\E/," | sed -r "s,\\\\,/,g"
}

# Open bash filepath in Notepad++
notepad() {
    if ! [ "${1}" = "" ]; then
        WINPATH=`winpath ${1}`
    fi
    "c:\Program Files (x86)\Notepad++\notepad.exe" "${WINPATH}"
}

# Open bash filepath in Eclipse
eclipse() {
    if ! [ "${1}" = "" ]; then
        WINPATH=`winpath ${1}`
    fi
    "c:\Eclipse\ide\eclipse.exe" "${WINPATH}"
}
