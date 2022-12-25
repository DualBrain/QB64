The [_ACCEPTFILEDROP](_ACCEPTFILEDROP) statement prepares a program window to receive files dropped from Windows Explorer in a drag/drop operation.

## Syntax

>  [_ACCEPTFILEDROP](_ACCEPTFILEDROP) [{ON|OFF}]

## Description

* Calling the statement with no parameters turns drag/dropping ON.
* To know when files have been dropped into your program's window, check that [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES) is greater than 0.
* Use [_DROPPEDFILE](_DROPPEDFILE) to read the list, either sequentially or by index.
* If using [_DROPPEDFILE](_DROPPEDFILE) with an index, you must call [_FINISHDROP](_FINISHDROP) after you finish working with the list.
* **[Keywords currently not supported](Keywords-currently-not-supported-by-QB64)**.

## Availability

* Version 1.3 and up.

## Example(s)

Accepting files dragged from a folder and processing the list received sequentially. 

```vb

SCREEN _NEWIMAGE(128, 25, 0)

_ACCEPTFILEDROP 'enables drag/drop functionality
PRINT "Drag files from a folder and drop them in this window..."

DO
    IF _TOTALDROPPEDFILES THEN
        FOR i = 1 TO _TOTALDROPPEDFILES
            a$ = _DROPPEDFILE 'reads the list sequentially; when the result is empty ("") it means the list is over
            COLOR 15
            PRINT i,
            IF _FILEEXISTS(a$) THEN
                COLOR 2: PRINT "file",
            ELSE
                IF _DIREXISTS(a$) THEN
                    COLOR 3: PRINT "folder",
                ELSE
                    COLOR 4: PRINT "not found", 'highly unlikely, but who knows?
                END IF
            END IF
            COLOR 15
            PRINT a$
        NEXT
    END IF

    _LIMIT 30
LOOP

```

## See Also

* [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES), [_DROPPEDFILE](_DROPPEDFILE), [_FINISHDROP](_FINISHDROP)
* [_FILEEXISTS](_FILEEXISTS), [_DIREXISTS](_DIREXISTS)
