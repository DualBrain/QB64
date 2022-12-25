**RETURN** is used in [GOSUB](GOSUB) procedures to return to the original call code line or a specified line label.

## Syntax

> **RETURN** [{*linelabel*|*linenumber*}]

## Parameter(s)

* RETURN without parameters returns to the code immediately following the original [GOSUB](GOSUB) call.
* *line number* or *linelabel* after the RETURN statement returns code execution to that label.

## Usage

* Normally required at the end of a [GOSUB](GOSUB) procedure unless the procedure returns using a loop.
* RETURN is not used in error handling procedures. Error procedures use [RESUME](RESUME) *line number* or [RESUME](RESUME).
* GOSUB procedures use line numbers or line labels designated with a colon after the number or label.
* If RETURN is encountered without a previous [GOSUB](GOSUB) call a [ERROR Codes](ERROR-Codes) is produced.
* To avoid errors, place [GOSUB](GOSUB) procedures AFTER the main program code [END](END) or after an [EXIT SUB](EXIT-SUB) or [EXIT FUNCTION](EXIT-FUNCTION) call.

## Example(s)

Returns after a Gosub.

```vb

FOR a = 1 TO 10
  PRINT a
  IF a = 5 THEN GOSUB five
NEXT
END       'END or SYSTEM stop the program before the execution of a sub procedure

five:
  PRINT "Aha! Five!"
RETURN 

```

```text

 1
 2
 3
 4
 5
Aha! Five!
 6
 7
 8
 9
 10

```

Returns to a specific line label.

```vb

GOSUB hey 
PRINT "it didn't go here." 
hoho: 
  PRINT "it went here." 
END 

hey: 
RETURN hoho 

```


```text

it went here.

```

## See Also
 
* [GOSUB](GOSUB), [GOTO](GOTO)
* [RESUME](RESUME)
