**_glFinish:** block until all GL execution is complete


## Syntax


  SUB _glFinish
  void **_glFinish**(void);



## Description


**_glFinish** does not return until the effects of all previously called GL commands are complete. Such effects include all changes to GL state, all changes to connection state, and all changes to the frame buffer contents.


## Notes


**_glFinish** requires a round trip to the server.


## See Also


[_GL](_GL)
[_glFlush](_glFlush), [_glFenceSync](_glFenceSync), [_glWaitSync](_glWaitSync), [_glClientWaitSync](_glClientWaitSync)




Copyright 1991-2006 Silicon Graphics, Inc. This document is licensed under the SGI Free Software B License. For details, see [http://oss.sgi.com/projects/FreeB/ http://oss.sgi.com/projects/FreeB/].

