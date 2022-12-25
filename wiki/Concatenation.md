**Concatenation** is a process where literal or variable [STRING](STRING) values are combined using the [+](+) operator.

## Usage

> value$ = "Literal text" + string_variable$ + "more text."

* The [STRING](STRING) values added can be literal or string variable values or a string [FUNCTION](FUNCTION) value.
* When combining string values in a variable definition, concatenation MUST be used!
* Literal or variable numerical values cannot be used in string concatenation. 
* A numerical value can be changed to a string value using the [STR$](STR$)(number), [CHR$](CHR$)(code), [HEX$](HEX$), [OCT$](OCT$), [MKI$](MKI$), [MKS$](MKS$), [MKD$](MKD$), [MKL$](MKL$), [_MK$](_MK$) or [VARPTR$](VARPTR$) functions.
* [PRINT](PRINT) does not require any concatenation, but it can be used instead of using [semicolon](semicolon)s where strings are combined ONLY.
* String values CANNOT be subtracted from a value! Use [LEFT$](LEFT$), [RIGHT$](RIGHT$) or [MID$](MID$) to get portions of a string value.

Adding quotation marks to a string value using concatenation. Variables cannot be defined using semicolons! 

```vb

quote$ = CHR$(34) + "Hello World!" + CHR$(34)

PRINT "Bill Gates never said "; quote$; " when he answered the telephone!"

```

```text

Bill Gates never said "Hello World!" when he answered the telephone!

```

Inserting numerical values in a PRINT string with semicolons, PRINT USING and PRINT with concatenation.

```vb

name$ = "Billy"
boxes% = 102
sales! = 306.00
template$ = "& sold ### boxes for $$####,.##."

PRINT name$; " sold"; boxes%; "boxes for $"; sales!; "."
PRINT USING template$; name$; boxes%; sales!
PRINT name$ + " sold" + STR$(boxes%) + " boxes for $" + LTRIM$(STR$(sales!)) + "." 

``` 

```text

Billy sold 102 boxes for $ 306 .
Billy sold 102 boxes for $306.00.
Billy sold 102 boxes for $306.

```

> *Explanation:* Printed numerical values using semicolons have a space on each side. [PRINT USING](PRINT-USING) properly formats the string and displays the cent values when they are zero. [STR$](STR$) converts the number to a string and excludes the right number space, but leaves the sign space. [LTRIM$](LTRIM$) eliminates the leading sign space between the string number and the $ dollar sign.

## See Also

* [PRINT](PRINT), [PRINT USING](PRINT-USING)
* [CHR$](CHR$), [STR$](STR$), [VARPTR$](VARPTR$)
* [Semicolon](Semicolon), [Comma](Comma)
