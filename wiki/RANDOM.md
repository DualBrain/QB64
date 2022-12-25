**RANDOM** is used in an [OPEN](OPEN) statement to read([GET](GET)) from or write([PUT](PUT)) to a file. 

## Syntax

> OPEN Filename$ FOR RANDOM AS #1 [LEN = *recordlength%*]

* RANDOM is the Default mode if no mode is given in the [OPEN](OPEN) statement.
* It creates the file if the legal file name given does NOT exist.
* As a RANDOM file, it can read or write any record using [GET](GET) and/or [PUT](PUT) statements. 
* *Recordlength%* is determined by getting the LEN of a [TYPE](TYPE) variable or a [FIELD](FIELD) statement.
  - [STRING](STRING) = 1 byte/character, [INTEGER](INTEGER) = 2 bytes, [LONG](LONG) = 4 bytes, [SINGLE](SINGLE) = 4 bytes [DOUBLE](DOUBLE) = 8 bytes 
  - [_BYTE](_BYTE) = 1 byte, [_INTEGER64](_INTEGER64) = 8 bytes, [_FLOAT](_FLOAT) = 10 bytes (so far)
* If no record length is used in the [OPEN](OPEN) statement, the default record size is 128 bytes except for the last record.
* A record length cannot exceed 32767 or an [ERROR Codes](ERROR-Codes) will occur!
* To determine the number of records in a file the records% = [LOF](LOF) \ recordlength%. 
* When **variable length strings** are PUT into RANDOM files the record length must exceed the maximum string entry by: 
  - 2 bytes are reserved for recording variable string lengths up to 32767 bytes (LEN = longest + 2) 
  - 8 bytes are reserved for recording variable string lengths exceeding 32767 bytes (LEN = longest + 8)
* A serial communication port can also be opened for RANDOM in an [OPEN COM](OPEN-COM) statement.

## Example(s)

Function that finds a RANDOM file's record number for a string value such as a phone number.

```vb

TYPE customer
  age AS INTEGER
  phone AS STRING * 10
END TYPE

DIM SHARED cust AS customer, recLEN
recLEN = LEN(cust)            'get the length of the record type
PRINT "RecLEN:"; recLEN

OPEN "randfile.rec" FOR RANDOM AS #1 LEN = recLEN
FOR i = 1 TO 4
  READ cust.age, cust.phone
  PUT #1, , cust
NEXT
CLOSE #1

RP = RecordPos("randfile.rec", "2223456789")  'returns 0 if record not found!

PRINT RP  

IF RP THEN
  OPEN "randfile.rec" FOR RANDOM AS #2 LEN = recLEN
  GET #2, RP, cust
  CLOSE #2
PRINT cust.age, cust.phone
END IF

END

DATA 59,2223456789,62,4122776477,32,3335551212,49,1234567890

FUNCTION RecordPos (file$, search$)
f = FREEFILE
OPEN file$ FOR INPUT AS #f
FL = LOF(f)
dat$ = INPUT$(FL, f)
CLOSE f
recpos = INSTR(dat$, search$)
IF recpos THEN RecordPos = recpos \ recLEN + 1 ELSE RecordPos = 0
END FUNCTION 

```

> *Note:* Random files can store records holding various variable types using a [TYPE](TYPE) definition or a [FIELD](FIELD) statement.

When not using a [TYPE](TYPE) or fixed length strings, QB4.5 allows RANDOM files to hold variable length strings up to 2 bytes less than the LEN = record length statement:

```vb

_CONTROLCHR OFF
OPEN "myfile.txt" FOR OUTPUT AS #1: CLOSE #1: ' clears former file of all entries.
OPEN "myfile.txt" FOR RANDOM AS #1 LEN = 13 'strings can be up to 11 bytes with 2 byte padder

a$ = CHR$(1) + CHR$(0) + "ABCDEFGHI"
b$ = "ABCDEFGHI"
c$ = "1234"

PUT #1, 1, a$
PUT #1, 2, b$
PUT #1, 3, c$

FOR i = 1 TO 3
  GET #1, i, a$
  PRINT a$, LEN(a$)
NEXT

CLOSE 

```

```text

☺ ABCDEFGHI       11
ABCDEFGHI         9
1234              4

```

> *Note:* The 2 byte file padders before each string PUT will show the length of a string for GET as [ASCII](ASCII) characters. Padders will always be 2 bytes and strings up to the last one will be 13 bytes each no matter the length up to 11, so the file size can be determined as (2 + 11) + (2 + 9 + 2) + (2 + 4) or 13 + 13 + 2 + 4 = 32 bytes. 

## See Also
 
* [GET](GET), [PUT](PUT), [FIELD](FIELD)
* [BINARY](BINARY) 
* [SEEK](SEEK), [SEEK (statement)](SEEK-(statement))
