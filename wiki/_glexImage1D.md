**_glTexImage1D:** specify a one-dimensional texture image


## Syntax


  SUB _glTexImage1D (BYVAL target AS _UNSIGNED LONG, BYVAL level AS LONG, BYVAL internalformat AS LONG, BYVAL width AS LONG, BYVAL border AS LONG, BYVAL format AS _UNSIGNED LONG, BYVAL type AS _UNSIGNED LONG, pixels AS _OFFSET)
  void **_glTexImage1D**(GLenum target, GLint level, GLint internalFormat, GLsizei width, GLint border, GLenum format, GLenum type, const GLvoid * data);


; target
>  Specifies the target texture. Must be [_GL_TEXTURE_1D](_GL_TEXTURE_1D) or [_GL_PROXY_TEXTURE_1D](_GL_PROXY_TEXTURE_1D).
; level
>  Specifies the level-of-detail number. Level 0 is the base image level. Level *n* is the *n*th mipmap reduction image.
; internalFormat
>  Specifies the number of color components in the texture. Must be one of base internal formats given in Table 1, one of the sized internal formats given in Table 2, or one of the compressed internal formats given in Table 3, below.
; width
>  Specifies the width of the texture image. All implementations support texture images that are at least 1024 texels wide. The height of the 1D texture image is 1.
; border
>  This value must be 0.
glapi pixeltransferupparams|


## Description


Texturing maps a portion of a specified texture image onto each graphical primitive for which texturing is enabled. To enable and disable one-dimensional texturing, call [_glEnable](_glEnable) and [_glDisable](_glDisable) with argument [_GL_TEXTURE_1D](_GL_TEXTURE_1D).

Texture images are defined with **_glTexImage1D**. The arguments describe the parameters of the texture image, such as width, width of the border, level-of-detail number (see [_glTexParameter](_glTexParameter)), and the internal resolution and format used to store the image. The last three arguments describe how the image is represented in memory.

If target is [_GL_PROXY_TEXTURE_1D](_GL_PROXY_TEXTURE_1D), no data is read from data, but all of the texture image state is recalculated, checked for consistency, and checked against the implementation's capabilities. If the implementation cannot handle a texture of the requested texture size, it sets all of the image state to 0, but does not generate an error (see [_glGetError](_glGetError)). To query for an entire mipmap array, use an image array level greater than or equal to 1.

If target is [_GL_TEXTURE_1D](_GL_TEXTURE_1D), data is read from data as a sequence of signed or unsigned bytes, shorts, or longs, or single-precision floating-point values, depending on type. These values are grouped into sets of one, two, three, or four values, depending on format, to form elements. Each data byte is treated as eight 1-bit elements, with bit ordering determined by [_GL_UNPACK_LSB_FIRST](_GL_UNPACK_LSB_FIRST) (see [_glPixelStore](_glPixelStore)).

If a non-zero named buffer object is bound to the [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER) target (see [_glBindBuffer](_glBindBuffer)) while a texture image is specified, data is treated as a byte offset into the buffer object's data store.

The first element corresponds to the left end of the texture array. Subsequent elements progress left-to-right through the remaining texels in the texture array. The final element corresponds to the right end of the texture array.

format determines the composition of each element in data. It can assume one of these symbolic values:

; [_GL_RED](_GL_RED)
>  Each element is a single red component. The GL converts it to floating point and assembles it into an RGBA element by attaching 0 for green and blue, and 1 for alpha. Each component is then multiplied by the signed scale factor [_GL_c_SCALE](_GL_c_SCALE), added to the signed bias [_GL_c_BIAS](_GL_c_BIAS), and clamped to the range [0,1].
; [_GL_RG](_GL_RG)
>  Each element is a red/green pair. The GL converts it to floating point and assembles it into an RGBA element by attaching 0 for blue, and 1 for alpha. Each component is then multiplied by the signed scale factor [_GL_c_SCALE](_GL_c_SCALE), added to the signed bias [_GL_c_BIAS](_GL_c_BIAS), and clamped to the range [0,1].
; [_GL_RGB](_GL_RGB) or [_GL_BGR](_GL_BGR)
>  Each element is an RGB triple. The GL converts it to floating point and assembles it into an RGBA element by attaching 1 for alpha. Each component is then multiplied by the signed scale factor [_GL_c_SCALE](_GL_c_SCALE), added to the signed bias [_GL_c_BIAS](_GL_c_BIAS), and clamped to the range [0,1].
; [_GL_RGBA](_GL_RGBA) or [_GL_BGRA](_GL_BGRA)
>  Each element contains all four components. Each component is multiplied by the signed scale factor [_GL_c_SCALE](_GL_c_SCALE), added to the signed bias [_GL_c_BIAS](_GL_c_BIAS), and clamped to the range [0,1].
; [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT)
>  Each element is a single depth value. The GL converts it to floating point, multiplies by the signed scale factor [_GL_DEPTH_SCALE](_GL_DEPTH_SCALE), adds the signed bias [_GL_DEPTH_BIAS](_GL_DEPTH_BIAS), and clamps to the range [0,1].
If an application wants to store the texture at a certain resolution or in a certain format, it can request the resolution and format with internalFormat. The GL will choose an internal representation that closely approximates that requested by internalFormat, but it may not match exactly. (The representations specified by [_GL_RED](_GL_RED), [_GL_RG](_GL_RG), [_GL_RGB](_GL_RGB) and [_GL_RGBA](_GL_RGBA) must match exactly.)

internalFormat may be one of the base internal formats shown in Table 1, below

glapi baseformattable

internalFormat may also be one of the sized internal formats shown in Table 2, below

glapi internalformattable

Finally, internalFormat may also be one of the generic or compressed compressed texture formats shown in Table 3 below

glapi compressedformattable

If the internalFormat parameter is one of the generic compressed formats, [_GL_COMPRESSED_RED](_GL_COMPRESSED_RED), [_GL_COMPRESSED_RG](_GL_COMPRESSED_RG), [_GL_COMPRESSED_RGB](_GL_COMPRESSED_RGB), or [_GL_COMPRESSED_RGBA](_GL_COMPRESSED_RGBA), the GL will replace the internal format with the symbolic constant for a specific internal format and compress the texture before storage. If no corresponding internal format is available, or the GL can not compress that image for any reason, the internal format is instead replaced with a corresponding base internal format.

If the internalFormat parameter is [_GL_SRGB](_GL_SRGB), [_GL_SRGB8](_GL_SRGB8), [_GL_SRGB_ALPHA](_GL_SRGB_ALPHA)or [_GL_SRGB8_ALPHA8](_GL_SRGB8_ALPHA8), the texture is treated as if the red, green, or blue components are encoded in the sRGB color space. Any alpha component is left unchanged. The conversion from the sRGB encoded component c<sub>s</sub> to a linear component c<sub>l</sub> is:

glapi srgb equation

Assume c<sub>s</sub> is the sRGB component in the range [0,1].

Use the [_GL_PROXY_TEXTURE_1D](_GL_PROXY_TEXTURE_1D) target to try out a resolution and format. The implementation will update and recompute its best match for the requested storage resolution and format. To then query this state, call [_glGetTexLevelParameter](_glGetTexLevelParameter). If the texture cannot be accommodated, texture state is set to 0.

A one-component texture image uses only the red component of the RGBA color from data. A two-component image uses the R and A values. A three-component image uses the R, G, and B values. A four-component image uses all of the RGBA components.

Image-based shadowing can be enabled by comparing texture r coordinates to depth texture values to generate a boolean result. See [_glTexParameter](_glTexParameter) for details on texture comparison.


## Notes


[_glPixelStore](_glPixelStore) modes affect texture images.

data may be a null pointer. In this case texture memory is allocated to accommodate a texture of width width. You can then download subtextures to initialize the texture memory. The image is undefined if the program tries to apply an uninitialized portion of the texture image to a primitive.

**_glTexImage1D** specifies the one-dimensional texture for the current texture unit, specified with [_glActiveTexture](_glActiveTexture).


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if target is not [_GL_TEXTURE_1D](_GL_TEXTURE_1D) or [_GL_PROXY_TEXTURE_1D](_GL_PROXY_TEXTURE_1D).

[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if format is not an accepted format constant. Format constants other than [_GL_STENCIL_INDEX](_GL_STENCIL_INDEX) are accepted.

[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if type is not a type constant.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if level is less than 0.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) may be generated if level is greater than log<sub>2</sub>(*max*), where *max* is the returned value of [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if internalFormat is not one of the accepted resolution and format symbolic constants.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if width is less than 0 or greater than [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if border is not 0.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if type is one of [_GL_UNSIGNED_BYTE_3_3_2](_GL_UNSIGNED_BYTE_3_3_2), [_GL_UNSIGNED_BYTE_2_3_3_REV](_GL_UNSIGNED_BYTE_2_3_3_REV), [_GL_UNSIGNED_SHORT_5_6_5](_GL_UNSIGNED_SHORT_5_6_5), or [_GL_UNSIGNED_SHORT_5_6_5_REV](_GL_UNSIGNED_SHORT_5_6_5_REV) and format is not [_GL_RGB](_GL_RGB).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if type is one of [_GL_UNSIGNED_SHORT_4_4_4_4](_GL_UNSIGNED_SHORT_4_4_4_4), [_GL_UNSIGNED_SHORT_4_4_4_4_REV](_GL_UNSIGNED_SHORT_4_4_4_4_REV), [_GL_UNSIGNED_SHORT_5_5_5_1](_GL_UNSIGNED_SHORT_5_5_5_1), [_GL_UNSIGNED_SHORT_1_5_5_5_REV](_GL_UNSIGNED_SHORT_1_5_5_5_REV), [_GL_UNSIGNED_INT_8_8_8_8](_GL_UNSIGNED_INT_8_8_8_8), [_GL_UNSIGNED_INT_8_8_8_8_REV](_GL_UNSIGNED_INT_8_8_8_8_REV), [_GL_UNSIGNED_INT_10_10_10_2](_GL_UNSIGNED_INT_10_10_10_2), or [_GL_UNSIGNED_INT_2_10_10_10_REV](_GL_UNSIGNED_INT_2_10_10_10_REV) and format is neither [_GL_RGBA](_GL_RGBA) nor [_GL_BGRA](_GL_BGRA).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if format is [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT) and internalFormat is not [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT), [_GL_DEPTH_COMPONENT16](_GL_DEPTH_COMPONENT16), [_GL_DEPTH_COMPONENT24](_GL_DEPTH_COMPONENT24), or [_GL_DEPTH_COMPONENT32](_GL_DEPTH_COMPONENT32).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if internalFormat is [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT), [_GL_DEPTH_COMPONENT16](_GL_DEPTH_COMPONENT16), [_GL_DEPTH_COMPONENT24](_GL_DEPTH_COMPONENT24), or [_GL_DEPTH_COMPONENT32](_GL_DEPTH_COMPONENT32), and format is not [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER) target and the buffer object's data store is currently mapped.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER) target and the data would be unpacked from the buffer object such that the memory reads required would exceed the data store size.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER) target and data is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.


## Use With


[_glGetTexImage](_glGetTexImage)

[_glGet](_glGet) with argument [_GL_PIXEL_UNPACK_BUFFER_BINDING](_GL_PIXEL_UNPACK_BUFFER_BINDING)


## See Also


[_GL](_GL)
[_glActiveTexture](_glActiveTexture), [_glBindTexture](_glBindTexture), [_glTexBuffer](_glTexBuffer), [_glTexBufferRange](_glTexBufferRange), [_glTexImage2D](_glTexImage2D), [_glTexImage2DMultisample](_glTexImage2DMultisample), [_glTexImage3D](_glTexImage3D), [_glTexImage3DMultisample](_glTexImage3DMultisample), [_glTexSubImage1D](_glTexSubImage1D), [_glPixelStore](_glPixelStore)







