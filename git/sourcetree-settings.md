## Reenable Merge Conflicts (and other hidden settings)

`C:\Users\<userid>\AppData\Local\Atlassian\SourceTree.exe*\X.x.x.x\user.config`
```
<setting name="SuppressConflictsWarning" serializeAs="String">
    <value>False</value>
</setting>
```

## Stash/Bitbucket integration:
Repository Settings->(select repo)->Edit->Option extended integration
```
Host Type: Stash
Host Root URL: https://stash.example.com:8443 (URL level before /projects)
Username: duh
```

## Jira integration:
Repository Settings->Advanced->Add Commit text links
```
Project Profile: the Jira project ID
Root URL: https://jira.exmaple.com/jira (URL level before /browse/PROJECT)
```
