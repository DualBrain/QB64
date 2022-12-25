The [FILES](FILES) statement is used to print a list of files in the current directory using a file specification.

## Syntax

> [FILES](FILES) [fileSpec$]

## Description

* fileSpec$ is a string expression or variable containing a path when required.
* fileSpec$ can use the * and ? wildcard specifications:
  - `*` denotes one or more wildcard characters in a filename or path specification as any legal file name  character(s).
  - `?` denotes one wildcard letter in a filename or path specification as any legal filename character. 
* If fileSpec$ is omitted, it is assumed to be **"*.*"** (all files and folders in the current directory).
* Illegal filename characters in **QB64** include * > < : " | \ / with any amount of dot extensions being allowed in Windows.
* FILES lists can make the screen roll up. Try using SHELL "DIR" with the /P option. [DIR command](http://www.computerhope.com/dirhlp.htm).

## QBasic

* Illegal filename characters in QBasic included *** ? , > < ; : " | \ / + [ ]** and more than one dot extension in [DOS](http://www.computerhope.com/issues/ch000209.htm).

## Example(s)

Finding a list of all BAS files in the current folder. 

```vb

FILES "*.BAS"

```

## Alternative file list solutions

*Alternative 1:* The DIR$ function adapted from PDS (7.1) returns a filename or a list when more than one exist. The file spec can use a path and/or wildcards.

```vb

FOR i = 1 TO 2
  PRINT
  LINE INPUT "Enter a file spec: ", spec$
  file$ = DIR$(spec$) 'use a file spec ONCE to find the last file name listed
  PRINT DIRCount%, file$, 'function can return the file count using SHARED variable
  IF DIRCount% > 1 THEN
    DO
      K$ = INPUT$(1)
      file$ = DIR$("") 'use an empty string parameter to return a list of files!
      PRINT file$,
    LOOP UNTIL LEN(file$) = 0 'file list ends with an empty string
  END IF
NEXT

END

FUNCTION DIR$ (spec$)
CONST TmpFile$ = "DIR$INF0.INF", ListMAX% = 500 'change maximum to suit your needs
SHARED DIRCount% 'returns file count if desired
STATIC Ready%, Index%, DirList$()
IF NOT Ready% THEN REDIM DirList$(ListMAX%): Ready% = -1 'DIM array first use
IF spec$ > "" THEN 'get file names when a spec is given
  SHELL _HIDE "DIR " + spec$ + " /b > " + TmpFile$
  Index% = 0: DirList$(Index%) = "": ff% = FREEFILE
  OPEN TmpFile$ FOR APPEND AS #ff%
  size& = LOF(ff%)
  CLOSE #ff%
  IF size& = 0 THEN KILL TmpFile$: EXIT FUNCTION
  OPEN TmpFile$ FOR INPUT AS #ff%
  DO WHILE NOT EOF(ff%) AND Index% < ListMAX%
    Index% = Index% + 1
    LINE INPUT #ff%, DirList$(Index%)
  LOOP
  DIRCount% = Index% 'SHARED variable can return the file count
  CLOSE #ff%
  KILL TmpFile$
ELSE IF Index% > 0 THEN Index% = Index% - 1 'no spec sends next file name
END IF
DIR$ = DirList$(Index%)
END FUNCTION 

```

> *Explanation:* The function will verify that a file exists (even if it is empty) by returning its name, or it returns an empty string if no file exists. It can return a list of file names by using an empty string parameter("") after sending a wildcard spec to get the first file name. The number of file names found is returned by using the SHARED variable, **DIRCount%**. Unlike the PDS DIR$ function, **it must use an empty string parameter as QB64 doesn't support optional parameters.** The function does not delete empty files.

*Alternative 2:*
* The member-contributed [FILELIST$](FILELIST$) function uses the mouse and does not affect your program screens. It can verify that a file name exists or display a list of long and short file names to choose from. It also avoids program errors when a file name does not exist.

## See Also

* [SHELL](SHELL), [SCREEN (function)](SCREEN-(function)) (See Example 3)
* [CHDIR](CHDIR), [MKDIR](MKDIR)
* [RMDIR](RMDIR), [KILL](KILL)
* [_CWD$](_CWD$), [_STARTDIR$](_STARTDIR$)
* [_FILEEXISTS](_FILEEXISTS), [_DIREXISTS](_DIREXISTS)
* [Windows Libraries](Windows-Libraries)
* [Windows Libraries](Windows-Libraries)
* [$CONSOLE]($CONSOLE)
