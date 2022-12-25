The [_DISPLAYORDER](_DISPLAYORDER) statement defines the order to render software, hardware and custom-OpenGL-code.

## Syntax

> [_DISPLAYORDER](_DISPLAYORDER) [{_SOFTWARE|_HARDWARE|_HARDWARE1|_GLRENDER}][, ...][, ...][, ...][, ...] 

## Parameter(s)

* _SOFTWARE refers to software created surfaces or [SCREEN](SCREEN)s.
* _HARDWARE and _HARDWARE1 refer to surfaces created by OpenGL hardware acceleration.
* _GLRENDER refers to OpenGL code rendering order

## Description

* The default on program start is: _DISPLAYORDER _SOFTWARE, _HARDWARE, _GLRENDER, _HARDWARE1
* Any content or combination order is allowed, except listing the same content twice consecutively.
* Simply using [_DISPLAYORDER](_DISPLAYORDER) _HARDWARE will render hardware surfaces only.
* Use an [underscore](underscore) to continue a code line on a new text row in the IDE.
* After _DISPLAYORDER has been used, it must be used to make any changes, even to default.

## Error(s)

* If a rendering content is not listed it will not be rendered except when using the startup default.
* Rendering the same content twice consecutively in a combination is not allowed.

## Availability

* Version 1.000 and up.

## See Also

* [_DISPLAY](_DISPLAY)
* [_PUTIMAGE](_PUTIMAGE)
* [_LOADIMAGE](_LOADIMAGE)
* [_COPYIMAGE](_COPYIMAGE)
* [Hardware images](Hardware-images)
