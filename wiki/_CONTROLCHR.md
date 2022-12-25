The [_CONTROLCHR](_CONTROLCHR) statement can be used to turn OFF control character attributes and allow them to be printed.

## Syntax

> [_CONTROLCHR](_CONTROLCHR) {OFF|ON}

## Description

* The [OFF](OFF) clause allows control characters 0 to 31 to be printed and not format printing as normal text characters. 
  * For example: **PRINT CHR$(13)** 'will not move the cursor to the next line and **PRINT CHR$(9)** 'will not tab. 
* The default [ON](ON) statement allows [ASCII](ASCII) to be used as control commands where some will not print or will format prints.
* **Note:** File prints may be affected also when using Carriage Return or Line Feed/Form Feed formatting.
* The QB64 IDE may allow Alt + number pad character entries, but they must be inside of [STRING](STRING) values. Otherwise the IDE may not recognize them.

## Example(s)

Printing the 255 [ASCII](ASCII) characters in [SCREEN](SCREEN) 0 with 32 colors.

```vb

DIM i AS _UNSIGNED _BYTE
WIDTH 40, 25
CLS
_CONTROLCHR OFF
i = 0
DO
 PRINT CHR$(i);
 i = i + 1
 IF (i AND &HF) = 0 THEN PRINT
LOOP WHILE i
LOCATE 1, 20
DO
 COLOR i AND &HF OR (i AND &H80) \ &H8, (i AND &H70) \ &H10
 PRINT CHR$(i);
 i = i + 1
 IF (i AND &HF) = 0 THEN LOCATE 1 + i \ &H10, 20
LOOP WHILE i
END 

```

## See Also

* [_CONTROLCHR (function)](_CONTROLCHR-(function))
* [CHR$](CHR$), [ASC](ASC)
* [INKEY$](INKEY$), [_KEYHIT](_KEYHIT)
* [ASCII](ASCII) (codes)
* [ASCII](ASCII)
