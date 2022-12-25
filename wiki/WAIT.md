The WAIT statement waits until the value read from an I/O port has certain bits set.

## Syntax

> WAIT port%, andMask%[, xorMask%]

## Description

* The WAIT statement reads a value from port% using INP.
* If xorMask% is specified, the value is XOR'd with xorMask%. It has the effect of "toggle these bits".
* The value is then AND'd with andMask%. It has the effect of "check if these bits are set".
* If the final value is non-zero, WAIT returns. Otherwise, another value is read from port% and checked again.
* The WAIT statement returns immediately if port% is not supported.

## Example(s)

> Waiting for vertical retrace

```vb

' Either statement can be used to try to reduce screen flickering.
' If both statements are used, try changing the order.

WAIT &H3DA, 8 ' finishes whenever the screen isn't being written to
WAIT &H3DA, 8, 8 ' finishes whenever the screen is being written to

```

## See Also

* [INP](INP), [OUT](OUT)
* [Scancodes](Scancodes)
