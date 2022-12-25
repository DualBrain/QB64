**_glReadBuffer:** select a color buffer source for pixel read operations from the current read framebuffer.


## Syntax


  SUB _glReadBuffer (BYVAL mode AS _UNSIGNED LONG)
  void **_glReadBuffer**(GLenum mode);


; mode
>  Specifies a color buffer. Accepted values are [_GL_FRONT_LEFT](_GL_FRONT_LEFT), [_GL_FRONT_RIGHT](_GL_FRONT_RIGHT), [_GL_BACK_LEFT](_GL_BACK_LEFT), [_GL_BACK_RIGHT](_GL_BACK_RIGHT), [_GL_FRONT](_GL_FRONT), [_GL_BACK](_GL_BACK), [_GL_LEFT](_GL_LEFT), [_GL_RIGHT](_GL_RIGHT), and the constants [_GL_COLOR_ATTACHMENT*i*](_GL_COLOR_ATTACHMENT*i*).


## Description


**_glReadBuffer** specifies which color buffer within the current bound [_GL_READ_FRAMEBUFFER](_GL_READ_FRAMEBUFFER) will be used as the source for pixel reading commands. These commands include: [_glBlitFramebuffer](_glBlitFramebuffer), [_glReadPixels](_glReadPixels), [_glCopyTexImage1D](_glCopyTexImage1D), [_glCopyTexImage2D](_glCopyTexImage2D), [_glCopyTexSubImage1D](_glCopyTexSubImage1D), [_glCopyTexSubImage2D](_glCopyTexSubImage2D), and [_glCopyTexSubImage3D](_glCopyTexSubImage3D).

mode accepts one of twelve or more predefined values. If the [default framebuffer](default framebuffer) (the zero [framebuffer object](framebuffer object))is bound to [_GL_READ_FRAMEBUFFER](_GL_READ_FRAMEBUFFER), then the following enumerators can be used: [_GL_FRONT](_GL_FRONT), [_GL_LEFT](_GL_LEFT), and [_GL_FRONT_LEFT](_GL_FRONT_LEFT) all name the front left buffer, [_GL_FRONT_RIGHT](_GL_FRONT_RIGHT) and [_GL_RIGHT](_GL_RIGHT) name the front right buffer, and [_GL_BACK_LEFT](_GL_BACK_LEFT) and [_GL_BACK](_GL_BACK) name the back left buffer. Nonstereo double-buffered configurations have only a front left and a back left buffer. Single-buffered configurations have a front left and a front right buffer if stereo, and only a front left buffer if nonstereo.

If a non-zero framebuffer object is bound, then the constants [_GL_COLOR_ATTACHMENT*i*](_GL_COLOR_ATTACHMENT*i*) may be used to indicate the *i*<sup>th</sup> color attachment, where *i* ranges from zero to the value of [_GL_MAX_COLOR_ATTACHMENTS](_GL_MAX_COLOR_ATTACHMENTS) minus one.

It is an error to specify a nonexistent buffer to **_glReadBuffer**.

For the default framebuffer, mode is initially [_GL_FRONT](_GL_FRONT) in single-buffered configurations and [_GL_BACK](_GL_BACK) in double-buffered configurations. For framebuffer objects, the default read buffer is [_GL_COLOR_ATTACHMENT0](_GL_COLOR_ATTACHMENT0).


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if mode is not one of the twelve (or more) accepted values.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if mode specifies a buffer that does not exist.


## Use With


[_glGet](_glGet) with argument [_GL_READ_BUFFER](_GL_READ_BUFFER)


## See Also


[_GL](_GL)
[_glBindFramebuffer](_glBindFramebuffer), [_glDrawBuffer](_glDrawBuffer), [_glDrawBuffers](_glDrawBuffers), [_glReadPixels](_glReadPixels)




Copyright 1991-2006 Silicon Graphics, Inc. Copyright 2011 Khronos Group. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

