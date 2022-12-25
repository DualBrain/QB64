The [WRITE (file statement)](WRITE-(file-statement)) file statement writes a list of comma separated variable values to a sequential file or port.

## Syntax

> WRITE #filenumber&[, expressionList]

## Description

* filenumber& is the number of the file or device OPENed in the OUTPUT or APPEND modes. See: FREEFILE.
* expressionList is a comma-separated list of values to be written to the file or device.
* WRITE can place any number and types of variable values needed in a file record separated by commas.
* String values will have quotation marks although quotes are not required to read strings in CSV files with [INPUT (file statement)](INPUT-(file-statement)) #.
* Data files using WRITE normally will have the same number of values listed on each file line.
* Data containing commas must be in quotation marks. Number commas are illegal!
* WRITE created files are normally read with INPUT #.
* CSV files created can be read by Excel using a .CSV file name extension. Strings may or may not include quotation marks.
* [Semicolon](Semicolon)s cannot be used in or following the WRITE statement!

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

> *File content:* [WRITE](WRITE) string values will include quotation marks, but they are not required to read the file.

```text

1,2,"Three"

```

> *Screen output:* [PRINT](PRINT) string values will not display enclosing quotes. [WRITE](WRITE) screen displays will.

```text

 1           2          Three
1,2,"Three"

```

## See Also

* [PRINT (file statement)](PRINT-(file-statement))
* [INPUT (file statement)](INPUT-(file-statement))
* [LINE INPUT (file statement)](LINE-INPUT-(file-statement))
* [SQL Client](SQL-Client) (library)
