### Add item to Start menu
`C:\Users\<id>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Custom Shortcuts`
("Custom Shortcuts" can be any folder name)

### Create New Email (Outlook)
`"C:\Program Files (x86)\Microsoft Office\Office16\Outlook.exe" /c ipm.note`

### Create New Appointment (Outlook)
`"C:\Program Files (x86)\Microsoft Office\Office16\Outlook.exe" /c ipm.appointment`

### Copy plaintext to clipboard

1. Create `c:\cdb\bin\cdb-clip.bat`
```batch
@REM Change default code page to UTF-8
@CHCP 65001 > null
@clip < c:\cdb\.cdb-clip-%1
```

2. Create `.cdb-clip-*` file(s) with text to copy.  Example `.cdb-clip-example`:
```
Text to copy
```

3. Create shortcut (see "Add item to Start menu" above for location): 
```
c:\cdb\bin\cdb-clip.bat example
```

### Copy HTML to clipboard
<!-- Refs:
https://superuser.com/a/912713
https://stackoverflow.com/a/58556998
-->

1. Create `c:\cdb\bin\cdb-clip-html.ps1`
```powershell
$clipname = $args[0]

Get-Content -Encoding UTF8 C:\cdb\.cdb-clip-$clipname.html | Set-Clipboard -AsHtml
```

2. Create `.cdb-clip-*.html` file(s) with text to copy.  Example`.cdb-clip-example.html`:
```
<a href="https://www.cleguardians.com/">Go Guardians!</a>
```

3. Create shortcut (see "Add item to Start menu" above for location): 
```
c:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe c:\cdb\bin\cdb-clip-html.ps1 example
```

