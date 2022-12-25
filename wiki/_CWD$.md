The [_CWD$](_CWD$) function returns the current working directory path as a string value without a trailing path separator.

## Syntax
 
> workingDirectory$ = [_CWD$](_CWD$)

## Description

* By default, the initial working directory path is usually the same as the directory of the executable file run.
* The current working directory can be changed with the [CHDIR](CHDIR) or [SHELL](SHELL) command; CHDIR sets it, _CWD$ returns it.
* Path returns will change only when the working path has changed.  When in C:\ and run QB64\cwd.exe, it will still return C:\
* The current working directory string can be used in [OPEN](OPEN) statements and [SHELL](SHELL) commands that deal with files.
* Works in Windows, macOS and Linux. [_OS$](_OS$) can be used by a program to predict the proper slash separations in different OS's.

## Error(s)

* If an error occurs while obtaining the working directory from the operating system, [ERROR Codes](ERROR-Codes) 51 (Internal Error) will be generated.

## Example(s)

Get the current working directory, and move around the file system:

```vb

startdir$ = _CWD$
PRINT "We started at "; startdir$
MKDIR "a_temporary_dir"
CHDIR "a_temporary_dir"
PRINT "We are now in "; _CWD$
CHDIR startdir$
PRINT "And now we're back in "; _CWD$
RMDIR "a_temporary_dir"

```

```text

We started at C:\QB64
We are now in C:\QB64\a_temporary_dir
And now we're back in C:\QB64

```

## See Also

* [CHDIR](CHDIR) (Change the current working directory)
* [RMDIR](RMDIR) (Remove a directory in the file system)
* [KILL](KILL) (Delete a file in the file system)
* [MKDIR](MKDIR) (Create a directory in the file system)
* [_OS$](_OS$) (returns current OS to program)
* [_STARTDIR$](_STARTDIR$) (returns path the user called program from) 
