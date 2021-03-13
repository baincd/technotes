# Settings

```jsonc
{
    // Preferred UI
    "window.menuBarVisibility": "toggle",
    "workbench.activityBar.visible": false,
    "editor.minimap.enabled": false,
    "workbench.startupEditor": "none",

    // Preferred Editors
    "files.insertFinalNewline": true,
    "editor.copyWithSyntaxHighlighting": false,


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
    "workbench.colorTheme": "Quiet Light"
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

]
```

# Extensions
- baincd.diff-lang-improved
- baincd.diff-lang-colorizer
- baincd.markdown-color-plus
- streetsidesoftware.code-spell-checker
- sleistner.vscode-fileutils
- baincd.copy-path-unixstyle
