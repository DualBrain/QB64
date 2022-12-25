The **SHARED** statement allows variables to be passed automatically to any [SUB](SUB) or [FUNCTION](FUNCTION) procedure.

## Syntax

> [**DIM**](DIM) **SHARED** Qt [**AS**](AS) [**STRING**](STRING) * 1

> [**DIM**](DIM) **SHARED** [**AS**](AS) [**STRING**](STRING) * 1 Qt


## Description
* [DIM](DIM)ensioned variables are shared with all procedures in the program module.
* When used with [DIM](DIM) in the main module, it eliminates the need to pass a parameter variable to a [SUB](SUB) or [FUNCTION](FUNCTION). 
* Use [COMMON SHARED](COMMON-SHARED) to share a list of variable values with sub-procedures or other modules. See also: [COMMON](COMMON)
* SHARED (**without [DIM](DIM)**) can share a list of variables inside of [SUB](SUB) or [FUNCTION](FUNCTION) procedures with the main module only.
* When using the **AS type variable-list** syntax, type symbols cannot be used.
> **Note: SHARED variables in sub-procedures will not be passed to other sub-procedures, only the main module.**

## Example(s)

Defining variable types with [AS](AS) or type suffixes.

```vb

DIM SHARED Qt AS STRING * 1, price AS DOUBLE, ID AS INTEGER
DIM SHARED Q$, prices#, IDs%

```

The DIR$ function returns a filename or a list when more than one exist. The file spec can use a path and/or wildcards.

```vb

FOR i = 1 TO 2
  LINE INPUT "Enter a file spec: ", spec$
  file$ = DIR$(spec$)        'use a file spec ONCE to find the last file name listed
  PRINT DIRCount%, file$,    'function can return the file count using SHARED variable 
  DO
    K$ = INPUT$(1)
    file$ = DIR$("")         'use an empty string parameter to return a list of files!
    PRINT file$,
  LOOP UNTIL LEN(file$) = 0  'file list ends with an empty string
NEXT
END

FUNCTION DIR$ (spec$)
CONST TmpFile$ = "DIR$INF0.INF", ListMAX% = 500  'change maximum to suit your needs
SHARED DIRCount%                                 'returns file count if desired
STATIC Ready%, Index%, DirList$()
IF NOT Ready% THEN REDIM DirList$(ListMax%): Ready% = -1  'DIM array first use
IF spec$ > "" THEN                               'get file names when a spec is given
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
  DIRCount% = Index%                       'SHARED variable can return the file count
  CLOSE #ff%
  KILL TmpFile$
ELSE IF Index% > 0 THEN Index% = Index% - 1 'no spec sends next file name
END IF                                      
DIR$ = DirList$(Index%)
END FUNCTION 

```

> *Explanation:* The SHARED variable value *DIRcount%* can tell the main program how many files were found using a wildcard spec.

## See Also
 
* [DIM](DIM), [REDIM](REDIM)
* [COMMON](COMMON), [COMMON SHARED](COMMON-SHARED)
