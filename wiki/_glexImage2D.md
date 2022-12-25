**_glTexImage2D:** specify a two-dimensional texture image


## Syntax


  SUB _glTexImage2D (BYVAL target AS _UNSIGNED LONG, BYVAL level AS LONG, BYVAL internalformat AS LONG, BYVAL width AS LONG, BYVAL height AS LONG, BYVAL border AS LONG, BYVAL format AS _UNSIGNED LONG, BYVAL type AS _UNSIGNED LONG, pixels AS _OFFSET)
  void **_glTexImage2D**(GLenum target, GLint level, GLint internalFormat, GLsizei width, GLsizei height, GLint border, GLenum format, GLenum type, const GLvoid * data);


; target
>  Specifies the target texture. Must be [_GL_TEXTURE_2D](_GL_TEXTURE_2D), [_GL_PROXY_TEXTURE_2D](_GL_PROXY_TEXTURE_2D), [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY), [_GL_PROXY_TEXTURE_1D_ARRAY](_GL_PROXY_TEXTURE_1D_ARRAY), [_GL_TEXTURE_RECTANGLE](_GL_TEXTURE_RECTANGLE), [_GL_PROXY_TEXTURE_RECTANGLE](_GL_PROXY_TEXTURE_RECTANGLE), [_GL_TEXTURE_CUBE_MAP_POSITIVE_X](_GL_TEXTURE_CUBE_MAP_POSITIVE_X), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_X](_GL_TEXTURE_CUBE_MAP_NEGATIVE_X), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Y](_GL_TEXTURE_CUBE_MAP_POSITIVE_Y), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Z](_GL_TEXTURE_CUBE_MAP_POSITIVE_Z), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z), or [_GL_PROXY_TEXTURE_CUBE_MAP](_GL_PROXY_TEXTURE_CUBE_MAP).
; level
>  Specifies the level-of-detail number. Level 0 is the base image level. Level *n* is the *n*th mipmap reduction image. If target is [_GL_TEXTURE_RECTANGLE](_GL_TEXTURE_RECTANGLE) or [_GL_PROXY_TEXTURE_RECTANGLE](_GL_PROXY_TEXTURE_RECTANGLE), level must be 0.
; internalFormat
>  Specifies the number of color components in the texture. Must be one of base internal formats given in Table 1, one of the sized internal formats given in Table 2, or one of the compressed internal formats given in Table 3, below.
; width
>  Specifies the width of the texture image. All implementations support texture images that are at least 1024 texels wide.
; height
>  Specifies the height of the texture image, or the number of layers in a texture array, in the case of the [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY) and [_GL_PROXY_TEXTURE_1D_ARRAY](_GL_PROXY_TEXTURE_1D_ARRAY) targets. All implementations support 2D texture images that are at least 1024 texels high, and texture arrays that are at least 256 layers deep.
; border
>  This value must be 0.
glapi pixeltransferupparams


## Description


Texturing allows elements of an image array to be read by shaders.

To define texture images, call **_glTexImage2D**. The arguments describe the parameters of the texture image, such as height, width, width of the border, level-of-detail number (see [_glTexParameter](_glTexParameter)), and number of color components provided. The last three arguments describe how the image is represented in memory.

If target is [_GL_PROXY_TEXTURE_2D](_GL_PROXY_TEXTURE_2D), [_GL_PROXY_TEXTURE_1D_ARRAY](_GL_PROXY_TEXTURE_1D_ARRAY), [_GL_PROXY_TEXTURE_CUBE_MAP](_GL_PROXY_TEXTURE_CUBE_MAP), or [_GL_PROXY_TEXTURE_RECTANGLE](_GL_PROXY_TEXTURE_RECTANGLE), no data is read from data, but all of the texture image state is recalculated, checked for consistency, and checked against the implementation's capabilities. If the implementation cannot handle a texture of the requested texture size, it sets all of the image state to 0, but does not generate an error (see [_glGetError](_glGetError)). To query for an entire mipmap array, use an image array level greater than or equal to 1.

If target is [_GL_TEXTURE_2D](_GL_TEXTURE_2D), [_GL_TEXTURE_RECTANGLE](_GL_TEXTURE_RECTANGLE) or one of the [_GL_TEXTURE_CUBE_MAP](_GL_TEXTURE_CUBE_MAP) targets, data is read from data as a sequence of signed or unsigned bytes, shorts, or longs, or single-precision floating-point values, depending on type. These values are grouped into sets of one, two, three, or four values, depending on format, to form elements. Each data byte is treated as eight 1-bit elements, with bit ordering determined by [_GL_UNPACK_LSB_FIRST](_GL_UNPACK_LSB_FIRST) (see [_glPixelStore](_glPixelStore)).

If target is [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY), data is interpreted as an array of one-dimensional images.

If a non-zero named buffer object is bound to the [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER) target (see [_glBindBuffer](_glBindBuffer)) while a texture image is specified, data is treated as a byte offset into the buffer object's data store.

The first element corresponds to the lower left corner of the texture image. Subsequent elements progress left-to-right through the remaining texels in the lowest row of the texture image, and then in successively higher rows of the texture image. The final element corresponds to the upper right corner of the texture image.

format determines the composition of each element in data. It can assume one of these symbolic values:

; [_GL_RED](_GL_RED)
>  Each element is a single red component. The GL converts it to floating point and assembles it into an RGBA element by attaching 0 for green and blue, and 1 for alpha. Each component is then multiplied by the signed scale factor [_GL_c_SCALE](_GL_c_SCALE), added to the signed bias [_GL_c_BIAS](_GL_c_BIAS), and clamped to the range [0,1].
; [_GL_RG](_GL_RG)
>  Each element is a red/green double. The GL converts it to floating point and assembles it into an RGBA element by attaching 0 for blue, and 1 for alpha. Each component is then multiplied by the signed scale factor [_GL_c_SCALE](_GL_c_SCALE), added to the signed bias [_GL_c_BIAS](_GL_c_BIAS), and clamped to the range [0,1].
; [_GL_RGB](_GL_RGB)
>  ; [_GL_BGR](_GL_BGR)
>  Each element is an RGB triple. The GL converts it to floating point and assembles it into an RGBA element by attaching 1 for alpha. Each component is then multiplied by the signed scale factor [_GL_c_SCALE](_GL_c_SCALE), added to the signed bias [_GL_c_BIAS](_GL_c_BIAS), and clamped to the range [0,1].
; [_GL_RGBA](_GL_RGBA)
>  ; [_GL_BGRA](_GL_BGRA)
>  Each element contains all four components. Each component is multiplied by the signed scale factor [_GL_c_SCALE](_GL_c_SCALE), added to the signed bias [_GL_c_BIAS](_GL_c_BIAS), and clamped to the range [0,1].
; [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT)
>  Each element is a single depth value. The GL converts it to floating point, multiplies by the signed scale factor [_GL_DEPTH_SCALE](_GL_DEPTH_SCALE), adds the signed bias [_GL_DEPTH_BIAS](_GL_DEPTH_BIAS), and clamps to the range [0,1].
; [_GL_DEPTH_STENCIL](_GL_DEPTH_STENCIL)
>  Each element is a pair of depth and stencil values. The depth component of the pair is interpreted as in [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT). The stencil component is interpreted based on specified the depth + stencil internal format.
If an application wants to store the texture at a certain resolution or in a certain format, it can request the resolution and format with internalFormat. The GL will choose an internal representation that closely approximates that requested by internalFormat, but it may not match exactly. (The representations specified by [_GL_RED](_GL_RED), [_GL_RG](_GL_RG), [_GL_RGB](_GL_RGB), and [_GL_RGBA](_GL_RGBA) must match exactly.)

internalFormat may be one of the base internal formats shown in Table 1, below

glapi baseformattable

internalFormat may also be one of the sized internal formats shown in Table 2, below

glapi internalformattable

Finally, internalFormat may also be one of the generic or compressed compressed texture formats shown in Table 3 below

glapi compressedformattable

If the internalFormat parameter is one of the generic compressed formats, [_GL_COMPRESSED_RED](_GL_COMPRESSED_RED), [_GL_COMPRESSED_RG](_GL_COMPRESSED_RG), [_GL_COMPRESSED_RGB](_GL_COMPRESSED_RGB), or [_GL_COMPRESSED_RGBA](_GL_COMPRESSED_RGBA), the GL will replace the internal format with the symbolic constant for a specific internal format and compress the texture before storage. If no corresponding internal format is available, or the GL can not compress that image for any reason, the internal format is instead replaced with a corresponding base internal format.

If the internalFormat parameter is [_GL_SRGB](_GL_SRGB), [_GL_SRGB8](_GL_SRGB8), [_GL_SRGB_ALPHA](_GL_SRGB_ALPHA), or [_GL_SRGB8_ALPHA8](_GL_SRGB8_ALPHA8), the texture is treated as if the red, green, or blue components are encoded in the sRGB color space. Any alpha component is left unchanged. The conversion from the sRGB encoded component c<sub>s</sub> to a linear component c<sub>l</sub> is:

glapi srgb equation

Assume c<sub>s</sub> is the sRGB component in the range [0,1].

Use the [_GL_PROXY_TEXTURE_2D](_GL_PROXY_TEXTURE_2D), [_GL_PROXY_TEXTURE_1D_ARRAY](_GL_PROXY_TEXTURE_1D_ARRAY), [_GL_PROXY_TEXTURE_RECTANGLE](_GL_PROXY_TEXTURE_RECTANGLE), or [_GL_PROXY_TEXTURE_CUBE_MAP](_GL_PROXY_TEXTURE_CUBE_MAP) target to try out a resolution and format. The implementation will update and recompute its best match for the requested storage resolution and format. To then query this state, call [_glGetTexLevelParameter](_glGetTexLevelParameter). If the texture cannot be accommodated, texture state is set to 0.

A one-component texture image uses only the red component of the RGBA color extracted from data. A two-component image uses the R and G values. A three-component image uses the R, G, and B values. A four-component image uses all of the RGBA components.

Image-based shadowing can be enabled by comparing texture r coordinates to depth texture values to generate a boolean result. See [_glTexParameter](_glTexParameter) for details on texture comparison.


## Notes


The [_glPixelStore](_glPixelStore) mode affects texture images.

data may be a null pointer. In this case, texture memory is allocated to accommodate a texture of width width and height height. You can then download subtextures to initialize this texture memory. The image is undefined if the user tries to apply an uninitialized portion of the texture image to a primitive.

**_glTexImage2D** specifies the two-dimensional texture for the current texture unit, specified with [_glActiveTexture](_glActiveTexture).


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if target is not [_GL_TEXTURE_2D](_GL_TEXTURE_2D), [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY), [_GL_TEXTURE_RECTANGLE](_GL_TEXTURE_RECTANGLE), [_GL_PROXY_TEXTURE_2D](_GL_PROXY_TEXTURE_2D), [_GL_PROXY_TEXTURE_1D_ARRAY](_GL_PROXY_TEXTURE_1D_ARRAY), [_GL_PROXY_TEXTURE_RECTANGLE](_GL_PROXY_TEXTURE_RECTANGLE), [_GL_PROXY_TEXTURE_CUBE_MAP](_GL_PROXY_TEXTURE_CUBE_MAP), [_GL_TEXTURE_CUBE_MAP_POSITIVE_X](_GL_TEXTURE_CUBE_MAP_POSITIVE_X), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_X](_GL_TEXTURE_CUBE_MAP_NEGATIVE_X), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Y](_GL_TEXTURE_CUBE_MAP_POSITIVE_Y), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Z](_GL_TEXTURE_CUBE_MAP_POSITIVE_Z), or [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z).

[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if target is one of the six cube map 2D image targets and the width and height parameters are not equal.

[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if type is not a type constant.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if width is less than 0 or greater than [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if target is not [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY) or [_GL_PROXY_TEXTURE_1D_ARRAY](_GL_PROXY_TEXTURE_1D_ARRAY) and height is less than 0 or greater than [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if target is [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY) or [_GL_PROXY_TEXTURE_1D_ARRAY](_GL_PROXY_TEXTURE_1D_ARRAY) and height is less than 0 or greater than [_GL_MAX_ARRAY_TEXTURE_LAYERS](_GL_MAX_ARRAY_TEXTURE_LAYERS).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if level is less than 0.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) may be generated if level is greater than log<sub>2</sub>(*max*), where *max* is the returned value of [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if internalFormat is not one of the accepted resolution and format symbolic constants.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if width or height is less than 0 or greater than [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if border is not 0.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if type is one of [_GL_UNSIGNED_BYTE_3_3_2](_GL_UNSIGNED_BYTE_3_3_2), [_GL_UNSIGNED_BYTE_2_3_3_REV](_GL_UNSIGNED_BYTE_2_3_3_REV), [_GL_UNSIGNED_SHORT_5_6_5](_GL_UNSIGNED_SHORT_5_6_5), [_GL_UNSIGNED_SHORT_5_6_5_REV](_GL_UNSIGNED_SHORT_5_6_5_REV), or [_GL_UNSIGNED_INT_10F_11F_11F_REV](_GL_UNSIGNED_INT_10F_11F_11F_REV), and format is not [_GL_RGB](_GL_RGB).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if type is one of [_GL_UNSIGNED_SHORT_4_4_4_4](_GL_UNSIGNED_SHORT_4_4_4_4), [_GL_UNSIGNED_SHORT_4_4_4_4_REV](_GL_UNSIGNED_SHORT_4_4_4_4_REV), [_GL_UNSIGNED_SHORT_5_5_5_1](_GL_UNSIGNED_SHORT_5_5_5_1), [_GL_UNSIGNED_SHORT_1_5_5_5_REV](_GL_UNSIGNED_SHORT_1_5_5_5_REV), [_GL_UNSIGNED_INT_8_8_8_8](_GL_UNSIGNED_INT_8_8_8_8), [_GL_UNSIGNED_INT_8_8_8_8_REV](_GL_UNSIGNED_INT_8_8_8_8_REV), [_GL_UNSIGNED_INT_10_10_10_2](_GL_UNSIGNED_INT_10_10_10_2), [_GL_UNSIGNED_INT_2_10_10_10_REV](_GL_UNSIGNED_INT_2_10_10_10_REV), or [_GL_UNSIGNED_INT_5_9_9_9_REV](_GL_UNSIGNED_INT_5_9_9_9_REV), and format is neither [_GL_RGBA](_GL_RGBA) nor [_GL_BGRA](_GL_BGRA).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if target is not [_GL_TEXTURE_2D](_GL_TEXTURE_2D), [_GL_PROXY_TEXTURE_2D](_GL_PROXY_TEXTURE_2D), [_GL_TEXTURE_RECTANGLE](_GL_TEXTURE_RECTANGLE), or [_GL_PROXY_TEXTURE_RECTANGLE](_GL_PROXY_TEXTURE_RECTANGLE), and internalFormat is [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT), [_GL_DEPTH_COMPONENT16](_GL_DEPTH_COMPONENT16), [_GL_DEPTH_COMPONENT24](_GL_DEPTH_COMPONENT24), or [_GL_DEPTH_COMPONENT32F](_GL_DEPTH_COMPONENT32F).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if format is [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT) and internalFormat is not [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT), [_GL_DEPTH_COMPONENT16](_GL_DEPTH_COMPONENT16), [_GL_DEPTH_COMPONENT24](_GL_DEPTH_COMPONENT24), or [_GL_DEPTH_COMPONENT32F](_GL_DEPTH_COMPONENT32F).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if internalFormat is [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT), [_GL_DEPTH_COMPONENT16](_GL_DEPTH_COMPONENT16), [_GL_DEPTH_COMPONENT24](_GL_DEPTH_COMPONENT24), or [_GL_DEPTH_COMPONENT32F](_GL_DEPTH_COMPONENT32F), and format is not [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER) target and the buffer object's data store is currently mapped.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER) target and the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER) target and data is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if target is [_GL_TEXTURE_RECTANGLE](_GL_TEXTURE_RECTANGLE) or [_GL_PROXY_TEXTURE_RECTANGLE](_GL_PROXY_TEXTURE_RECTANGLE) and level is not 0.


## Use With


[_glGetTexImage](_glGetTexImage)

[_glGet](_glGet) with argument [_GL_PIXEL_UNPACK_BUFFER_BINDING](_GL_PIXEL_UNPACK_BUFFER_BINDING)


## See Also


[_GL](_GL)
[_glActiveTexture](_glActiveTexture), [_glBindTexture](_glBindTexture), [_glTexImage1D](_glTexImage1D), [_glTexImage2DMultisample](_glTexImage2DMultisample), [_glTexImage3D](_glTexImage3D), [_glTexImage3DMultisample](_glTexImage3DMultisample), [_glTexSubImage2D](_glTexSubImage2D), [_glPixelStore](_glPixelStore)







