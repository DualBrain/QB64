The [OPEN](OPEN) statement is used to open a file or [OPEN COM](OPEN-COM) serial communications port for program input or output.

## Syntax

> [OPEN](OPEN) fileName$ [**FOR** mode] [{ACCESS|{LOCK|SHARED}} [{READ|WRITE}] [AS](AS) [#]fileNumber& [LEN = recordLength]

### Legacy *GW-BASIC* syntax

>  [OPEN](OPEN) modeLetter$, [#]fileNumber&, fileName$[, recordLength]

## Parameter(s)

* The fileName$ is a [STRING](STRING) variable or literal file name (path optional) in quotes. 
* FOR mode can be: [APPEND](APPEND) (write to end), [BINARY](BINARY) (read/write), [INPUT (file mode)](INPUT-(file-mode)) (read), [OUTPUT](OUTPUT) (write new) or [RANDOM](RANDOM) (read/write).
* GW-BASIC's modeLetter$ is a [STRING](STRING) variable or the letter "A", "B", "I", "O" or "R" designating the OPEN modes above.
* fileNumber& can be any **positive** [INTEGER](INTEGER) or [LONG](LONG) whole number value or an unused value determined by the [FREEFILE](FREEFILE) function.
* [LEN](LEN) = or recordLength is optional to denote the RANDOM file record byte length (default = 128) or sequential (default = 512) load buffer.

## Description

* **QB64** can open as many files as your computer memory can handle. QBasic could only open about 15 at a time.
* **QB64 will allocate 4 bytes of memory for every possible file number up to the highest number used in a program.**
* mode defaults to RANDOM if the mode or FOR access statement is omitted. (see open modes described below)
* **Only the fileName$, fileNumber& and LEN = recordLength values can use variable values in the QBasic syntax.**
* If [LEN](LEN) = is ommitted, sequential file record sizes default to 512 and [RANDOM](RANDOM) to 128 bytes in QBasic.
* fileName$ can be up to 255 characters with no limit on file name extension length in **QB64**. 
* Once a file or port is opened, it can be used in any program procedure using the assigned file number. 
* The **"SCRN:"** device is supported in **version 1.000 and up** (see Example 3).
* **Devices such as "KYBD:", "CONS:", and "LPTn:" are [Keywords currently not supported by QB64](Keywords-currently-not-supported-by-QB64)**.
>  **Note:** OPEN "LPTn" is not supported by QB64, but may be supported directly by your operating system. 
* [OPEN COM](OPEN-COM) can also be used for serial port access in **QB64**.

## Error(s)

* Illegal **QB64** Windows filename characters are ** " * / \ | ? : < > **. Multiple dots (periods) are allowed.
* Possible OPEN [ERROR Codes](ERROR-Codes) include "Bad file name or number", "Bad File Mode", "File Not Found" or "Path Not Found". 
  * An OPEN file not found error may occur if [CHR$](CHR$)(0) to (31) are used in a Windows file name.
* **QB64** does not have DOS file name limitations.

## Details

### File ACCESS and LOCK Permissions

* [ACCESS](ACCESS) clause limits file access to READ, WRITE or READ WRITE on a network.
* [LOCK (access)](LOCK-(access)) clause can specify SHARED or a LOCK READ or LOCK WRITE file lock in an OPEN statement working on a network.
* A separate [LOCK](LOCK) statement can lock or [UNLOCK](UNLOCK) file access on a network using a format that can lock specific records.
* If another process already has access to a specified file, program access is denied for that file OPEN access. A "Permission Denied" error 70 will be returned. A network program must be able to handle a denial of access error.

### File Access Modes

* FOR mode can be:
  * **OUTPUT**: Sequential mode creates a new file or erases an existing file for new program output. Use [WRITE (file statement)](WRITE-(file-statement)) to write numerical or text data or [PRINT (file statement)](PRINT-(file-statement)) for text. **OUTPUT clears files of all data** and clears the receive buffer on other devices such as COM ports.
  * **APPEND**: Sequential mode creates a new file if it doesn't exist or appends program output to the end of an existing file. Use [WRITE (file statement)](WRITE-(file-statement)) for numerical or text data or [PRINT (file statement)](PRINT-(file-statement)) for text as in the OUTPUT mode. **APPEND does not remove previous data.** 
  * **INPUT** : Sequential mode **only reads input** from an existing file. **[ERROR Codes](ERROR-Codes) if file does not exist.** Use [INPUT (file statement)](INPUT-(file-statement)) for comma separated numerical or text data and [LINE INPUT (file statement)](LINE-INPUT-(file-statement)) or [INPUT$](INPUT$) to only read text data. **Use [_FILEEXISTS](_FILEEXISTS) or [_DIREXISTS](_DIREXISTS) to avoid errors.**
  * **BINARY**: Creates a new file when it doesn't exist or reads and writes to an existing binary file. Use [GET](GET) to read or [PUT](PUT) to write byte positions simultaneously. [LEN](LEN) = statements are ignored in this mode.
  * **RANDOM**: Creates a new file when it doesn't exist or reads or writes to an existing random file record. Use [GET](GET) or [PUT](PUT) to read or write to file records. A [LEN](LEN) = statement can define the byte size of a record (no LEN statement defaults to 128 bytes)
  * Modes **INPUT**, **BINARY** and **RANDOM** allow a file to be concurrently opened in a different mode and number.

#### GW-BASIC modes

* *Mode letter* is a variable or literal [STRING](STRING) letter value as one of the following:

* "A" = **APPEND**.
* "B" = **BINARY**.
* "I" = **INPUT**.
* "O" = **OUTPUT**.
* "R" = **RANDOM**.

## Example(s)

Function that displays errors and the number of errors in QBasic filenames. Returns 0 when filename is OK.

```vb

 file$ = "Hello,~1.mp3"      'example call below
 LOCATE 20, 30: errors% = CheckName%(file$): COLOR 14: PRINT "  Total Errors ="; errors% 

FUNCTION CheckName% (Filename$)
  'NOTE: Function also displays filename errors so LOCATE on screen before call!
  DIM L AS INTEGER, DP AS INTEGER, XL AS INTEGER
  L = LEN(Filename$): DP = INSTR(Filename$, "."): IF DP THEN XL = L - DP 'extension
  IF L = 0 OR L > 12 OR DP > 9 OR XL > 3 THEN 
    CheckName% = -1: COLOR 12: PRINT "Illegal format!"; : EXIT FUNCTION
  END IF
  FOR i% = 1 TO L      'check each filename character"
     code% = ASC(MID$(Filename$, i%, 1)): COLOR 10      ' see ASCII codes
     SELECT CASE code%       'check for errors and highlight in red
	'CASE 34, 42 TO 44, 47, 58 TO 63, 91 TO 93, 124: E% = E% + 1: COLOR 12 ' **QBasic errors**
        CASE 34, 42, 47, 58, 60, 62, 92, 124: E% = E% + 1: COLOR 12 ' **QB64 errors**
        CASE 46: dot% = dot% + 1: IF dot% > 1 THEN E% = E% + 1: COLOR 12
     END SELECT     
     PRINT CHR$(code%);  'use LOCATE before FUNCTION call to place print
  NEXT  
  CheckName% = E%
END FUNCTION 

```

*Note: The QBasic character error list is commented out and the function will return invalid filenames under QB64.

```text

                         Hello,~1.mp3  Total Errors<nowiki> = </nowiki>1

```

> *Note:* The screen output displays filename characters in green except for red comma QBasic error.

When **OPEN "SCRN:" FOR OUTPUT AS #f** is used, **PRINT #f** will print the text to the screen instead of to a file:

```vb

f% = FREEFILE 'should always be 1 at program start
OPEN "SCRN:" FOR OUTPUT AS #f%
g% = FREEFILE 'should always be 2 after 1
OPEN "temp.txt" FOR OUTPUT AS #g%

FOR i = 1 TO 2
    PRINT #i, "Hello World, Screen and File version"
NEXT 

```

> *Note:* Linux or Mac file names can use a path destination such as ".\SCRN:" to use SCRN: as an actual file name. 

Showcasing different file modes.

```vb

CLS

OPEN "test.tst" FOR OUTPUT AS #1
PRINT #1, "If test.tst didn't exist:"
PRINT #1, "A new file was created named test.tst and then deleted."
PRINT #1, "If test.tst did exist:"
PRINT #1, "It was overwritten with this and deleted."
CLOSE #1

OPEN "test.tst" FOR INPUT AS #1
DO UNTIL EOF(1)
INPUT #1, a$
PRINT a$
LOOP
CLOSE #1

KILL "test.tst"

END

```

```text

If test.tst didn't exist:
A new file was created named test.tst and then deleted.
If test.tst did exist:
It was overwritten with this and deleted.

```

> **Warning:** Make sure you don't have a file named test.tst before you run this or it will be overwritten.

## See Also
 
* [PRINT (file statement)](PRINT-(file-statement)), [INPUT (file statement)](INPUT-(file-statement))
* [GET](GET), [PUT](PUT), [WRITE (file statement)](WRITE-(file-statement))
* [INPUT$](INPUT$), [LINE INPUT (file statement)](LINE-INPUT-(file-statement))
* [CLOSE](CLOSE), [LOF](LOF), [EOF](EOF), [LOC](LOC)
* [SEEK (statement)](SEEK-(statement)), [SEEK](SEEK)
* [OPEN COM](OPEN-COM), [LEN](LEN), [RESET](RESET) 
* [FIELD](FIELD), [TYPE](TYPE)
* [_FILEEXISTS](_FILEEXISTS), [_DIREXISTS](_DIREXISTS)
* [_OPENCLIENT](_OPENCLIENT), [_OPENHOST](_OPENHOST), [_OPENCONNECTION](_OPENCONNECTION) (TCP/IP)
* [_SNDOPEN](_SNDOPEN), [_LOADIMAGE](_LOADIMAGE)
