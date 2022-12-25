The [_MAPUNICODE](_MAPUNICODE) function returns the [Unicode](Unicode) (UTF-32) code point value of a mapped [ASCII](ASCII) character code.

## Syntax

> utfValue& = [_MAPUNICODE](_MAPUNICODE)(asciiCode%)

## Description

* UTF-32 values have 4-byte encoding so the return variable should be [LONG](LONG).
* The asciiCode% can be any [INTEGER](INTEGER) value from 0 to 255.
* Returns can be used to verify or catalog the present Unicode mapping.
* The function returns Unicode values for the control characters, CHR$(127) and extended characters without mapping them first.

## Example(s)

Store function return values in an array for ASCII codes 0 to 255 to restore them later.

```vb

DIM Unicode&(255)
SCREEN 0
_FONT _LOADFONT("C:\Windows\Fonts\Cour.ttf", 20, "MONOSPACE") 'select monospace font

FOR ascii = 0 TO 255
Unicode&(ascii) = _MAPUNICODE(ascii)     'read Unicode values
PRINT Unicode&(ascii);                   'display values in demo
NEXT
 'rest of program 
END

```

## See Also

* [_MAPUNICODE](_MAPUNICODE) (statement)
* [Unicode](Unicode), [Code Pages](Code-Pages) (by region)
* [ASCII](ASCII), [CHR$](CHR$), [ASC](ASC)
* [Text Using Graphics](Text-Using-Graphics)
