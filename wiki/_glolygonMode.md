**_glPolygonMode:** select a polygon rasterization mode


## Syntax


  SUB _glPolygonMode (BYVAL face AS _UNSIGNED LONG, BYVAL mode AS _UNSIGNED LONG)
  void **_glPolygonMode**(GLenum face, GLenum mode);


; face
>  Specifies the polygons that mode applies to. Must be [_GL_FRONT_AND_BACK](_GL_FRONT_AND_BACK) for front- and back-facing polygons.
; mode
>  Specifies how polygons will be rasterized. Accepted values are [_GL_POINT](_GL_POINT), [_GL_LINE](_GL_LINE), and [_GL_FILL](_GL_FILL). The initial value is [_GL_FILL](_GL_FILL) for both front- and back-facing polygons.


## Description


**_glPolygonMode** controls the interpretation of polygons for rasterization. face describes which polygons mode applies to: both front and back-facing polygons ([_GL_FRONT_AND_BACK](_GL_FRONT_AND_BACK)). The polygon mode affects only the final rasterization of polygons. In particular, a polygon's vertices are lit and the polygon is clipped and possibly culled before these modes are applied.

Three modes are defined and can be specified in mode:

; [_GL_POINT](_GL_POINT)
>  Polygon vertices that are marked as the start of a boundary edge are drawn as points. Point attributes such as [_GL_POINT_SIZE](_GL_POINT_SIZE) and [_GL_POINT_SMOOTH](_GL_POINT_SMOOTH) control the rasterization of the points. Polygon rasterization attributes other than [_GL_POLYGON_MODE](_GL_POLYGON_MODE) have no effect.
; [_GL_LINE](_GL_LINE)
>  Boundary edges of the polygon are drawn as line segments. Line attributes such as [_GL_LINE_WIDTH](_GL_LINE_WIDTH) and [_GL_LINE_SMOOTH](_GL_LINE_SMOOTH) control the rasterization of the lines. Polygon rasterization attributes other than [_GL_POLYGON_MODE](_GL_POLYGON_MODE) have no effect.
; [_GL_FILL](_GL_FILL)
>  The interior of the polygon is filled. Polygon attributes such as [_GL_POLYGON_SMOOTH](_GL_POLYGON_SMOOTH) control the rasterization of the polygon.
##  Examples 


To draw a surface with outlined polygons, call `glPolygonMode(, )`


## Notes


Vertices are marked as boundary or nonboundary with an edge flag. Edge flags are generated internally by the GL when it decomposes triangle stips and fans.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if either face or mode is not an accepted value.


## Use With


[_glGet](_glGet) with argument [_GL_POLYGON_MODE](_GL_POLYGON_MODE)


## See Also


[_GL](_GL)
[_glLineWidth](_glLineWidth), [_glPointSize](_glPointSize)




Copyright 1991-2006 Silicon Graphics, Inc. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

