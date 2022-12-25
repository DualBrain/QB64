The [CHDIR](CHDIR) statement changes the program's location from one working directory to another by specifying a literal or variable [STRING](STRING) path.

## Syntax

> [CHDIR](CHDIR) path$

## Description

* path$ is the new directory path the program will work in.
* path$ can be an absolute path (starting from the root folder) or relative path (starting from the current program location).
* If path$ specifies a non-existing path, a [ERROR Codes](ERROR-Codes) error will occur.
* **A QB64 [SHELL](SHELL) statement cannot use "CD " or "CHDIR " + path$ to change directories.**

## Example(s)

The following code is Windows-specific:

```vb

CHDIR "C:\"      'change to the root drive C (absolute path)
CHDIR "DOCUME~1" 'change to "C:\Documents and Settings" from root drive (relative path) 
CHDIR "..\"      'change back to previous folder one up 

```

> *Details:* **QB64** can use long or short (8.3 notation) file and path names.

Using the Windows API to find the current program's name and root path. The PATH$ is a shared function value.

```vb

_TITLE "My program"
PRINT TITLE$
PRINT PATH$

FUNCTION TITLE$ *=== SHOW CURRENT PROGRAM
SHARED PATH$           'optional path information shared with main module only
DECLARE LIBRARY        'Directory Information using KERNEL32 provided by Dav
  FUNCTION GetModuleFileNameA (BYVAL Module AS LONG, FileName AS STRING, BYVAL nSize AS LONG)
END DECLARE

FileName$ = SPACE$(256)
Result = GetModuleFileNameA(0, FileName$, LEN(FileName$))  '0 designates the current program
IF Result THEN             'Result returns the length or bytes of the string information
  PATH$ = LEFT$(FileName$, Result)
  start = 1
  DO
    posit = INSTR(start, PATH$, "\")
    IF posit THEN last = posit
    start = posit + 1
  LOOP UNTIL posit = 0
  TITLE$ = MID$(PATH$, last + 1)
  PATH$ = LEFT$(PATH$, last)
ELSE TITLE$ = "": PATH$ = ""
END IF
END FUNCTION 

```

> **Note:** The program's [_TITLE](_TITLE) name may be different from the actual program module's file name returned by Windows.

## See Also

* [SHELL](SHELL), [FILES](FILES)
* [MKDIR](MKDIR), [RMDIR](RMDIR)
* [$CONSOLE]($CONSOLE)
