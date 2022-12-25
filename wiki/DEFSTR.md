The [DEFSTR](DEFSTR) statement defines all variables with names starting with the specified letter (or letter range) AS [STRING](STRING) variables instead of the [SINGLE](SINGLE) type default.

## Legacy Support

* **DEF** statements ([DEFDBL](DEFDBL), [DEFSNG](DEFSNG), [DEFLNG](DEFLNG), [DEFINT](DEFINT), [DEFSTR](DEFSTR)) were used when storage space was a concern in older computers, as their usage could save up typing. Instead of `**DIM a AS STRING, a2 AS STRING, a3 AS STRING**`, simply having `**DEFSTR A**` in the code before using variables starting with letter **A** would do the same job.
* **For clarity, it is recommended to declare variables with meaningful names**.

## Syntax

> [DEFSTR](DEFSTR) letter[-range], letter2[-range2], [...]

## Description

* letter (or range) can be from A-Z or any other range, like **G-M**.
* You can also use commas for specific undefined variable first letters.
* Variables [DIM](DIM)ensioned as another variable type or that use type suffixes are not affected by [DEFSTR](DEFSTR).
* [DEFSTR](DEFSTR) sets the [Variable Types](Variable-Types) of all variable names with the starting letter(s) or letter ranges when encountered in the progression of the program (even in conditional statement blocks not executed and subsequent [SUB](SUB) procedures).
* **Warning: QBasic keyword names can only be used as string variable names when they are followed by the string type suffix ($).**

## QBasic

* QBasic's IDE would add DEF statements before any [SUB](SUB) or [FUNCTION](FUNCTION). QB64 (like QBasic) will change all variable types in subsequent sub-procedures to that default variable type without giving a [ERROR Codes](ERROR-Codes) warning or adding DEF statement to subsequent procedures. If you do not want that to occur, either remove that DEF statement or add the proper DEF type statements to subsequent procedures. May also affect [$INCLUDE]($INCLUDE) procedures.

## Example(s)

```vb

DEFSTR A, F-H, M

'With the above, all variables with names starting with A, F, G, H and M
'will be of type STRING, unless they have a type suffix
'indicating another type or they are dimensioned differently

```

## See Also
 
* [DEFSNG](DEFSNG), [DEFLNG](DEFLNG), [DEFINT](DEFINT), [DEFDBL](DEFDBL)
* [_DEFINE](_DEFINE)
