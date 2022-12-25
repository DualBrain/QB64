See [OPEN](OPEN).

The **INPUT** file mode in an [OPEN](OPEN) statement opens an existing file for [INPUT (file statement)](INPUT-(file-statement)).

## Syntax

> [OPEN](OPEN) fileName$ FOR **INPUT** AS #filenumber%

* If fileName$ does not exist, attempting to open it FOR INPUT will create a program [ERROR Codes](ERROR-Codes). Use [_FILEEXISTS](_FILEEXISTS) to avoid errors.
* The file number can be determined automatically by using a [FREEFILE](FREEFILE) variable value.
* Mode can use [INPUT (file statement)](INPUT-(file-statement)) #, [LINE INPUT (file statement)](LINE-INPUT-(file-statement)) # or [INPUT$](INPUT$) to read the file data.
* Use the [EOF](EOF) function to avoid reading data past the end of a file and creating an [ERROR Codes](ERROR-Codes).
* Input file statements will use the same file number as the OPEN statement.
* The INPUT mode allows the same file to be opened in another mode with a different number.
* **NOTE: [LINE INPUT (file statement)](LINE-INPUT-(file-statement)) will work faster in [BINARY](BINARY) than INPUT mode in QB64 to stay compatible with QBasic.**

## Example(s)

Avoiding an INPUT mode or [INPUT (file statement)](INPUT-(file-statement)) read error using a FileExist function. QB64 can use the [_FILEEXISTS](_FILEEXISTS) function.

```vb

 DIM Fdata$(100)
 INPUT "Enter data file name: ", datafile$
 IF _FILEEXISTS(datafile$) THEN
    D% = FREEFILE: count = 0
    OPEN datafile$ FOR INPUT AS #D%
    DO UNTIL EOF(D%)
     count = count + 1
     LINE INPUT #D%, Fdata$(count)
     IF count = 100 THEN EXIT DO  ' don't exceed array size!
    LOOP
  CLOSE #D%
 ELSE : PRINT "File not found!"
 END IF

```

> *Explanation:* The [_FILEEXISTS](_FILEEXISTS) function is used before `OPEN datafile$ FOR INPUT AS #D%`, which would generate an error in case the file didn't exist.

## See Also

* [INPUT (file statement)](INPUT-(file-statement)), [LINE INPUT (file statement)](LINE-INPUT-(file-statement)), [INPUT$](INPUT$) (file input)
* [INPUT](INPUT), [LINE INPUT](LINE-INPUT), [INPUT$](INPUT$) (keyboard input)
* [APPEND](APPEND), [RANDOM](RANDOM), [OUTPUT](OUTPUT), [BINARY](BINARY)
* [READ](READ), [DATA](DATA)
* [_FILEEXISTS](_FILEEXISTS), [_DIREXISTS](_DIREXISTS)
