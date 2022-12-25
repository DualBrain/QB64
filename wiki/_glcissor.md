This will define the scissor box.

## Syntax

* QB64: SUB [_glScissor](_glScissor) (BYVAL x AS LONG, BYVAL y AS LONG, BYVAL width AS LONG, BYVAL height) AS LONG)
* C/C++: void [_glScissor](_glScissor)(GLint x, GLint y, GLsizei width, GLsizei height);

## Parameters

* x, y Specify the lower left corner of the scissor box. Initially (0, 0).
* width, height Specify the width and height of the scissor box. When a GL context is first attached to a window, width and height are set to the dimensions of that window.

## Description

**_glScissor** defines a rectangle, called the scissor box, in window coordinates. The first two arguments, x and y, specify the lower left corner of the box. width and height specify the width and height of the box.

To enable and disable the scissor test, call [_glEnable](_glEnable) and [_glDisable](_glDisable) with argument [_GL_SCISSOR_TEST](_GL_SCISSOR_TEST). The test is initially disabled. While the test is enabled, only pixels that lie within the scissor box can be modified by drawing commands. Window coordinates have integer values at the shared corners of frame buffer pixels. `_glScissor(0,0,1,1)` allows modification of only the lower left pixel in the window, and `_glScissor(0,0,0,0)` doesn't allow modification of any pixels in the window.

When the scissor test is disabled, it is as though the scissor box includes the entire window.

## Error(s)

* [_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if either width or height is negative.

## Use With

* [_glGet](_glGet) with argument [_GL_SCISSOR_BOX](_GL_SCISSOR_BOX)
* [_glIsEnabled](_glIsEnabled) with argument [_GL_SCISSOR_TEST](_GL_SCISSOR_TEST)

## See Also

* [_GL](_GL)
* [_glEnable](_glEnable)
* [_glScissorArray](_glScissorArray)
* [_glScissorIndexed](_glScissorIndexed)
* [_glViewport](_glViewport)
