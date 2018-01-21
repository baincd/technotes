# To mirror display 1 to HDMI with resolution 1366x768
xrandr # This will show current resolution
xrandr --output HDMI1 --off
xrandr --output HDMI1 --auto --scale-from 1366x768

# To mirror display, automatically determining resolution:
xrandr --output HDMI1 --off && xrandr --output HDMI1 --auto --scale-from `xrandr | sed -rn '1s/^.* current ([0-9]+) x ([0-9]+).*/\1x\2/p'`
# To create alias, add to ~/.bashrc (substitute command above, escaping ` with \ )
alias mirrorscreen="<command>"
