The **PUT #** file or port statement writes data to a specific byte or record location.

## Syntax

> **PUT #*filenumber&*,** [*position*][, {*holdingvariable*|*holdingarray()*}]

* File/port number is the number used in the [OPEN](OPEN) statement. 
* The [INTEGER](INTEGER) or [LONG](LONG) file byte *position* in a [BINARY](BINARY) file or the record *position* in a [RANDOM](RANDOM) file **must be greater than zero**. 
* The file byte or record *position* can be omitted if the [PUT](PUT) or [GET](GET) is consecutive or when creating new file data sequentially. 
* The *holding variable* [TYPE](TYPE) determines byte size and the next byte position in the file when the *position* is ommitted.
* The first byte or record position is 1. This may require adding one to an offset value when documentation uses that position as 0.
* Both the file *position* and *holding variable*(and comma) can be omitted when using a [FIELD](FIELD) definition.
* If a [LEN](LEN) = record length statement is omitted in an [OPEN](OPEN) FOR [RANDOM](RANDOM)  statement the record size defaults to 128 bytes!
* **Warning: Not designating a PUT position can overwrite previous file data based on the current file *position*!**
* When using a numeric *holding variable*, values do NOT require conversion using [MKI$](MKI$), [MKL$](MKL$), [MKS$](MKS$) or [MKD$](MKD$).
* **QB64** can load [Arrays](Arrays) data directly(brackets required) to a [BINARY](BINARY) file using **one** PUT to a [BINARY](BINARY) file: **PUT #1, , array()**

## Example(s)

Using a [TYPE](TYPE) record variable(Contact) to enter a new [RANDOM](RANDOM) record to a file.

```vb

TYPE ContactType
  first AS STRING * 10
  last AS STRING * 20
  age AS INTEGER
END TYPE
DIM Contact AS ContactType

INPUT "Enter a first name: ", Contact.first
INPUT "Enter a last name: ", Contact.last
INPUT "Enter an age: ", Contact.age

OPEN "Record.lst" FOR RANDOM AS #1 LEN = LEN(Contact)
NumRecords% = LOF(1) \ LEN(Contact)
PRINT NumRecords%; "previous records"

PUT #1, NumRecords% + 1, Contact ' add a new record TYPE record value
CLOSE #1 

```

> *Note:* The DOT record variable values were created or changed before the PUT. The record length is 32 bytes.

Placing the contents of a numerical array into a [BINARY](BINARY) file. You may want to put the array size at the beginning too.

```vb

DIM SHARED array(100) AS INTEGER

FOR i = 1 TO 100
  array(i) = i
NEXT
showme  'display array contents

OPEN "BINFILE.BIN" FOR BINARY AS #1

PUT #1, , array()

ERASE array 'clear element values from array and display empty
showme
CLOSE #1

OPEN "BINFILE.BIN" FOR BINARY AS #2
GET #2, , array()
CLOSE #2
showme  'display array after transfer from file

END

SUB showme
FOR i = 1 TO 100
  PRINT array(i);
NEXT
PRINT "done"
END SUB 

```

> *Note:* Use empty brackets in QB64 when using [GET](GET) to create an array or [PUT](PUT) to create a [BINARY](BINARY) data file.

## See Example(s)

* [Program ScreenShots](Program-ScreenShots)

## See Also
 
* [GET](GET) 
* [SEEK](SEEK), [SEEK (statement)](SEEK-(statement)) 
* [PRINT (file statement)](PRINT-(file-statement)) 
* [FIELD](FIELD) 
* [PUT (graphics statement)](PUT-(graphics-statement))
* [PUT (TCP/IP statement)](PUT-(TCP-IP-statement))
