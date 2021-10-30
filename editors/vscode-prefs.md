# Settings

```jsonc
    // Preferred Theme
    "workbench.colorTheme": "Quiet Light", // may be changed by Settings-on-fire
    "workbench.colorCustomizations": {
        "[Quiet Light]": {
            "debugConsole.infoForeground": "#4e4e4e", // Override default light-theme value of #75beff
            "debugConsole.sourceForeground": "#5eb2fc", // Override default light-theme value of #616161
            "activityBar.activeBackground": "#9900ff20", // Override default light-theme value of null
            "editorGroup.border": "#d3d3d3", // Override default light-theme value of "#e7e7e7"
            "editorOverviewRuler.border": "#dddddd", // Override default light-theme value of "#7f7f7f4d"

            "diffEditor.removedTextBackground": "#ff000022", // Default: "#ff000033"

            // titlebar and statusbar                          light-theme  Light+    QuietLight  QuietLightForVsc
            "titleBar.activeBackground": "#dddddd",      //  [#dddddd]               #c4b7d7      #c4b7d7
            "statusBar.background": "#4b83cd",           //   #007acc                #705697     [#4b83cd]
            "statusBar.noFolderBackground": "#705697",   //   #68217a               [#705697]     #aa3731
            "statusBar.debuggingBackground": "#cc6633",  //  [#cc6633]               #705697      #aa3731
            "statusBarItem.errorBackground": "#c72e0f",  //   #611708     [#c72e0f]  #c72516      #3d0000
            "statusBarItem.remoteBackground": "#16825d", //   #007acc     [#16825d]  #4e3c69      #448c27
        }
    },
    "workbench.iconTheme": "vscode-icons",

    // Preferred UI settings
    "window.title": "${rootName}${separator}${dirty}${activeEditorShort}",  // Default: "${dirty}${activeEditorShort}${separator}${rootName}${separator}${appName}"
    "window.menuBarVisibility": "hidden", // Hide by default, may be changed by Settings-on-fire
    "workbench.activityBar.visible": false,
    "editor.minimap.enabled": false,
    "workbench.startupEditor": "none",
    "breadcrumbs.enabled": true, // no change from default, may be changed by Settings-on-fire
    "editor.renderLineHighlight": "line",  // no change from default, may be changed by Settings-on-fire
    "debug.console.wordWrap": false, // Disable by default, may be changed by Settings-on-fire
    "debug.console.collapseIdenticalLines": false, // Disable by default, may be changed by Settings-on-fire
    "git.enableStatusBarSync": false,

    // Preferred Editor Settings
    "editor.linkedEditing": true, // Depending on the language, related symbols, e.g. HTML tags, are updated while editing.
    "editor.copyWithSyntaxHighlighting": false,
    "editor.emptySelectionClipboard": false,
    "files.insertFinalNewline": true, // Enable by default, may be changed by Settings-on-fire
    "explorer.autoReveal": false, // Disable by default, may be changed by Settings-on-fire
    "files.associations": {
        "*.md.txt": "markdown"
    },
    "workbench.editorAssociations": {
        "git-rebase-todo": "default"
    },

    // Preferred Terminal Settings
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

    // Preferred General Extensions Settings
    "cSpell.diagnosticLevel": "Information", // no change from default, may be changed by Settings-on-fire
    "filterlines.createNewTab": false,
    "gitlens.codeLens.enabled": false, // Disable by default, may be changed by Settings-on-fire
    "gitlens.codeLens.scopes": [
        "document",
        "containers",
        "blocks" // Add start of functions, methods, etc
    ],
    "gitlens.hovers.enabled": false,  // Disable by default, may be changed by Settings-on-fire
    "gitlens.keymap": "none",
    "gitlens.menus": {
        "editorGroup": {
            "compare": false // Remove the "Open Changes with Previous Revision", "Show Revision Commit", "Open Changes with Next Revision" buttons in editor group
        },
    },
    "print.browserPath": "/usr/bin/google-chrome-stable --incognito",
    "print.lineNumbers": "off", // Workaround to https://github.com/earshinov/vscode-filter-lines/issues/9
    "pdf-preview.default.cursor": "hand",

    "settingsOnFire.toggle": {
        "Theme": {
            "on": {  "_label": "light → dark", "workbench.colorTheme": "Default Dark+" },
            "off": { "_label": "dark → light", "workbench.colorTheme": "Quiet Light"   }
        },
        "Git Code Lens": {
            "on": {  "_label": "disabled → enabled", "gitlens.codeLens.enabled": true  },
            "off": { "_label": "enabled → disabled", "gitlens.codeLens.enabled": false }
        },
        "Java Code Lens": {
            "on": {  "_label": "disabled → enabled", "java.referencesCodeLens.enabled": true,  },
            "off": { "_label": "enabled → disabled", "java.referencesCodeLens.enabled": false, }
        },
        "Java Automatic Build Disabled": {
            "on": {  "_label": "off → on", "java.autobuild.enabled": false, },
            "off": { "_label": "on → off", "java.autobuild.enabled": true,  }
        },
        "Hide Spelling Errors from Problems View": {
            "on": {  "_label": "off → on", "cSpell.diagnosticLevel": "Hint",        },
            "off": { "_label": "on → off", "cSpell.diagnosticLevel": "Information", }
        },
        "Git Lens Hovers": {
            "on": {  "_label": "off → on", "gitlens.hovers.enabled": true, },
            "off": { "_label": "on → off", "gitlens.hovers.enabled": false, }
        },
        "No Line Highlights": {
            "on": {  "_label": "off → on", "breadcrumbs.enabled": false, "editor.renderLineHighlight": "none", "markdown-color-plus.currentHeaders.background.enabled": false, },
            "off": { "_label": "on → off", "breadcrumbs.enabled": true,  "editor.renderLineHighlight": "line", "markdown-color-plus.currentHeaders.background.enabled": true,  }
        },
        "No EOF New Line": {
            "on": {  "_label": "off → on", "files.insertFinalNewline": false  },
            "off": { "_label": "on → off", "files.insertFinalNewline": true   }
        },
        "Sync Explorer with Active Editor": {
            "on": {  "_label": "off → on", "explorer.autoReveal": true,  },
            "off": { "_label": "on → off", "explorer.autoReveal": false, }
        },
        "Debug Console: Word Wrap": {
            "on": {  "_label": "off → on", "debug.console.wordWrap": true  },
            "off": { "_label": "on → off", "debug.console.wordWrap": false }
        },
        "Debug Console: Collapse Identical Lines": {
            "on": {  "_label": "off → on", "debug.console.collapseIdenticalLines": true  },
            "off": { "_label": "on → off", "debug.console.collapseIdenticalLines": false }
        },
        "Markdown Preview: Editing Mode": {
            "on": {  "_label": "off → on", "markdown.preview.doubleClickToSwitchToEditor": true,  "markdown.preview.markEditorSelection": true,  "markdown.preview.scrollEditorWithPreview": true,  "markdown.preview.scrollPreviewWithEditor": true, },
            "off": { "_label": "on → off", "markdown.preview.doubleClickToSwitchToEditor": false, "markdown.preview.markEditorSelection": false, "markdown.preview.scrollEditorWithPreview": false, "markdown.preview.scrollPreviewWithEditor": false,
            }
        },
        "Menu Bar": {
            "on": {  "_label": "off → on", "window.menuBarVisibility": "visible" },
            "off": { "_label": "on → off", "window.menuBarVisibility": "hidden"  }
        },
    },

    "insert-unicode.favorites": {
        "directories": {
            "1-Symbols": {
                "directories": {},
                "items": [[8253],[8226],[183],[176],[162],[9251]]
            },
            "2-Whitespace": {
                "directories": {},
                "items": [[9],[160],[8203]]
            },
            "3-Arrows": {
                "directories": {},
                "items": [[8592],[8594],[8596],[8656],[8658],[8660],[171],[187]]
            },
            "4-Checkmarks": {
                "directories": {},
                "items": [[10003],[10004],[10007],[10008],[10060],[9744],[9745],[9746]]
            },
            "5-Math Symbols": {
                "directories": {},
                "items": [[188],[189],[190],[8531],[8532],[177],[215],[247],[8804],[8805],[8776],[8800]]
            },
            "6-Emoji Smiles 🙂": {
                "directories": {},
                "items": [[9786,65039],[128578],[128521],[128513],[128522],[128512],[128515],[128516],[128518],[128514],[129315],[128537],[128536],[128139],]
            },
            "7-Emoji Symbols 👍": {
                "directories": {},
                "items": [[128077],[128079],[128075],[129303],[10084,65039]]
            },
            "8-Emoji Silly 😎": {
                "directories": {},
                "items": [[128526],[129299],[128579],[128540],[129322]]
            },
            "9-Emoji Unhappy 🙁": {
                "directories": {},
                "items": [[9785,65039],[128577],[128533],[128528],[128580],[129300],[128559],[128563]]
            }
        },
        "items": []
    },

    // Preferred Markdown Settings
    "markdown-color-plus.currentHeaders.background.enabled": true, // no change from default, may be changed by Settings-on-fire
    "markdown.preview.doubleClickToSwitchToEditor": false, // Disable by default, may be changed by Settings-on-fire
    "markdown.preview.markEditorSelection": false, // Disable by default, may be changed by Settings-on-fire
    "markdown.preview.scrollEditorWithPreview": false, // Disable by default, may be changed by Settings-on-fire
    "markdown.preview.scrollPreviewWithEditor": false, // Disable by default, may be changed by Settings-on-fire
    "markdown.extension.syntax.decorations": false,
    "markdown.extension.list.indentationSize": "inherit",

    "update.mode": "default",
```

# Key Bindings
```jsonc
// Redefine ctrl+d = "delete line" (replaces addSelectionToNextFindMatch, duplicates ctrl+shift+k)
{ "key": "ctrl+d",                "command": "editor.action.deleteLines",
                                     "when": "textInputFocus && !editorReadonly" },
{ "key": "ctrl+d",                "command": "-editor.action.addSelectionToNextFindMatch",
                                     "when": "editorFocus" },

// ctrl+shift+/ = "block comment" (moved from ctrl+shift+a)
// ctrl+shift+a = "toggle activity bar"
{ "key": "ctrl+shift+/",          "command": "editor.action.blockComment",
                                     "when": "editorTextFocus && !editorReadonly" },
{ "key": "ctrl+shift+a",          "command": "-editor.action.blockComment",
                                     "when": "editorTextFocus && !editorReadonly" },
{ "key": "ctrl+shift+a",          "command": "workbench.action.toggleActivityBarVisibility" },

// ctrl+\ = "toggle explorer sidebar" (replaces "split editor", duplicate ctrl+shift+e)
{ "key": "ctrl+\\",               "command": "workbench.view.explorer",
                                     "when": "!explorerViewletVisible" },
{ "key": "ctrl+\\",               "command": "workbench.action.toggleSidebarVisibility",
                                     "when": "explorerViewletVisible" },
{ "key": "ctrl+\\",               "command": "-workbench.action.splitEditor" },

// ctrl+] = "jump to bracket" (replaces indentLines, moved from ctrl+shift+\)
// ctrl+shift+\ = "toggle sidebar" (replaces focusTabs and jumpToBracket, duplicates ctrl+b)
{ "key": "ctrl+]",                "command": "editor.action.jumpToBracket",
                                     "when": "editorTextFocus" },
{ "key": "ctrl+]",                "command": "-editor.action.indentLines",
                                     "when": "editorTextFocus && !editorReadonly" },
{ "key": "ctrl+shift+\\",         "command": "workbench.action.toggleSidebarVisibility" },
{ "key": "ctrl+shift+\\",         "command": "-workbench.action.terminal.focusTabs",
                                     "when": "terminalFocus && terminalProcessSupported || terminalProcessSupported && terminalTabsFocus" },
{ "key": "ctrl+shift+\\",         "command": "-editor.action.jumpToBracket",
                                     "when": "editorTextFocus" },

{ "key": "ctrl+alt+\\",           "command": "workbench.files.action.showActiveFileInExplorer" },

// Extend sidebar shortcuts to hide sidebar if viewlet is currently visible
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

// Duplicate ctrl+k ctrl+f
{ "key": "ctrl+alt+f",            "command": "editor.action.formatSelection",
                                     "when": "editorHasDocumentSelectionFormattingProvider && editorTextFocus && !editorReadonly" },

// ctrl+shift+` = "switch active terminal" (replaces "new terminal")
{ "key": "ctrl+shift+`",          "command": "workbench.action.quickOpenTerm" },
{ "key": "ctrl+shift+`",          "command": "-workbench.action.terminal.new",
                                     "when": "terminalProcessSupported" },

// Remove ctrl+w closing window when last editor is closed
{ "key": "ctrl+w",                "command": "-workbench.action.closeWindow",
                                     "when": "!editorIsOpen && !multipleEditorGroups" },

// ctrl+shift+w = "close all editors" (replaces "close window")
{ "key": "ctrl+shift+w",          "command": "workbench.action.closeAllEditors" },
{ "key": "ctrl+shift+w",          "command": "-workbench.action.closeWindow" },

// ctrl+shift+f5 = "reload window (replaces "debug restart")
{ "key": "ctrl+shift+f5",         "command": "workbench.action.reloadWindow" },
{ "key": "ctrl+shift+f5",         "command": "-workbench.action.debug.restart",
                                     "when": "inDebugMode" },

// ctrl+alt+d = select launch configuration and start debugging
{ "key": "ctrl+alt+d",            "command": "workbench.action.debug.selectandstart" },

// ctrl+shift+, = "settings on fire" (replaces inPlaceReplaceUp)
{ "key": "ctrl+shift+,",          "command": "settingsOnFire.toggleSettings" },
{ "key": "ctrl+shift+,",          "command": "-editor.action.inPlaceReplace.up",
                                     "when": "editorTextFocus && !editorReadonly" },

// alt+left/right = back/forward (replaces "focus prev/next pane")
{ "key": "alt+left",              "command": "workbench.action.navigateBack" },
{ "key": "alt+left",              "command": "-workbench.action.terminal.focusPreviousPane",
                                     "when": "terminalFocus && terminalProcessSupported" },
// Override Alt+Right with Go Forward
{ "key": "alt+right",             "command": "workbench.action.navigateForward" },
{ "key": "alt+right",             "command": "-workbench.action.terminal.focusNextPane",
                                     "when": "terminalFocus && terminalProcessSupported" },
// ctrl+; enter = maximize editor
{ "key": "ctrl+; enter",          "command": "workbench.action.minimizeOtherEditors" },
```

# Extensions
- vscode-icons: `vscode-icons-team.vscode-icons`

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

