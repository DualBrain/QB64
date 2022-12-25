**_glClearDepth:** specify the clear value for the depth buffer


## Syntax


> : SUB _glClearDepth (BYVAL depth AS DOUBLE)
> : void **_glClearDepth**(GLdouble depth);
> : void **_glClearDepthf**(GLfloat depth);

; depth
>  Specifies the depth value used when the depth buffer is cleared. The initial value is 1.


## Description


**_glClearDepth** specifies the depth value used by [_glClear](_glClear) to clear the depth buffer. Values specified by **_glClearDepth** are clamped to the range [0, 1].


## Notes


The type of the depth parameter was changed from GLclampf to GLfloat for **_glClearDepthf** and from GLclampd to GLdouble for **_glClearDepth**. This change is transparent to user code.


## Use With


[_glGet](_glGet) with argument [_GL_DEPTH_CLEAR_VALUE](_GL_DEPTH_CLEAR_VALUE)

## See Also


[_GL](_GL)
[_glClear](_glClear)




