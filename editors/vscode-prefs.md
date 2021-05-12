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
    "editor.emptySelectionClipboard": false,
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
    
    "insert-unicode.favorites": {
      "directories": {
        "1-Symbols": {
          "directories": {},
          "items": [
            [
              8253
            ],
            [
              8226
            ],
            [
              183
            ],
            [
              176
            ],
            [
              162
            ],
            [
              9251
            ]
          ]
        },
        "2-Whitespace": {
          "directories": {},
          "items": [
            [
              9
            ],
            [
              160
            ],
            [
              8203
            ]
          ]
        },
        "3-Arrows": {
          "directories": {},
          "items": [
            [
              8592
            ],
            [
              8594
            ],
            [
              8656
            ],
            [
              8658
            ],
            [
              171
            ],
            [
              187
            ]
          ]
        },
        "4-Checkmarks": {
          "directories": {},
          "items": [
            [
              10003
            ],
            [
              10004
            ],
            [
              10007
            ],
            [
              10008
            ],
            [
              10060
            ],
            [
              9744
            ],
            [
              9745
            ],
            [
              9746
            ]
          ]
        },
        "5-Math Symbols": {
          "directories": {},
          "items": [
            [
              188
            ],
            [
              189
            ],
            [
              190
            ],
            [
              8531
            ],
            [
              8532
            ],
            [
              177
            ],
            [
              215
            ],
            [
              247
            ],
            [
              8804
            ],
            [
              8805
            ],
            [
              8776
            ],
            [
              8800
            ]
          ]
        },
        "6-Emoji Smiles 🙂": {
          "directories": {},
          "items": [
            [
              9786,
              65039
            ],
            [
              128578
            ],
            [
              128521
            ],
            [
              128513
            ],
            [
              128522
            ],
            [
              128512
            ],
            [
              128515
            ],
            [
              128516
            ],
            [
              128518
            ],
            [
              128514
            ],
            [
              129315
            ],
            [
              128537
            ],
            [
              128536
            ],
            [
              128139
            ],
          ]
        },
        "7-Emoji Symbols 👍": {
          "directories": {},
          "items": [
            [
              128077
            ],
            [
              128079
            ],
            [
              128075
            ],
            [
              129303
            ],
            [
              10084,
              65039
            ]
          ]
        },
        "8-Emoji Silly 😎": {
          "directories": {},
          "items": [
            [
              128526
            ],
            [
              129299
            ],
            [
              128579
            ],
            [
              128540
            ],
            [
              129322
            ]
          ]
        },
        "9-Emoji Unhappy 🙁": {
          "directories": {},
          "items": [
            [
              9785,
              65039
            ],
            [
              128577
            ],
            [
              128533
            ],
            [
              128528
            ],
            [
              128580
            ],
            [
              129300
            ],
            [
              128559
            ],
            [
              128563
            ]
          ]
        }
      },
      "items": []
    },

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
- Insert Unicode: `brunnerh.insert-unicode`

- DupChecker (uniq command): `jianbingfang.dupchecker`
- Filter Lines (grep command): `earshinov.filter-lines`

- PDF Preview: `tomoki1207.pdf`
- Diff Folding: `baincd.diff-lang-folding`
- Diff Colors: `baincd.diff-lang-colorizer`
- Markdown Colors: `baincd.markdown-color-plus`

