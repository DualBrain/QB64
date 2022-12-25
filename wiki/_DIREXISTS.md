The [_DIREXISTS](_DIREXISTS) function determines if a designated file path or folder exists and returns true (-1) or false (0).

## Syntax

> dirExists% = [_DIREXISTS](_DIREXISTS)(filepath$)

## Description

* The filepath$ parameter can be a literal or variable [STRING](STRING) path value.
* The function returns -1 when a path or folder exists and 0 when it does not.
* The function reads the system information directly without using a [SHELL](SHELL) procedure.
* The function will use the appropriate Operating System path separators. [_OS$](_OS$) can determine the operating system.
* **This function does not guarantee that a path can be accessed, only that it exists.**
* **NOTE: Checking if a folder exists in a CD drive may cause the tray to open automatically to request a disk when empty.**

## Example(s)

Checks if a folder exists before proceeding.

```vb

IF _DIREXISTS("internal\temp") THEN
    PRINT "Folder found."
END IF

```

## See Also

* [_FILEEXISTS](_FILEEXISTS)
* [SHELL](SHELL)
* [_OS$](_OS$)
