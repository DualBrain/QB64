**_glDepthRange:** specify mapping of depth values from normalized device coordinates to window coordinates


## Syntax


> :  SUB _glDepthRange (BYVAL zNear AS DOUBLE, BYVAL zFar AS DOUBLE)

> :  void **_glDepthRange**(GLdouble nearVal, GLdouble farVal);
> :  void **_glDepthRangef**(GLfloat nearVal, GLfloat farVal);

; nearVal
>  Specifies the mapping of the near clipping plane to window coordinates. The initial value is 0.
; farVal
>  Specifies the mapping of the far clipping plane to window coordinates. The initial value is 1.


## Description


After clipping and division by *w*, depth coordinates range from -1 to 1, corresponding to the near and far clipping planes. **_glDepthRange** specifies a linear mapping of the normalized depth coordinates in this range to window depth coordinates. Regardless of the actual depth buffer implementation, window coordinate depth values are treated as though they range from 0 through 1 (like color components). Thus, the values accepted by **_glDepthRange** are both clamped to this range before they are accepted.

The setting of (0,1) maps the near plane to 0 and the far plane to 1. With this mapping, the depth buffer range is fully utilized.


## Notes


It is not necessary that nearVal be less than farVal. Reverse mappings such as *nearVal* = 1, and *farVal* = 0 are acceptable.

The type of the nearVal and farVal parameters was changed from GLclampf to GLfloat for **_glDepthRangef** and from GLclampd to GLdouble for **_glDepthRange**. This change is transparent to user code.


## Use With


[_glGet](_glGet) with argument [_GL_DEPTH_RANGE](_GL_DEPTH_RANGE)


## See Also


[_GL](_GL)
[_glDepthFunc](_glDepthFunc), [_glDepthRangeArray](_glDepthRangeArray), [_glDepthRangeIndexed](_glDepthRangeIndexed), [_glPolygonOffset](_glPolygonOffset), [_glViewport](_glViewport)




