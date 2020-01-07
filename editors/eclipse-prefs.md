# Eclipse Installation

## Plugins
    MoreUnit

## Fix Junit Tests
https://bugs.eclipse.org/bugs/show_bug.cgi?id=481417#c8

# Workspace Configuration

## Setup Java Static Imports
Under Java/Editor/Content Assist/Favorites
```
java.text.MessageFormat.*
org.assertj.core.api.Assertions.*
org.hamcrest.Matchers.*
org.junit.Assert.*
org.mockito.Matchers.*
org.mockito.Mockito.*
```

# Templates
Java > Editor > Templates
- Name: debugout
  - Context: Java statements
  - Description: println for debugging (temporary)
  - Pattern: System.out.println(java.text.MessageFormat.format("===> ${user}/${enclosing_method}/${currentDate:date('msS')}: {0} - {1} - {2} <===",${cursor})); // TODO: delete temporary debugging line

# Key Bindings
* Shift+Ctrl+P - Bind to Quick Access in Windows
  * Remap "Matching bracket/character/tag" commands to Shift+Ctrl+]
* Shift-Ctrl-F - Bind to File Search in Windows
  * Remap "Format" commands to Ctrl+Alt+F
* Shift-F4 - Bind to Show in (Package Explorer) in Windows

# Refresh
General > Workspace > Refresh using native hooks or polling (Enable)
