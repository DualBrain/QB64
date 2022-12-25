**_glClearColor:** specify clear values for the color buffers


## Syntax


> : SUB **_glClearColor** (BYVAL red AS SINGLE, BYVAL green AS SINGLE, BYVAL blue AS SINGLE, BYVAL alpha AS SINGLE)
> : void **_glClearColor**(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);


; red, green, blue, alpha
>  Specify the red, green, blue, and alpha values used when the color buffers are cleared. The initial values are all 0.


## Description


**_glClearColor** specifies the red, green, blue, and alpha values used by [_glClear](_glClear) to clear the color buffers.


## Notes


The type of the red, green, blue, and alpha parameters was changed from GLclampf to GLfloat. This change is transparent to user code.


## Use With


[_glGet](_glGet) with argument [_GL_COLOR_CLEAR_VALUE](_GL_COLOR_CLEAR_VALUE)

## See Also


[_GL](_GL)
[_glClear](_glClear)




