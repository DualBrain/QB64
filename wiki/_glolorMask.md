**_glColorMask, glColorMaski:** enable and disable writing of frame buffer color components



## Syntax


> :  SUB _glColorMask (BYVAL red AS _UNSIGNED _BYTE, BYVAL green AS _UNSIGNED _BYTE, BYVAL blue AS _UNSIGNED _BYTE, BYVAL alpha AS _UNSIGNED _BYTE)
> :  void **_glColorMask**(GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);
> : void **_glColorMaski**(GLuint buf, GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);

; buf
>  For **_glColorMaski**, specifies the index of the draw buffer whose color mask to set.
; red, green, blue, alpha
>  Specify whether red, green, blue, and alpha are to be written into the frame buffer. The initial values are all [_GL_TRUE](_GL_TRUE), indicating that the color components are written.


## Description


**_glColorMask** and **_glColorMaski** specify whether the individual color components in the frame buffer can or cannot be written. **_glColorMaski** sets the mask for a specific draw buffer, whereas **_glColorMask** sets the mask for all draw buffers. If red is [_GL_FALSE](_GL_FALSE), for example, no change is made to the red component of any pixel in any of the color buffers, regardless of the drawing operation attempted.

Changes to individual bits of components cannot be controlled. Rather, changes are either enabled or disabled for entire color components.


## Error(s)


[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if buf is greater than [_GL_MAX_DRAW_BUFFERS](_GL_MAX_DRAW_BUFFERS) minus 1.


## Use With


[_glGet](_glGet) with argument [_GL_COLOR_WRITEMASK](_GL_COLOR_WRITEMASK)


## See Also


[_GL](_GL)
[_glClear](_glClear), [_glClearBuffer](_glClearBuffer), [_glDepthMask](_glDepthMask), [_glStencilMask](_glStencilMask)




