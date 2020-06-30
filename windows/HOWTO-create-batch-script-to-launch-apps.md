`good-morning.bat`:
```batchfile
@echo Good Morning!
@echo.

@echo Starting Foo... ### Example launching app directly ###
@start "" "C:\Program Files\Foo\foo.exe"

@echo Starting Bar... ### Example launching app via batch file, if direct does not work ###
@call "C:\Users\chris\launch-bar.bat"

@echo Starting git-bash...
@start "" "C:/Program Files (x86)/Git/git-bash.exe" --cd-to-home

@echo Starting Atom...
@start "" cmd /c "C:/Program Files (x86)/Atom/resources/cli/atom.cmd"

@echo.
@echo Ready to go - have a great day!
```

`launch-bar.bat`:
```batchfile
@start "" "C:\Program Files\Bar\bar.exe"
```
