# Eclipse Installation

## Plugins
    MoreUnit
    EclEmma
    TM Terminal

## Fix Junit Tests
https://bugs.eclipse.org/bugs/show_bug.cgi?id=481417#c8

# Workspace Configuration

## Java

### Setup Static Imports
Under Java/Editor/Content Assist/Favorites
```
java.text.MessageFormat.*
org.assertj.core.api.Assertions.*
org.hamcrest.Matchers.* // Since Matchers provides a few more options, use it instead of CoreMatchers
org.junit.Assert.*
org.mockito.Mockito.*  // Note: Mockito includes everything typically needed, so no need to include org.mockito.Matchers
```
### Templates
Java > Editor > Templates
- Name: debugout
  - Context: Java statements
  - Description: println for debugging (temporary)
  - Pattern: `System.out.println(java.text.MessageFormat.format("===> ${user}/${enclosing_method}/${currentDate:date('msS')}: {0} - {1} - {2} <===",${cursor})); // TODO: delete temporary debugging line`

# Maven
Maven
- Hide folders of physically nested modules

# Terminal
- Invert Terminal Colors (enable)
- Buffer Lines: 100,000
- (Local Terminal): Initial Working Directory: `${git_dir}/..`
- Show in...
  - Name: Git Bash
  - Path: `<git>\bin\sh.exe`
  - Arguments: `--login -i`
  - Icon: `<git>\mingw64\share\git\git-for-windows.ico`

# Key Bindings
* Shift+Ctrl+P - Bind to "Find Actions" (previously called Quick Access) in Windows
  * Remap "Matching bracket/character/tag" commands to Ctrl+]
* Shift+Ctrl+F - Bind to "File Search" in Windows
  * Remap "Format" commands to Ctrl+Alt+F
* Ctrl+\\ - Bind to "Show View (Package Explorer)" In Windows
* Ctrl+Alt+\\ - Bind to "Show in (Package Explorer)" in Windows
* Ctrl+\` - Bind to "Open Terminal on Selection" In Windows

# Refresh
General > Workspace > Refresh using native hooks or polling (Enable)

# Launch
Run/Debug > Launching > Launch Operation
- Always launch the previously launched application
- Terminate and Relaunch while launching

[ref](https://stackoverflow.com/questions/1151995/is-there-a-shortcut-in-eclipse-to-re-run-the-most-recently-launched-program/1152039#1152039)

# Workstation layout
```
+-----------------------------------------+--------------------------------+----------------------+
| Package Explorer; Type Hierarchy        | <editor>                       | Git Staging; History |
|                                         |                                |                      |
|                                         +--------------------------------+----------------------+
|                                         | Problems; Console; JUnit; Tasks; Bookmarks; Search    |
+-----------------------------------------+                                                       |
| Servers; Boot Dashboard                 |                                                       |
|                                         |                                                       |
+-----------------------------------------+-------------------------------------------------------+
```
* On right side, put Problems view collection on top

# Spring Boot DevTools Prefs

See [../java/spring-prefs.md](../java/spring-prefs.md)
