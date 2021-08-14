# Default workspace

Enable by adding the workspace path to shortcuts/aliases to open vscode

`/home/chris/default.code-workspace`:
```json
{
    "folders": [],
    "settings": {
        "workbench.startupEditor": "newUntitledFile"
    }
}
```

# Track changes to vscode settings, keybindings, snippets

1. ${vscode}/User: `git init`

2. `.gitignore`
```
globalStorage/
worksplaceStorage/
**
!*.json
!snippets/
!.gitignore
```

3. `.vscode/settings.json`
```jsonc
{
    "files.exclude": {
        "globalStorage": true,
        "workspaceStorage": true,
    }
}
```

4. Commit changes

# Git commit tasks and shortcuts

Create tasks and hotkeys to run git commit commands that use the git commit editor, which can take advantage of spellchecker in vscode

.gitconfig:
```
[core]
	editor = code --log off --wait
```

tasks.json:
```jsonc
		{
			"label": "git commit",
			"detail": "commit staged changes",
			"type": "shell",
			"command": "git commit",
			"options": {
				"cwd": "${fileDirname}"
			},
			"presentation": {
				"reveal": "silent",
				"panel": "shared",
			},
			"problemMatcher": []
		},
		{
			"label": "git commitall",
			"detail": "commit all working directory changes",
			"type": "shell",
			"command": "git add -A && git commit",
			"options": {
				"cwd": "${fileDirname}"
			},
			"presentation": {
				"reveal": "silent",
				"panel": "shared",
			},
			"problemMatcher": []
		},
		{
			"label": "git commit --amend",
			"detail": "amend staged changes to HEAD",
			"type": "shell",
			"command": "git commit --amend",
			"options": {
				"cwd": "${fileDirname}"
			},
			"presentation": {
				"reveal": "silent",
				"panel": "shared",
			},
			"problemMatcher": []
		},
```

keybindings.json:
```jsonc
{ "key": "ctrl+; g",              "command": "workbench.action.tasks.runTask",
                                     "args": "git commit" },
{ "key": "ctrl+; ctrl+shift+g",   "command": "workbench.action.tasks.runTask",
                                     "args": "git commitall" },
{ "key": "ctrl+; ctrl+alt+g",     "command": "workbench.action.tasks.runTask",
                                     "args": "git commit --amend" },

```
# Change Language Mode Key Bindings

Extensions:

- Change Language Mode `usernamehw.change-language-mode`

keybindings.json:
```jsonc
{ "key": "ctrl+; m",              "command": "changeLanguageMode.change",
                                     "args": "markdown" },
{ "key": "ctrl+; j",              "command": "changeLanguageMode.change",
                                     "args": "json" },
```

# Change Language to JSON and Format
Extensions:

- Change Language Mode `usernamehw.change-language-mode`
- Macros `ctf0.macros` (fork of geddski.macros)

settings.json:
```jsonc
    "macros.list": {
        "format-json-doc": [
            { "command": "changeLanguageMode.change", "args": "json" },
            { "command": "$delay", "args": { "delay": 50 } },
            "editor.action.formatDocument"
        ]
    },
```

keybindings.json:
```jsonc
{ "key": "ctrl+; ctrl+shift+j",   "command": "macros.format-json-doc", },
```

# Auto Commit on Save

1. Install extension appulate.filewatcher
	1. disable in other workspaces, enable for the workspace of interest
2. Modify the workspace settings JSON
```json
    "settings": {
        "filewatcher.commands": [
            {
                "match": "/home/chris/path/.*",
                "isAsync": true,
                "cmd": "git -C ${fileDirname} add . && git -C ${fileDirname} commit -m '${fileBasename} Changed'",
                "event": "onFolderChange"
            }
        ]
    }
```

# Enable Overtype Mode

Overtype extension: `drmerfy.overtype`

```
    "overtype.perEditor": true,
```

# Todo Tree

Highlight TODO and similar comments, and display in sidebar

Extension: `gruntfuggly.todo-tree`

```
    "todo-tree.regex.regex": "(//|#|<!--|;|/\\*|^|^\\s*(-|\\d+.)|^\\*\\*)\\s*($TAGS)", // Add **, Todo-Tree Markdown Fix https://github.com/Gruntfuggly/todo-tree#markdown-support
    "todo-tree.general.tags": [
        "CDBR", "CDB-RVW", // Added
        "??", "Q: ", // Added
        "<<<<<<<", // Added
        "System.out.println","System.out.print","System.err.println","System.err.print","log.debug(\"CDB","log.info(\"CDB","log.warn(\"CDB","console.log","debugger", // Added
        "CDB", "FIXME CDB", "TODO CDB", // Added
        "NEED", // Added
        "BUG",
        "HACK",
        "FIXME",
        "TODO",
        "XXX",
        "[ ]", // Todo-Tree Markdown Fix https://github.com/Gruntfuggly/todo-tree#markdown-support
        "[x]", // Todo-Tree Markdown Fix https://github.com/Gruntfuggly/todo-tree#markdown-support
        "[]", // Added
        "[>]", // Added
        "[>>]" // Added
    ],
    "todo-tree.general.tagGroups": {
        "[ ]": [ "[ ]", "[]" ],
        "CDB": ["CDB", "FIXME CDB", "TODO CDB"],
        "CDB-REVIEW": ["CDBR", "CDB-RVW" ],
        "Qs": ["??", "Q: "],
        "conflict": ["<<<<<<<"],
        "DEBUGGING": ["System.out.println","System.out.print","System.err.println","System.err.print","log.debug(\"CDB","log.info(\"CDB","log.warn(\"CDB","console.log","debugger", ],
    },
    "todo-tree.highlights.defaultHighlight": {
        "foreground": "#FFFFFF",
        "background": "#FF5454",
        "iconColour": "#FF5454"
    },
    "todo-tree.highlights.customHighlight": {
        "CDB": { "icon": "bell", "background": "#A80000", "iconColour": "#A80000" },
        "CDB-REVIEW": { "icon": "code-review", "iconColour": "#D4AC0D", "background": "#F7DC6F", "foreground": "#424949" },
        "Qs": { "icon": "question", "background": "#9900ff", "iconColour": "#9900ff" },
        "conflict": { "icon": "git-pull-request", "background": "#ff7f00", "iconColour": "#ff7f01" },
        "DEBUGGING": { "icon": "trash" },
        "NEED": { "icon": "issue-opened" },
        // "[ ]": { "background": "#ff000080" }, // Todo-Tree Markdown Fix https://github.com/Gruntfuggly/todo-tree#markdown-support
        "[x]": { "background": "#00cc0080", "icon": "check-circle-fill", "iconColour": "#00CC00" }, // Todo-Tree Markdown Fix https://github.com/Gruntfuggly/todo-tree#markdown-support
        "[>]": { "background": "#ebb800", "icon": "chevron-right", "iconColour": "#ebb800" },
        "[>>]": { "background": "DarkRed", "icon": "arrow-right", "iconColour": "DarkRed" }
    },
    "todo-tree.general.statusBar": "tags",
    "todo-tree.tree.labelFormat": "${filename}:${line} ${tag}${after}",
    "todo-tree.filtering.useBuiltInExcludes": "file and search excludes",
```

# Tag Highlighter

Highlight todo files:
- tags
- highlighted items (starting with "[] * ")
- Grey out action taken items (include "[> ...]")

Extension: `fabiospampinato.vscode-highlight`

```
    "highlight.regexes": {
        "^(\\s*)((\\[\\]|\\-|\\*|>)[ \\t]+\\*.*)$": { // "[] *" - Current item, highlight line in yellow
            "regexFlags": "gim",
            "filterFileRegex": "todo(\\.(txt|md))?",
            "decorations": [
                {},
                {
                    "backgroundColor": "#FFFF00AA",
                    "rangeBehavior": 1,
                    "isWholeLine": true
                },
            ]
        },
        "^(\\s*)(.*\\[>.*\\].*?)(\\s*)$": { // "[> .* ]" - Action Taken, highlight line in gray
            "regexFlags": "gim",
            "filterFileRegex": "todo(\\.(txt|md))?",
            "decorations": [
                {},
                {
                    "backgroundColor": "#D0D0D0AA",
                    "opacity": "0.8",
                    "rangeBehavior": 1
                },
            ]
        },
        "(#tag1\\S*)": {
            "regexFlags": "gi",
            "filterFileRegex": "todo(\\.(txt|md))?",
            "decorations": [
                {
                    "backgroundColor": "mediumseagreen",
                    "color": "#F8F8F8",
                    "rangeBehavior": 1
                },
            ]
        },
        "(#tag2\\S*)": {
            "regexFlags": "gi",
            "filterFileRegex": "todo(\\.(txt|md))?",
            "decorations": [
                {
                    "backgroundColor": "green",
                    "color": "#F8F8F8",
                    "rangeBehavior": 1
                },
            ]
        },
        "(#tag3\\S*)": {
            "regexFlags": "gi",
            "filterFileRegex": "todo(\\.(txt|md))?",
            "decorations": [
                {
                    "backgroundColor": "red",
                    "color": "#F8F8F8",
                    "rangeBehavior": 1
                },
            ]
        },
        "(#tag4\\S*)": {
            "regexFlags": "gi",
            "filterFileRegex": "todo(\\.(txt|md))?",
            "decorations": [
                {
                    "backgroundColor": "hotpink",
                    "color": "#F8F8F8",
                    "rangeBehavior": 1
                },
            ]
        },
        "(#tag5\\S*)": {
            "regexFlags": "gi",
            "filterFileRegex": "todo(\\.(txt|md))?",
            "decorations": [
                {
                    "backgroundColor": "deepskyblue",
                    "color": "#F8F8F8",
                    "rangeBehavior": 1
                },
            ]
        },
        "(#tag6\\S*)": { // Modify to tags on current list
            "regexFlags": "gi",
            "filterFileRegex": "todo(\\.(txt|md))?",
            "decorations": [
                {
                    "backgroundColor": "mediumorchid",
                    "color": "#F8F8F8",
                    "rangeBehavior": 1
                },
            ]
        },
        "(#(?!tag1|tag2|tag3|tag4|tag5|tag6)\\S*)": { // Catchall
            "regexFlags": "gi",
            "filterFileRegex": "todo(\\.(txt|md))?",
            "decorations": [
                {
                    "backgroundColor": "darkgray",
                    "color": "#F8F8F8",
                    "rangeBehavior": 1
                },
            ]
        },
    },
```

# Misc Extensions

- `baincd.copy-path-unixstyle`
- `baincd.duplicate-to-untitled-file`

