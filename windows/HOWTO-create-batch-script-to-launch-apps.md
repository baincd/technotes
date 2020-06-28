`good-morning.bat`:
```batchfile
@echo Good Morning!
@echo.
@echo Starting Foo... ### Example launching app directly ###
@start "" "C:\Program Files\Foo\foo.exe"
@echo Starting Bar... ### Example launching app via batch file, if direct does not work ###
@call "C:\Users\chris\launch-bar.bat"
@echo.
@echo Ready to go - have a great day!
```

`launch-bar.bat`:
```batchfile
@start "" "C:\Program Files\Bar\bar.exe"
```
