The **POS** function returns the current print cursor text column position.

## Syntax

> column% = POS(0)

* The value in parenthesis is normally  0, but any numerical value or variable could be used for compatibility with Basic.
* When a semicolon ends the previous PRINT statement the cursor column position will be after the last character printed.
* If [TAB](TAB) or a comma is used the column position will be immediately after the tabbed position normally 9 spaces after text
* If a [PRINT](PRINT) statement does not use a semicolon or comma at the end, the return value will be 1 on the next row.
* Column position returned can be saved to return to a previous print position later using [LOCATE](LOCATE).

## Example(s)

Column positions after prints.

```vb

PRINT POS(0) 'column position always starts on 1 at top of new or after CLS
PRINT "hello"; 'column position is 6 on same row immediately after text
PRINT POS(0)
PRINT 'start new row
PRINT "hello", 'column position is 15 on same row (normally tabs 9 spaces)
PRINT POS(0)
PRINT 'start new row
PRINT
PRINT POS(0) ' column position is 1 on next row 

```

*Note:* Column tab prints may not always move 9 spaces past the center of the screen. Some may move text to next row.

## See Also
 
* [CSRLIN](CSRLIN), [LOCATE](LOCATE), [PRINT](PRINT)
* [_PRINTSTRING](_PRINTSTRING) (graphic position print)
