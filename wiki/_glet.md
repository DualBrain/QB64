**_glGet:** return the value or values of a selected parameter


## Syntax


  SUB _glGetBooleanv (BYVAL pname AS _UNSIGNED LONG, params AS _UNSIGNED _BYTE)
  void **_glGetBooleanv**(GLenum *pname*, GLboolean * *params*);

  SUB _glGetDoublev (BYVAL pname AS _UNSIGNED LONG, params AS DOUBLE)
  void **_glGetDoublev**(GLenum *pname*, GLdouble * *params*);

  SUB _glGetFloatv (BYVAL pname AS _UNSIGNED LONG, params AS SINGLE)
  void **_glGetFloatv**(GLenum *pname*, GLfloat * *params*);

  SUB _glGetIntegerv (BYVAL pname AS _UNSIGNED LONG, params AS LONG)
  void **_glGetIntegerv**(GLenum *pname*, GLint * *params*);

  void **_glGetInteger64v**(GLenum *pname*, GLint64 * *params*);

; pname
>  Specifies the parameter value to be returned. The symbolic constants in the list below are accepted.
; params
>  Returns the value or values of the specified parameter.


## Syntax


  void **_glGetBooleani_v**(GLenum *pname*, GLuint *index*, GLboolean * *data*);
  void **_glGetIntegeri_v**(GLenum *pname*, GLuint *index*, GLint * *data*);
  void **_glGetFloati_v**(GLenum *pname*, GLuint *index*, GLfloat * *data*);
  void **_glGetDoublei_v**(GLenum *pname*, GLuint *index*, GLdouble * *data*);
  void **_glGetInteger64i_v**(GLenum *pname*, GLuint *index*, GLint64 * *data*);

; pname
>  Specifies the parameter value to be returned. The symbolic constants in the list below are accepted.
; index
>  Specifies the index of the particular element being queried.
; data
>  Returns the value or values of the specified parameter.


## Description


These four commands return values for simple state variables in GL. pname is a symbolic constant indicating the state variable to be returned, and params is a pointer to an array of the indicated type in which to place the returned data.

Type conversion is performed if params has a different type than the state variable value being requested. If **_glGetBooleanv** is called, a floating-point (or integer) value is converted to [_GL_FALSE](_GL_FALSE) if and only if it is 0.0 (or 0). Otherwise, it is converted to [_GL_TRUE](_GL_TRUE). If **_glGetIntegerv** is called, boolean values are returned as [_GL_TRUE](_GL_TRUE) or [_GL_FALSE](_GL_FALSE), and most floating-point values are rounded to the nearest integer value. Floating-point colors and normals, however, are returned with a linear mapping that maps 1.0 to the most positive representable integer value and <!--Missing Equation--> to the most negative representable integer value. If **_glGetFloatv** or **_glGetDoublev** is called, boolean values are returned as [_GL_TRUE](_GL_TRUE) or [_GL_FALSE](_GL_FALSE), and integer values are converted to floating-point values.

The following symbolic constants are accepted by pname:

; [_GL_ACTIVE_TEXTURE](_GL_ACTIVE_TEXTURE)
>  params returns a single value indicating the active multitexture unit. The initial value is [_GL_TEXTURE0](_GL_TEXTURE0). See [_glActiveTexture](_glActiveTexture).
; [_GL_ALIASED_LINE_WIDTH_RANGE](_GL_ALIASED_LINE_WIDTH_RANGE)
>  params returns a pair of values indicating the range of widths supported for aliased lines. See [_glLineWidth](_glLineWidth).
; [_GL_ARRAY_BUFFER_BINDING](_GL_ARRAY_BUFFER_BINDING)
>  params returns a single value, the name of the buffer object currently bound to the target [_GL_ARRAY_BUFFER](_GL_ARRAY_BUFFER). If no buffer object is bound to this target, 0 is returned. The initial value is 0. See [_glBindBuffer](_glBindBuffer).
; [_GL_BLEND](_GL_BLEND)
>  params returns a single boolean value indicating whether blending is enabled. The initial value is [_GL_FALSE](_GL_FALSE). See [_glBlendFunc](_glBlendFunc).
; [_GL_BLEND_COLOR](_GL_BLEND_COLOR)
>  params returns four values, the red, green, blue, and alpha values which are the components of the blend color. See [_glBlendColor](_glBlendColor).
; [_GL_BLEND_DST_ALPHA](_GL_BLEND_DST_ALPHA)
>  params returns one value, the symbolic constant identifying the alpha destination blend function. The initial value is [_GL_ZERO](_GL_ZERO). See [_glBlendFunc](_glBlendFunc) and [_glBlendFuncSeparate](_glBlendFuncSeparate).
; [_GL_BLEND_DST_RGB](_GL_BLEND_DST_RGB)
>  params returns one value, the symbolic constant identifying the RGB destination blend function. The initial value is [_GL_ZERO](_GL_ZERO). See [_glBlendFunc](_glBlendFunc) and [_glBlendFuncSeparate](_glBlendFuncSeparate).
; [_GL_BLEND_EQUATION_RGB](_GL_BLEND_EQUATION_RGB)
>  params returns one value, a symbolic constant indicating whether the RGB blend equation is [_GL_FUNC_ADD](_GL_FUNC_ADD), [_GL_FUNC_SUBTRACT](_GL_FUNC_SUBTRACT), [_GL_FUNC_REVERSE_SUBTRACT](_GL_FUNC_REVERSE_SUBTRACT), [_GL_MIN](_GL_MIN) or [_GL_MAX](_GL_MAX). See [_glBlendEquationSeparate](_glBlendEquationSeparate).
; [_GL_BLEND_EQUATION_ALPHA](_GL_BLEND_EQUATION_ALPHA)
>  params returns one value, a symbolic constant indicating whether the Alpha blend equation is [_GL_FUNC_ADD](_GL_FUNC_ADD), [_GL_FUNC_SUBTRACT](_GL_FUNC_SUBTRACT), [_GL_FUNC_REVERSE_SUBTRACT](_GL_FUNC_REVERSE_SUBTRACT), [_GL_MIN](_GL_MIN) or [_GL_MAX](_GL_MAX). See [_glBlendEquationSeparate](_glBlendEquationSeparate).
; [_GL_BLEND_SRC_ALPHA](_GL_BLEND_SRC_ALPHA)
>  params returns one value, the symbolic constant identifying the alpha source blend function. The initial value is [_GL_ONE](_GL_ONE). See [_glBlendFunc](_glBlendFunc) and [_glBlendFuncSeparate](_glBlendFuncSeparate).
; [_GL_BLEND_SRC_RGB](_GL_BLEND_SRC_RGB)
>  params returns one value, the symbolic constant identifying the RGB source blend function. The initial value is [_GL_ONE](_GL_ONE). See [_glBlendFunc](_glBlendFunc) and [_glBlendFuncSeparate](_glBlendFuncSeparate).
; [_GL_COLOR_CLEAR_VALUE](_GL_COLOR_CLEAR_VALUE)
>  params returns four values: the red, green, blue, and alpha values used to clear the color buffers. Integer values, if requested, are linearly mapped from the internal floating-point representation such that 1.0 returns the most positive representable integer value, and <!--Missing Equation--> returns the most negative representable integer value. The initial value is (0, 0, 0, 0). See [_glClearColor](_glClearColor).
; [_GL_COLOR_LOGIC_OP](_GL_COLOR_LOGIC_OP)
>  params returns a single boolean value indicating whether a fragment's RGBA color values are merged into the framebuffer using a logical operation. The initial value is [_GL_FALSE](_GL_FALSE). See [_glLogicOp](_glLogicOp).
; [_GL_COLOR_WRITEMASK](_GL_COLOR_WRITEMASK)
>  params returns four boolean values: the red, green, blue, and alpha write enables for the color buffers. The initial value is ([_GL_TRUE](_GL_TRUE), [_GL_TRUE](_GL_TRUE), [_GL_TRUE](_GL_TRUE), [_GL_TRUE](_GL_TRUE)). See [_glColorMask](_glColorMask).
; [_GL_COMPRESSED_TEXTURE_FORMATS](_GL_COMPRESSED_TEXTURE_FORMATS)
>  params returns a list of symbolic constants of length [_GL_NUM_COMPRESSED_TEXTURE_FORMATS](_GL_NUM_COMPRESSED_TEXTURE_FORMATS) indicating which compressed texture formats are available. See [_glCompressedTexImage2D](_glCompressedTexImage2D).
; [_GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS](_GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS)
>  params returns one value, the maximum number of active shader storage blocks that may be accessed by a compute shader.
; [_GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS](_GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS)
>  params returns one value, the maximum total number of active shader storage blocks that may be accessed by all active shaders.
; [_GL_MAX_COMPUTE_UNIFORM_BLOCKS](_GL_MAX_COMPUTE_UNIFORM_BLOCKS)
>  params returns one value, the maximum number of uniform blocks per compute shader. The value must be at least 14. See [_glUniformBlockBinding](_glUniformBlockBinding).
; [_GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS](_GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS)
>  params returns one value, the maximum supported texture image units that can be used to access texture maps from the compute shader. The value may be at least 16. See [_glActiveTexture](_glActiveTexture).
; [_GL_MAX_COMPUTE_UNIFORM_COMPONENTS](_GL_MAX_COMPUTE_UNIFORM_COMPONENTS)
>  params returns one value, the maximum number of individual floating-point, integer, or boolean values that can be held in uniform variable storage for a compute shader. The value must be at least 1024. See [_glUniform](_glUniform).
; [_GL_MAX_COMPUTE_ATOMIC_COUNTERS](_GL_MAX_COMPUTE_ATOMIC_COUNTERS)
>  params returns a single value, the maximum number of atomic counters available to compute shaders.
; [_GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS](_GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS)
>  params returns a single value, the maximum number of atomic counter buffers that may be accessed by a compute shader.
; [_GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS](_GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS)
>  params returns one value, the number of words for compute shader uniform variables in all uniform blocks (including default). The value must be at least 1. See [_glUniform](_glUniform).
; [_GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS](_GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS)
>  params returns one value, the number of invocations in a single local work group (i.e., the product of the three dimensions) that may be dispatched to a compute shader.
; [_GL_MAX_COMPUTE_WORK_GROUP_COUNT](_GL_MAX_COMPUTE_WORK_GROUP_COUNT)
>  Accepted by the indexed versions of **_glGet**. params the maximum number of work groups that may be dispatched to a compute shader. Indices 0, 1, and 2 correspond to the X, Y and Z dimensions, respectively.
; [_GL_MAX_COMPUTE_WORK_GROUP_SIZE](_GL_MAX_COMPUTE_WORK_GROUP_SIZE)
>  Accepted by the indexed versions of **_glGet**. params the maximum size of a work groups that may be used during compilation of a compute shader. Indices 0, 1, and 2 correspond to the X, Y and Z dimensions, respectively.
; [_GL_DISPATCH_INDIRECT_BUFFER_BINDING](_GL_DISPATCH_INDIRECT_BUFFER_BINDING)
>  params returns a single value, the name of the buffer object currently bound to the target [_GL_DISPATCH_INDIRECT_BUFFER](_GL_DISPATCH_INDIRECT_BUFFER). If no buffer object is bound to this target, 0 is returned. The initial value is 0. See [_glBindBuffer](_glBindBuffer).
; [_GL_MAX_DEBUG_GROUP_STACK_DEPTH](_GL_MAX_DEBUG_GROUP_STACK_DEPTH)
>  params returns a single value, the maximum depth of the debug message group stack.
; [_GL_DEBUG_GROUP_STACK_DEPTH](_GL_DEBUG_GROUP_STACK_DEPTH)
>  params returns a single value, the current depth of the debug message group stack.
; [_GL_CONTEXT_FLAGS](_GL_CONTEXT_FLAGS)
>  params returns one value, the flags with which the context was created (such as debugging functionality).
; [_GL_CULL_FACE](_GL_CULL_FACE)
>  params returns a single boolean value indicating whether polygon culling is enabled. The initial value is [_GL_FALSE](_GL_FALSE). See [_glCullFace](_glCullFace).
; [_GL_CURRENT_PROGRAM](_GL_CURRENT_PROGRAM)
>  params returns one value, the name of the program object that is currently active, or 0 if no program object is active. See [_glUseProgram](_glUseProgram).
; [_GL_DEPTH_CLEAR_VALUE](_GL_DEPTH_CLEAR_VALUE)
>  params returns one value, the value that is used to clear the depth buffer. Integer values, if requested, are linearly mapped from the internal floating-point representation such that 1.0 returns the most positive representable integer value, and <!--Missing Equation--> returns the most negative representable integer value. The initial value is 1. See [_glClearDepth](_glClearDepth).
; [_GL_DEPTH_FUNC](_GL_DEPTH_FUNC)
>  params returns one value, the symbolic constant that indicates the depth comparison function. The initial value is [_GL_LESS](_GL_LESS). See [_glDepthFunc](_glDepthFunc).
; [_GL_DEPTH_RANGE](_GL_DEPTH_RANGE)
>  params returns two values: the near and far mapping limits for the depth buffer. Integer values, if requested, are linearly mapped from the internal floating-point representation such that 1.0 returns the most positive representable integer value, and <!--Missing Equation--> returns the most negative representable integer value. The initial value is (0, 1). See [_glDepthRange](_glDepthRange).
; [_GL_DEPTH_TEST](_GL_DEPTH_TEST)
>  params returns a single boolean value indicating whether depth testing of fragments is enabled. The initial value is [_GL_FALSE](_GL_FALSE). See [_glDepthFunc](_glDepthFunc) and [_glDepthRange](_glDepthRange).
; [_GL_DEPTH_WRITEMASK](_GL_DEPTH_WRITEMASK)
>  params returns a single boolean value indicating if the depth buffer is enabled for writing. The initial value is [_GL_TRUE](_GL_TRUE). See [_glDepthMask](_glDepthMask).
; [_GL_DITHER](_GL_DITHER)
>  params returns a single boolean value indicating whether dithering of fragment colors and indices is enabled. The initial value is [_GL_TRUE](_GL_TRUE).
; [_GL_DOUBLEBUFFER](_GL_DOUBLEBUFFER)
>  params returns a single boolean value indicating whether double buffering is supported.
; [_GL_DRAW_BUFFER](_GL_DRAW_BUFFER)
>  params returns one value, a symbolic constant indicating which buffers are being drawn to. See [_glDrawBuffer](_glDrawBuffer). The initial value is [_GL_BACK](_GL_BACK) if there are back buffers, otherwise it is [_GL_FRONT](_GL_FRONT).
; [_GL_DRAW_BUFFER](_GL_DRAW_BUFFER)*i*
>  params returns one value, a symbolic constant indicating which buffers are being drawn to by the corresponding output color. See [_glDrawBuffers](_glDrawBuffers). The initial value of [_GL_DRAW_BUFFER0](_GL_DRAW_BUFFER0) is [_GL_BACK](_GL_BACK) if there are back buffers, otherwise it is [_GL_FRONT](_GL_FRONT). The initial values of draw buffers for all other output colors is [_GL_NONE](_GL_NONE).
; [_GL_DRAW_FRAMEBUFFER_BINDING](_GL_DRAW_FRAMEBUFFER_BINDING)
>  params returns one value, the name of the framebuffer object currently bound to the [_GL_DRAW_FRAMEBUFFER](_GL_DRAW_FRAMEBUFFER) target. If the default framebuffer is bound, this value will be zero. The initial value is zero. See [_glBindFramebuffer](_glBindFramebuffer).
; [_GL_READ_FRAMEBUFFER_BINDING](_GL_READ_FRAMEBUFFER_BINDING)
>  params returns one value, the name of the framebuffer object currently bound to the [_GL_READ_FRAMEBUFFER](_GL_READ_FRAMEBUFFER) target. If the default framebuffer is bound, this value will be zero. The initial value is zero. See [_glBindFramebuffer](_glBindFramebuffer).
; [_GL_ELEMENT_ARRAY_BUFFER_BINDING](_GL_ELEMENT_ARRAY_BUFFER_BINDING)
>  params returns a single value, the name of the buffer object currently bound to the target [_GL_ELEMENT_ARRAY_BUFFER](_GL_ELEMENT_ARRAY_BUFFER). If no buffer object is bound to this target, 0 is returned. The initial value is 0. See [_glBindBuffer](_glBindBuffer).
; [_GL_FRAGMENT_SHADER_DERIVATIVE_HINT](_GL_FRAGMENT_SHADER_DERIVATIVE_HINT)
>  params returns one value, a symbolic constant indicating the mode of the derivative accuracy hint for fragment shaders. The initial value is [_GL_DONT_CARE](_GL_DONT_CARE). See [_glHint](_glHint).
; [_GL_IMPLEMENTATION_COLOR_READ_FORMAT](_GL_IMPLEMENTATION_COLOR_READ_FORMAT)
>  params returns a single GLenum value indicating the implementation's preferred pixel data format. See [_glReadPixels](_glReadPixels).
; [_GL_IMPLEMENTATION_COLOR_READ_TYPE](_GL_IMPLEMENTATION_COLOR_READ_TYPE)
>  params returns a single GLenum value indicating the implementation's preferred pixel data type. See [_glReadPixels](_glReadPixels).
; [_GL_LINE_SMOOTH](_GL_LINE_SMOOTH)
>  params returns a single boolean value indicating whether antialiasing of lines is enabled. The initial value is [_GL_FALSE](_GL_FALSE). See [_glLineWidth](_glLineWidth).
; [_GL_LINE_SMOOTH_HINT](_GL_LINE_SMOOTH_HINT)
>  params returns one value, a symbolic constant indicating the mode of the line antialiasing hint. The initial value is [_GL_DONT_CARE](_GL_DONT_CARE). See [_glHint](_glHint).
; [_GL_LINE_WIDTH](_GL_LINE_WIDTH)
>  params returns one value, the line width as specified with [_glLineWidth](_glLineWidth). The initial value is 1.
; [_GL_LAYER_PROVOKING_VERTEX](_GL_LAYER_PROVOKING_VERTEX)
>  params returns one value, the implementation dependent specifc vertex of a primitive that is used to select the rendering layer. If the value returned is equivalent to [_GL_PROVOKING_VERTEX](_GL_PROVOKING_VERTEX), then the vertex selection follows the convention specified by [_glProvokingVertex](_glProvokingVertex). If the value returned is equivalent to [_GL_FIRST_VERTEX_CONVENTION](_GL_FIRST_VERTEX_CONVENTION), then the selection is always taken from the first vertex in the primitive. If the value returned is equivalent to [_GL_LAST_VERTEX_CONVENTION](_GL_LAST_VERTEX_CONVENTION), then the selection is always taken from the last vertex in the primitive. If the value returned is equivalent to [_GL_UNDEFINED_VERTEX](_GL_UNDEFINED_VERTEX), then the selection is not guaranteed to be taken from any specific vertex in the primitive.
; [_GL_LINE_WIDTH_GRANULARITY](_GL_LINE_WIDTH_GRANULARITY)
>  params returns one value, the width difference between adjacent supported widths for antialiased lines. See [_glLineWidth](_glLineWidth).
; [_GL_LINE_WIDTH_RANGE](_GL_LINE_WIDTH_RANGE)
>  params returns two values: the smallest and largest supported widths for antialiased lines. See [_glLineWidth](_glLineWidth).
; [_GL_LOGIC_OP_MODE](_GL_LOGIC_OP_MODE)
>  params returns one value, a symbolic constant indicating the selected logic operation mode. The initial value is [_GL_COPY](_GL_COPY). See [_glLogicOp](_glLogicOp).
; [_GL_MAJOR_VERSION](_GL_MAJOR_VERSION)
>  params returns one value, the major version number of the OpenGL API supported by the current context.
; [_GL_MAX_3D_TEXTURE_SIZE](_GL_MAX_3D_TEXTURE_SIZE)
>  params returns one value, a rough estimate of the largest 3D texture that the GL can handle. The value must be at least 64. Use [_GL_PROXY_TEXTURE_3D](_GL_PROXY_TEXTURE_3D) to determine if a texture is too large. See [_glTexImage3D](_glTexImage3D).
; [_GL_MAX_ARRAY_TEXTURE_LAYERS](_GL_MAX_ARRAY_TEXTURE_LAYERS)
>  params returns one value. The value indicates the maximum number of layers allowed in an array texture, and must be at least 256. See [_glTexImage2D](_glTexImage2D).
; [_GL_MAX_CLIP_DISTANCES](_GL_MAX_CLIP_DISTANCES)
>  params returns one value, the maximum number of application-defined clipping distances. The value must be at least 8.
; [_GL_MAX_COLOR_TEXTURE_SAMPLES](_GL_MAX_COLOR_TEXTURE_SAMPLES)
>  params returns one value, the maximum number of samples in a color multisample texture.
; [_GL_MAX_COMBINED_ATOMIC_COUNTERS](_GL_MAX_COMBINED_ATOMIC_COUNTERS)
>  params returns a single value, the maximum number of atomic counters available to all active shaders.
; [_GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS](_GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS)
>  params returns one value, the number of words for fragment shader uniform variables in all uniform blocks (including default). The value must be at least 1. See [_glUniform](_glUniform).
; [_GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS](_GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS)
>  params returns one value, the number of words for geometry shader uniform variables in all uniform blocks (including default). The value must be at least 1. See [_glUniform](_glUniform).
; [_GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS](_GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS)
>  params returns one value, the maximum supported texture image units that can be used to access texture maps from the vertex shader and the fragment processor combined. If both the vertex shader and the fragment processing stage access the same texture image unit, then that counts as using two texture image units against this limit. The value must be at least 48. See [_glActiveTexture](_glActiveTexture).
; [_GL_MAX_COMBINED_UNIFORM_BLOCKS](_GL_MAX_COMBINED_UNIFORM_BLOCKS)
>  params returns one value, the maximum number of uniform blocks per program. The value must be at least 36. See [_glUniformBlockBinding](_glUniformBlockBinding).
; [_GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS](_GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS)
>  params returns one value, the number of words for vertex shader uniform variables in all uniform blocks (including default). The value must be at least 1. See [_glUniform](_glUniform).
; [_GL_MAX_CUBE_MAP_TEXTURE_SIZE](_GL_MAX_CUBE_MAP_TEXTURE_SIZE)
>  params returns one value. The value gives a rough estimate of the largest cube-map texture that the GL can handle. The value must be at least 1024. Use [_GL_PROXY_TEXTURE_CUBE_MAP](_GL_PROXY_TEXTURE_CUBE_MAP) to determine if a texture is too large. See [_glTexImage2D](_glTexImage2D).
; [_GL_MAX_DEPTH_TEXTURE_SAMPLES](_GL_MAX_DEPTH_TEXTURE_SAMPLES)
>  params returns one value, the maximum number of samples in a multisample depth or depth-stencil texture.
; [_GL_MAX_DRAW_BUFFERS](_GL_MAX_DRAW_BUFFERS)
>  params returns one value, the maximum number of simultaneous outputs that may be written in a fragment shader. The value must be at least 8. See [_glDrawBuffers](_glDrawBuffers).
; [_GL_MAX_DUALSOURCE_DRAW_BUFFERS](_GL_MAX_DUALSOURCE_DRAW_BUFFERS)
>  params returns one value, the maximum number of active draw buffers when using dual-source blending. The value must be at least 1. See [_glBlendFunc](_glBlendFunc) and [_glBlendFuncSeparate](_glBlendFuncSeparate).
; [_GL_MAX_ELEMENTS_INDICES](_GL_MAX_ELEMENTS_INDICES)
>  params returns one value, the recommended maximum number of vertex array indices. See [_glDrawRangeElements](_glDrawRangeElements).
; [_GL_MAX_ELEMENTS_VERTICES](_GL_MAX_ELEMENTS_VERTICES)
>  params returns one value, the recommended maximum number of vertex array vertices. See [_glDrawRangeElements](_glDrawRangeElements).
; [_GL_MAX_FRAGMENT_ATOMIC_COUNTERS](_GL_MAX_FRAGMENT_ATOMIC_COUNTERS)
>  params returns a single value, the maximum number of atomic counters available to fragment shaders.
; [_GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS](_GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS)
>  params returns one value, the maximum number of active shader storage blocks that may be accessed by a fragment shader.
; [_GL_MAX_FRAGMENT_INPUT_COMPONENTS](_GL_MAX_FRAGMENT_INPUT_COMPONENTS)
>  params returns one value, the maximum number of components of the inputs read by the fragment shader, which must be at least 128.
; [_GL_MAX_FRAGMENT_UNIFORM_COMPONENTS](_GL_MAX_FRAGMENT_UNIFORM_COMPONENTS)
>  params returns one value, the maximum number of individual floating-point, integer, or boolean values that can be held in uniform variable storage for a fragment shader. The value must be at least 1024. See [_glUniform](_glUniform).
; [_GL_MAX_FRAGMENT_UNIFORM_VECTORS](_GL_MAX_FRAGMENT_UNIFORM_VECTORS)
>  params returns one value, the maximum number of individual 4-vectors of floating-point, integer, or boolean values that can be held in uniform variable storage for a fragment shader. The value is equal to the value of [_GL_MAX_FRAGMENT_UNIFORM_COMPONENTS](_GL_MAX_FRAGMENT_UNIFORM_COMPONENTS) divided by 4 and must be at least 256. See [_glUniform](_glUniform).
; [_GL_MAX_FRAGMENT_UNIFORM_BLOCKS](_GL_MAX_FRAGMENT_UNIFORM_BLOCKS)
>  params returns one value, the maximum number of uniform blocks per fragment shader. The value must be at least 12. See [_glUniformBlockBinding](_glUniformBlockBinding).
; [_GL_MAX_FRAMEBUFFER_WIDTH](_GL_MAX_FRAMEBUFFER_WIDTH)
>  params returns one value, the maximum width for a framebuffer that has no attachments, which must be at least 16384. See [_glFramebufferParameter](_glFramebufferParameter).
; [_GL_MAX_FRAMEBUFFER_HEIGHT](_GL_MAX_FRAMEBUFFER_HEIGHT)
>  params returns one value, the maximum height for a framebuffer that has no attachments, which must be at least 16384. See [_glFramebufferParameter](_glFramebufferParameter).
; [_GL_MAX_FRAMEBUFFER_LAYERS](_GL_MAX_FRAMEBUFFER_LAYERS)
>  params returns one value, the maximum number of layers for a framebuffer that has no attachments, which must be at least 2048. See [_glFramebufferParameter](_glFramebufferParameter).
; [_GL_MAX_FRAMEBUFFER_SAMPLES](_GL_MAX_FRAMEBUFFER_SAMPLES)
>  params returns one value, the maximum samples in a framebuffer that has no attachments, which must be at least 4. See [_glFramebufferParameter](_glFramebufferParameter).
; [_GL_MAX_GEOMETRY_ATOMIC_COUNTERS](_GL_MAX_GEOMETRY_ATOMIC_COUNTERS)
>  params returns a single value, the maximum number of atomic counters available to geometry shaders.
; [_GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS](_GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS)
>  params returns one value, the maximum number of active shader storage blocks that may be accessed by a geometry shader.
; [_GL_MAX_GEOMETRY_INPUT_COMPONENTS](_GL_MAX_GEOMETRY_INPUT_COMPONENTS)
>  params returns one value, the maximum number of components of inputs read by a geometry shader, which must be at least 64.
; [_GL_MAX_GEOMETRY_OUTPUT_COMPONENTS](_GL_MAX_GEOMETRY_OUTPUT_COMPONENTS)
>  params returns one value, the maximum number of components of outputs written by a geometry shader, which must be at least 128.
; [_GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS](_GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS)
>  params returns one value, the maximum supported texture image units that can be used to access texture maps from the geometry shader. The value must be at least 16. See [_glActiveTexture](_glActiveTexture).
; [_GL_MAX_GEOMETRY_UNIFORM_BLOCKS](_GL_MAX_GEOMETRY_UNIFORM_BLOCKS)
>  params returns one value, the maximum number of uniform blocks per geometry shader. The value must be at least 12. See [_glUniformBlockBinding](_glUniformBlockBinding).
; [_GL_MAX_GEOMETRY_UNIFORM_COMPONENTS](_GL_MAX_GEOMETRY_UNIFORM_COMPONENTS)
>  params returns one value, the maximum number of individual floating-point, integer, or boolean values that can be held in uniform variable storage for a geometry shader. The value must be at least 1024. See [_glUniform](_glUniform).
; [_GL_MAX_INTEGER_SAMPLES](_GL_MAX_INTEGER_SAMPLES)
>  params returns one value, the maximum number of samples supported in integer format multisample buffers.
; [_GL_MIN_MAP_BUFFER_ALIGNMENT](_GL_MIN_MAP_BUFFER_ALIGNMENT)
>  params returns one value, the minimum alignment in basic machine units of pointers returned from[_glMapBuffer](_glMapBuffer) and [_glMapBufferRange](_glMapBufferRange). This value must be a power of two and must be at least 64.
; [_GL_MAX_LABEL_LENGTH](_GL_MAX_LABEL_LENGTH)
>  params returns one value, the maximum length of a label that may be assigned to an object. See [_glObjectLabel](_glObjectLabel) and [_glObjectPtrLabel](_glObjectPtrLabel).
; [_GL_MAX_PROGRAM_TEXEL_OFFSET](_GL_MAX_PROGRAM_TEXEL_OFFSET)
>  params returns one value, the maximum texel offset allowed in a texture lookup, which must be at least 7.
; [_GL_MIN_PROGRAM_TEXEL_OFFSET](_GL_MIN_PROGRAM_TEXEL_OFFSET)
>  params returns one value, the minimum texel offset allowed in a texture lookup, which must be at most -8.
; [_GL_MAX_RECTANGLE_TEXTURE_SIZE](_GL_MAX_RECTANGLE_TEXTURE_SIZE)
>  params returns one value. The value gives a rough estimate of the largest rectangular texture that the GL can handle. The value must be at least 1024. Use [_GL_PROXY_RECTANGLE_TEXTURE](_GL_PROXY_RECTANGLE_TEXTURE) to determine if a texture is too large. See [_glTexImage2D](_glTexImage2D).
; [_GL_MAX_RENDERBUFFER_SIZE](_GL_MAX_RENDERBUFFER_SIZE)
>  params returns one value. The value indicates the maximum supported size for renderbuffers. See [_glFramebufferRenderbuffer](_glFramebufferRenderbuffer).
; [_GL_MAX_SAMPLE_MASK_WORDS](_GL_MAX_SAMPLE_MASK_WORDS)
>  params returns one value, the maximum number of sample mask words.
; [_GL_MAX_SERVER_WAIT_TIMEOUT](_GL_MAX_SERVER_WAIT_TIMEOUT)
>  params returns one value, the maximum [_glWaitSync](_glWaitSync) timeout interval.
; [_GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS](_GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS)
>  params returns one value, the maximum number of shader storage buffer binding points on the context, which must be at least 8.
; [_GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS](_GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS)
>  params returns a single value, the maximum number of atomic counters available to tessellation control shaders.
; [_GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS](_GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS)
>  params returns a single value, the maximum number of atomic counters available to tessellation evaluation shaders.
; [_GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS](_GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS)
>  params returns one value, the maximum number of active shader storage blocks that may be accessed by a tessellation control shader.
; [_GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS](_GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS)
>  params returns one value, the maximum number of active shader storage blocks that may be accessed by a tessellation evaluation shader.
; [_GL_MAX_TEXTURE_BUFFER_SIZE](_GL_MAX_TEXTURE_BUFFER_SIZE)
>  params returns one value. The value gives the maximum number of texels allowed in the texel array of a texture buffer object. Value must be at least 65536.
; [_GL_MAX_TEXTURE_IMAGE_UNITS](_GL_MAX_TEXTURE_IMAGE_UNITS)
>  params returns one value, the maximum supported texture image units that can be used to access texture maps from the fragment shader. The value must be at least 16. See [_glActiveTexture](_glActiveTexture).
; [_GL_MAX_TEXTURE_LOD_BIAS](_GL_MAX_TEXTURE_LOD_BIAS)
>  params returns one value, the maximum, absolute value of the texture level-of-detail bias. The value must be at least 2.0.
; [_GL_MAX_TEXTURE_SIZE](_GL_MAX_TEXTURE_SIZE)
>  params returns one value. The value gives a rough estimate of the largest texture that the GL can handle. The value must be at least 1024. Use a proxy texture target such as [_GL_PROXY_TEXTURE_1D](_GL_PROXY_TEXTURE_1D) or [_GL_PROXY_TEXTURE_2D](_GL_PROXY_TEXTURE_2D) to determine if a texture is too large. See [_glTexImage1D](_glTexImage1D) and [_glTexImage2D](_glTexImage2D).
; [_GL_MAX_UNIFORM_BUFFER_BINDINGS](_GL_MAX_UNIFORM_BUFFER_BINDINGS)
>  params returns one value, the maximum number of uniform buffer binding points on the context, which must be at least 36.
; [_GL_MAX_UNIFORM_BLOCK_SIZE](_GL_MAX_UNIFORM_BLOCK_SIZE)
>  params returns one value, the maximum size in basic machine units of a uniform block, which must be at least 16384.
; [_GL_MAX_UNIFORM_LOCATIONS](_GL_MAX_UNIFORM_LOCATIONS)
>  params returns one value, the maximum number of explicitly assignable uniform locations, which must be at least 1024.
; [_GL_MAX_VARYING_COMPONENTS](_GL_MAX_VARYING_COMPONENTS)
>  params returns one value, the number components for varying variables, which must be at least 60.
; [_GL_MAX_VARYING_VECTORS](_GL_MAX_VARYING_VECTORS)
>  params returns one value, the number 4-vectors for varying variables, which is equal to the value of [_GL_MAX_VARYING_COMPONENTS](_GL_MAX_VARYING_COMPONENTS) and must be at least 15.
; [_GL_MAX_VARYING_FLOATS](_GL_MAX_VARYING_FLOATS)
>  params returns one value, the maximum number of interpolators available for processing varying variables used by vertex and fragment shaders. This value represents the number of individual floating-point values that can be interpolated; varying variables declared as vectors, matrices, and arrays will all consume multiple interpolators. The value must be at least 32.
; [_GL_MAX_VERTEX_ATOMIC_COUNTERS](_GL_MAX_VERTEX_ATOMIC_COUNTERS)
>  params returns a single value, the maximum number of atomic counters available to vertex shaders.
; [_GL_MAX_VERTEX_ATTRIBS](_GL_MAX_VERTEX_ATTRIBS)
>  params returns one value, the maximum number of 4-component generic vertex attributes accessible to a vertex shader. The value must be at least 16. See [_glVertexAttrib](_glVertexAttrib).
; [_GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS](_GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS)
>  params returns one value, the maximum number of active shader storage blocks that may be accessed by a vertex shader.
; [_GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS](_GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS)
>  params returns one value, the maximum supported texture image units that can be used to access texture maps from the vertex shader. The value may be at least 16. See [_glActiveTexture](_glActiveTexture).
; [_GL_MAX_VERTEX_UNIFORM_COMPONENTS](_GL_MAX_VERTEX_UNIFORM_COMPONENTS)
>  params returns one value, the maximum number of individual floating-point, integer, or boolean values that can be held in uniform variable storage for a vertex shader. The value must be at least 1024. See [_glUniform](_glUniform).
; [_GL_MAX_VERTEX_UNIFORM_VECTORS](_GL_MAX_VERTEX_UNIFORM_VECTORS)
>  params returns one value, the maximum number of 4-vectors that may be held in uniform variable storage for the vertex shader. The value of [_GL_MAX_VERTEX_UNIFORM_VECTORS](_GL_MAX_VERTEX_UNIFORM_VECTORS) is equal to the value of [_GL_MAX_VERTEX_UNIFORM_COMPONENTS](_GL_MAX_VERTEX_UNIFORM_COMPONENTS) and must be at least 256.
; [_GL_MAX_VERTEX_OUTPUT_COMPONENTS](_GL_MAX_VERTEX_OUTPUT_COMPONENTS)
>  params returns one value, the maximum number of components of output written by a vertex shader, which must be at least 64.
; [_GL_MAX_VERTEX_UNIFORM_BLOCKS](_GL_MAX_VERTEX_UNIFORM_BLOCKS)
>  params returns one value, the maximum number of uniform blocks per vertex shader. The value must be at least 12. See [_glUniformBlockBinding](_glUniformBlockBinding).
; [_GL_MAX_VIEWPORT_DIMS](_GL_MAX_VIEWPORT_DIMS)
>  params returns two values: the maximum supported width and height of the viewport. These must be at least as large as the visible dimensions of the display being rendered to. See [_glViewport](_glViewport).
; [_GL_MAX_VIEWPORTS](_GL_MAX_VIEWPORTS)
>  params returns one value, the maximum number of simultaneous viewports that are supported. The value must be at least 16. See [_glViewportIndexed](_glViewportIndexed).
; [_GL_MINOR_VERSION](_GL_MINOR_VERSION)
>  params returns one value, the minor version number of the OpenGL API supported by the current context.
; [_GL_NUM_COMPRESSED_TEXTURE_FORMATS](_GL_NUM_COMPRESSED_TEXTURE_FORMATS)
>  params returns a single integer value indicating the number of available compressed texture formats. The minimum value is 4. See [_glCompressedTexImage2D](_glCompressedTexImage2D).
; [_GL_NUM_EXTENSIONS](_GL_NUM_EXTENSIONS)
>  params returns one value, the number of extensions supported by the GL implementation for the current context. See [_glGetString](_glGetString).
; [_GL_NUM_PROGRAM_BINARY_FORMATS](_GL_NUM_PROGRAM_BINARY_FORMATS)
>  params returns one value, the number of program binary formats supported by the implementation.
; [_GL_NUM_SHADER_BINARY_FORMATS](_GL_NUM_SHADER_BINARY_FORMATS)
>  params returns one value, the number of binary shader formats supported by the implementation. If this value is greater than zero, then the implementation supports loading binary shaders. If it is zero, then the loading of binary shaders by the implementation is not supported.
; [_GL_PACK_ALIGNMENT](_GL_PACK_ALIGNMENT)
>  params returns one value, the byte alignment used for writing pixel data to memory. The initial value is 4. See [_glPixelStore](_glPixelStore).
; [_GL_PACK_IMAGE_HEIGHT](_GL_PACK_IMAGE_HEIGHT)
>  params returns one value, the image height used for writing pixel data to memory. The initial value is 0. See [_glPixelStore](_glPixelStore).
; [_GL_PACK_LSB_FIRST](_GL_PACK_LSB_FIRST)
>  params returns a single boolean value indicating whether single-bit pixels being written to memory are written first to the least significant bit of each unsigned byte. The initial value is [_GL_FALSE](_GL_FALSE). See [_glPixelStore](_glPixelStore).
; [_GL_PACK_ROW_LENGTH](_GL_PACK_ROW_LENGTH)
>  params returns one value, the row length used for writing pixel data to memory. The initial value is 0. See [_glPixelStore](_glPixelStore).
; [_GL_PACK_SKIP_IMAGES](_GL_PACK_SKIP_IMAGES)
>  params returns one value, the number of pixel images skipped before the first pixel is written into memory. The initial value is 0. See [_glPixelStore](_glPixelStore).
; [_GL_PACK_SKIP_PIXELS](_GL_PACK_SKIP_PIXELS)
>  params returns one value, the number of pixel locations skipped before the first pixel is written into memory. The initial value is 0. See [_glPixelStore](_glPixelStore).
; [_GL_PACK_SKIP_ROWS](_GL_PACK_SKIP_ROWS)
>  params returns one value, the number of rows of pixel locations skipped before the first pixel is written into memory. The initial value is 0. See [_glPixelStore](_glPixelStore).
; [_GL_PACK_SWAP_BYTES](_GL_PACK_SWAP_BYTES)
>  params returns a single boolean value indicating whether the bytes of two-byte and four-byte pixel indices and components are swapped before being written to memory. The initial value is [_GL_FALSE](_GL_FALSE). See [_glPixelStore](_glPixelStore).
; [_GL_PIXEL_PACK_BUFFER_BINDING](_GL_PIXEL_PACK_BUFFER_BINDING)
>  params returns a single value, the name of the buffer object currently bound to the target [_GL_PIXEL_PACK_BUFFER](_GL_PIXEL_PACK_BUFFER). If no buffer object is bound to this target, 0 is returned. The initial value is 0. See [_glBindBuffer](_glBindBuffer).
; [_GL_PIXEL_UNPACK_BUFFER_BINDING](_GL_PIXEL_UNPACK_BUFFER_BINDING)
>  params returns a single value, the name of the buffer object currently bound to the target [_GL_PIXEL_UNPACK_BUFFER](_GL_PIXEL_UNPACK_BUFFER). If no buffer object is bound to this target, 0 is returned. The initial value is 0. See [_glBindBuffer](_glBindBuffer).
; [_GL_POINT_FADE_THRESHOLD_SIZE](_GL_POINT_FADE_THRESHOLD_SIZE)
>  params returns one value, the point size threshold for determining the point size. See [_glPointParameter](_glPointParameter).
; [_GL_PRIMITIVE_RESTART_INDEX](_GL_PRIMITIVE_RESTART_INDEX)
>  params returns one value, the current primitive restart index. The initial value is 0. See [_glPrimitiveRestartIndex](_glPrimitiveRestartIndex).
; [_GL_PROGRAM_BINARY_FORMATS](_GL_PROGRAM_BINARY_FORMATS)
>  params an array of [_GL_NUM_PROGRAM_BINARY_FORMATS](_GL_NUM_PROGRAM_BINARY_FORMATS) values, indicating the proram binary formats supported by the implementation.
; [_GL_PROGRAM_PIPELINE_BINDING](_GL_PROGRAM_PIPELINE_BINDING)
>  params a single value, the name of the currently bound program pipeline object, or zero if no program pipeline object is bound. See [_glBindProgramPipeline](_glBindProgramPipeline).
; [_GL_PROVOKING_VERTEX](_GL_PROVOKING_VERTEX)
>  params returns one value, the currently selected provoking vertex convention. The initial value is [_GL_LAST_VERTEX_CONVENTION](_GL_LAST_VERTEX_CONVENTION). See [_glProvokingVertex](_glProvokingVertex).
; [_GL_POINT_SIZE](_GL_POINT_SIZE)
>  params returns one value, the point size as specified by [_glPointSize](_glPointSize). The initial value is 1.
; [_GL_POINT_SIZE_GRANULARITY](_GL_POINT_SIZE_GRANULARITY)
>  params returns one value, the size difference between adjacent supported sizes for antialiased points. See [_glPointSize](_glPointSize).
; [_GL_POINT_SIZE_RANGE](_GL_POINT_SIZE_RANGE)
>  params returns two values: the smallest and largest supported sizes for antialiased points. The smallest size must be at most 1, and the largest size must be at least 1. See [_glPointSize](_glPointSize).
; [_GL_POLYGON_OFFSET_FACTOR](_GL_POLYGON_OFFSET_FACTOR)
>  params returns one value, the scaling factor used to determine the variable offset that is added to the depth value of each fragment generated when a polygon is rasterized. The initial value is 0. See [_glPolygonOffset](_glPolygonOffset).
; [_GL_POLYGON_OFFSET_UNITS](_GL_POLYGON_OFFSET_UNITS)
>  params returns one value. This value is multiplied by an implementation-specific value and then added to the depth value of each fragment generated when a polygon is rasterized. The initial value is 0. See [_glPolygonOffset](_glPolygonOffset).
; [_GL_POLYGON_OFFSET_FILL](_GL_POLYGON_OFFSET_FILL)
>  params returns a single boolean value indicating whether polygon offset is enabled for polygons in fill mode. The initial value is [_GL_FALSE](_GL_FALSE). See [_glPolygonOffset](_glPolygonOffset).
; [_GL_POLYGON_OFFSET_LINE](_GL_POLYGON_OFFSET_LINE)
>  params returns a single boolean value indicating whether polygon offset is enabled for polygons in line mode. The initial value is [_GL_FALSE](_GL_FALSE). See [_glPolygonOffset](_glPolygonOffset).
; [_GL_POLYGON_OFFSET_POINT](_GL_POLYGON_OFFSET_POINT)
>  params returns a single boolean value indicating whether polygon offset is enabled for polygons in point mode. The initial value is [_GL_FALSE](_GL_FALSE). See [_glPolygonOffset](_glPolygonOffset).
; [_GL_POLYGON_SMOOTH](_GL_POLYGON_SMOOTH)
>  params returns a single boolean value indicating whether antialiasing of polygons is enabled. The initial value is [_GL_FALSE](_GL_FALSE). See [_glPolygonMode](_glPolygonMode).
; [_GL_POLYGON_SMOOTH_HINT](_GL_POLYGON_SMOOTH_HINT)
>  params returns one value, a symbolic constant indicating the mode of the polygon antialiasing hint. The initial value is [_GL_DONT_CARE](_GL_DONT_CARE). See [_glHint](_glHint).
; [_GL_READ_BUFFER](_GL_READ_BUFFER)
>  params returns one value, a symbolic constant indicating which color buffer is selected for reading. The initial value is [_GL_BACK](_GL_BACK) if there is a back buffer, otherwise it is [_GL_FRONT](_GL_FRONT). See [_glReadPixels](_glReadPixels).
; [_GL_RENDERBUFFER_BINDING](_GL_RENDERBUFFER_BINDING)
>  params returns a single value, the name of the renderbuffer object currently bound to the target [_GL_RENDERBUFFER](_GL_RENDERBUFFER). If no renderbuffer object is bound to this target, 0 is returned. The initial value is 0. See [_glBindRenderbuffer](_glBindRenderbuffer).
; [_GL_SAMPLE_BUFFERS](_GL_SAMPLE_BUFFERS)
>  params returns a single integer value indicating the number of sample buffers associated with the framebuffer. See [_glSampleCoverage](_glSampleCoverage).
; [_GL_SAMPLE_COVERAGE_VALUE](_GL_SAMPLE_COVERAGE_VALUE)
>  params returns a single positive floating-point value indicating the current sample coverage value. See [_glSampleCoverage](_glSampleCoverage).
; [_GL_SAMPLE_COVERAGE_INVERT](_GL_SAMPLE_COVERAGE_INVERT)
>  params returns a single boolean value indicating if the temporary coverage value should be inverted. See [_glSampleCoverage](_glSampleCoverage).
; [_GL_SAMPLER_BINDING](_GL_SAMPLER_BINDING)
>  params returns a single value, the name of the sampler object currently bound to the active texture unit. The initial value is 0. See [_glBindSampler](_glBindSampler).
; [_GL_SAMPLES](_GL_SAMPLES)
>  params returns a single integer value indicating the coverage mask size. See [_glSampleCoverage](_glSampleCoverage).
; [_GL_SCISSOR_BOX](_GL_SCISSOR_BOX)
>  params returns four values: the <!--Missing Equation--> and <!--Missing Equation--> window coordinates of the scissor box, followed by its width and height. Initially the <!--Missing Equation--> and <!--Missing Equation--> window coordinates are both 0 and the width and height are set to the size of the window. See [_glScissor](_glScissor).
; [_GL_SCISSOR_TEST](_GL_SCISSOR_TEST)
>  params returns a single boolean value indicating whether scissoring is enabled. The initial value is [_GL_FALSE](_GL_FALSE). See [_glScissor](_glScissor).
; [_GL_SHADER_COMPILER](_GL_SHADER_COMPILER)
>  params returns a single boolean value indicating whether an online shader compiler is present in the implementation. All desktop OpenGL implementations must support online shader compilations, and therefore the value of [_GL_SHADER_COMPILER](_GL_SHADER_COMPILER) will always be [_GL_TRUE](_GL_TRUE).
; [_GL_SHADER_STORAGE_BUFFER_BINDING](_GL_SHADER_STORAGE_BUFFER_BINDING)
>  When used with non-indexed variants of **_glGet** (such as **_glGetIntegerv**), params returns a single value, the name of the buffer object currently bound to the target [_GL_SHADER_STORAGE_BUFFER](_GL_SHADER_STORAGE_BUFFER). If no buffer object is bound to this target, 0 is returned. When used with indexed variants of **_glGet** (such as **_glGetIntegeri_v**), params returns a single value, the name of the buffer object bound to the indexed shader storage buffer binding points. The initial value is 0 for all targets. See [_glBindBuffer](_glBindBuffer), [_glBindBufferBase](_glBindBufferBase), and [_glBindBufferRange](_glBindBufferRange).
; [_GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT](_GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT)
>  params returns a single value, the minimum required alignment for shader storage buffer sizes and offset. The initial value is 1. See [_glShaderStorageBlockBinding](_glShaderStorageBlockBinding).
; [_GL_SHADER_STORAGE_BUFFER_START](_GL_SHADER_STORAGE_BUFFER_START)
>  When used with indexed variants of **_glGet** (such as **_glGetInteger64i_v**), params returns a single value, the start offset of the binding range for each indexed shader storage buffer binding. The initial value is 0 for all bindings. See [_glBindBufferRange](_glBindBufferRange).
; [_GL_SHADER_STORAGE_BUFFER_SIZE](_GL_SHADER_STORAGE_BUFFER_SIZE)
>  When used with indexed variants of **_glGet** (such as **_glGetInteger64i_v**), params returns a single value, the size of the binding range for each indexed shader storage buffer binding. The initial value is 0 for all bindings. See [_glBindBufferRange](_glBindBufferRange).
; [_GL_SMOOTH_LINE_WIDTH_RANGE](_GL_SMOOTH_LINE_WIDTH_RANGE)
>  params returns a pair of values indicating the range of widths supported for smooth (antialiased) lines. See [_glLineWidth](_glLineWidth).
; [_GL_SMOOTH_LINE_WIDTH_GRANULARITY](_GL_SMOOTH_LINE_WIDTH_GRANULARITY)
>  params returns a single value indicating the level of quantization applied to smooth line width parameters.
; [_GL_STENCIL_BACK_FAIL](_GL_STENCIL_BACK_FAIL)
>  params returns one value, a symbolic constant indicating what action is taken for back-facing polygons when the stencil test fails. The initial value is [_GL_KEEP](_GL_KEEP). See [_glStencilOpSeparate](_glStencilOpSeparate).
; [_GL_STENCIL_BACK_FUNC](_GL_STENCIL_BACK_FUNC)
>  params returns one value, a symbolic constant indicating what function is used for back-facing polygons to compare the stencil reference value with the stencil buffer value. The initial value is [_GL_ALWAYS](_GL_ALWAYS). See [_glStencilFuncSeparate](_glStencilFuncSeparate).
; [_GL_STENCIL_BACK_PASS_DEPTH_FAIL](_GL_STENCIL_BACK_PASS_DEPTH_FAIL)
>  params returns one value, a symbolic constant indicating what action is taken for back-facing polygons when the stencil test passes, but the depth test fails. The initial value is [_GL_KEEP](_GL_KEEP). See [_glStencilOpSeparate](_glStencilOpSeparate).
; [_GL_STENCIL_BACK_PASS_DEPTH_PASS](_GL_STENCIL_BACK_PASS_DEPTH_PASS)
>  params returns one value, a symbolic constant indicating what action is taken for back-facing polygons when the stencil test passes and the depth test passes. The initial value is [_GL_KEEP](_GL_KEEP). See [_glStencilOpSeparate](_glStencilOpSeparate).
; [_GL_STENCIL_BACK_REF](_GL_STENCIL_BACK_REF)
>  params returns one value, the reference value that is compared with the contents of the stencil buffer for back-facing polygons. The initial value is 0. See [_glStencilFuncSeparate](_glStencilFuncSeparate).
; [_GL_STENCIL_BACK_VALUE_MASK](_GL_STENCIL_BACK_VALUE_MASK)
>  params returns one value, the mask that is used for back-facing polygons to mask both the stencil reference value and the stencil buffer value before they are compared. The initial value is all 1's. See [_glStencilFuncSeparate](_glStencilFuncSeparate).
; [_GL_STENCIL_BACK_WRITEMASK](_GL_STENCIL_BACK_WRITEMASK)
>  params returns one value, the mask that controls writing of the stencil bitplanes for back-facing polygons. The initial value is all 1's. See [_glStencilMaskSeparate](_glStencilMaskSeparate).
; [_GL_STENCIL_CLEAR_VALUE](_GL_STENCIL_CLEAR_VALUE)
>  params returns one value, the index to which the stencil bitplanes are cleared. The initial value is 0. See [_glClearStencil](_glClearStencil).
; [_GL_STENCIL_FAIL](_GL_STENCIL_FAIL)
>  params returns one value, a symbolic constant indicating what action is taken when the stencil test fails. The initial value is [_GL_KEEP](_GL_KEEP). See [_glStencilOp](_glStencilOp). This stencil state only affects non-polygons and front-facing polygons. Back-facing polygons use separate stencil state. See [_glStencilOpSeparate](_glStencilOpSeparate).
; [_GL_STENCIL_FUNC](_GL_STENCIL_FUNC)
>  params returns one value, a symbolic constant indicating what function is used to compare the stencil reference value with the stencil buffer value. The initial value is [_GL_ALWAYS](_GL_ALWAYS). See [_glStencilFunc](_glStencilFunc). This stencil state only affects non-polygons and front-facing polygons. Back-facing polygons use separate stencil state. See [_glStencilFuncSeparate](_glStencilFuncSeparate).
; [_GL_STENCIL_PASS_DEPTH_FAIL](_GL_STENCIL_PASS_DEPTH_FAIL)
>  params returns one value, a symbolic constant indicating what action is taken when the stencil test passes, but the depth test fails. The initial value is [_GL_KEEP](_GL_KEEP). See [_glStencilOp](_glStencilOp). This stencil state only affects non-polygons and front-facing polygons. Back-facing polygons use separate stencil state. See [_glStencilOpSeparate](_glStencilOpSeparate).
; [_GL_STENCIL_PASS_DEPTH_PASS](_GL_STENCIL_PASS_DEPTH_PASS)
>  params returns one value, a symbolic constant indicating what action is taken when the stencil test passes and the depth test passes. The initial value is [_GL_KEEP](_GL_KEEP). See [_glStencilOp](_glStencilOp). This stencil state only affects non-polygons and front-facing polygons. Back-facing polygons use separate stencil state. See [_glStencilOpSeparate](_glStencilOpSeparate).
; [_GL_STENCIL_REF](_GL_STENCIL_REF)
>  params returns one value, the reference value that is compared with the contents of the stencil buffer. The initial value is 0. See [_glStencilFunc](_glStencilFunc). This stencil state only affects non-polygons and front-facing polygons. Back-facing polygons use separate stencil state. See [_glStencilFuncSeparate](_glStencilFuncSeparate).
; [_GL_STENCIL_TEST](_GL_STENCIL_TEST)
>  params returns a single boolean value indicating whether stencil testing of fragments is enabled. The initial value is [_GL_FALSE](_GL_FALSE). See [_glStencilFunc](_glStencilFunc) and [_glStencilOp](_glStencilOp).
; [_GL_STENCIL_VALUE_MASK](_GL_STENCIL_VALUE_MASK)
>  params returns one value, the mask that is used to mask both the stencil reference value and the stencil buffer value before they are compared. The initial value is all 1's. See [_glStencilFunc](_glStencilFunc). This stencil state only affects non-polygons and front-facing polygons. Back-facing polygons use separate stencil state. See [_glStencilFuncSeparate](_glStencilFuncSeparate).
; [_GL_STENCIL_WRITEMASK](_GL_STENCIL_WRITEMASK)
>  params returns one value, the mask that controls writing of the stencil bitplanes. The initial value is all 1's. See [_glStencilMask](_glStencilMask). This stencil state only affects non-polygons and front-facing polygons. Back-facing polygons use separate stencil state. See [_glStencilMaskSeparate](_glStencilMaskSeparate).
; [_GL_STEREO](_GL_STEREO)
>  params returns a single boolean value indicating whether stereo buffers (left and right) are supported.
; [_GL_SUBPIXEL_BITS](_GL_SUBPIXEL_BITS)
>  params returns one value, an estimate of the number of bits of subpixel resolution that are used to position rasterized geometry in window coordinates. The value must be at least 4.
; [_GL_TEXTURE_BINDING_1D](_GL_TEXTURE_BINDING_1D)
>  params returns a single value, the name of the texture currently bound to the target [_GL_TEXTURE_1D](_GL_TEXTURE_1D). The initial value is 0. See [_glBindTexture](_glBindTexture).
; [_GL_TEXTURE_BINDING_1D_ARRAY](_GL_TEXTURE_BINDING_1D_ARRAY)
>  params returns a single value, the name of the texture currently bound to the target [_GL_TEXTURE_1D_ARRAY](_GL_TEXTURE_1D_ARRAY). The initial value is 0. See [_glBindTexture](_glBindTexture).
; [_GL_TEXTURE_BINDING_2D](_GL_TEXTURE_BINDING_2D)
>  params returns a single value, the name of the texture currently bound to the target [_GL_TEXTURE_2D](_GL_TEXTURE_2D). The initial value is 0. See [_glBindTexture](_glBindTexture).
; [_GL_TEXTURE_BINDING_2D_ARRAY](_GL_TEXTURE_BINDING_2D_ARRAY)
>  params returns a single value, the name of the texture currently bound to the target [_GL_TEXTURE_2D_ARRAY](_GL_TEXTURE_2D_ARRAY). The initial value is 0. See [_glBindTexture](_glBindTexture).
; [_GL_TEXTURE_BINDING_2D_MULTISAMPLE](_GL_TEXTURE_BINDING_2D_MULTISAMPLE)
>  params returns a single value, the name of the texture currently bound to the target [_GL_TEXTURE_2D_MULTISAMPLE](_GL_TEXTURE_2D_MULTISAMPLE). The initial value is 0. See [_glBindTexture](_glBindTexture).
; [_GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY](_GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY)
>  params returns a single value, the name of the texture currently bound to the target [_GL_TEXTURE_2D_MULTISAMPLE_ARRAY](_GL_TEXTURE_2D_MULTISAMPLE_ARRAY). The initial value is 0. See [_glBindTexture](_glBindTexture).
; [_GL_TEXTURE_BINDING_3D](_GL_TEXTURE_BINDING_3D)
>  params returns a single value, the name of the texture currently bound to the target [_GL_TEXTURE_3D](_GL_TEXTURE_3D). The initial value is 0. See [_glBindTexture](_glBindTexture).
; [_GL_TEXTURE_BINDING_BUFFER](_GL_TEXTURE_BINDING_BUFFER)
>  params returns a single value, the name of the texture currently bound to the target [_GL_TEXTURE_BUFFER](_GL_TEXTURE_BUFFER). The initial value is 0. See [_glBindTexture](_glBindTexture).
; [_GL_TEXTURE_BINDING_CUBE_MAP](_GL_TEXTURE_BINDING_CUBE_MAP)
>  params returns a single value, the name of the texture currently bound to the target [_GL_TEXTURE_CUBE_MAP](_GL_TEXTURE_CUBE_MAP). The initial value is 0. See [_glBindTexture](_glBindTexture).
; [_GL_TEXTURE_BINDING_RECTANGLE](_GL_TEXTURE_BINDING_RECTANGLE)
>  params returns a single value, the name of the texture currently bound to the target [_GL_TEXTURE_RECTANGLE](_GL_TEXTURE_RECTANGLE). The initial value is 0. See [_glBindTexture](_glBindTexture).
; [_GL_TEXTURE_COMPRESSION_HINT](_GL_TEXTURE_COMPRESSION_HINT)
>  params returns a single value indicating the mode of the texture compression hint. The initial value is [_GL_DONT_CARE](_GL_DONT_CARE).
; [_GL_TEXTURE_BUFFER_BINDING](_GL_TEXTURE_BUFFER_BINDING)
>  params returns a single value, the name of the texture buffer object currently bound. The initial value is 0. See [_glBindBuffer](_glBindBuffer).
; [_GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT](_GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT)
>  params returns a single value, the minimum required alignment for texture buffer sizes and offset. The initial value is 1. See [_glUniformBlockBinding](_glUniformBlockBinding).
;; [_GL_TIMESTAMP](_GL_TIMESTAMP)
>  params returns a single value, the 64-bit value of the current GL time. See [_glQueryCounter](_glQueryCounter).
; [_GL_TRANSFORM_FEEDBACK_BUFFER_BINDING](_GL_TRANSFORM_FEEDBACK_BUFFER_BINDING)
>  When used with non-indexed variants of **_glGet** (such as **_glGetIntegerv**), params returns a single value, the name of the buffer object currently bound to the target [_GL_TRANSFORM_FEEDBACK_BUFFER](_GL_TRANSFORM_FEEDBACK_BUFFER). If no buffer object is bound to this target, 0 is returned. When used with indexed variants of **_glGet** (such as **_glGetIntegeri_v**), params returns a single value, the name of the buffer object bound to the indexed transform feedback attribute stream. The initial value is 0 for all targets. See [_glBindBuffer](_glBindBuffer), [_glBindBufferBase](_glBindBufferBase), and [_glBindBufferRange](_glBindBufferRange).
; [_GL_TRANSFORM_FEEDBACK_BUFFER_START](_GL_TRANSFORM_FEEDBACK_BUFFER_START)
>  When used with indexed variants of **_glGet** (such as **_glGetInteger64i_v**), params returns a single value, the start offset of the binding range for each transform feedback attribute stream. The initial value is 0 for all streams. See [_glBindBufferRange](_glBindBufferRange).
; [_GL_TRANSFORM_FEEDBACK_BUFFER_SIZE](_GL_TRANSFORM_FEEDBACK_BUFFER_SIZE)
>  When used with indexed variants of **_glGet** (such as **_glGetInteger64i_v**), params returns a single value, the size of the binding range for each transform feedback attribute stream. The initial value is 0 for all streams. See [_glBindBufferRange](_glBindBufferRange).
; [_GL_UNIFORM_BUFFER_BINDING](_GL_UNIFORM_BUFFER_BINDING)
>  When used with non-indexed variants of **_glGet** (such as **_glGetIntegerv**), params returns a single value, the name of the buffer object currently bound to the target [_GL_UNIFORM_BUFFER](_GL_UNIFORM_BUFFER). If no buffer object is bound to this target, 0 is returned. When used with indexed variants of **_glGet** (such as **_glGetIntegeri_v**), params returns a single value, the name of the buffer object bound to the indexed uniform buffer binding point. The initial value is 0 for all targets. See [_glBindBuffer](_glBindBuffer), [_glBindBufferBase](_glBindBufferBase), and [_glBindBufferRange](_glBindBufferRange).
; [_GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT](_GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT)
>  params returns a single value, the minimum required alignment for uniform buffer sizes and offset. The initial value is 1. See [_glUniformBlockBinding](_glUniformBlockBinding).
; [_GL_UNIFORM_BUFFER_SIZE](_GL_UNIFORM_BUFFER_SIZE)
>  When used with indexed variants of **_glGet** (such as **_glGetInteger64i_v**), params returns a single value, the size of the binding range for each indexed uniform buffer binding. The initial value is 0 for all bindings. See [_glBindBufferRange](_glBindBufferRange).
; [_GL_UNIFORM_BUFFER_START](_GL_UNIFORM_BUFFER_START)
>  When used with indexed variants of **_glGet** (such as **_glGetInteger64i_v**), params returns a single value, the start offset of the binding range for each indexed uniform buffer binding. The initial value is 0 for all bindings. See [_glBindBufferRange](_glBindBufferRange).
; [_GL_UNPACK_ALIGNMENT](_GL_UNPACK_ALIGNMENT)
>  params returns one value, the byte alignment used for reading pixel data from memory. The initial value is 4. See [_glPixelStore](_glPixelStore).
; [_GL_UNPACK_IMAGE_HEIGHT](_GL_UNPACK_IMAGE_HEIGHT)
>  params returns one value, the image height used for reading pixel data from memory. The initial is 0. See [_glPixelStore](_glPixelStore).
; [_GL_UNPACK_LSB_FIRST](_GL_UNPACK_LSB_FIRST)
>  params returns a single boolean value indicating whether single-bit pixels being read from memory are read first from the least significant bit of each unsigned byte. The initial value is [_GL_FALSE](_GL_FALSE). See [_glPixelStore](_glPixelStore).
; [_GL_UNPACK_ROW_LENGTH](_GL_UNPACK_ROW_LENGTH)
>  params returns one value, the row length used for reading pixel data from memory. The initial value is 0. See [_glPixelStore](_glPixelStore).
; [_GL_UNPACK_SKIP_IMAGES](_GL_UNPACK_SKIP_IMAGES)
>  params returns one value, the number of pixel images skipped before the first pixel is read from memory. The initial value is 0. See [_glPixelStore](_glPixelStore).
; [_GL_UNPACK_SKIP_PIXELS](_GL_UNPACK_SKIP_PIXELS)
>  params returns one value, the number of pixel locations skipped before the first pixel is read from memory. The initial value is 0. See [_glPixelStore](_glPixelStore).
; [_GL_UNPACK_SKIP_ROWS](_GL_UNPACK_SKIP_ROWS)
>  params returns one value, the number of rows of pixel locations skipped before the first pixel is read from memory. The initial value is 0. See [_glPixelStore](_glPixelStore).
; [_GL_UNPACK_SWAP_BYTES](_GL_UNPACK_SWAP_BYTES)
>  params returns a single boolean value indicating whether the bytes of two-byte and four-byte pixel indices and components are swapped after being read from memory. The initial value is [_GL_FALSE](_GL_FALSE). See [_glPixelStore](_glPixelStore).
; [_GL_VERTEX_PROGRAM_POINT_SIZE](_GL_VERTEX_PROGRAM_POINT_SIZE)
>  params returns a single boolean value indicating whether vertex program point size mode is enabled. If enabled, and a vertex shader is active, then the point size is taken from the shader built-in gl_PointSize. If disabled, and a vertex shader is active, then the point size is taken from the point state as specified by [_glPointSize](_glPointSize). The initial value is [_GL_FALSE](_GL_FALSE).
; [_GL_VERTEX_BINDING_DIVISOR](_GL_VERTEX_BINDING_DIVISOR)
>  Accepted by the indexed forms. params returns a single integer value representing the instance step divisor of the first element in the bound buffer's data store for vertex attribute bound to index.
; [_GL_VERTEX_BINDING_OFFSET](_GL_VERTEX_BINDING_OFFSET)
>  Accepted by the indexed forms. params returns a single integer value representing the byte offset of the first element in the bound buffer's data store for vertex attribute bound to index.
; [_GL_VERTEX_BINDING_STRIDE](_GL_VERTEX_BINDING_STRIDE)
>  Accepted by the indexed forms. params returns a single integer value representing the byte offset between the start of each element in the bound buffer's data store for vertex attribute bound to index.
; [_GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET](_GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET)
>  params returns a single integer value containing the maximum offset that may be added to a vertex binding offset.
; [_GL_MAX_VERTEX_ATTRIB_BINDINGS](_GL_MAX_VERTEX_ATTRIB_BINDINGS)
>  params returns a single integer value containing the maximum number of vertex buffers that may be bound.
; [_GL_VIEWPORT](_GL_VIEWPORT)
>  When used with non-indexed variants of **_glGet** (such as **_glGetIntegerv**), params returns four values: the <!--Missing Equation--> and <!--Missing Equation--> window coordinates of the viewport, followed by its width and height. Initially the <!--Missing Equation--> and <!--Missing Equation--> window coordinates are both set to 0, and the width and height are set to the width and height of the window into which the GL will do its rendering. See [_glViewport](_glViewport). When used with indexed variants of **_glGet** (such as **_glGetIntegeri_v**), params returns four values: the <!--Missing Equation--> and <!--Missing Equation--> window coordinates of the indexed viewport, followed by its width and height. Initially the <!--Missing Equation--> and <!--Missing Equation--> window coordinates are both set to 0, and the width and height are set to the width and height of the window into which the GL will do its rendering. See [_glViewportIndexed](_glViewportIndexed).
; [_GL_VIEWPORT_BOUNDS_RANGE](_GL_VIEWPORT_BOUNDS_RANGE)
>  params returns two values, the minimum and maximum viewport bounds range. The minimum range should be at least [-32768, 32767].
; [_GL_VIEWPORT_INDEX_PROVOKING_VERTEX](_GL_VIEWPORT_INDEX_PROVOKING_VERTEX)
>  params returns one value, the implementation dependent specifc vertex of a primitive that is used to select the viewport index. If the value returned is equivalent to [_GL_PROVOKING_VERTEX](_GL_PROVOKING_VERTEX), then the vertex selection follows the convention specified by [_glProvokingVertex](_glProvokingVertex). If the value returned is equivalent to [_GL_FIRST_VERTEX_CONVENTION](_GL_FIRST_VERTEX_CONVENTION), then the selection is always taken from the first vertex in the primitive. If the value returned is equivalent to [_GL_LAST_VERTEX_CONVENTION](_GL_LAST_VERTEX_CONVENTION), then the selection is always taken from the last vertex in the primitive. If the value returned is equivalent to [_GL_UNDEFINED_VERTEX](_GL_UNDEFINED_VERTEX), then the selection is not guaranteed to be taken from any specific vertex in the primitive.
; [_GL_VIEWPORT_SUBPIXEL_BITS](_GL_VIEWPORT_SUBPIXEL_BITS)
>  params returns a single value, the number of bits of sub-pixel precision which the GL uses to interpret the floating point viewport bounds. The minimum value is 0.
; [_GL_MAX_ELEMENT_INDEX](_GL_MAX_ELEMENT_INDEX)
>  params returns a single value, the maximum index that may be specified during the transfer of generic vertex attributes to the GL.

Many of the boolean parameters can also be queried more easily using [_glIsEnabled](_glIsEnabled).


## Notes


The following parameters return the associated value for the active texture unit: [_GL_TEXTURE_1D](_GL_TEXTURE_1D), [_GL_TEXTURE_BINDING_1D](_GL_TEXTURE_BINDING_1D), [_GL_TEXTURE_2D](_GL_TEXTURE_2D), [_GL_TEXTURE_BINDING_2D](_GL_TEXTURE_BINDING_2D), [_GL_TEXTURE_3D](_GL_TEXTURE_3D) and [_GL_TEXTURE_BINDING_3D](_GL_TEXTURE_BINDING_3D).

[_GL_MAX_VIEWPORTS](_GL_MAX_VIEWPORTS), [_GL_VIEWPORT_SUBPIXEL_BITS](_GL_VIEWPORT_SUBPIXEL_BITS), [_GL_VIEWPORT_BOUNDS_RANGE](_GL_VIEWPORT_BOUNDS_RANGE), [_GL_LAYER_PROVOKING_VERTEX](_GL_LAYER_PROVOKING_VERTEX), and [_GL_VIEWPORT_INDEX_PROVOKING_VERTEX](_GL_VIEWPORT_INDEX_PROVOKING_VERTEX) are available only if the GL version is 4.1 or greater.

[_GL_MAX_VERTEX_ATOMIC_COUNTERS](_GL_MAX_VERTEX_ATOMIC_COUNTERS), [_GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS](_GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS), [_GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS](_GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS), [_GL_MAX_GEOMETRY_ATOMIC_COUNTERS](_GL_MAX_GEOMETRY_ATOMIC_COUNTERS), [_GL_MAX_FRAMGENT_ATOMIC_COUNTERS](_GL_MAX_FRAMGENT_ATOMIC_COUNTERS), and [_GL_MIN_MAP_BUFFER_ALIGNMENT](_GL_MIN_MAP_BUFFER_ALIGNMENT) are accepted by pname only if the GL version is 4.2 or greater.

[_GL_MAX_ELEMENT_INDEX](_GL_MAX_ELEMENT_INDEX) is accepted by pname only if the GL version is 4.3 or greater.

[_GL_MAX_COMPUTE_UNIFORM_BLOCKS](_GL_MAX_COMPUTE_UNIFORM_BLOCKS), [_GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS](_GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS), [_GL_MAX_COMPUTE_UNIFORM_COMPONENTS](_GL_MAX_COMPUTE_UNIFORM_COMPONENTS), [_GL_MAX_COMPUTE_ATOMIC_COUNTERS](_GL_MAX_COMPUTE_ATOMIC_COUNTERS), [_GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS](_GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS), [_GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS](_GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS), [_GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS](_GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS), [_GL_MAX_COMPUTE_WORK_GROUP_COUNT](_GL_MAX_COMPUTE_WORK_GROUP_COUNT), and [_GL_MAX_COMPUTE_WORK_GROUP_SIZE](_GL_MAX_COMPUTE_WORK_GROUP_SIZE) and [_GL_DISPATCH_INDIRECT_BUFFER_BINDING](_GL_DISPATCH_INDIRECT_BUFFER_BINDING) are available only if the GL version is 4.3 or greater.

[_GL_MAX_DEBUG_GROUP_STACK_DEPTH](_GL_MAX_DEBUG_GROUP_STACK_DEPTH), [_GL_DEBUG_GROUP_STACK_DEPTH](_GL_DEBUG_GROUP_STACK_DEPTH) and [_GL_MAX_LABEL_LENGTH](_GL_MAX_LABEL_LENGTH) are accepted only if the GL version is 4.3 or greater.

[_GL_MAX_UNIFORM_LOCATIONS](_GL_MAX_UNIFORM_LOCATIONS) is accepted only if the GL version is 4.3 or greater.

[_GL_MAX_FRAMEBUFFER_WIDTH](_GL_MAX_FRAMEBUFFER_WIDTH), [_GL_MAX_FRAMEBUFFER_HEIGHT](_GL_MAX_FRAMEBUFFER_HEIGHT), [_GL_MAX_FRAMEBUFFER_LAYERS](_GL_MAX_FRAMEBUFFER_LAYERS), and [_GL_MAX_FRAMEBUFFER_SAMPLES](_GL_MAX_FRAMEBUFFER_SAMPLES) are available only if the GL version is 4.3 or greater.

[_GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS](_GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS), [_GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS](_GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS), [_GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS](_GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS), [_GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS](_GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS), [_GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS](_GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS), and [_GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS](_GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS) are available only if the GL version is 4.3 or higher.

[_GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT](_GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT) is available only if the GL version is 4.3 or greater.

[_GL_VERTEX_BINDING_DIVISOR](_GL_VERTEX_BINDING_DIVISOR), [_GL_VERTEX_BINDING_OFFSET](_GL_VERTEX_BINDING_OFFSET), [_GL_VERTEX_BINDING_STRIDE](_GL_VERTEX_BINDING_STRIDE), [_GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET](_GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET) and [_GL_MAX_VERTEX_ATTRIB_BINDINGS](_GL_MAX_VERTEX_ATTRIB_BINDINGS) are available only if the GL version is 4.3 or greater.


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if pname is not an accepted value.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated on any of **_glGetBooleani_v**, **_glGetIntegeri_v**, **_glGetFloati_v**, **_glGetDoublei_v**, or **_glGetInteger64i_v** if index is outside of the valid range for the indexed state target.


## See Also


[_GL](_GL)
[_glGetActiveUniform](_glGetActiveUniform), [_glGetAttachedShaders](_glGetAttachedShaders), [_glGetAttribLocation](_glGetAttribLocation), [_glGetBufferParameter](_glGetBufferParameter), [_glGetBufferPointerv](_glGetBufferPointerv), [_glGetBufferSubData](_glGetBufferSubData), [_glGetCompressedTexImage](_glGetCompressedTexImage), [_glGetError](_glGetError), [_glGetProgram](_glGetProgram), [_glGetProgramInfoLog](_glGetProgramInfoLog), [_glGetQueryiv](_glGetQueryiv), [_glGetQueryObject](_glGetQueryObject), [_glGetShader](_glGetShader), [_glGetShaderInfoLog](_glGetShaderInfoLog), [_glGetShaderSource](_glGetShaderSource), [_glGetString](_glGetString), [_glGetTexImage](_glGetTexImage), [_glGetTexLevelParameter](_glGetTexLevelParameter), [_glGetTexParameter](_glGetTexParameter), [_glGetUniform](_glGetUniform), [_glGetUniformLocation](_glGetUniformLocation), [_glGetVertexAttrib](_glGetVertexAttrib), [_glGetVertexAttribPointerv](_glGetVertexAttribPointerv), [_glIsEnabled](_glIsEnabled)




Copyright 1991-2006 Silicon Graphics, Inc. Copyright 2010-2011 Khronos Group. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

