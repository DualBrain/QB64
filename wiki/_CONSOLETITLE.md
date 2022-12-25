The [_CONSOLETITLE](_CONSOLETITLE) statement sets the console window's title-bar text.

## Syntax

> [_CONSOLETITLE](_CONSOLETITLE) text$

## Parameter(s)

* *text$* can be any literal or variable [STRING](STRING) value.

## Example(s)
 
Hiding the main program window while displaying the console window with a title.

```vb

$SCREENHIDE
_DELAY 4
$CONSOLE
_CONSOLETITLE "Error Log"

_DEST _CONSOLE
PRINT "Errors go here! (fyi, this line is not an error)"
END

```

> *Note:* You can also use [SHELL](SHELL) "title consoletitle" to set the title of the console window. However, the recommended practice is to use [_CONSOLETITLE](_CONSOLETITLE).

## See Also

* [$CONSOLE]($CONSOLE), [_CONSOLE](_CONSOLE)
* [$SCREENHIDE]($SCREENHIDE), [$SCREENSHOW]($SCREENSHOW)
* [_SCREENHIDE](_SCREENHIDE), [_SCREENSHOW](_SCREENSHOW)
