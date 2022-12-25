**_glStencilMask:** control the front and back writing of individual bits in the stencil planes


## Syntax


  SUB _glStencilMask (BYVAL mask AS _UNSIGNED LONG)
  void **_glStencilMask**(GLuint mask);


; mask
>  Specifies a bit mask to enable and disable writing of individual bits in the stencil planes. Initially, the mask is all 1's.


## Description


**_glStencilMask** controls the writing of individual bits in the stencil planes. The least significant *n* bits of mask, where *n* is the number of bits in the stencil buffer, specify a mask. Where a 1 appears in the mask, it's possible to write to the corresponding bit in the stencil buffer. Where a 0 appears, the corresponding bit is write-protected. Initially, all bits are enabled for writing.

There can be two separate mask writemasks; one affects back-facing polygons, and the other affects front-facing polygons as well as other non-polygon primitives. [_glStencilMask](_glStencilMask) sets both front and back stencil writemasks to the same values. Use [_glStencilMaskSeparate](_glStencilMaskSeparate) to set front and back stencil writemasks to different values.


## Notes


[_glStencilMask](_glStencilMask) is the same as calling [_glStencilMaskSeparate](_glStencilMaskSeparate) with face set to [_GL_FRONT_AND_BACK](_GL_FRONT_AND_BACK).


## Use With


[_glGet](_glGet) with argument [_GL_STENCIL_WRITEMASK](_GL_STENCIL_WRITEMASK), [_GL_STENCIL_BACK_WRITEMASK](_GL_STENCIL_BACK_WRITEMASK), or [_GL_STENCIL_BITS](_GL_STENCIL_BITS)


## See Also


[_GL](_GL)
[_glClear](_glClear), [_glClearBuffer](_glClearBuffer), [_glColorMask](_glColorMask), [_glDepthMask](_glDepthMask), [_glStencilFunc](_glStencilFunc), [_glStencilFuncSeparate](_glStencilFuncSeparate), [_glStencilMaskSeparate](_glStencilMaskSeparate), [_glStencilOp](_glStencilOp), [_glStencilOpSeparate](_glStencilOpSeparate)







