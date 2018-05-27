#!/bin/bash

# This is a comment

# set the first param to var myvar
myvar=$1

byeFunc () {
    # rem will print "Good Night World"
    echo $1 $2
}

# Conditionals: https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php
if ! [ $myvar ]; then
    echo Missing Param!
    exit 1
elif [ $myvar = "hello" ]; then
    echo Hello World
elif [ $myvar = "goodnight" ]; then
    byeFunc "Good Night" "World"
else
    echo what?
fi

echo SUCCESS

# Loop over lines
while read -r line; do
  echo "$line"
done <<< `git status --porcelain=2 --branch  2> /dev/null`
