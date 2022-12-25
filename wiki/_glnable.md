**_glEnable:** enable or disable server-side GL capabilities


## Syntax


  SUB _glEnable (BYVAL cap AS _UNSIGNED LONG)
  void **_glEnable**(GLenum cap);

  SUB _glDisable (BYVAL cap AS _UNSIGNED LONG)
  void **_glDisable**(GLenum cap);


; cap
>  Specifies a symbolic constant indicating a GL capability.


## Syntax


| name = glEnablei, glDisablei 
| core = 3.0
}}

  void **_glEnablei**(GLenum cap, GLuint index);
  void **_glDisablei**(GLenum cap, GLuint index);

; cap
>  Specifies a symbolic constant indicating a GL capability.
; index
>  Specifies the index of the capability to enable/disable.


## Description


**_glEnable** and [_glDisable](_glDisable) enable and disable various capabilities. Use [_glIsEnabled](_glIsEnabled) or [_glGet](_glGet) to determine the current setting of any capability. The initial value for each capability with the exception of [_GL_DITHER](_GL_DITHER) and [_GL_MULTISAMPLE](_GL_MULTISAMPLE) is [_GL_FALSE](_GL_FALSE). The initial value for [_GL_DITHER](_GL_DITHER) and [_GL_MULTISAMPLE](_GL_MULTISAMPLE) is [_GL_TRUE](_GL_TRUE).

Both **_glEnable** and [_glDisable](_glDisable) take a single argument, cap, which can assume one of the following values:

; [_GL_BLEND](_GL_BLEND)
>  If enabled, blend the computed fragment color values with the values in the color buffers. See [GLAPI/glBlendFunc](GLAPI/glBlendFunc). Sets the blend enable/disable flag for all color buffers.
; [_GL_CLIP_DISTANCE](_GL_CLIP_DISTANCE)*i*
>  If enabled, clip geometry against user-defined half space *i*.
; [_GL_COLOR_LOGIC_OP](_GL_COLOR_LOGIC_OP)
>  If enabled, apply the currently selected logical operation to the computed fragment color and color buffer values. See [GLAPI/glLogicOp](GLAPI/glLogicOp).
; [_GL_CULL_FACE](_GL_CULL_FACE)
>  If enabled, cull polygons based on their winding in window coordinates. See [GLAPI/glCullFace](GLAPI/glCullFace).
; [_GL_DEBUG_OUTPUT](_GL_DEBUG_OUTPUT)
>  If enabled, debug messages are produced by a debug context. When disabled, the debug message log is silenced. Note that in a non-debug context, very few, if any messages might be produced, even when [_GL_DEBUG_OUTPUT](_GL_DEBUG_OUTPUT) is enabled.
; [_GL_DEBUG_OUTPUT_SYNCHRONOUS](_GL_DEBUG_OUTPUT_SYNCHRONOUS)
>  If enabled, debug messages are produced synchronously by a debug context. If disabled, debug messages may be produced asynchronously. In particular, they may be delayed relative to the execution of GL commands, and the debug callback function may be called from a thread other than that in which the commands are executed. See [_glDebugMessageCallback](_glDebugMessageCallback).
; [_GL_DEPTH_CLAMP](_GL_DEPTH_CLAMP)
>  If enabled, the -w<sub>c</sub> <= z<sub>c</sub> <= w<sub>c</sub> plane equation is ignored by view volume clipping (effectively, there is no near or far plane clipping). See [GLAPI/glDepthRange](GLAPI/glDepthRange).
; [_GL_DEPTH_TEST](_GL_DEPTH_TEST)
>  If enabled, do depth comparisons and update the depth buffer. Note that even if the depth buffer exists and the depth mask is non-zero, the depth buffer is not updated if the depth test is disabled. See [GLAPI/glDepthFunc](GLAPI/glDepthFunc) and [GLAPI/glDepthRange](GLAPI/glDepthRange).
; [_GL_DITHER](_GL_DITHER)
>  If enabled, dither color components or indices before they are written to the color buffer.
; [_GL_FRAMEBUFFER_SRGB](_GL_FRAMEBUFFER_SRGB)
>  If enabled and the value of [_GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING](_GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING) for the framebuffer attachment corresponding to the destination buffer is [_GL_SRGB](_GL_SRGB), the R, G, and B destination color values (after conversion from fixed-point to floating-point) are considered to be encoded for the sRGB color space and hence are linearized prior to their use in blending.
; [_GL_LINE_SMOOTH](_GL_LINE_SMOOTH)
>  If enabled, draw lines with correct filtering. Otherwise, draw aliased lines. See [GLAPI/glLineWidth](GLAPI/glLineWidth).
; [_GL_MULTISAMPLE](_GL_MULTISAMPLE)
>  If enabled, use multiple fragment samples in computing the final color of a pixel. See [GLAPI/glSampleCoverage](GLAPI/glSampleCoverage).
; [_GL_POLYGON_OFFSET_FILL](_GL_POLYGON_OFFSET_FILL)
>  If enabled, and if the polygon is rendered in [_GL_FILL](_GL_FILL) mode, an offset is added to depth values of a polygon's fragments before the depth comparison is performed. See [GLAPI/glPolygonOffset](GLAPI/glPolygonOffset).
; [_GL_POLYGON_OFFSET_LINE](_GL_POLYGON_OFFSET_LINE)
>  If enabled, and if the polygon is rendered in [_GL_LINE](_GL_LINE) mode, an offset is added to depth values of a polygon's fragments before the depth comparison is performed. See [GLAPI/glPolygonOffset](GLAPI/glPolygonOffset).
; [_GL_POLYGON_OFFSET_POINT](_GL_POLYGON_OFFSET_POINT)
>  If enabled, an offset is added to depth values of a polygon's fragments before the depth comparison is performed, if the polygon is rendered in [_GL_POINT](_GL_POINT) mode. See [GLAPI/glPolygonOffset](GLAPI/glPolygonOffset).
; [_GL_POLYGON_SMOOTH](_GL_POLYGON_SMOOTH)
>  If enabled, draw polygons with proper filtering. Otherwise, draw aliased polygons. For correct antialiased polygons, an alpha buffer is needed and the polygons must be sorted front to back.
; [_GL_PRIMITIVE_RESTART](_GL_PRIMITIVE_RESTART)
>  Enables primitive restarting. If enabled, any one of the draw commands which transfers a set of generic attribute array elements to the GL will restart the primitive when the index of the vertex is equal to the primitive restart index. See [_glPrimitiveRestartIndex](_glPrimitiveRestartIndex).
; [_GL_PRIMITIVE_RESTART_FIXED_INDEX](_GL_PRIMITIVE_RESTART_FIXED_INDEX)
>  Enables primitive restarting with a fixed index. If enabled, any one of the draw commands which transfers a set of generic attribute array elements to the GL will restart the primitive when the index of the vertex is equal to the fixed primitive index for the specified index type. The fixed index is equal to 2^n - 1 where *n* is equal to 8 for [_GL_UNSIGNED_BYTE](_GL_UNSIGNED_BYTE), 16 for [_GL_UNSIGNED_SHORT](_GL_UNSIGNED_SHORT) and 32 for [_GL_UNSIGNED_INT](_GL_UNSIGNED_INT).
; [_GL_RASTERIZER_DISCARD](_GL_RASTERIZER_DISCARD)
>  If enabled, all primitives are discarded before rasterization, but *after* any optional transform feedback. Also causes [_glClear](_glClear) and [_glClearBuffer](_glClearBuffer) commands to be ignored.
; [_GL_SAMPLE_ALPHA_TO_COVERAGE](_GL_SAMPLE_ALPHA_TO_COVERAGE)
>  If enabled, compute a temporary coverage value where each bit is determined by the alpha value at the corresponding sample location. The temporary coverage value is then ANDed with the fragment coverage value.
; [_GL_SAMPLE_ALPHA_TO_ONE](_GL_SAMPLE_ALPHA_TO_ONE)
>  If enabled, each sample alpha value is replaced by the maximum representable alpha value.
; [_GL_SAMPLE_COVERAGE](_GL_SAMPLE_COVERAGE)
>  If enabled, the fragment's coverage is ANDed with the temporary coverage value. If [_GL_SAMPLE_COVERAGE_INVERT](_GL_SAMPLE_COVERAGE_INVERT) is set to [_GL_TRUE](_GL_TRUE), invert the coverage value. See [GLAPI/glSampleCoverage](GLAPI/glSampleCoverage).
; [_GL_SAMPLE_SHADING](_GL_SAMPLE_SHADING)
>  If enabled, the active fragment shader is run once for each covered sample, or at fraction of this rate as determined by the current value of [_GL_MIN_SAMPLE_SHADING_VALUE](_GL_MIN_SAMPLE_SHADING_VALUE). See [GLAPI/glMinSampleShading](GLAPI/glMinSampleShading).
; [_GL_SAMPLE_MASK](_GL_SAMPLE_MASK)
>  If enabled, the sample coverage mask generated for a fragment during rasterization will be ANDed with the value of [_GL_SAMPLE_MASK_VALUE](_GL_SAMPLE_MASK_VALUE) before shading occurs. See [GLAPI/glSampleMaski](GLAPI/glSampleMaski).
; [_GL_SCISSOR_TEST](_GL_SCISSOR_TEST)
>  If enabled, discard fragments that are outside the scissor rectangle. See [GLAPI/glScissor](GLAPI/glScissor).
; [_GL_STENCIL_TEST](_GL_STENCIL_TEST)
>  If enabled, do stencil testing and update the stencil buffer. See [GLAPI/glStencilFunc](GLAPI/glStencilFunc) and [GLAPI/glStencilOp](GLAPI/glStencilOp).
; [_GL_TEXTURE_CUBE_MAP_SEAMLESS](_GL_TEXTURE_CUBE_MAP_SEAMLESS)
>  If enabled, cubemap textures are sampled such that when linearly sampling from the border between two adjacent faces, texels from both faces are used to generate the final sample value. When disabled, texels from only a single face are used to construct the final sample value.
; [_GL_PROGRAM_POINT_SIZE](_GL_PROGRAM_POINT_SIZE)
>  If enabled and a vertex or geometry shader is active, then the derived point size is taken from the (potentially clipped) shader builtin gl_PointSize and clamped to the implementation-dependent point size range.

###  Indexed Capabilities 


Some of the GL's capabilities are indexed. **_glEnablei** and **_glDisablei** enable and disable indexed capabilities. Only the following capabilities may be used with indices higher than zero:

; [_GL_BLEND](_GL_BLEND)
>  If enabled, blend the computed fragment color values with the values in the specified color buffer. index must be less than [_GL_MAX_DRAW_BUFFERS](_GL_MAX_DRAW_BUFFERS) or [_GL_INVALID_VALUE](_GL_INVALID_VALUE) will result. See [GLAPI/glBlendFunc](GLAPI/glBlendFunc).


## Error(s)


[_GL_INVALID_ENUM](_GL_INVALID_ENUM) is generated if cap is not one of the values listed previously.

[_GL_INVALID_VALUE](_GL_INVALID_VALUE) is generated by **_glEnablei** and **_glDisablei** if index is greater than or equal to the number of indexed capabilities for cap.


## Notes


[_GL_PRIMITIVE_RESTART](_GL_PRIMITIVE_RESTART) is available only if the GL version is 3.1 or greater.

[_GL_TEXTURE_CUBE_MAP_SEAMLESS](_GL_TEXTURE_CUBE_MAP_SEAMLESS) is available only if the GL version is 3.2 or greater.

[_GL_PRIMITIVE_RESTART_FIXED_INDEX](_GL_PRIMITIVE_RESTART_FIXED_INDEX) is available only if the GL version is 4.3 or greater.

[_GL_DEBUG_OUTPUT](_GL_DEBUG_OUTPUT) and [_GL_DEBUG_OUTPUT_SYNCHRONOUS](_GL_DEBUG_OUTPUT_SYNCHRONOUS) are available only if the GL version is 4.3 or greater.

Any token accepted by **_glEnable** or **_glDisable** is also accepted by **_glEnablei** and **_glDisablei**, but if the capability is not indexed, the maximum value that index may take is zero.

In general, passing an indexed capability to **_glEnable** or **_glDisable** will enable or disable that capability for all indices, resepectively.


## Use With


[_glIsEnabled](_glIsEnabled)

[_glGet](_glGet)


## See Also


[_GL](_GL)
[_glActiveTexture](_glActiveTexture), [_glBlendFunc](_glBlendFunc), [_glCullFace](_glCullFace), [_glDepthFunc](_glDepthFunc), [_glDepthRange](_glDepthRange), [_glGet](_glGet), [_glIsEnabled](_glIsEnabled), [_glLineWidth](_glLineWidth), [_glLogicOp](_glLogicOp), [_glPointSize](_glPointSize), [_glPolygonMode](_glPolygonMode), [_glPolygonOffset](_glPolygonOffset), [_glSampleCoverage](_glSampleCoverage), [_glScissor](_glScissor), [_glStencilFunc](_glStencilFunc), [_glStencilOp](_glStencilOp), [_glTexImage1D](_glTexImage1D), [_glTexImage2D](_glTexImage2D), [_glTexImage3D](_glTexImage3D)




Copyright 1991-2006 Silicon Graphics, Inc. Copyright 2010-2011 Khronos Group. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

