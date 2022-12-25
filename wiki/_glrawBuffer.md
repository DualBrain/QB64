**_glDrawBuffer:** specify which color buffers are to be drawn into


## Syntax


> :  SUB _glDrawBuffer (BYVAL mode AS _UNSIGNED LONG)
> :  void **_glDrawBuffer**(GLenum mode);


; mode
>  Specifies up to four color buffers to be drawn into. Symbolic constants [_GL_NONE](_GL_NONE), [_GL_FRONT_LEFT](_GL_FRONT_LEFT), [_GL_FRONT_RIGHT](_GL_FRONT_RIGHT), [_GL_BACK_LEFT](_GL_BACK_LEFT), [_GL_BACK_RIGHT](_GL_BACK_RIGHT), [_GL_FRONT](_GL_FRONT), [_GL_BACK](_GL_BACK), [_GL_LEFT](_GL_LEFT), [_GL_RIGHT](_GL_RIGHT), and [_GL_FRONT_AND_BACK](_GL_FRONT_AND_BACK) are accepted. The initial value is [_GL_FRONT](_GL_FRONT) for single-buffered contexts, and [_GL_BACK](_GL_BACK) for double-buffered contexts.


## Description


When colors are written to the frame buffer, they are written into the color buffers specified by **_glDrawBuffer**. The specifications are as follows:

; [_GL_NONE](_GL_NONE)
>  No color buffers are written.
; [_GL_FRONT_LEFT](_GL_FRONT_LEFT)
>  Only the front left color buffer is written.
; [_GL_FRONT_RIGHT](_GL_FRONT_RIGHT)
>  Only the front right color buffer is written.
; [_GL_BACK_LEFT](_GL_BACK_LEFT)
>  Only the back left color buffer is written.
; [_GL_BACK_RIGHT](_GL_BACK_RIGHT)
>  Only the back right color buffer is written.
; [_GL_FRONT](_GL_FRONT)
>  Only the front left and front right color buffers are written. If there is no front right color buffer, only the front left color buffer is written.
; [_GL_BACK](_GL_BACK)
>  Only the back left and back right color buffers are written. If there is no back right color buffer, only the back left color buffer is written.
; [_GL_LEFT](_GL_LEFT)
>  Only the front left and back left color buffers are written. If there is no back left color buffer, only the front left color buffer is written.
; [_GL_RIGHT](_GL_RIGHT)
>  Only the front right and back right color buffers are written. If there is no back right color buffer, only the front right color buffer is written.
; [_GL_FRONT_AND_BACK](_GL_FRONT_AND_BACK)
>  All the front and back color buffers (front left, front right, back left, back right) are written. If there are no back color buffers, only the front left and front right color buffers are written. If there are no right color buffers, only the front left and back left color buffers are written. If there are no right or back color buffers, only the front left color buffer is written.
If more than one color buffer is selected for drawing, then blending or logical operations are computed and applied independently for each color buffer and can produce different results in each buffer.

Monoscopic contexts include only *left* buffers, and stereoscopic contexts include both *left* and *right* buffers. Likewise, single-buffered contexts include only *front* buffers, and double-buffered contexts include both *front* and *back* buffers. The context is selected at GL initialization.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if mode is not an accepted value.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if none of the buffers indicated by mode exists.


## Use With


[_glGet](_glGet) with argument [_GL_DRAW_BUFFER](_GL_DRAW_BUFFER)


## See Also


[_GL](_GL)
[_glBindFramebuffer](_glBindFramebuffer), [_glBlendFunc](_glBlendFunc), [_glColorMask](_glColorMask), [_glDrawBuffers](_glDrawBuffers), [_glLogicOp](_glLogicOp)




