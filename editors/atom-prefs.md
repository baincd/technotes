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
* custom-window-title-baincd (baincd)
  * settings:
  ```
<%= fileName %><% if (projectName) { %> - <%= projectName %><% if (gitHead) { %> [<%= gitHead %>]<% } %><% } %>
```
* atom-ide-terminal (qicrosoft)
    * Disable login shell (unless .bashrc is configured to run on login shell)
* sublime-style-column-selection (bigfive)
* atom-beautify (Glavin001)
* recent-files-fuzzy-finder (viddo)
  * Enable Restore Session
  * Add to keymap:
```js
'atom-workspace':
  'ctrl-t': 'recent-files-fuzzy-finder:toggle-finder'
```

## HTML Installed Packages
* autoclose-html (mattberkowitz)
* double-tag (dsandstrom)

## Other Useful Packages
* hex-view (EoinDoherty)
* on-save (baincd fork of mvila)
  ```js
    {
      "srcDir": ".",
      "files": "**/*.txt",
      // LINUX command to auto commit on save:
      "command": "git add ${srcFile} && (git commit -m \"Saved File ${srcFile}\" || true)",
      // Windows command to auto commit on save:
      "command": "git add ${srcFile} && (git commit -m \"Saved File ${srcFile}\" || (exit 0))",
    }
  ```
* tree-view-sort (hex-ci)
  * Disable case-sensitive sorting (matches default Atom sorting)
