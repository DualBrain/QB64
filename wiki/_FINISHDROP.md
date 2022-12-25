The [_FINISHDROP](_FINISHDROP) statement resets [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES) and clears the [_DROPPEDFILE](_DROPPEDFILE) list of items (files/folders).

## Syntax

> [_FINISHDROP](_FINISHDROP)

## Description

* When using [_DROPPEDFILE](_DROPPEDFILE) with an index (which goes from 1 to [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES)), you must call [_FINISHDROP](_FINISHDROP) after you finish working with the list in order to prepare for the next drag/drop operation.
* **[Keywords currently not supported](Keywords-currently-not-supported-by-QB64)**.

## Availability

* Version 1.3 and up.

## Example(s)

Accepting files dragged from a folder and processing the list received by specifying an index. 

```vb

SCREEN _NEWIMAGE(128, 25, 0)

_ACCEPTFILEDROP 'enables drag/drop functionality
PRINT "Drag files from a folder and drop them in this window..."

DO
    IF _TOTALDROPPEDFILES THEN
        FOR i = 1 TO _TOTALDROPPEDFILES
            a$ = _DROPPEDFILE(i)
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
        _FINISHDROP 'If _FINISHDROP isn't called here then _TOTALDROPPEDFILES never gets reset.
    END IF

    _LIMIT 30
LOOP

```

## See Also

* [_ACCEPTFILEDROP](_ACCEPTFILEDROP), [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES), [_DROPPEDFILE](_DROPPEDFILE)
* [_FILEEXISTS](_FILEEXISTS), [_DIREXISTS](_DIREXISTS)
