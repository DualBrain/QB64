The **semicolon** is used in a [PRINT](PRINT) statement to stop the screen print cursor immediately after the printed value. 

## Usage

`COLOR 13: PRINT "Value ="; value1; value2; value3`

```text

1234  5678  9012

```

* Positive numerical values [PRINT](PRINT) will include a space before and after each value printed. Strings will not have spacing.
* Use the [WRITE](WRITE) statement to print values with only commas between the values and no spacing.
* A semicolon can append the next print when used at the end of a [PRINT](PRINT) statement.
* Use a semicolon after text that will be [PRINT](PRINT) on the last two text rows of a [SCREEN (statement)](SCREEN-(statement)) to prevent screen rolling.
* [INPUT](INPUT) statements can use the semicolon **before** the text to prevent screen rolling. **INPUT ; "text or question"; variable**.
* A semicolon **after** the text will create a question mark and space after the [INPUT](INPUT) text question. Use a comma for statements.
* **NOTE: Semicolons can NOT be used to combine string variables in a string variable definition!** 
* Use the **+** [concatenation](concatenation) operator to combine [STRING](STRING) variable definition values only! 
* [Semicolon](Semicolon)s cannot be used in or following a [WRITE](WRITE) statement!

## See Also

* [Comma](Comma)
* [PRINT](PRINT), [PRINT USING](PRINT-USING)
* [WRITE](WRITE)
* [INPUT](INPUT), [LINE INPUT](LINE-INPUT)
* [STR$](STR$) (convert number to string)
* [VAL](VAL) (convert string to number)
