The SPC function is used in [PRINT](PRINT) and [LPRINT](LPRINT) statements to print or output a number of space characters.

## Syntax

> **SPC(count%)**

## Parameter(s)

* *count* designates the number of column spaces to move the cursor in a [PRINT](PRINT) statement.

## Usage

* When used in a [PRINT](PRINT) statement,
  * count% is the number of space characters to print, overwriting existing characters.
  * If count% is greater than the number of columns left in the current row, remaining space characters are printed on the next row.
* When used in a [PRINT (file statement)](PRINT-(file-statement)) statement,
  * count% is the number of space characters to output.
  * If count% is less than or equal to zero, the function has no effect.

## Example(s)

Using SPC to space a text print.

```vb

PRINT "123456789"
PRINT "abc" ; SPC(3) ; "123"

```

```text

123456789
abc   123

```

## See Also

* [PRINT](PRINT), [PRINT (file statement)](PRINT-(file-statement))
* [LPRINT](LPRINT), [STRING$](STRING$)
* [TAB](TAB), [SPACE$](SPACE$)
