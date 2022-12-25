The [_PRINTMODE (function)](_PRINTMODE-(function)) function returns the current [_PRINTMODE](_PRINTMODE) status as a numerical value from 1 to 3 in graphic screen modes.

## Syntax

> currentPrintMode = [_PRINTMODE](_PRINTMODE-(function))[(imageHandle&)]

## Parameter(s)

* If no imageHandle& is given, the current [_DEST](_DEST) [SCREEN](SCREEN) page or image is assumed.

## Description

* Returns a status value from 1 to 3 designating the current mode setting:
    * **1**: mode is _KEEPBACKGROUND
    * **2**: mode is _ONLYBACKGROUND
    * **3**: mode is _FILLBACKGROUND **(default)**
* **The [_PRINTMODE](_PRINTMODE) statement and function can only be used in graphic screen modes, not SCREEN 0**

## See Also

* [_PRINTMODE](_PRINTMODE)
* [_LOADFONT](_LOADFONT)
* [_NEWIMAGE](_NEWIMAGE)
* [_PRINTSTRING](_PRINTSTRING)
