**_glViewport:** set the viewport


## Syntax


;QB64:SUB _glViewport (BYVAL x AS LONG, BYVAL y AS LONG, BYVAL width AS LONG, BYVAL height AS LONG)
;C/C++:void **_glViewport**(GLint x, GLint y, GLsizei width, GLsizei height);


; x, y
>  Specify the lower left corner of the viewport rectangle, in pixels. The initial value is (0,0).
; width, height
>  Specify the width and height of the viewport. When a GL context is first attached to a window, width and height are set to the dimensions of that window.


## Description


**_glViewport** specifies the affine transformation of *x* and *y* from normalized device coordinates to window coordinates. Let (x<sub>nd</sub>, y<sub>nd</sub>) be normalized device coordinates. Then the window coordinates (x<sub>w</sub>, y<sub>w</sub>) are computed as follows:

glapi viewport equations

Viewport width and height are silently clamped to a range that depends on the implementation. To query this range, call [_glGet](_glGet) with argument [_GL_MAX_VIEWPORT_DIMS](_GL_MAX_VIEWPORT_DIMS).


## Error(s)


[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if either width or height is negative.


## Use With


[_glGet](_glGet) with argument [_GL_VIEWPORT](_GL_VIEWPORT)

[_glGet](_glGet) with argument [_GL_MAX_VIEWPORT_DIMS](_GL_MAX_VIEWPORT_DIMS)


## See Also


[_GL](_GL)
[_glDepthRange](_glDepthRange), [_glViewportArray](_glViewportArray), [_glViewportIndexed](_glViewportIndexed)







