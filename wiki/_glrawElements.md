**_glDrawElements:** render primitives from array data


## Syntax


>   SUB _glDrawElements (BYVAL mode AS _UNSIGNED LONG, BYVAL count AS LONG, BYVAL type AS _UNSIGNED LONG, indices AS _OFFSET)
>   void **_glDrawElements**(GLenum mode, GLsizei count, GLenum type, const GLvoid * indices);


; mode
>  Specifies what kind of primitives to render. Symbolic constants [_GL_POINTS](_GL_POINTS), [_GL_LINE_STRIP](_GL_LINE_STRIP), [_GL_LINE_LOOP](_GL_LINE_LOOP), [_GL_LINES](_GL_LINES), [_GL_LINE_STRIP_ADJACENCY](_GL_LINE_STRIP_ADJACENCY), [_GL_LINES_ADJACENCY](_GL_LINES_ADJACENCY), [_GL_TRIANGLE_STRIP](_GL_TRIANGLE_STRIP), [_GL_TRIANGLE_FAN](_GL_TRIANGLE_FAN), [_GL_TRIANGLES](_GL_TRIANGLES), [_GL_TRIANGLE_STRIP_ADJACENCY](_GL_TRIANGLE_STRIP_ADJACENCY), [_GL_TRIANGLES_ADJACENCY](_GL_TRIANGLES_ADJACENCY) and [_GL_PATCHES](_GL_PATCHES) are accepted.
; count
>  Specifies the number of elements to be rendered.
; type
>  Specifies the type of the values in indices. Must be one of [_GL_UNSIGNED_BYTE](_GL_UNSIGNED_BYTE), [_GL_UNSIGNED_SHORT](_GL_UNSIGNED_SHORT), or [_GL_UNSIGNED_INT](_GL_UNSIGNED_INT).
; indices
>  Specifies a pointer to the location where the indices are stored.


## Description


**_glDrawElements** specifies multiple geometric primitives with very few subroutine calls. Instead of calling a GL function to pass each individual vertex, normal, texture coordinate, edge flag, or color, you can prespecify separate arrays of vertices, normals, and so on, and use them to construct a sequence of primitives with a single call to **_glDrawElements**.

When **_glDrawElements** is called, it uses count sequential elements from an enabled array, starting at indices (interpreted as a byte count) to construct a sequence of geometric primitives. mode specifies what kind of primitives are constructed and how the array elements construct these primitives. If more than one array is enabled, each is used.

Vertex attributes that are modified by **_glDrawElements** have an unspecified value after **_glDrawElements** returns. Attributes that aren't modified maintain their previous values.


## Notes


[_GL_LINE_STRIP_ADJACENCY](_GL_LINE_STRIP_ADJACENCY), [_GL_LINES_ADJACENCY](_GL_LINES_ADJACENCY), [_GL_TRIANGLE_STRIP_ADJACENCY](_GL_TRIANGLE_STRIP_ADJACENCY) and [_GL_TRIANGLES_ADJACENCY](_GL_TRIANGLES_ADJACENCY) are available only if the GL version is 3.2 or greater.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if mode is not an accepted value.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated if count is negative.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a geometry shader is active and mode is incompatible with the input primitive type of the geometry shader in the currently installed program object.

[_GL_INVALID_OPERATION](_GL_INVALID_OPERATION) is generated if a non-zero buffer object name is bound to an enabled array or the element array and the buffer object's data store is currently mapped.


## See Also


[_GL](_GL)
[_glBindVertexArray](_glBindVertexArray), [_glDrawArrays](_glDrawArrays), [_glDrawElementsBaseVertex](_glDrawElementsBaseVertex), [_glDrawElementsIndirect](_glDrawElementsIndirect), [_glDrawElementsInstanced](_glDrawElementsInstanced), [_glDrawElementsInstancedBaseInstance](_glDrawElementsInstancedBaseInstance), [_glDrawElementsInstancedBaseVertex](_glDrawElementsInstancedBaseVertex), [_glDrawElementsInstancedBaseVertexBaseInstance](_glDrawElementsInstancedBaseVertexBaseInstance), [_glDrawRangeElements](_glDrawRangeElements), [_glDrawRangeElementsBaseVertex](_glDrawRangeElementsBaseVertex), [_glMultiDrawElements](_glMultiDrawElements), [_glMultiDrawElementsBaseVertex](_glMultiDrawElementsBaseVertex), [_glMultiDrawElementsIndirect](_glMultiDrawElementsIndirect)




