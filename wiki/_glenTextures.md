**_glGenTextures:** generate texture names


## Syntax


  SUB _glGenTextures (BYVAL n AS LONG, textures AS _UNSIGNED LONG)
  void **_glGenTextures**(GLsizei n, GLuint * textures);


; n
>  Specifies the number of texture names to be generated.
; textures
>  Specifies an array in which the generated texture names are stored.


## Description


**_glGenTextures** returns n texture names in textures. There is no guarantee that the names form a contiguous set of integers; however, it is guaranteed that none of the returned names was in use immediately before the call to **_glGenTextures**.

The generated textures have no dimensionality; they assume the dimensionality of the texture target to which they are first bound (see [_glBindTexture](_glBindTexture)).

Texture names returned by a call to **_glGenTextures** are not returned by subsequent calls, unless they are first deleted with [_glDeleteTextures](_glDeleteTextures).


## Error(s)


[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if n is negative.


## Use With


[_glIsTexture](_glIsTexture)


## See Also


[_GL](_GL)
[_glBindTexture](_glBindTexture), [_glDeleteTextures](_glDeleteTextures), [_glIsTexture](_glIsTexture)




Copyright 1991-2006 Silicon Graphics, Inc. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

