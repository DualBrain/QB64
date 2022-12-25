The [_PRINTMODE](_PRINTMODE) statement sets the text or [_FONT](_FONT) printing mode on a background image when using [PRINT](PRINT) or [_PRINTSTRING](_PRINTSTRING).

## Syntax

> [_PRINTMODE](_PRINTMODE) {*_KEEPBACKGROUND*|*_ONLYBACKGROUND*|*_FILLBACKGROUND*}[, imageHandle&]

## Parameter(s)

* One of 3 mode keywords is mandatory when using this statement to deal with the text background.
  * *_KEEPBACKGROUND* (mode 1): Text background transparent. Only the text is displayed over anything behind it.
  * *_ONLYBACKGROUND* (mode 2): Text background only is displayed. Text is transparent to anything behind it.
  * *_FILLBACKGROUND* (mode 3): Text and background block anything behind them like a normal [PRINT](PRINT). **Default setting.**
* If the optional imageHandle& is omitted or = 0) it will use the current [_DEST](_DEST) image background.

## Description

* Use the [_PRINTMODE (function)](_PRINTMODE-(function)) to find the current [_PRINTMODE](_PRINTMODE) setting mode number.
* **The _PRINTMODE statement and function can only be used in graphic screen modes, not SCREEN 0**

## Example(s)

Using _PRINTMODE with [PRINT](PRINT) in a graphic screen mode. The background used is CHR$(219) = █

```vb

SCREEN 12
COLOR 8: LOCATE 10, 10: PRINT STRING$(3, 219) 'background 
_PRINTMODE _KEEPBACKGROUND
COLOR 15: LOCATE 10, 10: PRINT _PRINTMODE 
END 

```

## See Also

* [_PRINTMODE (function)](_PRINTMODE-(function))
* [_PRINTSTRING](_PRINTSTRING)
* [_LOADFONT](_LOADFONT)
* [_NEWIMAGE](_NEWIMAGE)
* [PRINT](PRINT), [PRINT USING](PRINT-USING)
