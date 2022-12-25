**_glHint:** specify implementation-specific hints


## Syntax


  SUB _glHint (BYVAL target AS _UNSIGNED LONG, BYVAL mode AS _UNSIGNED LONG)
  void **_glHint**(GLenum target, GLenum mode);


; target
>  Specifies a symbolic constant indicating the behavior to be controlled. [_GL_LINE_SMOOTH_HINT](_GL_LINE_SMOOTH_HINT), [_GL_POLYGON_SMOOTH_HINT](_GL_POLYGON_SMOOTH_HINT), [_GL_TEXTURE_COMPRESSION_HINT](_GL_TEXTURE_COMPRESSION_HINT), and [_GL_FRAGMENT_SHADER_DERIVATIVE_HINT](_GL_FRAGMENT_SHADER_DERIVATIVE_HINT) are accepted.
; mode
>  Specifies a symbolic constant indicating the desired behavior. [_GL_FASTEST](_GL_FASTEST), [_GL_NICEST](_GL_NICEST), and [_GL_DONT_CARE](_GL_DONT_CARE) are accepted.


## Description


Certain aspects of GL behavior, when there is room for interpretation, can be controlled with hints. A hint is specified with two arguments. target is a symbolic constant indicating the behavior to be controlled, and mode is another symbolic constant indicating the desired behavior. The initial value for each target is [_GL_DONT_CARE](_GL_DONT_CARE). mode can be one of the following:

; [_GL_FASTEST](_GL_FASTEST)
>  
The most efficient option should be chosen.
; [_GL_NICEST](_GL_NICEST)
>  
The most correct, or highest quality, option should be chosen.
; [_GL_DONT_CARE](_GL_DONT_CARE)
>  
No preference.
Though the implementation aspects that can be hinted are well defined, the interpretation of the hints depends on the implementation. The hint aspects that can be specified with target, along with suggested semantics, are as follows:

; [_GL_FRAGMENT_SHADER_DERIVATIVE_HINT](_GL_FRAGMENT_SHADER_DERIVATIVE_HINT)
>  
Indicates the accuracy of the derivative calculation for the GL shading language fragment processing built-in functions: [_dFdx](_dFdx), [_dFdy](_dFdy), and [_fwidth](_fwidth).
; [_GL_LINE_SMOOTH_HINT](_GL_LINE_SMOOTH_HINT)
>  
Indicates the sampling quality of antialiased lines. If a larger filter function is applied, hinting [_GL_NICEST](_GL_NICEST) can result in more pixel fragments being generated during rasterization.
; [_GL_POLYGON_SMOOTH_HINT](_GL_POLYGON_SMOOTH_HINT)
>  
Indicates the sampling quality of antialiased polygons. Hinting [_GL_NICEST](_GL_NICEST) can result in more pixel fragments being generated during rasterization, if a larger filter function is applied.
; [_GL_TEXTURE_COMPRESSION_HINT](_GL_TEXTURE_COMPRESSION_HINT)
>  
Indicates the quality and performance of the compressing texture images. Hinting [_GL_FASTEST](_GL_FASTEST) indicates that texture images should be compressed as quickly as possible, while [_GL_NICEST](_GL_NICEST) indicates that texture images should be compressed with as little image quality loss as possible. [_GL_NICEST](_GL_NICEST) should be selected if the texture is to be retrieved by [_glGetCompressedTexImage](_glGetCompressedTexImage) for reuse.

## Notes


The interpretation of hints depends on the implementation. Some implementations ignore **_glHint** settings.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if either target or mode is not an accepted value.




Copyright 1991-2006 Silicon Graphics, Inc. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

