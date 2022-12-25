The **STR$** function returns the [STRING](STRING) representation of a numerical value.

## Syntax

> result$ = **STR$(**number**)**

## Parameter(s)

* number is any numerical type value to convert.

## Description

* Returns any type number value with leading sign(space/minus) or decimal point when one exists in the numerical value.
* If number is positive, the [STRING](STRING) value returned will have a leading space character which can be removed using [LTRIM$](LTRIM$).
* If number is negative, the minus sign will precede the number instead of a space which [LTRIM$](LTRIM$) will not remove.
* Trimming a STR$ string number using [RTRIM$](RTRIM$) is not required as [PRINT](PRINT) creates the undocumented trailing number space.

## Example(s)

```vb

PRINT STR$( 1.0 )
PRINT STR$( 2.3 )
PRINT STR$( -4.5 )

```

```text

 1
 2.3
-4.5

```

```vb

a = 33
PRINT STR$(a) + "10" + "1" + "who" + STR$(a) + STR$(a) + LTRIM$(STR$(a))

```

```text

 33101who 33 3333

```

## See Also

* [VAL](VAL), [STRING](STRING)
* [LTRIM$](LTRIM$), [MID$](MID$)
* [RIGHT$](RIGHT$), [LEFT$](LEFT$)
* [HEX$](HEX$), [OCT$](OCT$)
