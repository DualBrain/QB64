**_glLogicOp:** specify a logical pixel operation for rendering


## Syntax


  SUB _glLogicOp (BYVAL opcode AS _UNSIGNED LONG)
  void **_glLogicOp**(GLenum opcode);


; opcode
>  Specifies a symbolic constant that selects a logical operation. The following symbols are accepted: [_GL_CLEAR](_GL_CLEAR), [_GL_SET](_GL_SET), [_GL_COPY](_GL_COPY), [_GL_COPY_INVERTED](_GL_COPY_INVERTED), [_GL_NOOP](_GL_NOOP), [_GL_INVERT](_GL_INVERT), [_GL_AND](_GL_AND), [_GL_NAND](_GL_NAND), [_GL_OR](_GL_OR), [_GL_NOR](_GL_NOR), [_GL_XOR](_GL_XOR), [_GL_EQUIV](_GL_EQUIV), [_GL_AND_REVERSE](_GL_AND_REVERSE), [_GL_AND_INVERTED](_GL_AND_INVERTED), [_GL_OR_REVERSE](_GL_OR_REVERSE), and [_GL_OR_INVERTED](_GL_OR_INVERTED). The initial value is [_GL_COPY](_GL_COPY).


## Description


**_glLogicOp** specifies a logical operation that, when enabled, is applied between the incoming RGBA color and the RGBA color at the corresponding location in the frame buffer. To enable or disable the logical operation, call [_glEnable](_glEnable) and [_glDisable](_glDisable) using the symbolic constant [_GL_COLOR_LOGIC_OP](_GL_COLOR_LOGIC_OP). The initial value is disabled.



{|
|+
! **Opcode**
! **Resulting Operation**
|+
| [_GL_CLEAR](_GL_CLEAR)
| 0
|+
| [_GL_SET](_GL_SET)
| 1
|+
| [_GL_COPY](_GL_COPY)
| s
|+
| [_GL_COPY_INVERTED](_GL_COPY_INVERTED)
| ~s
|+
| [_GL_NOOP](_GL_NOOP)
| d
|+
| [_GL_INVERT](_GL_INVERT)
| ~d
|+
| [_GL_AND](_GL_AND)
| s & d
|+
| [_GL_NAND](_GL_NAND)
| ~(s & d)
|+
| [_GL_OR](_GL_OR)
| s | d
|+
| [_GL_NOR](_GL_NOR)
| ~(s | d)
|+
| [_GL_XOR](_GL_XOR)
| s ^ d
|+
| [_GL_EQUIV](_GL_EQUIV)
| ~(s ^ d)
|+
| [_GL_AND_REVERSE](_GL_AND_REVERSE)
| s & ~d
|+
| [_GL_AND_INVERTED](_GL_AND_INVERTED)
| ~s & d
|+
| [_GL_OR_REVERSE](_GL_OR_REVERSE)
| s | ~d
|+
| [_GL_OR_INVERTED](_GL_OR_INVERTED)
| ~s | d
|}

opcode is a symbolic constant chosen from the list above. In the explanation of the logical operations, *s* represents the incoming color and *d* represents the color in the frame buffer. Standard C-language operators are used. As these bitwise operators suggest, the logical operation is applied independently to each bit pair of the source and destination colors.


## Notes


When more than one RGBA color buffer is enabled for drawing, logical operations are performed separately for each enabled buffer, using for the destination value the contents of that buffer (see [_glDrawBuffer](_glDrawBuffer)).

Logic operations have no effect on floating point draw buffers. However, if [_GL_COLOR_LOGIC_OP](_GL_COLOR_LOGIC_OP) is enabled, blending is still disabled in this case.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if opcode is not an accepted value.


## Use With


[_glGet](_glGet) with argument [_GL_LOGIC_OP_MODE](_GL_LOGIC_OP_MODE).

[_glIsEnabled](_glIsEnabled) with argument [_GL_COLOR_LOGIC_OP](_GL_COLOR_LOGIC_OP).


## See Also


[_GL](_GL)
[_glEnable](_glEnable), [_glDrawBuffer](_glDrawBuffer), [_glDrawBuffers](_glDrawBuffers), [_glStencilOp](_glStencilOp)




Copyright 1991-2006 Silicon Graphics, Inc. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

