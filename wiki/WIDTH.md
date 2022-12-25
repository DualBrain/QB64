The WIDTH statement changes the text dimensions of certain SCREEN modes.

##  *SCREEN* Syntax 

> **WIDTH** [**columns%**][**, rows%**]

##  *File* Syntax 

> **WIDTH** {***file_number*** | ***device***}, ***columnwidth%***

## Parameter(s)

* When parameters are not specified, columns defaults to 80 with 25 (30 in [SCREEN](SCREEN) 11 or 12) rows. 

## Usage

* WIDTH should be used AFTER a program SCREEN statement! It does not affect screen graphics or graphic coordinates.
* Affects SCREEN 0 Window size and alters the text block size of each screen mode listed in QBasic:
    * SCREEN 0 can use 80 or 40 columns and 25, 43 or 50 rows. Default is WIDTH 80, 25. 
    * SCREEN 9 can use 80 columns and 25 or 43(not supported on many monitors) rows. Default WIDTH 80, 25 fullscreen. 
    * SCREEN 10 can use 80 columns and 25 or 43 rows. Default is WIDTH 80, 25 fullscreen.
    * SCREEN 11 and 12 can use 80 columns and 30 or 60 rows. Default is WIDTH 80, 30 fullscreen.
* **QB64** can alter all [SCREEN](SCREEN) mode widths and heights which may also affect text or [_FONT](_FONT) block sizes.
* If a [$CONSOLE]($CONSOLE) window is active and you set [_DEST](_DEST) [_CONSOLE](_CONSOLE), WIDTH will affect the console output window size (Windows only).
* **Note:** WIDTH changes may change screen color settings in QBasic. Use [PALETTE](PALETTE) to reset to default colors.
* **[Keywords currently not supported by QB64](Keywords-currently-not-supported-by-QB64)**

## See Also

* [SCREEN](SCREEN), [COLOR](COLOR), [OUT](OUT)
* [_PRINTWIDTH](_PRINTWIDTH) (function)
* [_WIDTH (function)](_WIDTH-(function)), [_HEIGHT](_HEIGHT) (function)
* [_FONT](_FONT), [_FONTWIDTH](_FONTWIDTH), [_FONTHEIGHT](_FONTHEIGHT)
