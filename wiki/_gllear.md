**_glClear:** clear buffers to preset values


## Syntax


> : [SUB](SUB) _glClear ([BYVAL](BYVAL) mask AS [_UNSIGNED](_UNSIGNED) [LONG](LONG))
> :  void **_glClear**(GLbitfield mask);


## Parameters

* *mask* that indicate the buffer [OR](OR) buffers to be cleared. The three masks are [_GL_COLOR_BUFFER_BIT](_GL_COLOR_BUFFER_BIT), [_GL_DEPTH_BUFFER_BIT](_GL_DEPTH_BUFFER_BIT), and [_GL_STENCIL_BUFFER_BIT](_GL_STENCIL_BUFFER_BIT).


## Description


* [_glClear](_glClear) sets the bitplane area of the window to values previously selected by [_glClearColor](_glClearColor), [glClearDepth](glClearDepth), and [_glClearStencil](_glClearStencil). 
* Multiple color buffers can be cleared simultaneously by selecting more than one buffer at a time using [_glDrawBuffer](_glDrawBuffer).
* The pixel ownership test, the scissor test, dithering, and the buffer writemasks affect the operation of [_glClear](_glClear). The scissor box bounds the cleared region. Alpha function, blend function, logical operation, stenciling, texture mapping, and depth-buffering are ignored by [_glClear](_glClear).

* [_glClear](_glClear) takes a single argument that is the bitwise OR of several values indicating which buffer is to be cleared. The values are as follows:

> :: [_GL_COLOR_BUFFER_BIT](_GL_COLOR_BUFFER_BIT): Indicates the buffers currently enabled for color writing.
> :: [_GL_DEPTH_BUFFER_BIT](_GL_DEPTH_BUFFER_BIT): Indicates the depth buffer.
> :: [_GL_STENCIL_BUFFER_BIT](_GL_STENCIL_BUFFER_BIT): Indicates the stencil buffer.

* The value to which each buffer is cleared depends on the setting of the clear value for that buffer.


## Notes


If a buffer is not present, then a **_glClear** directed at that buffer has no effect.


## Error(s)


[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if any bit other than the three defined bits is set in mask.


## Use With


[_glGet](_glGet) with argument [_GL_DEPTH_CLEAR_VALUE](_GL_DEPTH_CLEAR_VALUE)

[_glGet](_glGet) with argument [_GL_COLOR_CLEAR_VALUE](_GL_COLOR_CLEAR_VALUE)

[_glGet](_glGet) with argument [_GL_STENCIL_CLEAR_VALUE](_GL_STENCIL_CLEAR_VALUE)


## See Also

* [_GL](_GL) 
* [_glClearBuffer](_glClearBuffer), [_glClearColor](_glClearColor), [_glClearDepth](_glClearDepth), [_glClearStencil](_glClearStencil) 
* [_glColorMask](_glColorMask), [_glDepthMask](_glDepthMask), [_glStencilMask](_glStencilMask)
* [_glDrawBuffer](_glDrawBuffer), [_glDrawBuffers](_glDrawBuffers)
* [_glScissor](_glScissor)




