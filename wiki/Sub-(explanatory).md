A **SUB** procedure is a procedure within a program that can calculate and return multiple parameter values just like a full program.

## Syntax

> **SUB Procedure_name** [(*parameter*[, *list*...])]
> ...
> ... 'procedure variable definitions and statements
> ...
> **END SUB**

## Parameter(s)

* Parameters passed after the procedure call must match the variable types in the SUB parameters in order.
* If there are no *parameter*s passed or they are [SHARED](SHARED) the parameters and parenthesis are not required in the procedure.
* Parameter [Variable](Variable) names in the procedure do not have to match the names used in the [CALL](CALL), just the value types.

## Description

* All [$DYNAMIC]($DYNAMIC) [variable](variable) values return to 0 or null strings when the procedure is exited except for [STATIC](STATIC) variable values.
* SUB procedures can return multiple values through the parameters unlike functions.
* SUB procedures return to the next code statement after the call in the main or other procedures.
* [EXIT](EXIT) SUB can be used to exit early or to exit before [GOSUB](GOSUB) procedures using [RETURN](RETURN).
* [TYPE](TYPE) and [DECLARE LIBRARY](DECLARE-LIBRARY) declarations can be made inside of SUB procedures in QB64 only.
* SUB procedures can save program memory as all memory used in a SUB is released on procedure exit except for [STATIC](STATIC) values.
* [_DEFINE](_DEFINE) can be used to define all new or old QB64 variable [TYPE](TYPE) definitions instead of DEF***.
* [$INCLUDE]($INCLUDE) text library files with needed SUB and [FUNCTION](FUNCTION) procedures can be included in programs after all sub-procedures.
* **QB64 ignores all procedural DECLARE statements!** Define all *parameter* [TYPE](TYPE)s in the SUB procedure.
*  **Images are not deallocated when the [SUB](SUB) or [FUNCTION](FUNCTION) they are created in ends. Free them with [_FREEIMAGE](_FREEIMAGE).**

## Example(s)

Text [PRINT](PRINT) screen centering using [PEEK](PEEK) to find the [SCREEN](SCREEN) mode width. Call and SUB procedure code:

```vb

DEFINT A-Z
SCREEN 13
Center 10, 15, "This text is centered." ' example module sub call
END

DEFINT A-Z ' only code allowed before SUB line is a DEF statement or a comment
SUB Center (Tclr, Trow, Text$)
Columns = _WIDTH / _FONTWIDTH 'Convert _WIDTH (in pixels) to width in characters
Middle = (Columns \ 2) + 1 ' reads any screen mode width
Tcol = Middle - (LEN(Text$) \ 2)
COLOR Tclr: LOCATE Trow, Tcol: PRINT Text$; ' end semicolon prevents screen roll
END SUB 

```

> *Explanation:* The procedure centers text printed to the screen. The parameters are the text color, row and the text itself as a string or string variable. The maximum width of the screen mode in characters is found and divided in half to find the center point. The text string's length is also divided in half and subtracted from the screen's center position. The procedure will also work when the [WIDTH](WIDTH) statement has been used. When adding variables to Text$ use the + concatenation operator. Not semicolons!

SUB and [FUNCTION](FUNCTION) procedures always return to the place they were called in the main or other sub-procedures:

```vb

a = 10
Add1 a
PRINT a  'Add1 returns final 'a' value here

END

SUB Add1 (n)
n = n + 1
Add2 n
PRINT "exit 1"
END SUB

SUB Add2 (m)
m = m + 2
PRINT "exit 2"
END SUB

```

```text

exit 2
exit 1
 13

```

>  *Note:* Parameter **a** is used to call the sub-procedures even though parameters **n** and **m** are used internally.

## See Also
 
* [FUNCTION](FUNCTION), [CALL](CALL)
* [BYVAL](BYVAL), [SCREEN (statement)](SCREEN-(statement))
* [EXIT](EXIT), [END](END)
