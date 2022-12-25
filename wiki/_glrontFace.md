**_glFrontFace:** define front- and back-facing polygons


## Syntax


  SUB _glFrontFace (BYVAL mode AS _UNSIGNED LONG)
  void **_glFrontFace**(GLenum mode);


; mode
>  Specifies the orientation of front-facing polygons. [_GL_CW](_GL_CW) and [_GL_CCW](_GL_CCW) are accepted. The initial value is [_GL_CCW](_GL_CCW).


## Description


In a scene composed entirely of opaque closed surfaces, back-facing polygons are never visible. Eliminating these invisible polygons has the obvious benefit of speeding up the rendering of the image. To enable and disable elimination of back-facing polygons, call [_glEnable](_glEnable) and [_glDisable](_glDisable) with argument [_GL_CULL_FACE](_GL_CULL_FACE).

The projection of a polygon to window coordinates is said to have clockwise winding if an imaginary object following the path from its first vertex, its second vertex, and so on, to its last vertex, and finally back to its first vertex, moves in a clockwise direction about the interior of the polygon. The polygon's winding is said to be counterclockwise if the imaginary object following the same path moves in a counterclockwise direction about the interior of the polygon. **_glFrontFace** specifies whether polygons with clockwise winding in window coordinates, or counterclockwise winding in window coordinates, are taken to be front-facing. Passing [_GL_CCW](_GL_CCW) to mode selects counterclockwise polygons as front-facing; [_GL_CW](_GL_CW) selects clockwise polygons as front-facing. By default, counterclockwise polygons are taken to be front-facing.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if mode is not an accepted value.


## Use With


[_glGet](_glGet) with argument [_GL_FRONT_FACE](_GL_FRONT_FACE)


## See Also


[_GL](_GL)
[_glCullFace](_glCullFace)




Copyright 1991-2006 Silicon Graphics, Inc. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

