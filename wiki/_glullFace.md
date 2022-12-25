**_glCullFace:** specify whether front- or back-facing facets can be culled


## Syntax


> :SUB **_glCullFace** (BYVAL mode AS _UNSIGNED LONG)
> : void **_glCullFace**(GLenum mode);


; mode
>  Specifies whether front- or back-facing facets are candidates for culling. Symbolic constants [_GL_FRONT](_GL_FRONT), [_GL_BACK](_GL_BACK), and [_GL_FRONT_AND_BACK](_GL_FRONT_AND_BACK) are accepted. The initial value is [_GL_BACK](_GL_BACK).


## Description


**_glCullFace** specifies whether front- or back-facing facets are culled (as specified by *mode*) when facet culling is enabled. Facet culling is initially disabled. To enable and disable facet culling, call the [_glEnable](_glEnable) and [_glDisable](_glDisable) commands with the argument [_GL_CULL_FACE](_GL_CULL_FACE). Facets include triangles, quadrilaterals, polygons, and rectangles.

[_glFrontFace](_glFrontFace) specifies which of the clockwise and counterclockwise facets are front-facing and back-facing. See [_glFrontFace](_glFrontFace).


## Notes


If mode is [_GL_FRONT_AND_BACK](_GL_FRONT_AND_BACK), no facets are drawn, but other primitives such as points and lines are drawn.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if mode is not an accepted value.


## Use With


[_glIsEnabled](_glIsEnabled) with argument [_GL_CULL_FACE](_GL_CULL_FACE)

[_glGet](_glGet) with argument [_GL_CULL_FACE_MODE](_GL_CULL_FACE_MODE)


## See Also


[_GL](_GL)
[_glEnable](_glEnable), [_glFrontFace](_glFrontFace)




