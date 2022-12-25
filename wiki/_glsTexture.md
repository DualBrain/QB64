**_glIsTexture:** determine if a name corresponds to a texture


## Syntax


  FUNCTION _glIsTexture~%% (BYVAL texture AS _UNSIGNED LONG)
  GLboolean **_glIsTexture**(GLuint texture);


; texture
>  Specifies a value that may be the name of a texture.


## Description


**_glIsTexture** returns [_GL_TRUE](_GL_TRUE) if texture is currently the name of a texture. If texture is zero, or is a non-zero value that is not currently the name of a texture, or if an error occurs, **_glIsTexture** returns [_GL_FALSE](_GL_FALSE).

A name returned by [_glGenTextures](_glGenTextures), but not yet associated with a texture by calling [_glBindTexture](_glBindTexture), is not the name of a texture.


## See Also


[_GL](_GL)
[_glBindTexture](_glBindTexture), [_glDeleteTextures](_glDeleteTextures), [_glGenTextures](_glGenTextures)




Copyright 1991-2006 Silicon Graphics, Inc. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

