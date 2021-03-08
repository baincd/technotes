# Settings

```json
{
    // Preferred UI
    "window.menuBarVisibility": "toggle",
    "workbench.activityBar.visible": false,
    "editor.minimap.enabled": false,
    "workbench.startupEditor": "none",

    // Preferred Editors
    "files.insertFinalNewline": true,
    "workbench.settings.openDefaultKeybindings": true,

    // Set via integrated-terminal > Select Default Shell
    // Windows will be something like "C:\\Program Files\\Git\\bin\\bash.exe"
    "terminal.integrated.shell.linux": "/bin/bash",
    "terminal.integrated.cwd": "${fileDirname}",
    "terminal.integrated.scrollback": 10000,

    // My personally preferred theme - YMMV
    "workbench.colorTheme": "Quiet Light"
}

```

# Key Bindings
```json
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

// Duplicate ctrl+shift+i
{ "key": "ctrl+alt+f",            "command": "editor.action.formatDocument",
                                     "when": "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor" },
{ "key": "ctrl+alt+f",            "command": "editor.action.formatDocument.none",
                                     "when": "editorTextFocus && !editorHasDocumentFormattingProvider && !editorReadonly" },

// Remove ctrl+w closing window when last editor is open
{ "key": "ctrl+w",                "command": "-workbench.action.closeWindow",
                                     "when": "!editorIsOpen && !multipleEditorGroups" },
// Override workbench.action.closeWindow
{ "key": "ctrl+shift+w",          "command": "workbench.action.closeAllEditors" },

]
```

# Extensions
- baincd.diff-lang-improved *(also add color settings from documentation)*
- streetsidesoftware.code-spell-checker
