**_glDrawArrays:** render primitives from array data


## Syntax


> :  SUB _glDrawArrays (BYVAL mode AS _UNSIGNED LONG, BYVAL first AS LONG, BYVAL count AS LONG)
> :  void **_glDrawArrays**(GLenum mode, GLint first, GLsizei count);


; mode
>  Specifies what kind of primitives to render. Symbolic constants [_GL_POINTS](_GL_POINTS), [_GL_LINE_STRIP](_GL_LINE_STRIP), [_GL_LINE_LOOP](_GL_LINE_LOOP), [_GL_LINES](_GL_LINES), [_GL_LINE_STRIP_ADJACENCY](_GL_LINE_STRIP_ADJACENCY), [_GL_LINES_ADJACENCY](_GL_LINES_ADJACENCY), [_GL_TRIANGLE_STRIP](_GL_TRIANGLE_STRIP), [_GL_TRIANGLE_FAN](_GL_TRIANGLE_FAN), [_GL_TRIANGLES](_GL_TRIANGLES), [_GL_TRIANGLE_STRIP_ADJACENCY](_GL_TRIANGLE_STRIP_ADJACENCY), [_GL_TRIANGLES_ADJACENCY](_GL_TRIANGLES_ADJACENCY) and [_GL_PATCHES](_GL_PATCHES) are accepted.
; first
>  Specifies the starting index in the enabled arrays.
; count
>  Specifies the number of indices to be rendered.


## Description


**_glDrawArrays** specifies multiple geometric primitives with very few subroutine calls. Instead of calling a GL procedure to pass each individual vertex, normal, texture coordinate, edge flag, or color, you can prespecify separate arrays of vertices, normals, and colors and use them to construct a sequence of primitives with a single call to **_glDrawArrays**.

When **_glDrawArrays** is called, it uses count sequential elements from each enabled array to construct a sequence of geometric primitives, beginning with element first. mode specifies what kind of primitives are constructed and how the array elements construct those primitives.

Vertex attributes that are modified by **_glDrawArrays** have an unspecified value after **_glDrawArrays** returns. Attributes that aren't modified remain well defined.


## Notes


[_GL_LINE_STRIP_ADJACENCY](_GL_LINE_STRIP_ADJACENCY), [_GL_LINES_ADJACENCY](_GL_LINES_ADJACENCY), [_GL_TRIANGLE_STRIP_ADJACENCY](_GL_TRIANGLE_STRIP_ADJACENCY) and [_GL_TRIANGLES_ADJACENCY](_GL_TRIANGLES_ADJACENCY) are available only if the GL version is 3.2 or greater.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if mode is not an accepted value.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if count is negative.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to an enabled array and the buffer object's data store is currently mapped.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a geometry shader is active and mode is incompatible with the input primitive type of the geometry shader in the currently installed program object.


## See Also


[_GL](_GL)
[_glBindVertexArray](_glBindVertexArray), [_glDrawArraysIndirect](_glDrawArraysIndirect), [_glDrawArraysInstanced](_glDrawArraysInstanced), [_glDrawArraysInstancedBaseInstance](_glDrawArraysInstancedBaseInstance), [_glMultiDrawArrays](_glMultiDrawArrays), [_glMultiDrawArraysIndirect](_glMultiDrawArraysIndirect)




