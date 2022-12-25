The STRING$ function returns a STRING consisting of a single character repeated a number of times.

## Syntax

>  result$ = STRING$(*count&*, {*character$* | *ASCIIcode%*} )

## Description

* count& is the number of times the character specified by character is repeated.
* Character is a literal string character, a string variable or an [ASCII](ASCII) code number.
* If count& is negative, an [ERROR Codes](ERROR-Codes) error will occur. The count can be zero.
* If character is a [STRING](STRING) value and its length is zero, an [ERROR Codes](ERROR-Codes) error will occur.
* If more than one string character value is used, the first character will be repeated. 
* A [STRING](STRING) statement can be added to a string value with the + [concatenation](concatenation) operator. 
* The function result can also be used to [GET](GET) and [PUT](PUT) a number of bytes as zero characters: bytes$ = STRING(numbytes, 0)

*Differences between QB64 and QB 4.5:*

* **QB64** can use [LONG](LONG) values for a count up to 2,147,483,647 while **QB 4.5** could only use [INTEGER](INTEGER) values up to 32,767.

## Example(s)

> Printing 40 asterisks across the screen using an ASCII character code instead of [CHR$](CHR$)(42).

```vb

PRINT STRING$(40, 42)

```

```text

****************************************

```

> Using a [STRING](STRING) to specify the repeated character.

```vb

text$ = "B" + STRING$(40, "A") + "D"
PRINT text$

```

```text

BAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD

```

## See Example(s)

* [SAVEIMAGE](SAVEIMAGE)
* [SaveIcon32](SaveIcon32)

## See Also

* [SPACE$](SPACE$)
* [ASC](ASC), [CHR$](CHR$)
* [ASCII](ASCII)
