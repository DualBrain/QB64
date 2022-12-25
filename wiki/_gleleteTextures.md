**_glDeleteTextures:** delete named textures


## Syntax


>   SUB _glDeleteTextures (BYVAL n AS LONG, textures AS _UNSIGNED LONG)

>   void **_glDeleteTextures**(GLsizei n, const GLuint * textures);


; n
>  Specifies the number of textures to be deleted.
; textures
>  Specifies an array of textures to be deleted.


## Description


**_glDeleteTextures** deletes n textures named by the elements of the array textures. After a texture is deleted, it has no contents or dimensionality, and its name is free for reuse (for example by [_glGenTextures](_glGenTextures)). If a texture that is currently bound is deleted, the binding reverts to 0 (the default texture).

**_glDeleteTextures** silently ignores 0's and names that do not correspond to existing textures.


## Error(s)


[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if n is negative.


## Use With


[_glIsTexture](_glIsTexture)


## See Also


[_GL](_GL)
[_glBindTexture](_glBindTexture), [_glGenTextures](_glGenTextures), [_glIsTexture](_glIsTexture)




