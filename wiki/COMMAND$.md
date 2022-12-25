The **COMMAND$** function returns the command line argument(s) passed when a program is run.

## Syntax
 
> commandLine$ = [COMMAND$](COMMAND$)[(count%)]

## Description

* The [STRING](STRING) return value is anything typed after a program's executable file name in command line (or using the [RUN](RUN) statement).
* Unlike QuickBASIC, **QB64** does not return all [UCASE$](UCASE$) values so keep that in mind when checking parameters.
* In **QB64**, COMMAND$ works as an array to return specific elements passed to the command line. COMMAND$(2) would return the second parameter passed at the command line. Arguments can contain spaces if they are passed inside quotation marks. This can be used to properly retrieve file names and arguments which contain spaces.
* Use the [_COMMANDCOUNT](_COMMANDCOUNT) function to find the number of parameters passed to a program via the command line. See *Example 2* below.

## Example(s)

Compile both programs. ProgramA [RUN](RUN)s ProgramB with a parameter passed following the filename: 

```vb

LOCATE 12, 36: PRINT "ProgramA"

LOCATE 23, 25: PRINT "Press any key to run ProgramB"
K$ = INPUT$(1)
RUN "ProgramB FS"  'pass FS parameter to ProgramB in QB64 or QB4.5

SYSTEM

```

> *ProgramB* checks for fullscreen parameter pass in QB64 and goes full screen. 

```vb

LOCATE 17, 36: PRINT "ProgramB"
parameter$ = UCASE$(COMMAND$) 'UCASE$ is needed in QB64 only, as QB4.5 will always return upper case
LOCATE 20, 33: PRINT "Parameter = " + parameter$
IF LEFT$(parameter$, 2) = "FS" THEN _FULLSCREEN 'parameter changes to full screen

END 

```

```text

                                    ProgramB

                                 Parameter = FS.EXE

```

Program gets the number of parameters passed to the program, and then prints those parameters to the screen one at a time.

```vb

count = _COMMANDCOUNT
FOR c = 1 TO count
    PRINT COMMAND$(c) 'or process commands sent
NEXT

```

```text

-1
a data file

```

> *Explanation: If we start *ThisProgram.exe* with the command line **ThisProgram -l "a data file"**, COMMAND$ will return a single string of "-1 a data file" which might be hard to process and interpret properly, but COMMAND$(1) would return "-l" and COMMAND$(2) would return the quoted "a data file" option as separate entries for easier parsing and processing.

As part of the command array syntax, you can also just read the array to see how many commands were sent (or simply check [_COMMANDCOUNT](_COMMANDCOUNT)):

```vb

DO
    count = count + 1
    cmd$ = COMMAND$(count)
    IF cmd$ = "" THEN EXIT DO 'read until an empty return
    PRINT cmd$ 'or process commands sent
LOOP
count = count - 1 'save the number of parameters sent to this program when run

```

## See Also

* [SHELL](SHELL), [RUN](RUN)
* [UCASE$](UCASE$), [LCASE$](LCASE$)
* [_COMMANDCOUNT](_COMMANDCOUNT)
