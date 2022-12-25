**_glBindTexture:** bind a named texture to a texturing target


## Syntax


> : SUB **_glBindTexture** (BYVAL target AS _UNSIGNED LONG, BYVAL texture AS _UNSIGNED LONG)
> : void **_glBindTexture**(GLenum target, GLuint texture);


; target
>  Specifies the target to which the texture is bound. Must be either [_GL_TEXTURE_1D](_GL_TEXTURE_1D), [_GL_TEXTURE_2D](_GL_TEXTURE_2D), [_GL_TEXTURE_3D](_GL_TEXTURE_3D), or [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY), [_GL_TEXTURE_2D_ARRAY](_GL_TEXTURE_2D_ARRAY), [_GL_TEXTURE_RECTANGLE](_GL_TEXTURE_RECTANGLE), [_GL_TEXTURE_CUBE_MAP](_GL_TEXTURE_CUBE_MAP), [_GL_TEXTURE_2D_MULTISAMPLE](_GL_TEXTURE_2D_MULTISAMPLE), [_GL_TEXTURE_2D_MULTISAMPLE_ARRAY](_GL_TEXTURE_2D_MULTISAMPLE_ARRAY), [_GL_TEXTURE_BUFFER](_GL_TEXTURE_BUFFER), or [_GL_TEXTURE_CUBE_MAP_ARRAY](_GL_TEXTURE_CUBE_MAP_ARRAY).
; texture
>  Specifies the name of a texture.


## Description


**_glBindTexture** lets you create or use a named texture. Calling **_glBindTexture** with target set to [_GL_TEXTURE_1D](_GL_TEXTURE_1D), [_GL_TEXTURE_2D](_GL_TEXTURE_2D), [_GL_TEXTURE_3D](_GL_TEXTURE_3D), or [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY), [_GL_TEXTURE_2D_ARRAY](_GL_TEXTURE_2D_ARRAY), [_GL_TEXTURE_RECTANGLE](_GL_TEXTURE_RECTANGLE), [_GL_TEXTURE_CUBE_MAP](_GL_TEXTURE_CUBE_MAP), [_GL_TEXTURE_2D_MULTISAMPLE](_GL_TEXTURE_2D_MULTISAMPLE) or [_GL_TEXTURE_2D_MULTISAMPLE_ARRAY](_GL_TEXTURE_2D_MULTISAMPLE_ARRAY) and texture set to the name of the new texture binds the texture name to the target. When a texture is bound to a target, the previous binding for that target is automatically broken.

Texture names are unsigned integers. The value zero is reserved to represent the default texture for each texture target. Texture names and the corresponding texture contents are local to the shared object space of the current GL rendering context; two rendering contexts share texture names only if they explicitly enable sharing between contexts through the appropriate GL windows interfaces functions.

You must use [_glGenTextures](_glGenTextures) to generate a set of new texture names.

When a texture is first bound, it assumes the specified target: A texture first bound to [_GL_TEXTURE_1D](_GL_TEXTURE_1D) becomes one-dimensional texture, a texture first bound to [_GL_TEXTURE_2D](_GL_TEXTURE_2D) becomes two-dimensional texture, a texture first bound to [_GL_TEXTURE_3D](_GL_TEXTURE_3D) becomes three-dimensional texture, a texture first bound to [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY) becomes one-dimensional array texture, a texture first bound to [_GL_TEXTURE_2D_ARRAY](_GL_TEXTURE_2D_ARRAY) becomes two-dimensional arary texture, a texture first bound to [_GL_TEXTURE_RECTANGLE](_GL_TEXTURE_RECTANGLE) becomes rectangle texture, a, texture first bound to [_GL_TEXTURE_CUBE_MAP](_GL_TEXTURE_CUBE_MAP) becomes a cube-mapped texture, a texture first bound to [_GL_TEXTURE_2D_MULTISAMPLE](_GL_TEXTURE_2D_MULTISAMPLE) becomes a two-dimensional multisampled texture, and a texture first bound to [_GL_TEXTURE_2D_MULTISAMPLE_ARRAY](_GL_TEXTURE_2D_MULTISAMPLE_ARRAY) becomes a two-dimensional multisampled array texture. The state of a one-dimensional texture immediately after it is first bound is equivalent to the state of the default [_GL_TEXTURE_1D](_GL_TEXTURE_1D) at GL initialization, and similarly for the other texture types.

While a texture is bound, GL operations on the target to which it is bound affect the bound texture, and queries of the target to which it is bound return state from the bound texture. In effect, the texture targets become aliases for the textures currently bound to them, and the texture name zero refers to the default textures that were bound to them at initialization.

A texture binding created with **_glBindTexture** remains active until a different texture is bound to the same target, or until the bound texture is deleted with [_glDeleteTextures](_glDeleteTextures).

Once created, a named texture may be re-bound to its same original target as often as needed. It is usually much faster to use **_glBindTexture** to bind an existing named texture to one of the texture targets than it is to reload the texture image using [_glTexImage1D](_glTexImage1D), [_glTexImage2D](_glTexImage2D), [_glTexImage3D](_glTexImage3D) or another similar function.


## Notes


The [_GL_TEXTURE_2D_MULTISAMPLE](_GL_TEXTURE_2D_MULTISAMPLE) and [_GL_TEXTURE_2D_MULTISAMPLE_ARRAY](_GL_TEXTURE_2D_MULTISAMPLE_ARRAY) targets are available only if the GL version is 3.2 or higher.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if target is not one of the allowable values.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if target is not a name returned from a previous call to [_glGenTextures](_glGenTextures).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if texture was previously created with a target that doesn't match that of target.


## Use With


[_glGet](_glGet) with argument [_GL_TEXTURE_BINDING_1D](_GL_TEXTURE_BINDING_1D), [_GL_TEXTURE_BINDING_2D](_GL_TEXTURE_BINDING_2D), [_GL_TEXTURE_BINDING_3D](_GL_TEXTURE_BINDING_3D), [_GL_TEXTURE_BINDING_1D_ARRAY](_GL_TEXTURE_BINDING_1D_ARRAY), [_GL_TEXTURE_BINDING_2D_ARRAY](_GL_TEXTURE_BINDING_2D_ARRAY), [_GL_TEXTURE_BINDING_RECTANGLE](_GL_TEXTURE_BINDING_RECTANGLE), [_GL_TEXTURE_BINDING_2D_MULTISAMPLE](_GL_TEXTURE_BINDING_2D_MULTISAMPLE), or [_GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY](_GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY).

## See Also


[_GL](_GL)
[_glActiveTexture](_glActiveTexture), [_glDeleteTextures](_glDeleteTextures), [_glGenTextures](_glGenTextures), [_glGetTexParameter](_glGetTexParameter), [_glIsTexture](_glIsTexture), [_glTexParameter](_glTexParameter)




