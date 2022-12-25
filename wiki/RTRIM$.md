The RTRIM$ function removes trailing space characters from a STRING value.

## Syntax

> return$ = RTRIM$(value$)

## Description

* value$ is the STRING value to trim.
* If value$ contains no trailing space characters, value$ is returned unchanged.
* Convert fixed length STRING values by using a different return$ variable.

## Example(s)

Trimming a fixed length string value for use by another string variable:

```vb

name$ = RTRIM$(contact.name) ' trims spaces from end of fixed length TYPE value.

``` 

Trimming text string ends:

```vb

PRINT RTRIM$("some text") + "."
PRINT RTRIM$("some text   ") + "."
PRINT RTRIM$("Tommy    ")

```

```text

some text.
some text.
Tommy

```

## See Also

* [LTRIM$](LTRIM$), [STR$](STR$)
* [LSET](LSET), [RSET](RSET)
