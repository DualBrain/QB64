**_glTexSubImage1D:** specify a one-dimensional texture subimage


## Syntax


  SUB _glTexSubImage1D (BYVAL target AS _UNSIGNED LONG, BYVAL level AS LONG, BYVAL xoffset AS LONG, BYVAL width AS LONG, BYVAL format AS _UNSIGNED LONG, BYVAL type AS _UNSIGNED LONG, pixels AS _OFFSET)
  void **_glTexSubImage1D**(GLenum target, GLint level, GLint xoffset, GLsizei width, GLenum format, GLenum type, const GLvoid * data);


; target
>  Specifies the target texture. Must be [_GL_TEXTURE_1D](_GL_TEXTURE_1D).
; level
>  Specifies the level-of-detail number. Level 0 is the base image level. Level *n* is the *n*th mipmap reduction image.
; xoffset
>  Specifies a texel offset in the x direction within the texture array.
; width
>  Specifies the width of the texture subimage.
glapi pixeltransferupparams


## Description


Texturing maps a portion of a specified texture image onto each graphical primitive for which texturing is enabled. To enable or disable one-dimensional texturing, call [_glEnable](_glEnable) and [_glDisable](_glDisable) with argument [_GL_TEXTURE_1D](_GL_TEXTURE_1D).

**_glTexSubImage1D** redefines a contiguous subregion of an existing one-dimensional texture image. The texels referenced by data replace the portion of the existing texture array with x indices xoffset and xoffset + width - 1, inclusive. This region may not include any texels outside the range of the texture array as it was originally specified. It is not an error to specify a subtexture with width of 0, but such a specification has no effect.

If a non-zero named buffer object is bound to the [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER) target (see [_glBindBuffer](_glBindBuffer)) while a texture image is specified, data is treated as a byte offset into the buffer object's data store.


## Notes


[_glPixelStore](_glPixelStore) modes affect texture images.

**_glTexSubImage1D** specifies a one-dimensional subtexture for the current texture unit, specified with [_glActiveTexture](_glActiveTexture).


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if target is not one of the allowable values.

[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if format is not an accepted format constant.

[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if type is not a type constant.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if level is less than 0.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) may be generated if level is greater than log<sub>2</sub>(*max*), where *max* is the returned value of [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if *xoffset* < 0, or if *xoffset* + *width* > *w*, where *w* is the [_GL_TEXTURE_WIDTH](_GL_TEXTURE_WIDTH). Note that *w* includes twice the border width.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if width is less than 0.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if the texture array has not been defined by a previous [_glTexImage1D](_glTexImage1D) operation.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if type is one of [_GL_UNSIGNED_BYTE_3_3_2](_GL_UNSIGNED_BYTE_3_3_2), [_GL_UNSIGNED_BYTE_2_3_3_REV](_GL_UNSIGNED_BYTE_2_3_3_REV), [_GL_UNSIGNED_SHORT_5_6_5](_GL_UNSIGNED_SHORT_5_6_5), or [_GL_UNSIGNED_SHORT_5_6_5_REV](_GL_UNSIGNED_SHORT_5_6_5_REV) and format is not [_GL_RGB](_GL_RGB).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if type is one of [_GL_UNSIGNED_SHORT_4_4_4_4](_GL_UNSIGNED_SHORT_4_4_4_4), [_GL_UNSIGNED_SHORT_4_4_4_4_REV](_GL_UNSIGNED_SHORT_4_4_4_4_REV), [_GL_UNSIGNED_SHORT_5_5_5_1](_GL_UNSIGNED_SHORT_5_5_5_1), [_GL_UNSIGNED_SHORT_1_5_5_5_REV](_GL_UNSIGNED_SHORT_1_5_5_5_REV), [_GL_UNSIGNED_INT_8_8_8_8](_GL_UNSIGNED_INT_8_8_8_8), [_GL_UNSIGNED_INT_8_8_8_8_REV](_GL_UNSIGNED_INT_8_8_8_8_REV), [_GL_UNSIGNED_INT_10_10_10_2](_GL_UNSIGNED_INT_10_10_10_2), or [_GL_UNSIGNED_INT_2_10_10_10_REV](_GL_UNSIGNED_INT_2_10_10_10_REV) and format is neither [_GL_RGBA](_GL_RGBA) nor [_GL_BGRA](_GL_BGRA).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER) target and the buffer object's data store is currently mapped.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER) target and the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER) target and data is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.


## Use With


[_glGetTexImage](_glGetTexImage)

[_glGet](_glGet) with argument [_GL_PIXEL_UNPACK_BUFFER_BINDING](_GL_PIXEL_UNPACK_BUFFER_BINDING)


## See Also


[_GL](_GL)
[_glActiveTexture](_glActiveTexture), [_glBindTexture](_glBindTexture), [_glTexSubImage2D](_glTexSubImage2D), [_glTexSubImage3D](_glTexSubImage3D), [_glCopyTexImage1D](_glCopyTexImage1D), [_glTexImage1D](_glTexImage1D), [_glTexStorage1D](_glTexStorage1D), [_glTextureView](_glTextureView), [_glPixelStore](_glPixelStore)







