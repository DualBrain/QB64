**_glDepthFunc:** specify the value used for depth buffer comparisons


## Syntax


> :  SUB _glDepthFunc (BYVAL func AS _UNSIGNED LONG)
> :  void **_glDepthFunc**(GLenum func);


; func
>  Specifies the depth comparison function. Symbolic constants [_GL_NEVER](_GL_NEVER), [_GL_LESS](_GL_LESS), [_GL_EQUAL](_GL_EQUAL), [_GL_LEQUAL](_GL_LEQUAL), [_GL_GREATER](_GL_GREATER), [_GL_NOTEQUAL](_GL_NOTEQUAL), [_GL_GEQUAL](_GL_GEQUAL), and [_GL_ALWAYS](_GL_ALWAYS) are accepted. The initial value is [_GL_LESS](_GL_LESS).


## Description


**_glDepthFunc** specifies the function used to compare each incoming pixel depth value with the depth value present in the depth buffer. The comparison is performed only if depth testing is enabled. (See [_glEnable](_glEnable) and [_glDisable](_glDisable) of [_GL_DEPTH_TEST](_GL_DEPTH_TEST).)

func specifies the conditions under which the pixel will be drawn. The comparison functions are as follows:

; [_GL_NEVER](_GL_NEVER)
>  Never passes.
; [_GL_LESS](_GL_LESS)
>  Passes if the incoming depth value is less than the stored depth value.
; [_GL_EQUAL](_GL_EQUAL)
>  Passes if the incoming depth value is equal to the stored depth value.
; [_GL_LEQUAL](_GL_LEQUAL)
>  Passes if the incoming depth value is less than or equal to the stored depth value.
; [_GL_GREATER](_GL_GREATER)
>  Passes if the incoming depth value is greater than the stored depth value.
; [_GL_NOTEQUAL](_GL_NOTEQUAL)
>  Passes if the incoming depth value is not equal to the stored depth value.
; [_GL_GEQUAL](_GL_GEQUAL)
>  Passes if the incoming depth value is greater than or equal to the stored depth value.
; [_GL_ALWAYS](_GL_ALWAYS)
>  Always passes.
The initial value of func is [_GL_LESS](_GL_LESS). Initially, depth testing is disabled. If depth testing is disabled or if no depth buffer exists, it is as if the depth test always passes.


## Notes


Even if the depth buffer exists and the depth mask is non-zero, the depth buffer is not updated if the depth test is disabled. In order to unconditionally write to the depth buffer, the depth test should be enabled and set to [_GL_ALWAYS](_GL_ALWAYS).


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if func is not an accepted value.


## Use With


[_glGet](_glGet) with argument [_GL_DEPTH_FUNC](_GL_DEPTH_FUNC)

[_glIsEnabled](_glIsEnabled) with argument [_GL_DEPTH_TEST](_GL_DEPTH_TEST)


## See Also


[_GL](_GL)
[_glEnable](_glEnable), [_glDepthRange](_glDepthRange), [_glPolygonOffset](_glPolygonOffset)




