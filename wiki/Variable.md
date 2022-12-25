A **variable** is a "container" name that can hold a numerical or string value which can be referenced or changed by the program (as opposed to [CONST](CONST)ant values which never change).

**Variable names**

Variables in QB64 can be any name except the names of QB64 or QBasic keywords and may not contain spaces or non-alphabetical/non-numerical characters (except "." and "_"). Numerical characters cannot be  used as the first character of a variable or array name! **QB64 reserves the use of a leading underscore to QB64 procedural or variable type names only!**

Variable values can be passed to sub-procedures by using the name as a [SUB](SUB) or [FUNCTION](FUNCTION) parameter in a [CALL](CALL). Variable names in the main program module can be passed to sub-procedures by using [DIM](DIM) [SHARED](SHARED) without using them as [CALL](CALL) parameters.

Variable names dimensioned in [SUB](SUB) or [FUNCTION](FUNCTION) procedures can be the same as names used in the main procedure and can hold different values. [SHARED](SHARED) sub-procedure variables can only be shared with the main program module! 

Dot variable names are normally used with [TYPE](TYPE) variable definitions. The first name before the dot is the name of the variable [DIM](DIM) [AS](AS) the type. The name after the dot is the name of the variable assigned inside of the [TYPE](TYPE).

**Variable types**

Variables can be defined as a specific type using a variable type suffix or by using a [DIM](DIM) or [REDIM](REDIM)(for dynamic arrays only) statement [AS](AS) a variable type of [_BIT](_BIT), [_BYTE](_BYTE), [INTEGER](INTEGER), [LONG](LONG), [SINGLE](SINGLE), [DOUBLE](DOUBLE), [_INTEGER64](_INTEGER64), [_FLOAT](_FLOAT) or [STRING](STRING) in QB64. 

Groups of variable names can be type defined by the first letter or list of letters of the names using [DEFINT](DEFINT), [DEFLNG](DEFLNG), [DEFSNG](DEFSNG), [DEFDBL](DEFDBL), [DEFSTR](DEFSTR) or [_DEFINE](_DEFINE) [AS](AS) in QB64.

[$DYNAMIC]($DYNAMIC) arrays can be resized and can retain their remaining element values when used with [REDIM](REDIM) [_PRESERVE](_PRESERVE) in QB64. [ERASE](ERASE) or [CLEAR](CLEAR) removes the array entirely from memory!

[$STATIC]($STATIC) arrays cannot be resized, but cannot be removed either. [ERASE](ERASE) or [CLEAR](CLEAR) will clear the array element values only!

**Variable values**

All numerical variables default to 0 and all string variables default to "" at the start of a program and when first referenced inside of a [SUB](SUB) or [FUNCTION](FUNCTION) procedure except when the variable is defined as a [STATIC](STATIC) value.

[Arrays](Arrays) variable names can hold many values in one variable name by specifying a reference index enclosed in parentheses.

[STATIC](STATIC) sub-procedure values keep their value after the sub-procedure is exited. They will hold an empty value when first used.

Variables are used to hold program data information that is attained through the program flow, either by user input, calculations or by other ways of communication (as with I/O, memory, TCP/IP or files).

Assignment of variable values can be done using the = assignment symbol (variable1.number = 500, for example).

To pass variable values to a sub-procedure without altering or affecting the variable name's value, parenthesis can be used around the variable name in the [CALL](CALL).

## Example(s)

*Example of different usages of variables:*

```vb

max = 1000 
DIM d(max) 
FOR c = 1 TO max 
d(c) = c + d(c - 1) 
NEXT
PRINT "Show the result of the addition from 1 to n (1+2+3...+n)" 
PRINT "n = (0-" + LTRIM$(STR$(max)) + "): "; 
INPUT "", n 
IF n <= max AND n >= 0 THEN PRINT d(n) ELSE PRINT "Invalid value (only 0 to" + STR$(max) + " is permitted)." 

```

```text

Show the result of the addition from 1 to n (1+2+3...+n)
n = (1-1000): 10
 55

```

## See Also

* [Argument](Argument), [Expression](Expression), [Arrays](Arrays)
