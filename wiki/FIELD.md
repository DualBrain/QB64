The [FIELD](FIELD) statement creates a [STRING](STRING) type definition for a [RANDOM](RANDOM)-access file buffer.

## Syntax

> [FIELD](FIELD) [#]fileNumber&, fieldWidth1% AS variable1$[, fieldWidthN% AS variableN$]

## Description

* fileNumber% is a file number used in the [OPEN](OPEN) statement or a value from the [FREEFILE](FREEFILE) function. 
* Combined size of the fieldWidth% parameters **must not exceed the [LEN](LEN) = recordsize in the [RANDOM](RANDOM) [OPEN](OPEN) statement** or a [ERROR Codes](ERROR-Codes) will occur.
* Variables are limited to [STRING](STRING) types. Use [TYPE](TYPE) instead of FIELD if you want to use numerical values. 
* Once a [FIELD](FIELD) is defined in a statement, [GET](GET) can read and [PUT](PUT) can write data without placeholders or variables.
* [LSET](LSET), [RSET](RSET), [PRINT (file statement)](PRINT-(file-statement)), [PRINT USING (file statement)](PRINT-USING-(file-statement)), and [WRITE (file statement)](WRITE-(file-statement)) can be used to place characters in the file buffer before a [PUT](PUT).
* All field definitions for a file are removed when the file is [CLOSE](CLOSE) or [RESET](RESET) and all strings are set to null ("").
* **Do not re-assign a field defined variable value or use it in an [INPUT](INPUT) statement if you want the variable to remain a field**.

## Example(s)

Comparing a [TYPE](TYPE) definition with a FIELD [STRING](STRING) definition. Demo using a [TYPE](TYPE) definition to create a file:

```vb

TYPE ClientType
   CName AS STRING * 30     '30 bytes
   Address AS STRING * 30   '30 bytes 
   City   AS STRING * 15    '15 bytes
   State  AS STRING * 2     ' 2 bytes
   Zip    AS STRING * 5     ' 5 bytes
END TYPE      ' total size = 82 bytes
DIM Client AS ClientType
RecordLEN = LEN(Client)       'find the size of each TYPE record

OPEN "ADDRESS.DAT" FOR RANDOM AS #1 LEN = RecordLEN
RESTORE ClientData         'restore to start of DATA
record = 0
DO
   READ CName$, Address$, City$, State$, Zip$       'read DATA
   IF CName$ = "END" THEN EXIT DO
   record = record + 1               'increment record number
   Client.CName = CName$          
   Client.Address = Address$
   Client.City = City$
   Client.State = State$
   Client.Zip = Zip$
   PUT #1, record, Client     'PUT by record number
LOOP
CLOSE #1 
END

ClientData:
   DATA "Bob White","104 Birdland Rd.","Bellview","PA","15236"
   DATA "Ward Cleaver","123 W. Beaver St.","Beaver","PA","15255"
   DATA "Elmer Fudd","45 Wabbit St.","Bethel Park","PA","15022"
   DATA "Wyley Coyote","33 Roadrunner Ave.","Clairton","PA","15122"
   DATA "Jim Morrison","19 Doorway Dr.","Belleview","PA","15236"
   DATA "END",0,0,0,0 

```

Demo using the FIELD statement to read the file:

```vb

CONST NM = 30, AD = 30, CT = 15, ST = 2, ZC = 5  ' Define field and record lengths with constants.
CONST RLEN = NM + AD + CY + ST + ZC
'
OPEN "ADDRESS.DAT" FOR RANDOM AS #1 LEN = RLEN
FIELD #1, NM AS CName$, AD AS Address$, CY AS City$, ST AS State$, ZC AS Zip$
FIELD #1, RLEN AS Clist$         'define entire record

GET #1, 1                  'GET does not need a variable to read FIELD records!
                                  'Read file for zip codes from 15230 to 15239 .
DO WHILE NOT EOF(1)
   ZipCheck$ = Zip$                            'read zip codes
   IF (ZipCheck$ >= "15230" AND ZipCheck$ <= "15239") THEN
      Info$ = Clist$
      PRINT LEFT$(Info$, 30)     'read name string
      PRINT MID$(Info$, 31, 30)  'read address string
      PRINT RIGHT$(Info$, 17)    'read city, state and zip code
      PRINT
   END IF
   GET #1                               'simply GET reads each FIELD record after first
LOOP
CLOSE #1
END 

```

## See Also

* [OPEN](OPEN), [TYPE](TYPE)
* [GET](GET), [PUT](PUT)
* [LSET](LSET), [RSET](RSET)
