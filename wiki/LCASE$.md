The [LCASE$](LCASE$) function returns an all-lowercase version of a [STRING](STRING).

## Syntax

> result$ = [LCASE$](LCASE$)(text$)

## Description

* Normally used to guarantee that user input is not capitalized.
* Does not affect non-alphabetical characters.

## Example(s)

The following code guarantees that all user letter entries will be lower case:

```vb

PRINT "Do you want to continue? (y/n)"

DO
    K$ = LCASE$(INKEY$)
LOOP UNTIL K$ = "y" OR K$ = "n"

```

## See Also

* [UCASE$](UCASE$) (upper case)
* [INKEY$](INKEY$)
* [INPUT$](INPUT$)
