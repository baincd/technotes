# My Atom Preferences

## Custom Configuration

### Text colors
add to `~/.atom/styles.less`
```css
atom-text-editor.editor .invisible-character {
  color: #486e55; // Very dark grayish cyan - easier to see on dark background:
}
```

### Shortcuts
add to `~/.atom/keymap.cson`
```js
'atom-text-editor':
  'ctrl-d': 'editor:delete-line'
```

## General Installed Packages
* custom-window-title (pixilz/baincd)
  * settings:
  ```
<%= fileName %><% if (projectName) { %> - <%= projectName %><% if (gitHead) { %> [<%= gitHead %>]<% } %><% } %>
```
* platformio-ide-terminal (platformio)
    * Disable login shell (unless .bashrc is configured to run on login shell)

## HTML Installed Packages
* autoclose-html (mattberkowitz)
* double-tag (dsandstrom)
