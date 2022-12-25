The WRITE statement writes a [comma](comma)-separated list of values to the screen without spacing.

## Syntax

> WRITE [expression, List]

## Description

* expressionList is a comma-separated list of variable or literal values to be written to the screen.
* Write statement separates displayed values using [comma](comma) separators(required) that will display on the screen. 
* Leading and trailing number spaces are omitted when displaying numerical values.
* [STRING](STRING) [quotation mark](quotation-mark)s will also be displayed.
* [Semicolon](Semicolon)s cannot be used in or following the WRITE statement!

## Example(s)

Comparing WRITE to the same PRINT statement.

```vb

a% = 123
b$ = "Hello"
c! = 3.1415

PRINT a%, b$, c!   'commas display tab spaced data
WRITE a%, b$, c!   'displays commas between values, strings retain end quotes

```

```text

123        Hello      3.1415
123,"Hello",3.1415 

```

## See Also

* [WRITE (file statement)](WRITE-(file-statement))
* [INPUT (file statement)](INPUT-(file-statement))
* [PRINT](PRINT), [PRINT (file statement)](PRINT-(file-statement))
* [PRINT USING](PRINT-USING)
