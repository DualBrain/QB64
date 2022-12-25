The [_ECHO](_ECHO) statement allows outputting text to a [$CONSOLE]($CONSOLE) window without having to alternate between [_DEST](_DEST) pages.

## Syntax

> [_ECHO](_ECHO) {*"text to output"* | textVariable$}

## Description

* [_ECHO](_ECHO) is a shorthand to saving current [_DEST](_DEST), switching to [_DEST](_DEST) [_CONSOLE](_CONSOLE), [PRINT](PRINT)ing, then switching back to the previous [_DEST](_DEST).
* To output numbers, use the [STR$](STR$) function.

## Availability

* Version 1.3 and up.

## Example(s)

```vb

$CONSOLE
PRINT "this will show in the main window"
_ECHO "this will show in the console"

```

## See Also

* [_DEST](_DEST)
* [$CONSOLE]($CONSOLE), [_CONSOLE](_CONSOLE)
* [STR$](STR$)
