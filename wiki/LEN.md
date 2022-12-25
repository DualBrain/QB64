The [LEN](LEN) function returns the number of bytes used by a variable value and the number of characters in a [STRING](STRING).

## Syntax

> length% = [LEN](LEN)(literalTextOrVariable)

* Literal or variable [STRING](STRING) values return the number of string bytes which is the same as the number of string characters.
* A numerical *variable* will return the number of bytes used by a numerical variable type.
  * [_BYTE](_BYTE) variable types return 1 byte.
  * [INTEGER](INTEGER) variable types return 2 bytes.
  * [SINGLE](SINGLE) and [LONG](LONG) integer variable types return 4 bytes.
  * [DOUBLE](DOUBLE) and [_INTEGER64](_INTEGER64) variable types return 8 bytes.
  * [_FLOAT](_FLOAT) variable types return 32 bytes.
  * [_OFFSET](_OFFSET) and [_MEM](_MEM) variable types return varying byte sizes.
  * *Note:* [_BIT](_BIT) variable types and bit multiples **cannot be measured in bytes**.
* **LEN cannot return lengths of literal numerical values and will create a "variable required" status error in the IDE.**
* **LEN =** can be used with a user defined [TYPE](TYPE) variable to determine the number of bytes used in [RANDOM](RANDOM) file records:
> `[OPEN](OPEN) file$ FOR [RANDOM](RANDOM) AS #n LEN = LEN(recordTypeVariable)`**
  * If a LEN = statement is not used, [RANDOM](RANDOM) default record length is 128 or sequencial is 512 up to a maximum of 32767 bytes.
  * [BINARY](BINARY) OPEN statements will ignore LEN = statements. The byte size of a [GET](GET) or [PUT](PUT) is determined by the [Variable Types](Variable-Types).

## Example(s)

With a string variable the byte size is the same as the number of characters.

```vb

LastName$ = "Williams"
PRINT LEN(LastName$); "bytes" 

```

```text

 8 bytes

```

Testing [INPUT](INPUT) for numerical [STRING](STRING) entries from a user.

```vb

INPUT "number: ", num$

value$ = LTRIM$(STR$(VAL(num$)))
L = LEN(value$)

PRINT LEN(num$), L 

```

> *Note:* [&H](&H), [&O](&O), D and E will also be accepted as numerical type data in a [VAL](VAL) conversion, but will add to the entry length.

With numerical value types you MUST use a variable to find the inherent byte length when using LEN.

```vb

DIM I AS INTEGER
PRINT "INTEGER ="; LEN(I); "bytes"
DIM L AS LONG
PRINT "LONG ="; LEN(L); "bytes"
DIM I64 AS _INTEGER64
PRINT "_INTEGER64 ="; LEN(I64); "bytes"
DIM S AS SINGLE
PRINT "SINGLE ="; LEN(S); "bytes"
DIM D AS DOUBLE
PRINT "DOUBLE ="; LEN(D); "bytes"
DIM F AS _FLOAT
PRINT "_FLOAT ="; LEN(F); "bytes" 

```

```text

INTEGER = 2 bytes
LONG = 4 bytes
_INTEGER64 = 8 bytes
SINGLE = 4 bytes
DOUBLE = 8 bytes
_FLOAT = 32 bytes

```

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

## See Also

* [LOF](LOF), [EOF](EOF)
* [AS](AS), [TYPE](TYPE)
* [RANDOM](RANDOM), [BINARY](BINARY)
* [Variable Types](Variable-Types)
