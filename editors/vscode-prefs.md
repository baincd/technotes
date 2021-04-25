# Settings

```jsonc
{
    // Preferred UI (General)
    "workbench.activityBar.visible": false,
    "window.menuBarVisibility": "hidden",
    "editor.minimap.enabled": false,
    "workbench.startupEditor": "none",

    // Preferred Editors
    "files.insertFinalNewline": true,
    "editor.copyWithSyntaxHighlighting": false,
    "files.associations": {
        "*.md.txt": "markdown"
    },

    // Misc Editor Prefs
    "markdown.preview.doubleClickToSwitchToEditor": false,
    "markdown.preview.markEditorSelection": false,
    "debug.console.collapseIdenticalLines": false,

    // Set via integrated-terminal > Select Default Shell
    // Windows will be something like "C:\\Program Files\\Git\\bin\\bash.exe"
    "terminal.integrated.shell.linux": "/bin/bash",
    "terminal.integrated.cwd": "${fileDirname}",
    "terminal.integrated.scrollback": 10000,
    "terminal.integrated.commandsToSkipShell": [
        "workbench.action.toggleSidebarVisibility",
        "workbench.view.explorer",
        "workbench.files.action.showActiveFileInExplorer",
        "workbench.action.reloadWindow",
        "workbench.action.quickOpenTerm"
    ],

    // My personally preferred theme - YMMV
    "workbench.colorTheme": "Quiet Light",

    // Prefs for Extensions
    "print.browserPath": "/home/chris/bin/chrome-incognito.sh", // /usr/bin/google-chrome-stable --incognito "$@"
    "print.lineNumbers": "off",
    "filterlines.createNewTab": false,
    "filterlines.foldIndentedContext": false, // Workaround to https://github.com/earshinov/vscode-filter-lines/issues/9
    "pdf-preview.default.cursor": "hand",

    // Settings On Fire Configuration
    "settingsOnFire.toggle": {
      "Theme": {
        "on": {
          "_label": "light → dark",
          "workbench.colorTheme": "Default Dark+"
        },
        "off": {
          "_label": "dark → light",
          "workbench.colorTheme": "Quiet Light"
        }
      },
      "Copy With Syntax Highlighting": {
        "on": {
          "_label": "off → on",
          "editor.copyWithSyntaxHighlighting": true,
        },
        "off": {
          "_label": "on → off",
          "editor.copyWithSyntaxHighlighting": false,
        }
      },
      "EOF New Line Disabled": {
        "on": {
          "_label": "off → on",
          "files.insertFinalNewline": false
        },
        "off": {
          "_label": "on → off",
          "files.insertFinalNewline": true
        }
      },
      "Debug Console: Collapse Identical Lines": {
        "on": {
          "_label": "off → on",
          "debug.console.collapseIdenticalLines": true
        },
        "off": {
          "_label": "on → off",
          "debug.console.collapseIdenticalLines": false
        }
      },
      "Markdown Preview: Editing Mode": {
        "on": {
          "_label": "off → on",
          "markdown.preview.doubleClickToSwitchToEditor": true,
          "markdown.preview.markEditorSelection": true,
        },
        "off": {
          "_label": "on → off",
          "markdown.preview.doubleClickToSwitchToEditor": false,
          "markdown.preview.markEditorSelection": false,
        }
      },
      "Menu Bar": {
        "on": {
          "_label": "off → on",
          "window.menuBarVisibility": "visible"
        },
        "off": {
          "_label": "on → off",
          "window.menuBarVisibility": "hidden"
        }
      },
    },
    
    
}

```

# Key Bindings
```jsonc
[
// Duplicate ctrl+shift+k
// Override editor.action.addSelectionToNextFindMatch
{ "key": "ctrl+d",               "command": "editor.action.deleteLines",
                                    "when": "textInputFocus && !editorReadonly" },
// Moved from ctrl+shift+a (see below)
{ "key": "ctrl+shift+/",         "command": "editor.action.blockComment",
                                    "when": "editorTextFocus && !editorReadonly" },

// Override editor.action.blockComment (move to ctrl+shift+/ above)
{ "key": "ctrl+shift+a",         "command": "workbench.action.toggleActivityBarVisibility" },

// Duplicate ctrl+shift+e
// Override workbench.action.splitEditor
{ "key": "ctrl+\\",              "command": "workbench.view.explorer",
                                    "when": "!explorerViewletVisible" },
{ "key": "ctrl+\\",              "command": "workbench.action.toggleSidebarVisibility",
                                    "when": "explorerViewletVisible" },
// Duplicate ctrl+b
// Override editor.action.jumpToBracket (move to ctrl+] below)
{ "key": "ctrl+shift+\\",         "command": "workbench.action.toggleSidebarVisibility"},

{ "key": "ctrl+alt+\\",           "command": "workbench.files.action.showActiveFileInExplorer"},

// Extend shortcuts to hide sidebar if viewlet is currently visible
{ "key": "ctrl+shift+e",          "command": "workbench.action.toggleSidebarVisibility",
                                     "when": "sideBarVisible && activeViewlet == 'workbench.view.explorer'" },
{ "key": "ctrl+shift+f",          "command": "workbench.action.toggleSidebarVisibility",
                                     "when": "sideBarVisible && activeViewlet == 'workbench.view.search'" },
{ "key": "ctrl+shift+g",          "command": "workbench.action.toggleSidebarVisibility",
                                     "when": "sideBarVisible && activeViewlet == 'workbench.view.scm'" },
{ "key": "ctrl+shift+d",          "command": "workbench.action.toggleSidebarVisibility",
                                     "when": "sideBarVisible && activeViewlet == 'workbench.view.debug'" },
{ "key": "ctrl+shift+x",          "command": "workbench.action.toggleSidebarVisibility",
                                     "when": "sideBarVisible && activeViewlet == 'workbench.view.extensions'" },

// Move from ctrl+shift+\\ (see above)
// Override editor.action.indentLines
{ "key": "ctrl+]",                "command": "editor.action.jumpToBracket",
                                     "when": "editorTextFocus" },

// Duplicate ctrl+k ctrl+f
{ "key": "ctrl+alt+f",            "command": "editor.action.formatSelection",
                                     "when": "editorHasDocumentSelectionFormattingProvider && editorTextFocus && !editorReadonly" },

{ "key": "alt+`",                 "command": "workbench.action.quickOpenTerm" },

// Remove ctrl+w closing window when last editor is closed
{ "key": "ctrl+w",                "command": "-workbench.action.closeWindow",
                                     "when": "!editorIsOpen && !multipleEditorGroups" },
// Override workbench.action.closeWindow
{ "key": "ctrl+shift+w",          "command": "workbench.action.closeAllEditors" },

{ "key": "ctrl+shift+f5",         "command": "workbench.action.reloadWindow" },

{ "key": "ctrl+shift+,",          "command": "settingsOnFire.toggleSettings" },

]
```

# Extensions
- Spell Check: `streetsidesoftware.code-spell-checker`
- File Utils: `sleistner.vscode-fileutils`
- Printing: `pdconsec.vscode-print`
- Quick Settings: `edb.settings-on-fire`

- DupChecker (uniq command): `jianbingfang.dupchecker`
- Filter Lines (grep command): `earshinov.filter-lines`

- PDF Preview: `tomoki1207.pdf`
- Diff Folding: `baincd.diff-lang-folding`
- Diff Colors: `baincd.diff-lang-colorizer`
- Markdown Colors: `baincd.markdown-color-plus`

