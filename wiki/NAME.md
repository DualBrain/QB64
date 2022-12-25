The [NAME](NAME) statement changes the name of a file or directory to a new name.

## Syntax

> [NAME](NAME) oldFileOrFolderName$ **AS** newFileOrFolderName$

## Description

* oldFileOrFolderName$ and newFileOrFolderName$ are variables or literal [STRING](STRING)s in quotes. Paths can be included.
* If the two paths are different, the statement moves the original file to the new path and renames it.
* If the path is the same or a path is not included, the original file is just renamed.
* [SHELL](SHELL) can use *"REN " + filename$ + " " + newname$* for the same purpose (Windows).
* Path or filename [ERROR Codes](ERROR-Codes) are possible and should be handled in the program.
* **Caution: There is no prompt to continue or execution verification.**

## Example(s)

```vb

NAME "BIGBAD.TXT" AS "BADWOLF.TXT"

```

## See Also

* [SHELL](SHELL), [MKDIR](MKDIR), [FILES](FILES) 
* [CHDIR](CHDIR), [KILL](KILL), [RMDIR](RMDIR)
* [Windows Libraries](Windows-Libraries)
