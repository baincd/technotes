## Setup for Windows Git bash

`~/.bashrc`
```bash
# Convert Bash filepath to Windows filepath
winpath() {
    realpath $1 | sed -r 's*^/([a-zA-Z])/*\1:/*' | sed 's*/*\\*g'
}

# Convert Windows filepath to Bash filepath
bashpath () {
     echo "${1}" | sed -r "s,^([a-zA-Z]):\\\\,/\L\1\E/," | sed -r "s,\\\\,/,g"
}

notepad() {
    if ! [ "${1}" = "" ]; then
        WINPATH=`winpath ${1}`
    fi
    "c:\Program Files (x86)\Notepad++\notepad.exe" "${WINPATH}"
}

eclipse() {
    if ! [ "${1}" = "" ]; then
        WINPATH=`winpath ${1}`
    fi
    "c:\Eclipse\ide\eclipse.exe" "${WINPATH}"
}

```
