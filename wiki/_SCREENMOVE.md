The [_SCREENMOVE](_SCREENMOVE) statement positions the program window on the desktop using designated coordinates.

## Syntax

> [_SCREENMOVE](_SCREENMOVE) {column&, row&}
>
> [_SCREENMOVE _MIDDLE](_SCREENMOVE)

## Parameter(s)

* Positions the program window on the desktop using the column& and row& pixel coordinates for the upper left corner.
* **_MIDDLE** can be used instead to automatically center the program window on the desktop, in any screen resolution.

## Description

* The program's [SCREEN](SCREEN) dimensions may influence the desktop position that can be used to keep the entire window on the screen. 
* Use [_DESKTOPWIDTH](_DESKTOPWIDTH) and [_DESKTOPHEIGHT](_DESKTOPHEIGHT) to find the current desktop resolution to place the program's window.
* On dual monitors a negative column& position or a value greater than the main screen width can be used to position a window in another monitor.
* **A small delay may be necessary when a program first starts up to properly orient the screen on the desktop properly.** See [_SCREENEXISTS](_SCREENEXISTS).
* **[Keywords currently not supported](Keywords-currently-not-supported-by-QB64)**

## Example(s)

Calculating the border and header offsets by comparing a coordinate move with _MIDDLE by using trial and error.

```vb

userwidth& = _DESKTOPWIDTH: userheight& = _DESKTOPHEIGHT 'get current screen resolution
SCREEN _NEWIMAGE(800, 600, 256)
scrnwidth& = _WIDTH: scrnheight& = _HEIGHT  'get the dimensions of the program screen

_SCREENMOVE (userwidth& \ 2 - scrnwidth& \ 2) - 3, (userheight& \ 2 - scrnheight& \ 2) - 29
_DELAY 4
_SCREENMOVE _MIDDLE  'check centering

END 

```

> When positioning the window, offset the position by -3 columns and - 29 rows to calculate the top left corner coordinate.

Moving a program window to a second monitor positioned to the right of the main desktop.

```vb

wide& = _DESKTOPWIDTH
high& = _DESKTOPHEIGHT

PRINT wide&; "X"; high&

_DELAY 4
_SCREENMOVE wide& + 200, 200 'positive value for right monitor 2

img2& = _SCREENIMAGE
wide2& = _WIDTH(img2&)
high2& = _HEIGHT(img2&)
PRINT wide2&; "X"; high2&
_DELAY 4
_SCREENMOVE _MIDDLE 'moves program back to main monitor 1 

```

> *Notes:* Change the [_SCREENMOVE](_SCREENMOVE) column to negative for a left monitor.

**[_FULLSCREEN](_FULLSCREEN) works in the primary monitor and may push all running programs to a monitor on the right.**

## See Also

* [_SCREENX](_SCREENX), [_SCREENY](_SCREENY)
* [_SCREENIMAGE](_SCREENIMAGE), [_DESKTOPWIDTH](_DESKTOPWIDTH), [_DESKTOPHEIGHT](_DESKTOPHEIGHT)
* [_SCREENPRINT](_SCREENPRINT)
* [_SCREENEXISTS](_SCREENEXISTS)
* [_NEWIMAGE](_NEWIMAGE), [SCREEN (statement)](SCREEN-(statement))
