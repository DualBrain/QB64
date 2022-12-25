**_glPointSize:** specify the diameter of rasterized points


## Syntax


  SUB _glPointSize (BYVAL size AS SINGLE)
  void **_glPointSize**(GLfloat size);


; size
>  Specifies the diameter of rasterized points. The initial value is 1.


## Description


**_glPointSize** specifies the rasterized diameter of points. If point size mode is disabled (see [_glEnable](_glEnable) with parameter [_GL_PROGRAM_POINT_SIZE](_GL_PROGRAM_POINT_SIZE)), this value will be used to rasterize points. Otherwise, the value written to the shading language built-in variable gl_PointSize will be used.


## Notes


The point size specified by **_glPointSize** is always returned when [_GL_POINT_SIZE](_GL_POINT_SIZE) is queried. Clamping and rounding for points have no effect on the specified value.


## Error(s)


[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if size is less than or equal to 0.


## Use With


[_glGet](_glGet) with argument [_GL_POINT_SIZE_RANGE](_GL_POINT_SIZE_RANGE)

[_glGet](_glGet) with argument [_GL_POINT_SIZE_GRANULARITY](_GL_POINT_SIZE_GRANULARITY)

[_glGet](_glGet) with argument [_GL_POINT_SIZE](_GL_POINT_SIZE)

[_glGet](_glGet) with argument [_GL_POINT_SIZE_MIN](_GL_POINT_SIZE_MIN)

[_glGet](_glGet) with argument [_GL_POINT_SIZE_MAX](_GL_POINT_SIZE_MAX)

[_glGet](_glGet) with argument [_GL_POINT_FADE_THRESHOLD_SIZE](_GL_POINT_FADE_THRESHOLD_SIZE)

[_glIsEnabled](_glIsEnabled) with argument [_GL_PROGRAM_POINT_SIZE](_GL_PROGRAM_POINT_SIZE)


## See Also


[_GL](_GL)
[_glEnable](_glEnable), [_glPointParameter](_glPointParameter)




Copyright 1991-2006 Silicon Graphics, Inc. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

