@rem system-shutdown.ico created from system-shutdown.png icon in GNOME/adwaita-icon-theme

@echo OFF

echo Shutdown Windows
echo.

choice /C SRQ /T 30 /D Q /m "[S]hutdown, [R]estart, or [Q]cancel? "

if ERRORLEVEL 3 Goto Cancel
if ERRORLEVEL 2 Goto Restart
if ERRORLEVEL 1 Goto Shutdown

Goto End

:Shutdown
  echo Goodbye!
  %windir%\System32\shutdown.exe /s /t 0
  Goto End

:Restart
  echo See you soon!
  %windir%\System32\shutdown.exe /r /t 0
  Goto End

:Cancel
  echo No Worries - I'm not going anywhere!
  Goto End

:End
echo.
pause
