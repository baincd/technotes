TODO: reorganize this page

# New Distro installed
* Confirm UID
* Mount files
* Grub menu
* Label partition
* Setup Bash prompt
* Setup Bash aliases
* Setup git config
* link to common files drive (docs, music, pictures, videos, books, images, dev, wc)
* Rename User Directories to lower case
	* edit ~/.config/user-dirs/dirs
	* Fix Bluetooth/Local Services
	* Fix File Manager Bookmarks (Home, Desktop, wc, dev, docs, downloads, files)
* Redshift

## Software
* Firefox (copy profile?)
* Chrome?
* Atom
* Synapse?
* Java
* Eclipse
* Acrobat?  Flash?

# New Desktop Environment
* Touchpad
	* Disable touchpad tap-to-click
	* touchpad 2-finger scroll (down-goes-down) (disable natural scrolling)
* Toggle touchscreen shortcuts (xinput)
* Toggle touchpad shortcuts (xinput)
* Hotkeys - Window sizing
	* Win-L/R/+/- (Left/Right/Max vertical/Max Horizontal)
	* Win-Enter (toggle Maximize)
	* (Win-Shift-Enter) (toggle fullscreen)
	* (Win-Shift/Ctrl-L/R) (corners)
* Hotkeys - Switch Workspace
	* Ctrl-Alt-L/R
	* Shift-ctrl-alt-L/R
* Hotkeys - misc
	* Win-E, Win-T, Win-D, Win-R
* Setup mouse buttons
* Login Manager? (lightdm)
* Shutdown/Restart/Logout shortcuts
* Numlock on restart (numlockx)
* Disable bluetooth on startup (rfkill block bluetooth)
* Swap Keyboard Keys (Insert should be default, and fn+Insert should be PrtScr)
  * ~/bin/ins-prsc-swap: xmodmap -e "keycode 118 = Print"; xmodmap -e "keycode 107 = Insert"
  * ~/bin/ins-prsc-unswap: xmodmap -e "keycode 107 = Print"; xmodmap -e "keycode 118 = Insert"
  * ~/bin/ins-prsc-toggle: if [ "$(xmodmap -pk | grep "(Insert)" | grep 118 | wc -l)" = "1" ]; then ~/bin/ins-prsc-swap.sh else ~/bin/ins-prsc-unswap.sh fi
  * Hotkey - Win + Print -> ~/bin/ins-prsc-toggle
  * Source: https://ictsolved.github.io/remap-key-in-linux/

* Setup mouse
* Setup printer


## Theme
* Panels Layout
	* Menu
	* (Launchers: Files, Terminal, Firefox)
	* App Windows
	* (workspaces)
	* System tray: ... Battery %, WiFi, Sound
	* Clock
* Wallpaper

* Mint Theme Setup
    Window Borders: Ambiance-Crunchy
    Icons: Adwaita-blue-light
    Controls: BlueMenta
    Mouse Pointer: DMZ-White
    Desktop: Eleganse-dark

## Windows 🤮
* Change Power Settings
* Office
* Restore Disk
