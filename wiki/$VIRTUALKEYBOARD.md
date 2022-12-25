[DEPRECATED] The [$VIRTUALKEYBOARD]($VIRTUALKEYBOARD) [Metacommand](Metacommand) turns the virtual keyboard ON or OFF.

## Syntax

>  [$VIRTUALKEYBOARD]($VIRTUALKEYBOARD):{ON|OFF}

## Description

* Places a virtual keyboard on screen, which can be used in touch-enabled devices like Windows tablets.
* Deprecated.

## Example(s)

```vb

$VIRTUALKEYBOARD:ON

DO: LOOP UNTIL INKEY$ = CHR$(27) 

```

## See Also

* [Metacommand](Metacommand)s
