The [_BLINK](_BLINK) function returns the current blink setting for SCREEN 0 colors. If enabled, returns -1 (default), otherwise returns 0.

## Syntax

> blinkState%% = [_BLINK](_BLINK)

## Availability

* Build 20170816/61 and up.

## Example(s)

```vb

COLOR 16, 7

'Try uncommenting the line below:
'_BLINK OFF

IF _BLINK THEN
    PRINT "I'm blinking"
ELSE
    PRINT "I'm not blinking"
END IF

```

## See Also

* [_BLINK](_BLINK) (statement)
* [OUT](OUT)
