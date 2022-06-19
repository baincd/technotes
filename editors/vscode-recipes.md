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
