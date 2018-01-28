@rem rem is a comment
@rem any line starting with @ will not be echoed to the terminal
@rem or to turn off echoing of lines to terminal all together do:
@echo off

rem set the first param to var myvar
SET myvar=%~1

if [%myvar%]==[] (
    echo Missing Param!
    goto:eof
) else (if [%myvar%]==[hello] (
    echo Hello World
) else (if [%myvar%]==[goodnight] (
    call:byeFunc "Good Night", "World"
) else (
    echo "what?"
)))

echo SUCCESS

goto:eof

:byeFunc
    rem will print "Good Night World"
    echo %~1 %~2
goto:eof
