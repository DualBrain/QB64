The **SEEK** statement sets the next byte or record position of a file for a read or write.

## Syntax

> SEEK *filenumber&*, *position*

* *filenumber* must be the file number that is [OPEN](OPEN) and being read or written to.
* *position* is a byte in [BINARY](BINARY) or sequencial files created in [OUTPUT](OUTPUT), [APPEND](APPEND) or [INPUT (file mode)](INPUT-(file-mode))s. The first byte = 1.
* *position* is the record in [RANDOM](RANDOM) files to read or write. Records can hold more than one variable defined in a [TYPE](TYPE).
* Since the first SEEK file position is 1 it may require adding one to an offset value when documentation uses that position as 0.
* After a SEEK statement, the next file operation starts at that SEEK byte position.
* The SEEK statement can work with the [SEEK](SEEK) function to move around in a file.

## Example(s)

A SEEK statement using the [SEEK](SEEK) function to move to the next random record in a file.

```vb

 SEEK 1, SEEK(1) + 1

```

## See Also

* [SEEK](SEEK) (function)
* [GET](GET), [PUT](PUT)
