The [GET #](GET-#) statement reads data from a file or port device by bytes or record positions.

## Syntax

> [GET #](GET-#)fileNumber&, [position][, {targetVariable|targetArray()}]

## Description

* fileNumber& is the file or port number used in the [OPEN](OPEN) AS [BINARY](BINARY) or [RANDOM](RANDOM) statement. 
* The [INTEGER](INTEGER) or [LONG](LONG) byte position in a [BINARY](BINARY) file or the record position in a [RANDOM](RANDOM) file **must be greater than zero**.
* The position can be omitted if the GET operations are consecutive based on the targetVariable [TYPE](TYPE) byte size.
* The targetVariable [Data types](Data-types) or [FIELD](FIELD) *variable* size determines the byte size and the next position in the file.
* The first byte position in a file is 1. <!-- giving the previous information is enough: This may require adding one to an offset value when documentation uses that position as 0. -->
* GET does not require a byte or record position or targetVariable (or comma) when using a [FIELD](FIELD) statement.
* **QB64** can [PUT](PUT) the entire contents of an array to a file and later GET those contents to a targetArray() (include brackets).
* **GET may ignore the end of a file and return bad data. If the [EOF](EOF) function returns -1 after a GET operation, it indicates that the data has ended.**

```text

 DO UNTIL EOF(1)
   GET #1, , value%
   IF NOT(EOF(1)) THEN PUT #2, , value%
 LOOP

```

## Example(s)

Opening a RANDOM file using LEN to calculate and LEN = to designate the file record size.

```vb

TYPE variabletype
  x AS INTEGER'       '2 bytes
  y AS STRING * 10'  '10 bytes
  z AS LONG'          '4 bytes
END TYPE'            '16 bytes total
DIM record AS variabletype
DIM newrec AS variabletype

file$ = "testrand.inf" '<<<< filename may overwrite existing file
number% = 1 '<<<<<<<<<< record number to write cannot be zero
RecordLEN% = LEN(record)
PRINT RecordLEN%; "bytes"
record.x = 255
record.y = "Hello world!"
record.z = 65535
PRINT record.x, record.y, record.z

OPEN file$ FOR RANDOM AS #1 LEN = RecordLEN%
PUT #1, number% , record 'change record position number to add records
CLOSE #1

OPEN file$ FOR RANDOM AS #2 LEN = RecordLEN%
NumRecords% = LOF(2) \ RecordLEN%
PRINT NumRecords%; "records"

GET #2, NumRecords% , newrec 'GET last record available
CLOSE #2
PRINT newrec.x, newrec.y, newrec.z

END 

```

```text

 16 bytes
 255        Hello worl       65535
 1 records
 255        Hello worl       65535

```

> *Explanation:* The byte size of the record [TYPE](TYPE) determines the [LOF](LOF) byte size of the file and can determine the number of records.
> To read the last record [GET](GET) the number of records. To add a record, use the number of records + 1 to [PUT](PUT) new record data.

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

## See Also

* [PUT](PUT), [SEEK](SEEK), [SEEK (statement)](SEEK-(statement)) 
* [INPUT (file statement)](INPUT-(file-statement)), [GET (TCP/IP statement)](GET-(TCP-IP-statement))
* [FIELD](FIELD), [RANDOM](RANDOM), [BINARY](BINARY)
* [LEN](LEN), [LOF](LOF), [EOF](EOF)
