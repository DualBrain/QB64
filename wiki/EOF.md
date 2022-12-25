The [EOF](EOF) function indicates that the end of a file has been reached.

## Syntax

> endReached%% =  EOF([#]fileNumber&)

## Description

* fileNumber& is the number of the file being read. **#** is not required.
* Returns 0 until the end of a file. This avoids a file read error.
* Returns -1 (true) at the end of the file.
* **Note that [GET](GET) can return invalid data at the end of a file.** Read [EOF](EOF) after a GET operation to see if the end of the file has been reached and discard last read.

## See Also

* [OPEN](OPEN)
* [LOF](LOF), [LEN](LEN)
* [INPUT (file statement)](INPUT-(file-statement))
* [LINE INPUT (file statement)](LINE-INPUT-(file-statement))
* [GET](GET), [PUT](PUT)
