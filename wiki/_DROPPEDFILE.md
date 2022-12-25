The [_DROPPEDFILE](_DROPPEDFILE) function returns the list of items (files or folders) dropped in a program's window after [_ACCEPTFILEDROP](_ACCEPTFILEDROP) is enabled.

## Syntax

*Syntax 1*

> nextItem$ = [_DROPPEDFILE](_DROPPEDFILE)

*Syntax 2*

> nextItem$ = [_DROPPEDFILE](_DROPPEDFILE)(index&)

## Description

* After [_ACCEPTFILEDROP](_ACCEPTFILEDROP) is enabled, once [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES) is greater than 0 the list of dropped items will be available for retrieval with [_DROPPEDFILE](_DROPPEDFILE)
* When using [_DROPPEDFILE](_DROPPEDFILE) to read the list sequentially (without specifying an *index&*), an empty string ("") indicates the list is over and then [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES) gets reset to 0.
* When using [_DROPPEDFILE](_DROPPEDFILE) with an index (which goes from 1 to [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES)), you must call [_FINISHDROP](_FINISHDROP) after you finish working with the list.
* Because it returns a string, [_DROPPEDFILE](_DROPPEDFILE) also accepts being followed by a string suffix ([_DROPPEDFILE](_DROPPEDFILE)**$**)
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
        _FINISHDROP
    END IF

    _LIMIT 30
LOOP

```

## See Also

* [_ACCEPTFILEDROP](_ACCEPTFILEDROP), [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES), [_FINISHDROP](_FINISHDROP)
* [_FILEEXISTS](_FILEEXISTS), [_DIREXISTS](_DIREXISTS)
