# Installed Packages
* custom-window-title (pixilz/baincd)
* platformio-ide-terminal (platformio)
    * Disable login shell (unless .bashrc is configured to run on login shell)
#### HTML
* autoclose-html (mattberkowitz)
* double-tag (dsandstrom)


# Custom Window Title settings
```
<%= fileName %><% if (projectName) { %> - <%= projectName %><% if (gitHead) { %> [<%= gitHead %>]<% } %><% } %>
```
