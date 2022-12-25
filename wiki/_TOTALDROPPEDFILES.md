The [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES) function returns the number of items (files or folders) dropped in a program's window after [_ACCEPTFILEDROP](_ACCEPTFILEDROP) is enabled.

## Syntax

>  totalFilesReceived& = [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES)

## Description

* After [_ACCEPTFILEDROP](_ACCEPTFILEDROP) is enabled, [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES) will return 0 until the user drops files or folders into the program's window.
* When using [_DROPPEDFILE](_DROPPEDFILE) to read the list sequentially, [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES) will be reset to 0 after the last item is retrieved (after [_DROPPEDFILE](_DROPPEDFILE) returns an empty string "").
* If using [_DROPPEDFILE](_DROPPEDFILE) with an index, you must call [_FINISHDROP](_FINISHDROP) after you finish working with the list.
* When using [_DROPPEDFILE](_DROPPEDFILE) to read the list with an index, [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES) will **not** be reset (and the list of items won't be cleared) until [_FINISHDROP](_FINISHDROP) is called.
* **[Keywords currently not supported](Keywords-currently-not-supported-by-QB64)**.

## Availability

* Version 1.3 and up.

## Example(s)

* See example for [_ACCEPTFILEDROP](_ACCEPTFILEDROP)

## See Also

* [_ACCEPTFILEDROP](_ACCEPTFILEDROP), [_DROPPEDFILE](_DROPPEDFILE), [_FINISHDROP](_FINISHDROP)
* [_FILEEXISTS](_FILEEXISTS), [_DIREXISTS](_DIREXISTS)
