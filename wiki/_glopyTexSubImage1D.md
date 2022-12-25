**_glCopyTexSubImage1D:** copy a one-dimensional texture subimage


## Syntax


>   SUB _glCopyTexSubImage1D (BYVAL target AS _UNSIGNED LONG, BYVAL level AS LONG, BYVAL xoffset AS LONG, BYVAL x AS LONG, BYVAL y AS LONG, BYVAL width AS LONG)

>   void **_glCopyTexSubImage1D**(GLenum target, GLint level, GLint xoffset, GLint x, GLint y, GLsizei width);


; target
>  Specifies the target texture. Must be [_GL_TEXTURE_1D](_GL_TEXTURE_1D).
; level
>  Specifies the level-of-detail number. Level 0 is the base image level. Level *n* is the *n*th mipmap reduction image.
; xoffset
>  Specifies the texel offset within the texture array.
; x, y
>  Specify the window coordinates of the left corner of the row of pixels to be copied.
; width
>  Specifies the width of the texture subimage.


## Description


**_glCopyTexSubImage1D** replaces a portion of a one-dimensional texture image with pixels from the current [_GL_READ_BUFFER](_GL_READ_BUFFER) (rather than from main memory, as is the case for [_glTexSubImage1D](_glTexSubImage1D)).

The screen-aligned pixel row with left corner at (x,\ y), and with length width replaces the portion of the texture array with x indices xoffset through *xoffset + width - 1*, inclusive. The destination in the texture array may not include any texels outside the texture array as it was originally specified.

The pixels in the row are processed exactly as if [_glReadPixels](_glReadPixels) had been called, but the process stops just before final conversion. At this point, all pixel component values are clamped to the range [0, 1] and then converted to the texture's internal format for storage in the texel array.

It is not an error to specify a subtexture with zero width, but such a specification has no effect. If any of the pixels within the specified row of the current [_GL_READ_BUFFER](_GL_READ_BUFFER) are outside the read window associated with the current rendering context, then the values obtained for those pixels are undefined.

No change is made to the *internalformat*, *width*, or *border* parameters of the specified texture array or to texel values outside the specified subregion.


## Notes


The [_glPixelStore](_glPixelStore) mode affects texture images.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if /target is not [_GL_TEXTURE_1D](_GL_TEXTURE_1D).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if the texture array has not been defined by a previous [_glTexImage1D](_glTexImage1D) or [_glCopyTexImage1D](_glCopyTexImage1D) operation.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if level is less than 0.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) may be generated if *level* is greater than log<sub>2</sub>(max), where *max* is the returned value of [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if xoffset < 0 or xoffset + width > w, where w is the [_GL_TEXTURE_WIDTH](_GL_TEXTURE_WIDTH).


## Use With


[_glGetTexImage](_glGetTexImage)


## See Also


[_GL](_GL)
[_glActiveTexture](_glActiveTexture), [_glBindTexture](_glBindTexture), [_glBindFramebuffer](_glBindFramebuffer), [_glCopyImageSubData](_glCopyImageSubData), [_glCopyTexSubImage2D](_glCopyTexSubImage2D), [_glCopyTexSubImage3D](_glCopyTexSubImage3D), [_glCopyTexImage1D](_glCopyTexImage1D), [_glReadBuffer](_glReadBuffer)




