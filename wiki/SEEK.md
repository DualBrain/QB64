The **SEEK** function returns the current byte or record position in a file.

## Syntax

> byte = SEEK(filenumber&)

* Filenumber is the number of an [OPEN](OPEN) file in any mode.
* In [RANDOM](RANDOM) files SEEK returns the current record position.
* In [BINARY](BINARY) or sequencial files SEEK returns the current byte position(first byte = 1).
* Since the first file position is 1 it may require adding one to an offset value when documentation uses that position as 0.
* Devices that do not support SEEK (SCRN, CONS, KBRD, COMn and LPTn) return 0. 

## See Also
 
* [SEEK (statement)](SEEK-(statement)) 
* [LOC](LOC)
