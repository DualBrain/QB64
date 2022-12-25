See [OPEN](OPEN).

[BINARY](BINARY) is used in an [OPEN](OPEN) statement to work with the file or port device manipulating its bytes directly.

## Syntax

> [OPEN](OPEN) fileName$ [FOR](FOR) [BINARY](BINARY) [AS](AS) #fileNumber%

## Description

* [OPEN](OPEN) FOR BINARY creates the file if the fileName$ does not exist.
* fileName$ is the name of the file to open, but could also configure a port.
* #fileNumber% is the number that will represent the file when performing file operations.
* BINARY files use [GET](GET) and [PUT](PUT) to read or write the file at any byte position.
* In **version 1.000 and up** you can use [LINE INPUT](LINE-INPUT) in [BINARY](BINARY) mode for faster access to text file data.
* QBasic's [BSAVE](BSAVE) or BINARY save files can be read using BINARY mode.
* BINARY mode ignores any [LEN](LEN) = recordlength statement in the [OPEN](OPEN) statement.
* Ports can also be opened in [BINARY](BINARY) mode. See: [OPEN COM](OPEN-COM)

## Example(s)

Shows how a PUT variable value is converted to an [ASCII](ASCII) string [_MK$](_MK$) format in a BINARY file.

```vb

DIM int64 AS _INTEGER64
DIM byte8 AS STRING * 8
int64 = 12345678
PRINT int64

OPEN "temp64.tmp" FOR BINARY AS #1
PUT #1, , int64                 'the file size will be 8 bytes
CLOSE

PRINT "Press a key to read the file!"
K$ = INPUT$(1)

OPEN "temp64.tmp" FOR BINARY AS #1
GET #1, , byte8                'GET the value as a string
PRINT "text string: "; byte8   'show that string is in _MK$ format

PRINT _CV(_INTEGER64, byte8)   'convert to numerical value
CLOSE

```

> *Note:* The numerical value does not need to be converted if the file is read using the same numerical variable type as written.

A binary file viewer that can view integer values. The type of value can be changed at [DIM](DIM).

```vb

SCREEN _NEWIMAGE(1000, 600, 256)
_SCREENMOVE _MIDDLE
DIM value AS INTEGER    'value type can be changed
LINE INPUT ; "Enter a BINARY filename to open: ", file$
PRINT " Press S to restart!"

IF LEN(file$) THEN OPEN file$ FOR BINARY AS #1 ELSE END
IF LOF(1) = 0 THEN PRINT "Empty file!": END
DO
  FOR i = 1 TO 16
    x = x + 1
    GET #1, , value
    IF EOF(1) THEN EXIT DO
    PRINT value;
  NEXT
  PRINT CHR$(27); x; "@"; row
  K$ = INPUT$(1)
  IF UCASE$(K$) = "S" THEN CLS: x = 0: row = 0: PRINT "Restarted!": SEEK 1, 1
  IF x = 256 THEN x = 0: row = row + 1: PRINT
LOOP UNTIL K$ = CHR$(27)
CLOSE #1
PRINT "Press Escape to exit!"
DO: _LIMIT 100
LOOP UNTIL INKEY$ = CHR$(27)
SYSTEM

```

## See Also

* [OPEN](OPEN), [CLOSE](CLOSE)
* [GET](GET), [PUT](PUT), [LINE INPUT](LINE-INPUT)
* [SEEK](SEEK) (function), [SEEK (statement)](SEEK-(statement))
* [INPUT (file mode)](INPUT-(file-mode)), [RANDOM](RANDOM), [APPEND](APPEND), [OUTPUT](OUTPUT)
* [Bitmaps](Bitmaps), [Binary](Binary) (numbers)
