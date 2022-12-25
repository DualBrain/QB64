The [_DEFAULTCOLOR](_DEFAULTCOLOR) function returns the current default text color for an image handle or page.

## Syntax

> result& = [_DEFAULTCOLOR](_DEFAULTCOLOR) [(imageHandle&)]

## Description

* If imageHandle& is omitted, it is assumed to be the current write page or image designated by [_DEST](_DEST).
* If imageHandle& is an invalid handle, an [ERROR Codes](ERROR-Codes) error occurs. Check handle values first.
* Default foreground colors are: [SCREEN](SCREEN) 0 = 7, [SCREEN](SCREEN) 1 and 10 = 3, [SCREEN](SCREEN) 2 and 11 = 1. All other [SCREEN](SCREEN)s = 15. 

## Example(s)

The default color is the color assigned to the text foreground. The [SCREEN](SCREEN) 12 default is [COLOR](COLOR) 15.

```vb

SCREEN 12
OUT &H3C8, 0: OUT &H3C9, 63: OUT &H3C9, 63: OUT &H3C9, 63  'assign background RGB intensities
OUT &H3C8, 8: OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 0     'assign RGB intensities to COLOR 8
_PRINTMODE  _KEEPBACKGROUND
COLOR 8                                                    'assign color 8 to text foreground
PRINT "The default color is attribute"; _DEFAULTCOLOR 

```

## See Also

* [COLOR](COLOR)
* [_DEST](_DEST)
* [Images](Images)
* [Windows Libraries](Windows-Libraries)
