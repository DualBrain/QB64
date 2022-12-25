The [LTRIM$](LTRIM$) function removes leading space characters from a [STRING](STRING) value.

## Syntax

> return$ = [LTRIM$](LTRIM$)(text$)

## Description

* text$ is the [STRING](STRING) value to trim.
* If text$ contains no leading space characters, it is returned unchanged.
* Convert fixed length [STRING](STRING) values by using a different return$ variable.
* Can be used to trim the leading space of a positive numerical value converted to a string value by [STR$](STR$).

## Example(s)

Trimming a positive string number.

```vb

value = 12345
number$ = LTRIM$(STR$(value)) 'converting number to string removes right PRINT space
PRINT "[" + number$ + "]" 

```

```text

[12345]

```

Trimming leading spaces from text strings.

```vb

PRINT LTRIM$("some text")
PRINT LTRIM$("   some text") 

```

```text

some text
some text

```

A TRIM$ function to trim spaces off of both ends of a string.

```vb

text$ = "        Text String           "
trimmed$ = TRIM$(text$)
PRINT CHR$(26) + trimmed$ + CHR$(27) 

FUNCTION TRIM$(text$)
TRIM$ = LTRIM$(RTRIM$(text$))
END FUNCTION 

```

```text

→Text String←

```

## See Also

* [RTRIM$](RTRIM$), [STR$](STR$)
* [LEFT$](LEFT$), [RIGHT$](RIGHT$)
* [HEX$](HEX$), [MID$](MID$)
