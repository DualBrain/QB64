See [OPEN](OPEN).

The [OUTPUT](OUTPUT) file mode is used in an [OPEN](OPEN) statement to send new data to files or ports.

## Syntax

> [OPEN](OPEN) fileName$ **FOR** [OUTPUT](OUTPUT) **AS** #1

## Description

* OUTPUT mode erases all previous data in an existing file or clears a port receive buffer.
* Creates an empty file if the filename does not exist. Use [APPEND](APPEND) if previous file data is to be preserved.
* Mode can use [PRINT (file statement)](PRINT-(file-statement)), [WRITE (file statement)](WRITE-(file-statement)) or [PRINT USING (file statement)](PRINT-USING-(file-statement)) to output file data.

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

END

```

## See Also

* [APPEND](APPEND), [RANDOM](RANDOM)
* [INPUT (file mode)](INPUT-(file-mode)), [BINARY](BINARY)
* [WRITE](WRITE), [INPUT (file statement)](INPUT-(file-statement))
