The TAB function is used in [PRINT](PRINT) and [LPRINT](LPRINT) statements to move to a specified column position.

## Syntax

> TAB(column%)

## Description

* Space characters are printed until the print cursor reaches the designated column%, overwriting existing characters.
* If a subsequent TAB *column%* is less than the current position, TAB moves the next print to that column on the next row.
* [ASCII](ASCII) [CHR$](CHR$)(9) can be substituted for sequencial 9 space column moves.
* [Comma](Comma) PRINT spacing is up to 15 column places (IE: TAB(15)) to a maximum column of 57.
* When printing to a file, a carriage return([CHR$](CHR$)(13)) and linefeed([CHR$](CHR$)(10)) character are output when it moves to the next row.
* **Note:** QBasic did not allow a TAB to be [concatenation](concatenation) to a string value. In [PRINT](PRINT) statements the [+](+) would be changed to a [semicolon](semicolon). 
> In QB64, TAB [concatenation](concatenation) is allowed instead of [semicolon](semicolon)s. Example: PRINT "text" + TAB(9) + "here"

## Example(s)

 Comparing TAB to [comma](comma) print spacing which moves the next text print 15 columns.

```vb

PRINT TAB(15); "T" 'TAB spacing

PRINT , "T" 'comma spacing

PRINT TAB(15); "T"; TAB(20); "A"; TAB(15); "B" 'semicolons add nothing to position

PRINT TAB(15); "T", TAB(20); "A"; TAB(15); "B" 'comma moves column position beyond 20 

```

```text

              T
              T
              T    A
              B 
              T
                   A
              B

```
 
>  *Explanation:* TAB moves the PRINT down to the next row when the current column position is more than the TAB position.

## See Also

* [PRINT](PRINT), [LPRINT](LPRINT)
* [SPC](SPC), [SPACE$](SPACE$)
* [STRING$](STRING$)
* [CHR$](CHR$), [ASCII](ASCII)
