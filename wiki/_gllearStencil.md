**_glClearStencil:** specify the clear value for the stencil buffer


## Syntax


> :  SUB _glClearStencil (BYVAL s AS LONG)
> :  void **_glClearStencil**(GLint s);


; s
>  Specifies the index used when the stencil buffer is cleared. The initial value is 0.


## Description


**_glClearStencil** specifies the index used by [_glClear](_glClear) to clear the stencil buffer. s is masked with 2<sup>m</sup> - 1, where m is the number of bits in the stencil buffer.


## Use With


[_glGet](_glGet) with argument [_GL_STENCIL_CLEAR_VALUE](_GL_STENCIL_CLEAR_VALUE)

[_glGet](_glGet) with argument [_GL_STENCIL_BITS](_GL_STENCIL_BITS)


## See Also


[_GL](_GL)
[_glClear](_glClear)




