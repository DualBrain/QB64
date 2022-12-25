A [FUNCTION](FUNCTION) block statement is used to create a function procedure to return a calculated value to a program.

## Syntax

> **FUNCTION procedureName**[type-suffix] [(*parameters*)]
>
>   *{code}*
>
>   'variable definitions and procedure statements
>
>   ⋮
>
>   procedureName = returnValue
>
> **END FUNCTION**

## Description

* The function type can be any variable type that it will return to the program and is represented by the type suffix.
* Functions hold one return value in the function's name which is a variable type. Other values can be passed through *parameters*.
* Functions are often referred to in program calculations, not called like SUB procedures. [CALL](CALL) cannot be used with functions.
* If there are no parameters passed or they are [SHARED](SHARED) the *parameters* and parenthesis are not required.
* Variable names within the procedure do not have to match the names used in the reference parameters, just the value types.
* All [$DYNAMIC]($DYNAMIC) variable values return to 0 or null strings when the procedure is exited except when a variable or the entire function is [STATIC](STATIC). This can save program memory as all [$DYNAMIC]($DYNAMIC) memory used in a FUNCTION is released on procedure exit.
* FUNCTION procedure code can use [GOSUB](GOSUB) and [GOTO](GOTO) line numbers or labels inside of the procedure when necessary. 
* For early function exits use [EXIT](EXIT) [FUNCTION](FUNCTION) before [END FUNCTION](END-FUNCTION) and [GOSUB](GOSUB) procedures using [RETURN](RETURN).
* **QB64 ignores all procedural DECLARE statements.** Define all *parameter* [Data types](Data-types) in the FUNCTION procedure.
*  **Images are not deallocated when the [SUB](SUB) or [FUNCTION](FUNCTION) they are created in ends. Free them with [_FREEIMAGE](_FREEIMAGE).**
* The IDE can create the FUNCTION and END FUNCTION lines for you. Use the *New FUNCTION...* option in the Edit Menu. A box will come up for you to enter a name for the FUNCTION. Enter all code between the FUNCTION and [END FUNCTION](END-FUNCTION) lines.

## QBasic

* Once a FUNCTION was created and used, the QBasic IDE would DECLARE it when the file was saved. **QB64 doesn't need these declarations.**
* QBasic's IDE could place a [DEFINT](DEFINT), [DEFSNG](DEFSNG), [DEFLNG](DEFLNG), [DEFDBL](DEFDBL) or [DEFSTR](DEFSTR) statement before the FUNCTION line if it is used in the main module. It may even be the wrong variable type needed.
* QBasic allowed programmers to add DATA fields anywhere because the IDE separated the main code from other procedures.

## Example(s)

A simple function that returns the current path. Place [FUNCTION](FUNCTION) or [SUB](SUB) procedures after the program [END](END).

```vb

PRINT "Current path = "; PATH$
END

FUNCTION PATH$
    f% = FREEFILE
    file$ = "D0Spath.inf" 'file name uses a zero to prevent an overwrite of existing file name
    SHELL _HIDE "CD > " + file$ 'send screen information to a created text file
    OPEN file$ FOR INPUT AS #f% 'file should exist with one line of text
    LINE INPUT #f%, PATH$ 'read file path text to function name
    CLOSE #f%
    KILL file$
END FUNCTION 

```

Returns a [LONG](LONG) array byte size required for a certain sized graphics screen pixel area [GET (graphics statement)](GET-(graphics-statement)).

```vb

INPUT "Enter a screen mode: ", mode%
INPUT "Enter image width: ", wide&
INPUT "Enter image depth: ", deep&
IntegerArray& = ImageBufferSize&(wide&, deep&, mode%) \ 2 ' returns size of an INTEGER array.
PRINT IntegerArray&
END

DEFINT A-Z
FUNCTION ImageBufferSize& (Wide&, Deep&, ScreenMode%)
    SELECT CASE ScreenMode%
        CASE 1: BPPlane = 2: Planes = 1
        CASE 2, 3, 4, 11: BPPlane = 1: Planes = 1
        CASE 7, 8, 9, 12: BPPlane = 1: Planes = 4
        CASE 10: BPPlane = 1: Planes = 2
        CASE 13: BPPlane = 8: Planes = 1
        CASE ELSE: BPPlane = 0
    END SELECT
    ImageBufferSize& = 4 + INT((Wide& * BPPlane + 7) / 8) * (Deep& * Planes) 'return the value to function name.
END FUNCTION 

```

> *Explanation:* Function calculates the array byte size required when you [GET (graphics statement)](GET-(graphics-statement)) an area of a graphics [SCREEN](SCREEN). Each mode may require a different sized array. Since graphics uses [INTEGER](INTEGER) arrays, 2 byte elements, the size returned is divided by 2 in the IntegerArray& calculation function reference. Function returns only 4 for [SCREEN](SCREEN) 0 which is a text only mode.

## See Also

* [SUB](SUB), [SCREEN (statement)](SCREEN-(statement)) 
* [EXIT](EXIT) (statement), [END](END)
* [_EXIT (function)](_EXIT-(function))
