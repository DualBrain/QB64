The [_TRIM$](_TRIM$) function removes both leading and trailing space characters from a [STRING](STRING) value.

## Syntax

> return$ = [_TRIM$](_TRIM$)(text$)

## Description

* Shorthand to using [LTRIM$](LTRIM$)([RTRIM$](RTRIM$)("text"))
* text$ is the [STRING](STRING) value to trim.
* If text$ contains no leading or trailing space characters, it is returned unchanged.
* Convert fixed length [STRING](STRING) values by using a different return$ variable.

## Example(s)

Demonstrating how _TRIM$(text$) can replace LTRIM$(RTRIM$(text$)):

```vb

text$ = SPACE$(10) + "some text" + SPACE$(10)
PRINT "[" + text$ + "]" 
PRINT "[" + RTRIM$(text$) + "]" 
PRINT "[" + LTRIM$(text$) + "]" 
PRINT "[" + LTRIM$(RTRIM$(text$)) + "]" 
PRINT "[" + _TRIM$(text$) + "]" 

```

```text

[          some text          ]
[          some text]
[some text          ]
[some text]
[some text]

```

## See Also

* [RTRIM$](RTRIM$), [LTRIM$](LTRIM$)
