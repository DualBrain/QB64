[$COLOR]($COLOR) is a metacommand that adds named color [CONST](CONST) in a program.

## Syntax

>  [$COLOR]($COLOR):{0|32}


## Description

* [$COLOR]($COLOR):0 adds [CONST](CONST) for colors 0-15. The actual constant names can be found in the file **source/utilities/color0.bi**.
* [$COLOR]($COLOR):32 adds [CONST](CONST) for 32-bit colors, similar to HTML color names. The actual constant names can be found in the file **source/utilities/color32.bi**.
* [$COLOR]($COLOR) is a shorthand to manually using [$INCLUDE]($INCLUDE) pointing to the files listed above.
* *NOTE*: When using [$NOPREFIX]($NOPREFIX), the color constants change to **C_<old name>** (ex: **Blue** becomes **C_Blue**).

## Example(s)

Adding named color constants for SCREEN 0:

```vb

$COLOR:0
COLOR BrightWhite, Red
PRINT "BrightWhite on red."

```

```text

Bright white on red.

```

Adding named color constants for 32-bit modes:

```vb

SCREEN _NEWIMAGE(640, 400, 32)
$COLOR:32
COLOR CrayolaGold, DarkCyan
PRINT "CrayolaGold on DarkCyan."


```

Using [$COLOR]($COLOR) with [$NOPREFIX]($NOPREFIX):

```vb

$NOPREFIX
$COLOR:0
COLOR C_BrightWhite, C_Red
PRINT "BrightWhite on Red."
 

```

## See Also

* [COLOR](COLOR), [SCREEN](SCREEN) 
* [_NEWIMAGE](_NEWIMAGE), [$INCLUDE]($INCLUDE)
* [$NOPREFIX]($NOPREFIX)
* [Metacommand](Metacommand)
