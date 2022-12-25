The [FREEFILE](FREEFILE) function returns a [LONG](LONG) value that is an unused file access number.

## Syntax

> fileHandle& = [FREEFILE](FREEFILE)

## Description

* [FREEFILE](FREEFILE) values should be given to unique variables so that each file has a specific variable value assigned to it.
* Once the number is assigned in an [OPEN](OPEN) statement, the file number can later be used to read, write or [CLOSE](CLOSE) that file.
* File numbers [CLOSE](CLOSE)d are made available to [FREEFILE](FREEFILE) for reuse immediately. 
* [FREEFILE](FREEFILE) returns are normally sequential starting with 1. Only file numbers in use will not be returned.
* [OPEN](OPEN) each file number after each [FREEFILE](FREEFILE) return or the values returned may be the same.

## See Also

* [GET](GET), [PUT](PUT), [CLOSE](CLOSE)
