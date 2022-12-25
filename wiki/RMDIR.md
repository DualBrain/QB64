The RMDIR statement deletes an empty directory using a designated path relative to the present path location.

## Syntax

> RMDIR directory$

## Description

* directory$ is a relative path to the directory to delete.
* Directory path must be a literal or variable [STRING](STRING) value designating the folder to be deleted.
* If the directory contains files or folders, a [ERROR Codes](ERROR-Codes) will occur.
* If the directory path cannot be found, a [ERROR Codes](ERROR-Codes) error occurs.

## Example(s)

```vb

ON ERROR GOTO ErrorHandler
DO
    ERRcode = 0
    INPUT "Enter path and name of directory to delete: "; directory$
    IF LEN(directory$) THEN      'valid user entry or quits
        RMDIR directory$    'removes empty folder without a prompt
        IF ERRcode = 0 THEN PRINT "Folder "; directory$; " removed."
    END IF
LOOP UNTIL ERRcode = 0 OR LEN(directory$) = 0
SYSTEM

ErrorHandler:
    ERRcode = ERR    'get error code returned
    SELECT CASE ERRcode
        CASE 75
            PRINT directory$ + " is not empty!"
        CASE 76
            PRINT directory$ + " does not exist!"
        CASE ELSE
            PRINT "Error"; ERRcode; "attempting to delete " + directory$
    END SELECT
    PRINT
RESUME NEXT


```

> This Windows-specific output from two runs of the above program is typical, though your output may vary. User-entered text is in italics.

```text

Enter path and name of directory to delete: *Some\Folder\That\Doesnt\Exist*
Some\folder\That\Doesnt\Exist does not exist!

Enter path and name of directory to delete: *C:\temp*
C:\temp is not empty!


```

## See Also

* [MKDIR](MKDIR), [CHDIR](CHDIR)
* [KILL](KILL), [FILES](FILES)
