The [$CONSOLE]($CONSOLE) [metacommand](metacommand) creates a console window that can be used throughout a QB64 program module.

## Syntax

> [$CONSOLE]($CONSOLE)[:ONLY]

## Description

* [_CONSOLE](_CONSOLE) **ON** or **OFF** may be used to show or hide the console window at run time.
* The **:ONLY** option can be used when only a console window is desired without a program window.
* [_DEST](_DEST) and [_SOURCE](_SOURCE) are automatically set to [_CONSOLE](_CONSOLE) when the **:ONLY** option is used, in order to send screen output to the console window and get input from it too.
  * In normal [$CONSOLE]($CONSOLE) mode (dual screen) you have to manually set [_DEST](_DEST) and [_SOURCE](_SOURCE) to [_CONSOLE](_CONSOLE) in order to work with the console window.
* [_SCREENHIDE](_SCREENHIDE) and [_SCREENSHOW](_SCREENSHOW) can be used to hide or show the main program window.
* [_DELAY](_DELAY) or [SLEEP](SLEEP) can be used to allow the console window to be set in front of the main program window.
* [_CONSOLETITLE](_CONSOLETITLE) can be used to change the title of the console window.
* **Note:** Text can be copied partially or totally from console screens in Windows by highlighting and using the title bar menu. 
> To copy console text output, right click the title bar and select *Edit* for *Mark* to highlight and repeat to *Copy* 
* QB64 [Metacommand](Metacommand)s are not commented out with ' or REM, differently from QBasic metacommands.

## Example(s)

Hiding and displaying a console window. Use [_DELAY](_DELAY) to place console in front of main program window.

```vb

$CONSOLE
_DELAY 4

_CONSOLE OFF
_DELAY 4
_CONSOLE ON

_DEST _CONSOLE
PRINT "Close this console window or click main window and press a key!" 

```

How to use a Console window to copy screen output using the *Edit* menu by right clicking the console title bar.

```vb

$CONSOLE
_DEST _CONSOLE

c&& = -1: d& = -1: e% = -1: f%% = -1
hx$ = HEX$(f%%)
PRINT "Max hex _BYTE = "; hx$; " with"; LEN(hx$); "digits ="; VAL("&H" + hx$)
hx$ = HEX$(e%)
PRINT "Max hex INTEGER = "; hx$; " with"; LEN(hx$); "digits ="; VAL("&H" + hx$)
hx$ = HEX$(d&)
PRINT "Max hex LONG = "; hx$; " with"; LEN(hx$); "digits ="; VAL("&H" + hx$)
hx$ = HEX$(c&&)
PRINT "Max hex _INTEGER64 = "; hx$; " with"; LEN(hx$); "digits ="; VAL("&H" + hx$)
hx$ = HEX$(9223372036854775807)
PRINT "Max _INTEGER64 value = "; hx$; " with"; LEN(hx$); "digits"
hx$ = HEX$(-9223372036854775808)
PRINT "Min _INTEGER64 value = "; hx$; " with"; LEN(hx$); "digits" 

```

```text

Max hex _BYTE = FF with 2 digits = 255
Max hex INTEGER = FFFF with 4 digits = 65535
Max hex LONG = FFFFFFFF with 8 digits = 4294967295
Max hex _INTEGER64 = FFFFFFFFFFFFFFFF with 16 digits =-1
Max _INTEGER64 value = 7FFFFFFFFFFFFFFF with 16 digits
Min _INTEGER64 value = 8000000000000000 with 16 digits

```

> *Console:* Right click and select *Edit* > *Select All* (mouse highlight after) then hit Enter or select *Edit* > *Copy* to the [_CLIPBOARD$ (function)](_CLIPBOARD$-(function)).

```text

Max hex _BYTE = FF with 2 digits = 255
Max hex INTEGER = FFFF with 4 digits = 65535
Max hex LONG = FFFFFFFF with 8 digits = 4294967295
Max hex _INTEGER64 = FFFFFFFFFFFFFFFF with 16 digits =-1

```

> *Copied text:* The above text was copied after *Select All* was selected and the smaller area was re-highlighted with the mouse.

## See Also

* [_CONSOLE](_CONSOLE)
* [$SCREENHIDE]($SCREENHIDE), [$SCREENSHOW]($SCREENSHOW) (QB64 [Metacommand](Metacommand)s)
* [_SCREENHIDE](_SCREENHIDE), [_SCREENSHOW](_SCREENSHOW)
* [C Libraries](C-Libraries)
