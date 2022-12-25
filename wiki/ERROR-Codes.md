This page lists all the error codes defined in QB64 that can occur in a program when running. Unless overridden with an [ON ERROR](ON-ERROR) handler, these result in a dialog box appearing. Due to legacy holdovers from previous BASIC dialects, not all of these errors may actually occur in a program (unless manually triggered with [ERROR](ERROR)).

If you encounter an error while editing in the QB64 IDE or when compiling (especially a "C++ Compilation Failed" message), or believe your program is correct, please report the error at https://github.com/QB64Official/qb64/issues.

It's a good idea to exclude qb64.exe from any real-time anti-virus scanning to prevent generic strange errors when editing or compiling.

##  Recoverable errors 

These errors can be triggered in QB64, and may be caught by an [ON ERROR](ON-ERROR) handler. The default error handler gives the user option to continue program execution.

| Code | Description | Possible Cause |
| - | - | - |
| 0 | No Error | No error has occurred |
| 2 | Syntax error | [READ](READ) attempted to read a number but could not parse the next [DATA](DATA) item. |
| 3 | RETURN without GOSUB | The [RETURN](RETURN) statement was encountered without first executing a corresponding [GOSUB](GOSUB). |
| 4 | Out of DATA | The [READ](READ) statement has read past the end of a [DATA](DATA) block. Use [RESTORE](RESTORE) to change the current data item if necessary. |
| 5 | Illegal function call | A function was called with invalid parameters, in the wrong graphics mode or otherwise in an illegal fashion. [Illegal-Function](Illegal-Function) gives some suggestions. |
| 6 | Overflow | A numeric operation has resulted in a value beyond a variable's allowed range. See [Variable Types](Variable-Types). |
| 7 | Out of memory | Generic out of memory condition. |
| 9 | Subscript out of range | An [Arrays](Arrays) [UBOUND](UBOUND) or [LBOUND](LBOUND) [DIM](DIM) boundary has been exceeded. |
| 10 | Duplicate definition | An array created with [DIM](DIM) was redefined with [DIM](DIM) or [REDIM](REDIM). |
| 13 | Type mismatch | A [PRINT USING](PRINT-USING) format string did not match the type of the supplied variables. |
| 20 | RESUME without error | The [RESUME](RESUME) statement was encountered outside of an [ON ERROR](ON-ERROR) error handler. |
| 50 | FIELD overflow | The [FIELD](FIELD) statement tried to allocate more bytes than were specified for the record length of a random access file. |
| 51 | Internal error | Generic error | This error should be reported to the QB64 organization through Issues on GitHub. |
| 52 | Bad file name or number | A file handle was used that does not correspond to a valid opened file. |
| 53 | File not found | Attempt to open a file that does not (yet) exist. See File Error below. |
| 54 | Bad file mode | A file operation was not compatible with the mode used in the [OPEN](OPEN) statement. |
| 55 | File already open | An [OPEN](OPEN) statement attempted to use a file handle that is already in use. Consider using [FREEFILE](FREEFILE). |
| 59 | Bad record length | The record length used for a [RANDOM](RANDOM) file was insufficient (too small) to perform the operation. |
| 62 | Input past end of file | A file was read past its end. Ensure [EOF](EOF) is being correctly checked. |
| 63 | Bad record number | The record (for [RANDOM](RANDOM)) or offset (for [BINARY](BINARY)) is outside the allowed range. |
| 64 | Bad file name | You either can't create of this name, or containing certain haracters. This varies from operating system to operating system. See File Error below. |
| 68 | Device unavailable | A serial port (COM device) failed to behave as expected. |
| 70 | Permission denied | You do not have sufficient permission to read a particular file or to create a file under another username or a directory you do bot have write access. See File Error below. |
| 73 | Feature Unavailable |
| 75 | Path/File access error | Path to file is invalid. See File Error below. |
| 76 | Path not found | Path name specified does not exist, See File Error below |
| 258 | Invalid handle | A handle used for an image, sound, font etc. was invalid. Be sure to check the return values of functions like [_LOADFONT](_LOADFONT) and [_LOADIMAGE](_LOADIMAGE).

Error handling of file operations varies between operating systems and is highly dependent on the exact circumstances. The errors marked "file error" above should all be equally treated as a generic failure to read or write from disk.

##  Critical errors 

These errors can be triggered in QB64 but will not be caught by an [ON ERROR](ON-ERROR) handler. They are always fatal, causing the program to exit.

| Code | Description | Notes |
| - | - | - |
| 11 | Division by zero | Only relevant for integer division, and may not be caught on all operating systems. |
| 256 | Out of stack space | Too many nested [GOSUB](GOSUB) calls. |
| 257 | Out of memory | Generic out of memory condition. |
| 259 | Cannot find dynamic library file | A .dll, .so or .dylib file referred to by [DECLARE LIBRARY](DECLARE-LIBRARY) was not found. |
| 260, 261 | Sub/Function does not exist in dynamic library | A function declared with [DECLARE LIBRARY](DECLARE-LIBRARY) does not exist. |
| 270 | _GL command called outside of SUB _GL's scope |
| 271 | END/SYSTEM called within SUB _GL's scope |
| 300 | Memory region out of range | Triggrered by _MEM commands. |
| 301 | Invalid size | Triggrered by _MEM commands. |
| 302 | Source memory region out of range | Triggrered by _MEM commands. |
| 303 | Destination memory region out of range | Triggrered by _MEM commands. |
| 304 | Source and destination memory regions out of range | Triggrered by _MEM commands |
| 305 | Source memory has been freed || Triggrered by _MEM commands |
| 306 | Destination memory has been freed | Triggrered by _MEM commands |
| 307 | Memory already freed | Attempt to release memory previously released. Triggrered by _MEM commands. |
| 308 | Memory has been freed | Triggrered by _MEM commands. |
| 309 | Memory not initialized | Triggrered by _MEM commands. |
| 310 | Source memory not initialized | Triggrered by _MEM commands. |
| 311 | Destination memory not initialized | Triggrered by _MEM commands. |
| 312 | Source and destination memory not initialized | Triggrered by _MEM commands |
| 313 | Source and destination memory have been freed || Triggrered by _MEM commands. |
| 314 | _ASSERT failed | See [_ASSERT](_ASSERT). |
| 315 | _ASSERT failed (check console for description) | See [_ASSERT](_ASSERT). |
| 502 to 518 | Out of memory | Generic out of memory condition. |

##  Legacy errors 

These errors will never be generated by a genuine error condition, and can only be triggered by explicit use of the [ERROR](ERROR) command. They can all be caught by [ON ERROR](ON-ERROR).


| Code | Description |
| - | - |
| 1 | NEXT without FOR |
| 8 | Label not defined |
| 12 | Illegal in direct mode |
| 14 | Out of string space |
| 16 | String formula too complex |
| 17 | Cannot continue |
| 18 | Function not defined |
| 19 | No RESUME |
| 24 | Device timeout |
| 25 | Device fault |
| 26 | FOR without NEXT |
| 27 | Out of paper |
| 29 | WHILE without WEND |
| 30 | WEND without WHILE |
| 33 | Duplicate label |
| 35 | Subprogram not defined |
| 37 | Argument-count mismatch |
| 38 | Array not defined |
| 40 | Variable required |
| 56 | FIELD statement active |
| 57 | Device I/O error |
| 58 | File already exists |
| 61 | Disk full |
| 67 | Too many files |
| 69 | Communication-buffer overflow |
| 71 | Disk not ready |
| 72 | Disk-media error |
| 73 | Feature unavailable |
| 74 | Rename across disks |

## Custom errors

Any code not listed above may be used as a custom error code with [ERROR](ERROR) to signal other errors in your application. To avoid confusion, it is a good idea to start at error code 100 and go up from there.

## Other Errors

*Syntax errors: QB64 will display most statement syntax and parameter errors in the Status area below the editing area in the IDE. It may also show missing brackets or other syntax punctuation required. Check the keyword's syntax when necessary.
*Memory errors: Loading many resources with a function like [_LOADIMAGE](_LOADIMAGE) and not freeing (e.g. [_FREEIMAGE](_FREEIMAGE)) can cause out of memory conditions, especially when executed in a loop.
*CPU consumption: Loops will tend to use 100% of a processor by default. Consider using [_LIMIT](_LIMIT) to restrict CPU usage.

## See also

* [ERL](ERL) (closest line number when line numbers are used)
* [ERR](ERR) (error code number) 
* [ERROR](ERROR) (simulates error)
* [_ERRORLINE](_ERRORLINE) (actual text code line)
* [_ERRORMESSAGE$](_ERRORMESSAGE$) (last error message or a specific message)
* [_INCLERRORFILE$](_INCLERRORFILE$)
* [_INCLERRORLINE](_INCLERRORLINE) (returns the line number in an [$INCLUDE](INCLUDE) file that caused the most recent error, when an $INCLUDE file is being used)
* [ON ERROR](ON-ERROR) (calls error handing routine using [GOTO](GOTO) only)
