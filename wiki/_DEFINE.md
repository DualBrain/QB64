[_DEFINE](_DEFINE) defines a set of variable names according to their first character as a specified data type.

## Syntax

> [_DEFINE](_DEFINE) letter[-range, ...] [AS](AS) [_UNSIGNED] data[Variable Types](Variable-Types)

## Parameter(s)

* Variable start *letter range* is in the form firstletter-endingletter (like A-C) or just a single letter.
* *Data types*: [INTEGER](INTEGER), [SINGLE](SINGLE), [DOUBLE](DOUBLE), [LONG](LONG), [STRING](STRING), [_BIT](_BIT), [_BYTE](_BYTE), [_INTEGER64](_INTEGER64), [_FLOAT](_FLOAT), [_OFFSET](_OFFSET), [_MEM](_MEM)  
* Can also use the [_UNSIGNED](_UNSIGNED) definition for positive whole [INTEGER](INTEGER) type numerical values.

## Description

* **When a variable has not been defined or has no type suffix, the value defaults to a [SINGLE](SINGLE) precision floating point value.**
* _DEFINE sets the [Variable Types](Variable-Types) of all variable names with the starting letter(s) or letter ranges  when encountered in the progression of the program (even in conditional statement blocks not executed and subsequent [SUB](SUB) procedures).
* **NOTE: Many QBasic keyword variable names CAN be used with a [STRING](STRING) suffix ($)! You cannot use them without the suffix, use a numerical suffix or use [DIM](DIM), [REDIM](REDIM), [_DEFINE](_DEFINE), [BYVAL](BYVAL) or [TYPE](TYPE) variable [AS](AS) statements.**
* **QBasic's IDE** added DEF statements before any [SUB](SUB) or [FUNCTION](FUNCTION). **QB64** (like QB) will change all variable types in subsequent sub-procedures to that default variable type without giving a [ERROR Codes](ERROR-Codes) warning or adding the proper DEF statement to subsequent procedures. If you do not want that to occur, either remove that DEF statement or add the proper DEF type statements to subsequent procedures.
* May also affect [$INCLUDE]($INCLUDE) procedures.

## Example(s)

Defining variables that start with the letters A, B, C or F as unsigned integers, including the *Add2* [FUNCTION](FUNCTION).

```vb

_DEFINE A-C, F AS _UNSIGNED INTEGER

PRINT Add2(-1.1, -2.2)

END

FUNCTION Add2 (one, two)
Add2 = one + two
END FUNCTION 

```

```text

65533

```

> *Explanation:* Unsigned integers can only return positive values while ordinary [INTEGER](INTEGER) can also return negative values.

## See Also

* [DEFSTR](DEFSTR), [DEFLNG](DEFLNG), [DEFINT](DEFINT), [DEFSNG](DEFSNG), [DEFDBL](DEFDBL)
* [DIM](DIM), [REDIM](REDIM)
* [COMMON](COMMON), [SHARED](SHARED)
* [_UNSIGNED](_UNSIGNED)
