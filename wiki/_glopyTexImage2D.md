**_glCopyTexImage2D:** copy pixels into a 2D texture image


## Syntax


>   SUB _glCopyTexImage2D (BYVAL target AS _UNSIGNED LONG, BYVAL level AS LONG, BYVAL internalFormat AS _UNSIGNED LONG, BYVAL x AS LONG, BYVAL y AS LONG, BYVAL width AS LONG, BYVAL height AS LONG, BYVAL border AS LONG)
>   void **_glCopyTexImage2D**(GLenum target, GLint level, GLenum internalformat, GLint x, GLint y, GLsizei width, GLsizei height, GLint border);


; target
>  Specifies the target texture. Must be [_GL_TEXTURE_2D](_GL_TEXTURE_2D), [_GL_TEXTURE_CUBE_MAP_POSITIVE_X](_GL_TEXTURE_CUBE_MAP_POSITIVE_X), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_X](_GL_TEXTURE_CUBE_MAP_NEGATIVE_X), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Y](_GL_TEXTURE_CUBE_MAP_POSITIVE_Y), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Z](_GL_TEXTURE_CUBE_MAP_POSITIVE_Z), or [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z).
; level
>  Specifies the level-of-detail number. Level 0 is the base image level. Level *n* is the *n*th mipmap reduction image.
; internalformat
>  Specifies the internal format of the texture. Must be one of the following symbolic constants: [_GL_COMPRESSED_RED](_GL_COMPRESSED_RED), [_GL_COMPRESSED_RG](_GL_COMPRESSED_RG), [_GL_COMPRESSED_RGB](_GL_COMPRESSED_RGB), [_GL_COMPRESSED_RGBA](_GL_COMPRESSED_RGBA). [_GL_COMPRESSED_SRGB](_GL_COMPRESSED_SRGB), [_GL_COMPRESSED_SRGB_ALPHA](_GL_COMPRESSED_SRGB_ALPHA). [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT), [_GL_DEPTH_COMPONENT16](_GL_DEPTH_COMPONENT16), [_GL_DEPTH_COMPONENT24](_GL_DEPTH_COMPONENT24), [_GL_DEPTH_COMPONENT32](_GL_DEPTH_COMPONENT32), [_GL_RED](_GL_RED), [_GL_RG](_GL_RG), [_GL_RGB](_GL_RGB), [_GL_R3_G3_B2](_GL_R3_G3_B2), [_GL_RGB4](_GL_RGB4), [_GL_RGB5](_GL_RGB5), [_GL_RGB8](_GL_RGB8), [_GL_RGB10](_GL_RGB10), [_GL_RGB12](_GL_RGB12), [_GL_RGB16](_GL_RGB16), [_GL_RGBA](_GL_RGBA), [_GL_RGBA2](_GL_RGBA2), [_GL_RGBA4](_GL_RGBA4), [_GL_RGB5_A1](_GL_RGB5_A1), [_GL_RGBA8](_GL_RGBA8), [_GL_RGB10_A2](_GL_RGB10_A2), [_GL_RGBA12](_GL_RGBA12), [_GL_RGBA16](_GL_RGBA16), [_GL_SRGB](_GL_SRGB), [_GL_SRGB8](_GL_SRGB8), [_GL_SRGB_ALPHA](_GL_SRGB_ALPHA), or [_GL_SRGB8_ALPHA8](_GL_SRGB8_ALPHA8).
; x, y
>  Specify the window coordinates of the lower left corner of the rectangular region of pixels to be copied.
; width
>  Specifies the width of the texture image.
; height
>  Specifies the height of the texture image.
; border
>  This value must be 0.


## Description


**_glCopyTexImage2D** defines a two-dimensional texture image, or cube-map texture image with pixels from the current [_GL_READ_BUFFER](_GL_READ_BUFFER).

The screen-aligned pixel rectangle with lower left corner at (x, y) and with a width of width and a height of height defines the texture array at the mipmap level specified by level. internalformat specifies the internal format of the texture array.

The pixels in the rectangle are processed exactly as if [_glReadPixels](_glReadPixels) had been called, but the process stops just before final conversion. At this point all pixel component values are clamped to the range [0, 1] and then converted to the texture's internal format for storage in the texel array.

Pixel ordering is such that lower x and y screen coordinates correspond to lower s and t texture coordinates.

If any of the pixels within the specified rectangle of the current [_GL_READ_BUFFER](_GL_READ_BUFFER) are outside the window associated with the current rendering context, then the values obtained for those pixels are undefined.

When internalformat is one of the sRGB types, the GL does not automatically convert the source pixels to the sRGB color space. In this case, the **_glPixelMap** function can be used to accomplish the conversion.


## Notes


1, 2, 3, and 4 are not accepted values for internalformat.

An image with height or width of 0 indicates a NULL texture.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if target is not [_GL_TEXTURE_2D](_GL_TEXTURE_2D), [_GL_TEXTURE_CUBE_MAP_POSITIVE_X](_GL_TEXTURE_CUBE_MAP_POSITIVE_X), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_X](_GL_TEXTURE_CUBE_MAP_NEGATIVE_X), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Y](_GL_TEXTURE_CUBE_MAP_POSITIVE_Y), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Z](_GL_TEXTURE_CUBE_MAP_POSITIVE_Z), or [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if level is less than 0.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) may be generated if level is greater than log<sub>2</sub>(max}, where max is the returned value of [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if width is less than 0 or greater than [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if border is not 0.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if internalformat is not an accepted format.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if internalformat is [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT), [_GL_DEPTH_COMPONENT16](_GL_DEPTH_COMPONENT16), [_GL_DEPTH_COMPONENT24](_GL_DEPTH_COMPONENT24), or [_GL_DEPTH_COMPONENT32](_GL_DEPTH_COMPONENT32) and there is no depth buffer.


## Use With


[_glGetTexImage](_glGetTexImage)


## See Also


[_GL](_GL)
[_glActiveTexture](_glActiveTexture), [_glBindTexture](_glBindTexture), [_glBindFramebuffer](_glBindFramebuffer), [_glCopyTexImage1D](_glCopyTexImage1D), [_glCopyImageSubData](_glCopyImageSubData), [_glCopyTexSubImage1D](_glCopyTexSubImage1D), [_glCopyTexSubImage2D](_glCopyTexSubImage2D), [_glReadBuffer](_glReadBuffer)




