The [MKDIR](MKDIR) statement creates a new folder (**dir**ectory) at a specified path.

## Syntax

>  [MKDIR](MKDIR) pathSpec$

## Description

* The path specification (pathSpec$) is a literal or variable [STRING](STRING) expression that also specifies the new folder's name.
* If no path is given the directory will become a sub-directory of the present directory where the program is currently running.
* **QB64** can use both long or short path and file names with spaces when required.
* The new folder will be created without a user prompt or verification. 
* If a path is specified, the path must exist or a [ERROR Codes](ERROR-Codes) will occur. See [_DIREXISTS](_DIREXISTS).
* [SHELL](SHELL) can use the DOS command "MD " or "MKDIR " + path$ + newfolder$ to do the same thing.

## See Also

* [SHELL](SHELL), [CHDIR](CHDIR), [FILES](FILES)
* [NAME](NAME), [KILL](KILL), [RMDIR](RMDIR)
* [_DIREXISTS](_DIREXISTS)
* [Windows Libraries](Windows-Libraries)
