See [OPEN](OPEN).

[APPEND](APPEND) is used in an output type [OPEN](OPEN) statement to add data to the end of a file.

## Syntax

> [OPEN](OPEN) fileName$ **FOR APPEND** AS #1

## Description

* Creates an empty file using the filename if none exists.
* Mode places new data after the previous data in the file.
* Mode can use [PRINT (file statement)](PRINT-(file-statement)), [WRITE (file statement)](WRITE-(file-statement)) or [PRINT USING (file statement)](PRINT-USING-(file-statement)) to output file data or text.

## See Also

[OUTPUT](OUTPUT), [RANDOM](RANDOM), [INPUT (file mode)](INPUT-(file-mode)), [BINARY](BINARY)
