The [PRINT (file statement)](PRINT-(file-statement)) statement prints numeric or string expressions to a sequential file, IO port or device.

## Syntax

> **PRINT #*fileNumber&***, [ [expression] [{;|,] ... ]

## Parameter(s)

* fileNumber& is the file number of a file or device opened for writing. See [OPEN](OPEN).
* expression is a numeric or string expression to be written to the file. Quotes will be removed from strings.
* The print statement can be followed by a [semicolon](semicolon) to stop the print cursor or a [comma](comma) to tab the next print.

## Usage

* [STRING](STRING) values will be stripped of leading and trailing quotation marks when printed to the file. Use [CHR$](CHR$)(34) to add quotes to a file.
* separator is used to separate multiple expressions and specifies how the file cursor is to be moved before writing the next expression. It can be one of the following:
  * semi-colon (;) - specifies that the print cursor stop immediately after the print. A subsequent print will start there.
  * comma (,) - specifies that the file cursor is to move to the next 14-column tab-stop. If the file cursor is at column 56 or greater, it is moved to the next file row at column 1.
* If separator is not used at the end of the expression list, the file cursor moves to the next file row at column 1.
* PRINT # can use the **+ concatenation** operator or semicolons to combine strings.
* [SPC](SPC)(n%) - specifies that n% space characters will be written in a print.
* [TAB](TAB)(column%) - specifies that the file cursor is to move to a column number column%. If the file cursor is beyond that column, it is moved to that column on the next file row.
* When printing literal or variable numerical values the following rules apply:
  * If the value is positive, the number is prefixed with a space character, otherwise, the number is prefixed with a negative sign (-).
  * If the value is an [INTEGER](INTEGER) (whole number), no decimal point or fractional part will be written.
  * If the value is not an integer (whole number) and has zero for a coefficient, no leading zero is written. For example, -0.123 is written as "-.123 "
  * If a numeric literal is in scientific notation, the number is also written in scientific notation. [PRINT USING (file statement)](PRINT-USING-(file-statement)) can return actual rounded numerical values in string form.
  * The numerical value is always followed by a space character unless [STR$](STR$) is used to convert it to a string value.
* Whenever [PRINT (file statement)](PRINT-(file-statement)) moves the file cursor to a new file row, a carriage return character (CHR$(13)) followed by a line feed character (CHR$(10)) is written. The combination are referred to as the "CRLF" character.
* **Note: [RANDOM](RANDOM) and [BINARY](BINARY) files are not affected by PRINT # statements to them and will create a syntax error in QB64!**

## Example(s)

Prints data to a text file sequentially and reads it back to the program screen as one line of text.

```vb

filename$ = "testfile.dat" 
x = 1: y = 2: z$ = "Three" 

OPEN filename$ FOR OUTPUT AS #1 'opens and clears an existing file or creates new empty file 

PRINT #1, x, y, z$ 

CLOSE #1 

PRINT "File created with data. Press a key!" 

K$ = INPUT$(1) 'press a key 

OPEN filename$ FOR INPUT AS #2 'opens a file to read it 

LINE INPUT #2, text$ 

CLOSE #2 

PRINT text$ 
WRITE text$

END 

```

> *File content:* [PRINT (file statement)](PRINT-(file-statement)) string file values will not include the enclosing quotation marks but can be read by [LINE INPUT (file statement)](LINE-INPUT-(file-statement)) as text.

```text

 1             2            Three 

```

> *Screen output:* [PRINT](PRINT) string values will not display enclosing quotation marks. [WRITE](WRITE) screen displays will.

```text

 1             2            Three
" 1             2            Three"

```

## See Also

* [SPC](SPC), [SPACE$](SPACE$), [TAB](TAB)
* [PRINT USING (file statement)](PRINT-USING-(file-statement))
* [PRINT](PRINT)
* [WRITE (file statement)](WRITE-(file-statement)), [INPUT (file statement)](INPUT-(file-statement))
* [LINE INPUT (file statement)](LINE-INPUT-(file-statement))
* [OPEN](OPEN), [LPRINT](LPRINT), [WRITE](WRITE)
