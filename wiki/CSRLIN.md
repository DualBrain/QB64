The [CSRLIN](CSRLIN) function returns the current text row position of the [PRINT](PRINT) cursor.

## Syntax

> row% = [CSRLIN](CSRLIN)

## Description

*  The value returned is within the range of 1 to the current number of rows in the [SCREEN](SCREEN) mode used.
  * In [SCREEN](SCREEN) 0 (text mode), the [_HEIGHT](_HEIGHT) function returns the number of text rows.
  * In graphic modes, the number of available text rows can be calculated by dividing [_HEIGHT](_HEIGHT) (measured in pixels in graphic modes) by [_FONTHEIGHT](_FONTHEIGHT): ***totalRows%* = _HEIGHT / _FONTHEIGHT**
*  In screen modes that support page flipping, the [CSRLIN](CSRLIN) function returns the vertical coordinate of the cursor on the active page.
* x = [POS](POS)(0) returns the column location of the cursor.

## Example(s)

A semicolon stops the print cursor immediately after the print.

```vb

LOCATE 5, 5: PRINT "HELLO ";
Y = CSRLIN 'save the row
X = POS(0) 'save the column  
LOCATE 10, 10: PRINT "WORLD"
LOCATE Y, X 'restore saved position
PRINT "GOODBYE" 

```

```text

         HELLO GOODBYE

         WORLD


```

> *Explanation:* "HELLO " is printed and the semicolon stops the cursor immediately after the text. The [CSRLIN](CSRLIN) variable records the current print cursor's text row in Y. The [POS](POS) function records the current print cursor's text column in X. The second [PRINT](PRINT) statement displays the comment "WORLD" on the 10th line of the screen. The last [LOCATE](LOCATE) statement restores the position of the cursor to the original line and column immediately after the first print.

## See Also

* [SCREEN](SCREEN), [LOCATE](LOCATE), [POS](POS)
* [_PRINTSTRING](_PRINTSTRING) (graphic print)
