The [INPUT #](INPUT-#) file or port statement reads sequential data using one variable or a comma separated list of matching variable types.

## Syntax
 
> [INPUT #](INPUT-#)fileNumber&, variable1[, variable2, ..., variableN]

## Parameter(s)

* fileNumber& is a positive [LONG](LONG) integer value used to [OPEN](OPEN) the file FOR [INPUT (file mode)](INPUT-(file-mode)) mode. 
* The [Variable Types](Variable-Types) of the *variable* used defines the value or list of values to be returned from the file. Numeric types must match the values returned.
* As reflected in the syntax you can list a number of variables with different types seperated by a comma and they will hold the values in the file (keep in mind that the information in the file should match the variable types used).

## Description

* The file number can be determined by the programmer or be an unused number returned by the [FREEFILE](FREEFILE) function.
* Variable types must match the numerical [Variable Types](Variable-Types)s being read. [STRING](STRING) variables can return unquoted numeric values.
* Leading or trailing spaces of [STRING](STRING) values must be inside of quotes. [WRITE (file statement)](WRITE-(file-statement)) writes strings inside of quotes automatically. [PRINT (file statement)](PRINT-(file-statement)) removes quotes.
* [INPUT #](INPUT-#) will read each value until it encounters a comma for the next value in a list.
* Use the [EOF](EOF) function to avoid reading past the end of a file.
* Files created by [WRITE (file statement)](WRITE-(file-statement)) usually have the same number of values on each file line. If INPUT reads more or less values, it may read beyond the [EOF](EOF) or return bad data.
* Use the [LINE INPUT (file statement)](LINE-INPUT-(file-statement)) for files created with PRINT # or PRINT #, USING. 
* **INPUT can read Excel CSV files, but beware of unquoted text or numerical values containing commas.**

## Example(s)

Writes new data to a text file sequentially and reads it back to the program screen.

```vb

filename$ = "testfile.dat" 
x = 1: y = 2: z$ = "Three" 

OPEN filename$ FOR OUTPUT AS #1 'opens and clears an existing file or creates new empty file 
WRITE #1, x, y, z$ 
CLOSE #1 

PRINT "File created with data. Press a key!" 
K$ = INPUT$(1) 'press a key 

OPEN filename$ FOR INPUT AS #2 'opens a file to read it 
INPUT #2, a, b, c$ 
CLOSE #2 

PRINT a, b, c$ 
WRITE a, b, c$

END 

```

```text

 1           2          Three
1,2,"Three"

```

> *Screen output:* [PRINT](PRINT) string values will not display enclosing quotes. [WRITE](WRITE) screen displays will.

```text

1,2,"Three"

```

> *File content:* [WRITE (file statement)](WRITE-(file-statement)) string values will include quotation marks, but they are not required to read the file value as a string.

Commas inside of string values will not affect the INPUT value as those commas are not [WRITE (file statement)](WRITE-(file-statement)) separators.

```vb

x$ = "Hello, how are you?"
y$ = "I'm fine."

OPEN "testinp.dat" FOR OUTPUT AS #1
WRITE #1, x$, y$
CLOSE #1

OPEN "testinp.dat" FOR INPUT AS #1

INPUT #1, a$, b$
CLOSE #1

PRINT a$, b$ 
WRITE a$, b$ 

```

```text

Hello, how are you?        I'm fine. 
"Hello, how are you?","I'm fine."

```

```text

"Hello, how are you?","I'm fine."

```

> *File content:* Commas inside of strings delimited with quotes will be ignored. [WRITE (file statement)](WRITE-(file-statement)) will always enclose string values in quotes.

## See Also

* [INPUT (file mode)](INPUT-(file-mode)), [LINE INPUT (file statement)](LINE-INPUT-(file-statement)), [INPUT$](INPUT$) (file input)
* [INPUT](INPUT), [LINE INPUT](LINE-INPUT), [INPUT$](INPUT$) (keyboard input)
* [PRINT (file statement)](PRINT-(file-statement)), [PRINT USING (file statement)](PRINT-USING-(file-statement)) 
* [GET](GET)
