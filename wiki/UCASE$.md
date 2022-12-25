The [UCASE$](UCASE$) function returns an all-uppercase version of a [STRING](STRING).

## Syntax

> result$ = [UCASE$](UCASE$)(text$)

## Description

* Used to guarantee that all alphabetical characters in a [STRING](STRING) are capitalized.
* Does not affect non-alphabetical characters.

## Example(s)

 The following code guarantees that all letter key entries are capitalized:

```vb

PRINT "Do you want to continue? (y/n)"

DO
    K$ = UCASE$(INKEY$)
LOOP UNTIL K$ = "Y" OR K$ = "N"

```

## See Also

* [LCASE$](LCASE$) (lower case)
* [INKEY$](INKEY$)
* [INPUT$](INPUT$)
