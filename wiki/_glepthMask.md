**_glDepthMask:** enable or disable writing into the depth buffer


## Syntax


> :  SUB _glDepthMask (BYVAL flag AS _UNSIGNED _BYTE)
> :  void **_glDepthMask**(GLboolean flag);


; flag
>  Specifies whether the depth buffer is enabled for writing. If flag is [_GL_FALSE](_GL_FALSE), depth buffer writing is disabled. Otherwise, it is enabled. Initially, depth buffer writing is enabled.


## Description


**_glDepthMask** specifies whether the depth buffer is enabled for writing. If flag is [_GL_FALSE](_GL_FALSE), depth buffer writing is disabled. Otherwise, it is enabled. Initially, depth buffer writing is enabled.


## Use With


[_glGet](_glGet) with argument [_GL_DEPTH_WRITEMASK](_GL_DEPTH_WRITEMASK)


## Notes


Even if the depth buffer exists and the depth mask is non-zero, the depth buffer is not updated if the depth test is disabled. In order to unconditionally write to the depth buffer, the depth test should be enabled and set to [_GL_ALWAYS](_GL_ALWAYS) (see [_glDepthFunc](_glDepthFunc)).


## See Also


[_GL](_GL)
[_glColorMask](_glColorMask), [_glClearBuffer](_glClearBuffer), [_glDepthFunc](_glDepthFunc), [_glDepthRange](_glDepthRange), [_glStencilMask](_glStencilMask)




