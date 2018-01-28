# Mount and Unmount network drive
# Update IP address, Drive Name, username, uid, and gid
alias mediadrivemount='mkdir ~/mediadrive && sudo mount -t cifs "\\\\10.20.30.40\\Drive Name" ~/mediadrive -o username=chris,uid=1000,gid=1000'
alias mediadriveumount='sudo umount ~/mediadrive && rm -r ~/mediadrive'
