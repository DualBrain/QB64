[TO](TO) indicates a range of numerical values or an assignment of one value to another.

## Syntax

> DIM array(1 TO 100)

> FOR i = 1 TO 10

> _MAPUNICODE unicode TO asciicode

> _SETALPHA alpha%, c1& TO c2&

* To specify a range in the [CASE](CASE) clause of a [SELECT CASE](SELECT-CASE) statement.
* To specify the range for the loop counter in a [FOR...NEXT](FOR...NEXT) loop.
* Array dimensions can be set to have a range of element numbers with TO.
* Specifies an [ASCII](ASCII) character code to set with [_MAPUNICODE](_MAPUNICODE).
* Specifies a range of color values to set the transparencies with [_SETALPHA](_SETALPHA).
* To specify a range of records to lock or unlock in a networked environment, in the [LOCK](LOCK) statement.
* To separate the lower and upper bounds of an array specification in a [DIM](DIM) or [REDIM](REDIM) statement.

## See Also

* [DIM](DIM), [FOR...NEXT](FOR...NEXT)
* [_MAPUNICODE](_MAPUNICODE)
* [_SETALPHA](_SETALPHA)
