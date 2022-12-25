The [MKI$](MKI$) function encodes an [INTEGER](INTEGER) numerical value into a 2-byte [ASCII](ASCII) [STRING](STRING) value.

## Syntax

>  result$ = [MKI$](MKI$)(integerVariableOrLiteral%)

## Description

* integerVariableOrLiteral% is converted to two ASCII characters.
* [INTEGER](INTEGER) values can range from -32768 to 32767.
* MKI$ string values can be converted back to numerical INTEGER values using [CVI](CVI).
* The function takes up less byte space in a file than using the text numerical value when the value is over 2 digits.
* When a variable value is used with [PUT](PUT) a numerical value is converted automatically in [RANDOM](RANDOM) and [BINARY](BINARY) files.

## Example(s)

How MKI$ creates a two byte string integer value to save file space.

```vb

SCREEN 12    '_PRINTSTRING requires a graphic screen mode
DO
  COLOR 14: LOCATE 13, 20: INPUT "Enter an Integer from 1 to 32767(0 quits): ", number%
  IF number% < 1 THEN EXIT DO
  CLS
  A$ = CHR$(number% MOD 256)   'first digit(0 to 255)
  B$ = CHR$(number% \ 256)     'second digit(0 to 127)

  MKIvalue$ = A$ + B$
  Q$ = CHR$(34)
  strng$ = "CHR$(" + LTRIM$(STR$(number% MOD 256)) + ") + CHR$(" + LTRIM$(STR$(number% \ 256)) + ")"
  COLOR 11
  _PRINTSTRING (222, 252), STR$(number%) + " = " + strng$
  _PRINTSTRING (252, 300), "MKI$ value = " + Q$ + MKIvalue$ + Q$ 'print ASCII characters
LOOP
END 

```


> *Explanation:* INPUT in QB64 limits integer entries to 32767 maximum. MOD 256 finds the part of a value from 0 to 255 while the second value is the number of times that 256 can go into the value. [_PRINTSTRING](_PRINTSTRING) can print all of the [ASCII](ASCII) characters.

## See Also

* [MKD$](MKD$), [MKS$](MKS$), [MKL$](MKL$)
* [CVD](CVD), [CVI](CVI), [CVS](CVS), [CVL](CVL)
* [_MK$](_MK$), [_CV](_CV)
