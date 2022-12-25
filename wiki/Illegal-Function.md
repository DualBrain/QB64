**Illegal Function Call** returns ERROR Code 5 when a parameter does not match the function type or exceeds function limitations.

1. Graphic objects such as [LINE](LINE), [CIRCLE](CIRCLE), [PSET](PSET), [PRESET](PRESET) and [DRAW](DRAW) statements must use a graphic [SCREEN](SCREEN) mode other than the default SCREEN 0.

2. [GET (graphics statement)](GET-(graphics-statement)) and [PUT (graphics statement)](PUT-(graphics-statement)) cannot use offscreen coordinates in QB. **QB64** allows offscreen GETs, but PUT statements can only be used offscreen using the PUT [_CLIP](_CLIP) syntax. Graphic [SCREEN](SCREEN) modes are 1, 2, 7 through 13 only!

*Return to* [ERROR Codes](ERROR-Codes)
