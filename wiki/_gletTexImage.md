**_glGetTexImage:** return a texture image


## Syntax


  SUB _glGetTexImage (BYVAL target AS _UNSIGNED LONG, BYVAL level AS LONG, BYVAL format AS _UNSIGNED LONG, BYVAL type AS _UNSIGNED LONG, pixels AS _OFFSET)
  void **_glGetTexImage**(GLenum target, GLint level, GLenum format, GLenum type, GLvoid * img);


; target
>  Specifies which texture is to be obtained. [_GL_TEXTURE_1D](_GL_TEXTURE_1D), [_GL_TEXTURE_2D](_GL_TEXTURE_2D), [_GL_TEXTURE_3D](_GL_TEXTURE_3D), [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY), [_GL_TEXTURE_2D_ARRAY](_GL_TEXTURE_2D_ARRAY), [_GL_TEXTURE_RECTANGLE](_GL_TEXTURE_RECTANGLE), [_GL_TEXTURE_CUBE_MAP_POSITIVE_X](_GL_TEXTURE_CUBE_MAP_POSITIVE_X), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_X](_GL_TEXTURE_CUBE_MAP_NEGATIVE_X), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Y](_GL_TEXTURE_CUBE_MAP_POSITIVE_Y), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Z](_GL_TEXTURE_CUBE_MAP_POSITIVE_Z), and [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z) are accepted.
; level
>  Specifies the level-of-detail number of the desired image. Level 0 is the base image level. Level *n* is the *n*th mipmap reduction image.
; format
>  Specifies a pixel format for the returned data. The supported formats are [_GL_STENCIL_INDEX](_GL_STENCIL_INDEX), [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT), [_GL_DEPTH_STENCIL](_GL_DEPTH_STENCIL), [_GL_RED](_GL_RED), [_GL_GREEN](_GL_GREEN), [_GL_BLUE](_GL_BLUE), [_GL_RG](_GL_RG), [_GL_RGB](_GL_RGB), [_GL_RGBA](_GL_RGBA), [_GL_BGR](_GL_BGR), [_GL_BGRA](_GL_BGRA), [_GL_RED_INTEGER](_GL_RED_INTEGER), [_GL_GREEN_INTEGER](_GL_GREEN_INTEGER), [_GL_BLUE_INTEGER](_GL_BLUE_INTEGER), [_GL_RG_INTEGER](_GL_RG_INTEGER), [_GL_RGB_INTEGER](_GL_RGB_INTEGER), [_GL_RGBA_INTEGER](_GL_RGBA_INTEGER), [_GL_BGR_INTEGER](_GL_BGR_INTEGER), [_GL_BGRA_INTEGER](_GL_BGRA_INTEGER).
; type
>  Specifies a pixel type for the returned data. The supported types are [_GL_UNSIGNED_BYTE](_GL_UNSIGNED_BYTE), [_GL_BYTE](_GL_BYTE), [_GL_UNSIGNED_SHORT](_GL_UNSIGNED_SHORT), [_GL_SHORT](_GL_SHORT), [_GL_UNSIGNED_INT](_GL_UNSIGNED_INT), [_GL_INT](_GL_INT), [_GL_HALF_FLOAT](_GL_HALF_FLOAT), [_GL_FLOAT](_GL_FLOAT), [_GL_UNSIGNED_BYTE_3_3_2](_GL_UNSIGNED_BYTE_3_3_2), [_GL_UNSIGNED_BYTE_2_3_3_REV](_GL_UNSIGNED_BYTE_2_3_3_REV), [_GL_UNSIGNED_SHORT_5_6_5](_GL_UNSIGNED_SHORT_5_6_5), [_GL_UNSIGNED_SHORT_5_6_5_REV](_GL_UNSIGNED_SHORT_5_6_5_REV), [_GL_UNSIGNED_SHORT_4_4_4_4](_GL_UNSIGNED_SHORT_4_4_4_4), [_GL_UNSIGNED_SHORT_4_4_4_4_REV](_GL_UNSIGNED_SHORT_4_4_4_4_REV), [_GL_UNSIGNED_SHORT_5_5_5_1](_GL_UNSIGNED_SHORT_5_5_5_1), [_GL_UNSIGNED_SHORT_1_5_5_5_REV](_GL_UNSIGNED_SHORT_1_5_5_5_REV), [_GL_UNSIGNED_INT_8_8_8_8](_GL_UNSIGNED_INT_8_8_8_8), [_GL_UNSIGNED_INT_8_8_8_8_REV](_GL_UNSIGNED_INT_8_8_8_8_REV), [_GL_UNSIGNED_INT_10_10_10_2](_GL_UNSIGNED_INT_10_10_10_2), [_GL_UNSIGNED_INT_2_10_10_10_REV](_GL_UNSIGNED_INT_2_10_10_10_REV), [_GL_UNSIGNED_INT_24_8](_GL_UNSIGNED_INT_24_8), [_GL_UNSIGNED_INT_10F_11F_11F_REV](_GL_UNSIGNED_INT_10F_11F_11F_REV), [_GL_UNSIGNED_INT_5_9_9_9_REV](_GL_UNSIGNED_INT_5_9_9_9_REV), and [_GL_FLOAT_32_UNSIGNED_INT_24_8_REV](_GL_FLOAT_32_UNSIGNED_INT_24_8_REV).
; img
>  Returns the texture image. Should be a pointer to an array of the type specified by type.


## Description


**_glGetTexImage** returns a texture image into img. target specifies whether the desired texture image is one specified by [_glTexImage1D](_glTexImage1D) ([_GL_TEXTURE_1D](_GL_TEXTURE_1D)), [_glTexImage2D](_glTexImage2D) ([_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY), [_GL_TEXTURE_RECTANGLE](_GL_TEXTURE_RECTANGLE), [_GL_TEXTURE_2D](_GL_TEXTURE_2D) or any of [_GL_TEXTURE_CUBE_MAP_*](_GL_TEXTURE_CUBE_MAP_*)), or [_glTexImage3D](_glTexImage3D) ([_GL_TEXTURE_2D_ARRAY](_GL_TEXTURE_2D_ARRAY), [_GL_TEXTURE_3D](_GL_TEXTURE_3D)). level specifies the level-of-detail number of the desired image. format and type specify the format and type of the desired image array. See the reference page for [_glTexImage1D](_glTexImage1D) for a description of the acceptable values for the format and type parameters, respectively.

If a non-zero named buffer object is bound to the [_GL_PIXEL_PACK_BUFFER](_GL_PIXEL_PACK_BUFFER) target (see [_glBindBuffer](_glBindBuffer)) while a texture image is requested, img is treated as a byte offset into the buffer object's data store.

To understand the operation of **_glGetTexImage**, consider the selected internal four-component texture image to be an RGBA color buffer the size of the image. The semantics of **_glGetTexImage** are then identical to those of [_glReadPixels](_glReadPixels), with the exception that no pixel transfer operations are performed, when called with the same format and type, with *x* and *y* set to 0, *width* set to the width of the texture image and *height* set to 1 for 1D images, or to the height of the texture image for 2D images.

If the selected texture image does not contain four components, the following mappings are applied. Single-component textures are treated as RGBA buffers with red set to the single-component value, green set to 0, blue set to 0, and alpha set to 1. Two-component textures are treated as RGBA buffers with red set to the value of component zero, alpha set to the value of component one, and green and blue set to 0. Finally, three-component textures are treated as RGBA buffers with red set to component zero, green set to component one, blue set to component two, and alpha set to 1.

To determine the required size of img, use [_glGetTexLevelParameter](_glGetTexLevelParameter) to determine the dimensions of the internal texture image, then scale the required number of pixels by the storage required for each pixel, based on format and type. Be sure to take the pixel storage parameters into account, especially [_GL_PACK_ALIGNMENT](_GL_PACK_ALIGNMENT).


## Notes


If an error is generated, no change is made to the contents of img.

**_glGetTexImage** returns the texture image for the active texture unit.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if target, format, or type is not an accepted value.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if level is less than 0.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) may be generated if level is greater than log<sub>2</sub>(*max*), where *max* is the returned value of [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is returned if type is one of [_GL_UNSIGNED_BYTE_3_3_2](_GL_UNSIGNED_BYTE_3_3_2), [_GL_UNSIGNED_BYTE_2_3_3_REV](_GL_UNSIGNED_BYTE_2_3_3_REV), [_GL_UNSIGNED_SHORT_5_6_5](_GL_UNSIGNED_SHORT_5_6_5), [_GL_UNSIGNED_SHORT_5_6_5_REV](_GL_UNSIGNED_SHORT_5_6_5_REV), or [_GL_UNSIGNED_INT_10F_11F_11F_REV](_GL_UNSIGNED_INT_10F_11F_11F_REV) and format is not [_GL_RGB](_GL_RGB).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is returned if type is one of [_GL_UNSIGNED_SHORT_4_4_4_4](_GL_UNSIGNED_SHORT_4_4_4_4), [_GL_UNSIGNED_SHORT_4_4_4_4_REV](_GL_UNSIGNED_SHORT_4_4_4_4_REV), [_GL_UNSIGNED_SHORT_5_5_5_1](_GL_UNSIGNED_SHORT_5_5_5_1), [_GL_UNSIGNED_SHORT_1_5_5_5_REV](_GL_UNSIGNED_SHORT_1_5_5_5_REV), [_GL_UNSIGNED_INT_8_8_8_8](_GL_UNSIGNED_INT_8_8_8_8), [_GL_UNSIGNED_INT_8_8_8_8_REV](_GL_UNSIGNED_INT_8_8_8_8_REV), [_GL_UNSIGNED_INT_10_10_10_2](_GL_UNSIGNED_INT_10_10_10_2), [_GL_UNSIGNED_INT_2_10_10_10_REV](_GL_UNSIGNED_INT_2_10_10_10_REV), or [_GL_UNSIGNED_INT_5_9_9_9_REV](_GL_UNSIGNED_INT_5_9_9_9_REV) and format is neither [_GL_RGBA](_GL_RGBA) or [_GL_BGRA](_GL_BGRA).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_PACK_BUFFER](_GL_PIXEL_PACK_BUFFER) target and the buffer object's data store is currently mapped.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_PACK_BUFFER](_GL_PIXEL_PACK_BUFFER) target and the data would be packed to the buffer object such that the memory writes required would exceed the data store size.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_PACK_BUFFER](_GL_PIXEL_PACK_BUFFER) target and img is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.


## Use With


[_glGetTexLevelParameter](_glGetTexLevelParameter) with argument [_GL_TEXTURE_WIDTH](_GL_TEXTURE_WIDTH)

[_glGetTexLevelParameter](_glGetTexLevelParameter) with argument [_GL_TEXTURE_HEIGHT](_GL_TEXTURE_HEIGHT)

[_glGetTexLevelParameter](_glGetTexLevelParameter) with argument [_GL_TEXTURE_INTERNAL_FORMAT](_GL_TEXTURE_INTERNAL_FORMAT)

[_glGet](_glGet) with arguments [_GL_PACK_ALIGNMENT](_GL_PACK_ALIGNMENT) and others

[_glGet](_glGet) with argument [_GL_PIXEL_PACK_BUFFER_BINDING](_GL_PIXEL_PACK_BUFFER_BINDING)


## See Also


[_GL](_GL)
[_glActiveTexture](_glActiveTexture), [_glBindTexture](_glBindTexture), [_glPixelStore](_glPixelStore), [_glReadPixels](_glReadPixels), [_glTexSubImage1D](_glTexSubImage1D), [_glTexSubImage2D](_glTexSubImage2D), [_glTexSubImage3D](_glTexSubImage3D)




Copyright 1991-2006 Silicon Graphics, Inc. Copyright 2010 Khronos Group. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

