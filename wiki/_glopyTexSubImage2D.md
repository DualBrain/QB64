**_glCopyTexSubImage2D:** copy a two-dimensional texture subimage


## Syntax


>   SUB _glCopyTexSubImage2D (BYVAL target AS _UNSIGNED LONG, BYVAL level AS LONG, BYVAL xoffset AS LONG, BYVAL yoffset AS LONG, BYVAL x AS LONG, BYVAL y AS LONG, BYVAL width AS LONG, BYVAL height AS LONG)

>   void **_glCopyTexSubImage2D**(GLenum target, GLint level, GLint xoffset, GLint yoffset, GLint x, GLint y, GLsizei width, GLsizei height);


; target
>  Specifies the target texture. Must be [_GL_TEXTURE_2D](_GL_TEXTURE_2D), [_GL_TEXTURE_CUBE_MAP_POSITIVE_X](_GL_TEXTURE_CUBE_MAP_POSITIVE_X), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_X](_GL_TEXTURE_CUBE_MAP_NEGATIVE_X), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Y](_GL_TEXTURE_CUBE_MAP_POSITIVE_Y), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Z](_GL_TEXTURE_CUBE_MAP_POSITIVE_Z), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z), or [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY).
; level
>  Specifies the level-of-detail number. Level 0 is the base image level. Level *n* is the *n*th mipmap reduction image.
; xoffset
>  Specifies a texel offset in the x direction within the texture array.
; yoffset
>  Specifies a texel offset in the y direction within the texture array.
; x, y
>  Specify the window coordinates of the lower left corner of the rectangular region of pixels to be copied.
; width
>  Specifies the width of the texture subimage.
; height
>  Specifies the height of the texture subimage.


## Description


**_glCopyTexSubImage2D** replaces a rectangular portion of a two-dimensional texture image, cube-map texture image or a linear portion of a number of slices of a one-dimensional array texture with pixels from the current [_GL_READ_BUFFER](_GL_READ_BUFFER) (rather than from main memory, as is the case for [_glTexSubImage2D](_glTexSubImage2D)).

The screen-aligned pixel rectangle with lower left corner at (*x*, *y*) and with width width and height height replaces the portion of the texture array with x indices xoffset through *xoffset + width - 1*, inclusive, and y indices yoffset through *yoffset + height - 1*, inclusive, at the mipmap level specified by level.

The pixels in the rectangle are processed exactly as if [_glReadPixels](_glReadPixels) had been called, but the process stops just before final conversion. At this point, all pixel component values are clamped to the range [0, 1] and then converted to the texture's internal format for storage in the texel array.

The destination rectangle in the texture array may not include any texels outside the texture array as it was originally specified. It is not an error to specify a subtexture with zero width or height, but such a specification has no effect.

When target is [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY) then the y coordinate and height are treated as the start slice and number of slices to modify.

If any of the pixels within the specified rectangle of the current [_GL_READ_BUFFER](_GL_READ_BUFFER) are outside the read window associated with the current rendering context, then the values obtained for those pixels are undefined.

No change is made to the *internalformat*, *width*, *height*, or *border* parameters of the specified texture array or to texel values outside the specified subregion.


## Notes


[_glPixelStore](_glPixelStore) modes affect texture images.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if target is not [_GL_TEXTURE_2D](_GL_TEXTURE_2D), [_GL_TEXTURE_CUBE_MAP_POSITIVE_X](_GL_TEXTURE_CUBE_MAP_POSITIVE_X), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_X](_GL_TEXTURE_CUBE_MAP_NEGATIVE_X), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Y](_GL_TEXTURE_CUBE_MAP_POSITIVE_Y), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Y), [_GL_TEXTURE_CUBE_MAP_POSITIVE_Z](_GL_TEXTURE_CUBE_MAP_POSITIVE_Z), [_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z](_GL_TEXTURE_CUBE_MAP_NEGATIVE_Z), or [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if the texture array has not been defined by a previous [_glTexImage2D](_glTexImage2D) or [_glCopyTexImage2D](_glCopyTexImage2D) operation.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if level is less than 0.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) may be generated if *level* is greater than log<sub>2</sub>(max), where *max* is the returned value of [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE).

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if xoffset < 0, xoffset + width > w, yoffset < 0, or yoffset + height > h, where w is the [_GL_TEXTURE_WIDTH](_GL_TEXTURE_WIDTH) and h is the [_GL_TEXTURE_HEIGHT](_GL_TEXTURE_HEIGHT) of the texture image being modified.


## Use With


[_glGetTexImage](_glGetTexImage)


## See Also


[_GL](_GL)
[_glActiveTexture](_glActiveTexture), [_glBindTexture](_glBindTexture), [_glBindFramebuffer](_glBindFramebuffer), [_glCopyImageSubData](_glCopyImageSubData), [_glCopyTexSubImage1D](_glCopyTexSubImage1D), [_glCopyTexSubImage3D](_glCopyTexSubImage3D), [_glCopyTexImage2D](_glCopyTexImage2D), [_glReadBuffer](_glReadBuffer)




