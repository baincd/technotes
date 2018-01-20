# Disable Charms hint in Windows 8

In Windows 8, the Charms Bar is the options (Search, Share, Start, Devices, Settings) that display when you swipe on the screen from the right.

[Search Charms Bar Examples](https://www.google.com/search?q=windows+8+charms+bar&source=lnms&tbm=isch&sa=X&ei=_ddCU9ThOuaL0QHCuoHoAw&ved=0CAkQ_AUoAg&biw=1129&bih=572)

By default, the Top Right and Bottom Right corners are a hot corners - if the cursor is placed there, a Charms Bar "hint" is displayed (basically, the charms bar but transparent).  This is very annoying.

## To Disable
1) Open regedit
2) go to key (create if neccessary)
```
        HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ImmersiveShell\EdgeUI
```
3) Create new DWORD `DisableCharmsHint` with a value of `1` (or `0x00000001`)

These hot corners are disabled immediately (no restart or reboot required)

Note: even with the hint disabled, if you place the cursor in the top right corner then move the cursor straight down (or bottom right corner and straight up), the charms bar will display.  Annoying , but less annoying then the charms hint.

## To Enable
Either delete `DisableCharmsHint` or set the value to `0`

# Reference

[Original Source](http://www.askvg.com/how-to-disable-charms-bar-hint-in-windows-8/)
