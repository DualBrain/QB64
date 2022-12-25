The [KILL](KILL) statement deletes a file designated by a [STRING](STRING) value or variable.

## Syntax

> [KILL](KILL) fileSpec$

* fileSpec$ is a literal or variable string path and filename. Wildcards * and ? can be used with caution.
  - * denotes one or more wildcard letters of a name or extension
  - ? denotes one wildcard letter of a name or extension
* fileSpec$ can include a path that can be either relative to the program's current location or absolute, from the root drive.
* [KILL](KILL) cannot remove an [OPEN](OPEN) file. The program must [CLOSE](CLOSE) it first.  
* If the path or file does not exist, a "File not found" or "Path not found" [ERROR Codes](ERROR-Codes) will result. See [_FILEEXISTS](_FILEEXISTS).
* `[SHELL](SHELL) "DEL /Q " + fileName$` does the same without a prompt or verification for wildcard deletions.
* `[SHELL](SHELL) "DEL /P " + fileName$` will ask for user verification. 
* Cannot delete folders or directories. Use [RMDIR](RMDIR) to remove empty folders.
* **Warning: files deleted with [KILL](KILL) will not go to the Recycle Bin and they cannot be restored.**

## Example(s)

```vb

KILL "C:\QBasic\data\2000data.dat"

```

## See Also

* [RMDIR](RMDIR), [FILES](FILES), [SHELL](SHELL), [OPEN](OPEN)
* [CHDIR](CHDIR), [MKDIR](MKDIR), [NAME](NAME)
* [_FILEEXISTS](_FILEEXISTS), [_DIREXISTS](_DIREXISTS)
