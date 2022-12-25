**_glReadPixels:** read a block of pixels from the frame buffer


## Syntax


  SUB _glReadPixels (BYVAL x AS LONG, BYVAL y AS LONG, BYVAL width AS LONG, BYVAL height AS LONG, BYVAL format AS _UNSIGNED LONG, BYVAL type AS _UNSIGNED LONG, pixels AS _OFFSET)
  void **_glReadPixels**(GLint x, GLint y, GLsizei width, GLsizei height, GLenum format, GLenum type, GLvoid * data);


; x, y
>  Specify the window coordinates of the first pixel that is read from the frame buffer. This location is the lower left corner of a rectangular block of pixels.
; width, height
>  Specify the dimensions of the pixel rectangle. width and height of one correspond to a single pixel.
Glapi pixeltransferupparams|read=|


## Description


**_glReadPixels** returns pixel data from the frame buffer, starting with the pixel whose lower left corner is at location (x, y), into client memory starting at location data. Several parameters control the processing of the pixel data before it is placed into client memory. These parameters are set with [_glPixelStore](_glPixelStore). This reference page describes the effects on **_glReadPixels** of most, but not all of the parameters specified by these three commands.

If a non-zero named buffer object is bound to the [_GL_PIXEL_PACK_BUFFER](_GL_PIXEL_PACK_BUFFER) target (see [_glBindBuffer](_glBindBuffer)) while a block of pixels is requested, data is treated as a byte offset into the buffer object's data store rather than a pointer to client memory.

**_glReadPixels** returns values from each pixel with lower left corner at (*x* + *i*, *y* + *j*) for 0 <= *i* < *width* and 0 <= *j* < *height*. This pixel is said to be the *i*th pixel in the *j*th row. Pixels are returned in row order from the lowest to the highest row, left to right in each row.

format specifies the format for the returned pixel values; accepted values are:

; [_GL_STENCIL_INDEX](_GL_STENCIL_INDEX)
>  Stencil values are read from the stencil buffer. Each index is converted to fixed point, shifted left or right depending on the value and sign of [_GL_INDEX_SHIFT](_GL_INDEX_SHIFT), and added to [_GL_INDEX_OFFSET](_GL_INDEX_OFFSET). If [_GL_MAP_STENCIL](_GL_MAP_STENCIL) is [_GL_TRUE](_GL_TRUE), indices are replaced by their mappings in the table [_GL_PIXEL_MAP_S_TO_S](_GL_PIXEL_MAP_S_TO_S).
; [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT)
>  Depth values are read from the depth buffer. Each component is converted to floating point such that the minimum depth value maps to 0 and the maximum value maps to 1. Each component is then multiplied by [_GL_DEPTH_SCALE](_GL_DEPTH_SCALE), added to [_GL_DEPTH_BIAS](_GL_DEPTH_BIAS), and finally clamped to the range [0, 1].
; [_GL_DEPTH_STENCIL](_GL_DEPTH_STENCIL)
>  Values are taken from both the depth and stencil buffers. The type parameter must be [_GL_UNSIGNED_INT_24_8](_GL_UNSIGNED_INT_24_8) or [_GL_FLOAT_32_UNSIGNED_INT_24_8_REV](_GL_FLOAT_32_UNSIGNED_INT_24_8_REV).
; [_GL_RED](_GL_RED)
; [_GL_GREEN](_GL_GREEN)
; [_GL_BLUE](_GL_BLUE)
; [_GL_RGB](_GL_RGB)
; [_GL_BGR](_GL_BGR)
; [_GL_RGBA](_GL_RGBA)
; [_GL_BGRA](_GL_BGRA)
>  Finally, the indices or components are converted to the proper format, as specified by type. If format is [_GL_STENCIL_INDEX](_GL_STENCIL_INDEX) and type is not [_GL_FLOAT](_GL_FLOAT), each index is masked with the mask value given in the following table. If type is [_GL_FLOAT](_GL_FLOAT), then each integer index is converted to single-precision floating-point format.

If format is [_GL_RED](_GL_RED), [_GL_GREEN](_GL_GREEN), [_GL_BLUE](_GL_BLUE), [_GL_RGB](_GL_RGB), [_GL_BGR](_GL_BGR), [_GL_RGBA](_GL_RGBA), or [_GL_BGRA](_GL_BGRA) and type is not [_GL_FLOAT](_GL_FLOAT), each component is multiplied by the multiplier shown in the following table. If type is [_GL_FLOAT](_GL_FLOAT), then each component is passed as is (or converted to the client's single-precision floating-point format if it is different from the one used by the GL).

{| class="wikitable"
|+
! type
! **Index Mask**
! **Component Conversion**
|+
| [_GL_UNSIGNED_BYTE](_GL_UNSIGNED_BYTE)
| 2<sup>8</sup> - 1
| <math>(2^8 - 1)c</math>
|+
| [_GL_BYTE](_GL_BYTE)
| 2<sup>7</sup> - 1
| <math>\tfrac{(2^8 - 1)c - 1}{2}</math>
|+
| [_GL_UNSIGNED_SHORT](_GL_UNSIGNED_SHORT)
| 2<sup>16</sup> - 1
| <math>(2^{16} - 1)c</math>
|+
| [_GL_SHORT](_GL_SHORT)
| 2<sup>15</sup> - 1
| <math>\tfrac{(2^{16} - 1)c - 1}{2}</math>
|+
| [_GL_UNSIGNED_INT](_GL_UNSIGNED_INT)
| 2<sup>32</sup> - 1
| <math>(2^{32} - 1)c</math>
|+
| [_GL_INT](_GL_INT)
| 2<sup>31</sup> - 1
| <math>\tfrac{(2^{32} - 1)c - 1}{2}</math>
|+
| [_GL_HALF_FLOAT](_GL_HALF_FLOAT)
| none
| *c*
|+
| [_GL_FLOAT](_GL_FLOAT)
| none
| *c*
|+
| [_GL_UNSIGNED_BYTE_3_3_2](_GL_UNSIGNED_BYTE_3_3_2)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_BYTE_2_3_3_REV](_GL_UNSIGNED_BYTE_2_3_3_REV)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_SHORT_5_6_5](_GL_UNSIGNED_SHORT_5_6_5)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_SHORT_5_6_5_REV](_GL_UNSIGNED_SHORT_5_6_5_REV)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_SHORT_4_4_4_4](_GL_UNSIGNED_SHORT_4_4_4_4)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_SHORT_4_4_4_4_REV](_GL_UNSIGNED_SHORT_4_4_4_4_REV)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_SHORT_5_5_5_1](_GL_UNSIGNED_SHORT_5_5_5_1)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_SHORT_1_5_5_5_REV](_GL_UNSIGNED_SHORT_1_5_5_5_REV)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_INT_8_8_8_8](_GL_UNSIGNED_INT_8_8_8_8)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_INT_8_8_8_8_REV](_GL_UNSIGNED_INT_8_8_8_8_REV)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_INT_10_10_10_2](_GL_UNSIGNED_INT_10_10_10_2)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_INT_2_10_10_10_REV](_GL_UNSIGNED_INT_2_10_10_10_REV)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_INT_24_8](_GL_UNSIGNED_INT_24_8)
| 2<sup>N</sup> - 1
| <math>(2^N - 1)c</math>
|+
| [_GL_UNSIGNED_INT_10F_11F_11F_REV](_GL_UNSIGNED_INT_10F_11F_11F_REV)
| --
| Special
|+
| [_GL_UNSIGNED_INT_5_9_9_9_REV](_GL_UNSIGNED_INT_5_9_9_9_REV)
| --
| Special
|+
| [_GL_FLOAT_32_UNSIGNED_INT_24_8_REV](_GL_FLOAT_32_UNSIGNED_INT_24_8_REV)
| none
| *c* (Depth Only)
|}

Return values are placed in memory as follows. If format is [_GL_STENCIL_INDEX](_GL_STENCIL_INDEX), [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT), [_GL_RED](_GL_RED), [_GL_GREEN](_GL_GREEN), or [_GL_BLUE](_GL_BLUE), a single value is returned and the data for the *i*th pixel in the *j*th row is placed in location *j* * *width* + *i*. [_GL_RGB](_GL_RGB) and [_GL_BGR](_GL_BGR) return three values, [_GL_RGBA](_GL_RGBA) and [_GL_BGRA](_GL_BGRA) return four values for each pixel, with all values corresponding to a single pixel occupying contiguous space in data. Storage parameters set by [_glPixelStore](_glPixelStore), such as [_GL_PACK_LSB_FIRST](_GL_PACK_LSB_FIRST) and [_GL_PACK_SWAP_BYTES](_GL_PACK_SWAP_BYTES), affect the way that data is written into memory. See [_glPixelStore](_glPixelStore) for a description.


## Notes


Values for pixels that lie outside the window connected to the current GL context are undefined.

If an error is generated, no change is made to the contents of data.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if format or type is not an accepted value.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if either width or height is negative.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if format is [_GL_STENCIL_INDEX](_GL_STENCIL_INDEX) and there is no stencil buffer.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if format is [_GL_DEPTH_COMPONENT](_GL_DEPTH_COMPONENT) and there is no depth buffer.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if format is [_GL_DEPTH_STENCIL](_GL_DEPTH_STENCIL) and there is no depth buffer or if there is no stencil buffer.

[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if format is [_GL_DEPTH_STENCIL](_GL_DEPTH_STENCIL) and type is not [_GL_UNSIGNED_INT_24_8](_GL_UNSIGNED_INT_24_8) or [_GL_FLOAT_32_UNSIGNED_INT_24_8_REV](_GL_FLOAT_32_UNSIGNED_INT_24_8_REV).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if type is one of [_GL_UNSIGNED_BYTE_3_3_2](_GL_UNSIGNED_BYTE_3_3_2), [_GL_UNSIGNED_BYTE_2_3_3_REV](_GL_UNSIGNED_BYTE_2_3_3_REV), [_GL_UNSIGNED_SHORT_5_6_5](_GL_UNSIGNED_SHORT_5_6_5), or [_GL_UNSIGNED_SHORT_5_6_5_REV](_GL_UNSIGNED_SHORT_5_6_5_REV) and format is not [_GL_RGB](_GL_RGB).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if type is one of [_GL_UNSIGNED_SHORT_4_4_4_4](_GL_UNSIGNED_SHORT_4_4_4_4), [_GL_UNSIGNED_SHORT_4_4_4_4_REV](_GL_UNSIGNED_SHORT_4_4_4_4_REV), [_GL_UNSIGNED_SHORT_5_5_5_1](_GL_UNSIGNED_SHORT_5_5_5_1), [_GL_UNSIGNED_SHORT_1_5_5_5_REV](_GL_UNSIGNED_SHORT_1_5_5_5_REV), [_GL_UNSIGNED_INT_8_8_8_8](_GL_UNSIGNED_INT_8_8_8_8), [_GL_UNSIGNED_INT_8_8_8_8_REV](_GL_UNSIGNED_INT_8_8_8_8_REV), [_GL_UNSIGNED_INT_10_10_10_2](_GL_UNSIGNED_INT_10_10_10_2), or [_GL_UNSIGNED_INT_2_10_10_10_REV](_GL_UNSIGNED_INT_2_10_10_10_REV) and format is neither [_GL_RGBA](_GL_RGBA) nor [_GL_BGRA](_GL_BGRA).

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_PACK_BUFFER](_GL_PIXEL_PACK_BUFFER) target and the buffer object's data store is currently mapped.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_PACK_BUFFER](_GL_PIXEL_PACK_BUFFER) target and the data would be packed to the buffer object such that the memory writes required would exceed the data store size.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to the [_GL_PIXEL_PACK_BUFFER](_GL_PIXEL_PACK_BUFFER) target and data is not evenly divisible into the number of bytes needed to store in memory a datum indicated by type.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if [_GL_READ_FRAMEBUFFER_BINDING](_GL_READ_FRAMEBUFFER_BINDING) is non-zero, the read framebuffer is complete, and the value of [_GL_SAMPLE_BUFFERS](_GL_SAMPLE_BUFFERS) for the read framebuffer is greater than zero.


## Use With


[_glGet](_glGet) with argument [_GL_INDEX_MODE](_GL_INDEX_MODE)

[_glGet](_glGet) with argument [_GL_PIXEL_PACK_BUFFER_BINDING](_GL_PIXEL_PACK_BUFFER_BINDING)


## See Also


[_GL](_GL)
[_glBindFramebuffer](_glBindFramebuffer), [_glClampColor](_glClampColor), [_glDrawBuffers](_glDrawBuffers), [_glDrawBuffers](_glDrawBuffers), [_glPixelStore](_glPixelStore)

[Pixel Transfer](Pixel Transfer), [Pixel Buffer Object](Pixel Buffer Object)




Copyright 1991-2006 Silicon Graphics, Inc. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

