QB64 supports some DLL Library statements and functions. Currently the specified DLL file MUST either be in the **Windows System folder** (System32) or in the **QB64 folder!** 

**NOTE:** Use them at your own risk! **QB64 CANNOT** provide specific DLL Library information or support! When using unsupported DLL files use [DECLARE LIBRARY](DECLARE-LIBRARY) and the name of an **inactive** library **without** the .DLL extension. The following statement and function routine examples have been provided by members "as is":

## Example(s)

This example plays Midi files using the *playmidi32.dll* documented here: [Liberty Basic University](http://libertybasicuniversity.com/lbnews/nl110/midi3.htm). Download the following DLL file to your main QB64 folder: [PlayMidi32.dll](https://www.qb64.org/resources/Playmidi32.dll)

```vb

DECLARE DYNAMIC LIBRARY "playmidi32"
    FUNCTION PlayMIDI& (filename AS STRING)
END DECLARE
result = PlayMIDI(".\samples\qb64\original\ps2battl.mid" + CHR$(0))
PRINT result

```

> **Note:** Filename needs to be [CHR$](CHR$)(0) terminated. QB64 [STRING](STRING)s are passed to external libraries as pointers to first character.

## See Also

* [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY), [BYVAL](BYVAL)
* [_OFFSET](_OFFSET), [_OFFSET (function)](_OFFSET-(function)) (lp, ptr and p names)
* [C Libraries](C-Libraries), [SDL Libraries](SDL-Libraries), [Windows Libraries](Windows-Libraries)
* [Libraries](Libraries)
* [Port Access Libraries](Port-Access-Libraries) (COM or LPT)
