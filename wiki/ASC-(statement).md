The [ASC (statement)](ASC-(statement)) statement allows a **QB64** program to change a character at any position of a [STRING](STRING) variable.

## Syntax
 
>  [ASC (statement)](ASC-(statement))(stringExpression$[, position%]) = code%

## Description

* The stringExpression$ variable's value must have been previously defined and cannot be an empty string ("").
* position% is optional. If no position is used, the leftmost character at position 1 is assumed.
* position% cannot be zero or greater than the string's [LEN](LEN) or an [ERROR Codes](ERROR-Codes) will occur.
* The [ASCII](ASCII) replacement code% value can be any [INTEGER](INTEGER) value from 0 to 255.
* Some [ASCII](ASCII) control characters will not [PRINT](PRINT) a character or may format the [SCREEN](SCREEN). [_PRINTSTRING](_PRINTSTRING) can print them graphically.

## Example(s)

Demonstrates how to change existing text characters one letter at a time.

```vb

 a$ = "YZC"
 ASC(a$) = 65                 ' CHR$(65) = "A"
 ASC(a$, 2) = 66              ' CHR$(66) = "B"
 PRINT a$ 'ABC

 ASC(a$, 2) = 0               ' CHR$(0) = " " 
 PRINT a$

 ASC(a$, 2) = ASC("S")        ' get code value from ASC function
 PRINT a$

```

```text

 ABC
 A C
 ASC

```

## See Also

* [ASC](ASC) (function)
* [MID$ (statement)](MID$-(statement))
* [_PRINTSTRING](_PRINTSTRING)
* [INKEY$](INKEY$), [ASCII](ASCII)
