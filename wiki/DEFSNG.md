The [DEFSNG](DEFSNG) statement defines all variables with names starting with the specified letter (or letter range) AS [SINGLE](SINGLE) variables.

## Legacy Support

* **DEF** statements ([DEFDBL](DEFDBL), [DEFSNG](DEFSNG), [DEFLNG](DEFLNG), [DEFINT](DEFINT), [DEFSTR](DEFSTR)) were used when storage space was a concern in older computers, as their usage could save up typing. Instead of `**DIM a AS SINGLE, a2 AS SINGLE, a3 AS SINGLE**`, simply having `**DEFSNG A**` in the code before using variables starting with letter **A** would do the same job.
* **For clarity, it is recommended to declare variables with meaningful names**.

## Syntax

> [DEFSNG](DEFSNG) letter[-range], letter2[-range2], [...]

## Description

* Undeclared variables with no type suffix are of type [SINGLE](SINGLE) by default.
* letter (or range) can be from A-Z or any other range, like **G-M**.
* You can also use commas for specific undefined variable first letters.
* Variables [DIM](DIM)ensioned as another variable type or that use type suffixes are not affected by [DEFSNG](DEFSNG).
* [DEFSNG](DEFSNG) sets the [Variable Types](Variable-Types) of all variable names with the starting letter(s) or letter ranges when encountered in the progression of the program (even in conditional statement blocks not executed and subsequent [SUB](SUB) procedures).
* **Warning: QBasic keyword names cannot be used as numerical variable names with or without the type suffix.**

## QBasic

* QBasic's IDE would add DEF statements before any [SUB](SUB) or [FUNCTION](FUNCTION). QB64 (like QBasic) will change all variable types in subsequent sub-procedures to that default variable type without giving a [ERROR Codes](ERROR-Codes) warning or adding DEF statement to subsequent procedures. If you do not want that to occur, either remove that DEF statement or add the proper DEF type statements to subsequent procedures. May also affect [$INCLUDE]($INCLUDE) procedures.

## Example(s)

```vb

DEFSNG A, F-H, M

'With the above, all variables with names starting with A, F, G, H and M
'will be of type SINGLE, unless they have a type suffix
'indicating another type or they are dimensioned differently

```

## See Also
 
* [DEFDBL](DEFDBL), [DEFLNG](DEFLNG), [DEFINT](DEFINT), [DEFSTR](DEFSTR)
* [_DEFINE](_DEFINE)
