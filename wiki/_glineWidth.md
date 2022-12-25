**_glLineWidth:** specify the width of rasterized lines


## Syntax


  SUB _glLineWidth (BYVAL width AS SINGLE)
  void **_glLineWidth**(GLfloat width);


; width
>  Specifies the width of rasterized lines. The initial value is 1.


## Description


**_glLineWidth** specifies the rasterized width of both aliased and antialiased lines. Using a line width other than 1 has different effects, depending on whether line antialiasing is enabled. To enable and disable line antialiasing, call [_glEnable](_glEnable) and [_glDisable](_glDisable) with argument [_GL_LINE_SMOOTH](_GL_LINE_SMOOTH). Line antialiasing is initially disabled.

If line antialiasing is disabled, the actual width is determined by rounding the supplied width to the nearest integer. (If the rounding results in the value 0, it is as if the line width were 1.) If  <math>|\Delta X| \ge |\Delta Y|</math>, *i* pixels are filled in each column that is rasterized, where *i* is the rounded value of width. Otherwise, *i* pixels are filled in each row that is rasterized.

If antialiasing is enabled, line rasterization produces a fragment for each pixel square that intersects the region lying within the rectangle having width equal to the current line width, length equal to the actual length of the line, and centered on the mathematical line segment. The coverage value for each fragment is the window coordinate area of the intersection of the rectangular region with the corresponding pixel square. This value is saved and used in the final rasterization step.

Not all widths can be supported when line antialiasing is enabled. If an unsupported width is requested, the nearest supported width is used. Only width 1 is guaranteed to be supported; others depend on the implementation. Likewise, there is a range for aliased line widths as well. To query the range of supported widths and the size difference between supported widths within the range, call [_glGet](_glGet) with arguments [_GL_ALIASED_LINE_WIDTH_RANGE](_GL_ALIASED_LINE_WIDTH_RANGE), [_GL_SMOOTH_LINE_WIDTH_RANGE](_GL_SMOOTH_LINE_WIDTH_RANGE), and [_GL_SMOOTH_LINE_WIDTH_GRANULARITY](_GL_SMOOTH_LINE_WIDTH_GRANULARITY).


## Notes


The line width specified by **_glLineWidth** is always returned when [_GL_LINE_WIDTH](_GL_LINE_WIDTH) is queried. Clamping and rounding for aliased and antialiased lines have no effect on the specified value.

Nonantialiased line width may be clamped to an implementation-dependent maximum. Call [_glGet](_glGet) with [_GL_ALIASED_LINE_WIDTH_RANGE](_GL_ALIASED_LINE_WIDTH_RANGE) to determine the maximum width.

In OpenGL 1.2, the tokens [_GL_LINE_WIDTH_RANGE](_GL_LINE_WIDTH_RANGE) and [_GL_LINE_WIDTH_GRANULARITY](_GL_LINE_WIDTH_GRANULARITY) were replaced by [_GL_ALIASED_LINE_WIDTH_RANGE](_GL_ALIASED_LINE_WIDTH_RANGE), [_GL_SMOOTH_LINE_WIDTH_RANGE](_GL_SMOOTH_LINE_WIDTH_RANGE), and [_GL_SMOOTH_LINE_WIDTH_GRANULARITY](_GL_SMOOTH_LINE_WIDTH_GRANULARITY). The old names are retained for backward compatibility, but should not be used in new code.


## Error(s)


[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if width is less than or equal to 0.


## Use With


[_glGet](_glGet) with argument [_GL_LINE_WIDTH](_GL_LINE_WIDTH)

[_glGet](_glGet) with argument [_GL_ALIASED_LINE_WIDTH_RANGE](_GL_ALIASED_LINE_WIDTH_RANGE)

[_glGet](_glGet) with argument [_GL_SMOOTH_LINE_WIDTH_RANGE](_GL_SMOOTH_LINE_WIDTH_RANGE)

[_glGet](_glGet) with argument [_GL_SMOOTH_LINE_WIDTH_GRANULARITY](_GL_SMOOTH_LINE_WIDTH_GRANULARITY)

[_glIsEnabled](_glIsEnabled) with argument [_GL_LINE_SMOOTH](_GL_LINE_SMOOTH)


## See Also


[_GL](_GL)
[_glEnable](_glEnable)




Copyright 1991-2006 Silicon Graphics, Inc. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

