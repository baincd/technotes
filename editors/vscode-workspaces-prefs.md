# Default workspace

Enable by adding the workspace path to shortcuts/aliases to open vscode

`/home/chris/default.code-workspace`:
```json
{
	"folders": [],
	"settings": {
		"window.title": "${dirty}${activeEditorShort}${separator}Default Workspace${separator}${appName}",
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
