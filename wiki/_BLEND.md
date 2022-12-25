The [_BLEND](_BLEND) statement turns on 32 bit alpha blending for an image or screen mode and is on by default.

## Syntax

> [_BLEND](_BLEND) [imageHandle&]

### Parameters

* imageHandle& refers to an image in memory. If not specified, the current destination page (See [_DEST](_DEST)) is affected.

## Description

* Alpha blending is on by default when loading a .PNG image to a 32-bit surface.
* Normally it is used to turn blending on after a previous [_DONTBLEND](_DONTBLEND) call.
* [_BLEND](_BLEND) can only be used on 32-bit surfaces, otherwise it will produce the error [ERROR Codes](ERROR-Codes).
* **Note: [_DONTBLEND](_DONTBLEND) is faster than the default [_BLEND](_BLEND) unless you really need to use it in 32 bit.**
* **32 bit screen surface backgrounds (black) have zero [_ALPHA](_ALPHA) so that they are transparent when placed over other surfaces.**

## Example(s)

```vb

SCREEN _NEWIMAGE(640, 480, 32)

'CLS , _RGB(128, 128, 128) 'change background color for other results

_DONTBLEND

bg& = POINT(0, 0)
PRINT _RED(bg&), _GREEN(bg&), _BLUE(bg&), _ALPHA(bg&)

LINE (100, 100)-(200, 200), _RGBA32(255, 128, 0, 128), BF

LINE (440, 100)-(540, 200), _RGBA32(0, 0, 255, 64), BF

K$ = INPUT$(1)

_BLEND

LINE (270, 300)-(370, 400), _RGBA32(255, 128, 0, 128), BF
m& = POINT(303, 302)
PRINT _RED(m&), _GREEN(m&), _BLUE(m&), _ALPHA(m&)
K$ = INPUT$(1)

LINE (270, 300)-(370, 400), _RGBA32(0, 0, 255, 64), BF
m& = POINT(303, 302)
PRINT _RED(m&), _GREEN(m&), _BLUE(m&), _ALPHA(m&)

```

```text

_RGBA(255,128,0,128) onto _RGBA(0,0,255,64)

results in

_RGBA(95,48,64,128)

```

## See Also

* [_DONTBLEND](_DONTBLEND), [_BLEND (function)](_BLEND-(function))
* [Images](Images)
