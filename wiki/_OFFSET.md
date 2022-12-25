The [_OFFSET](_OFFSET) variable type stores the location of a value in memory. The byte size varies as required by the system.

## Syntax

> [DIM](DIM) variable [AS](AS) **[_OFFSET](_OFFSET)**

## Description

* [_OFFSET](_OFFSET) types can be created as signed or [_UNSIGNED](_UNSIGNED) at the programmer's discretion.
* The type suffix for [_OFFSET](_OFFSET) is **%&** which designates the integer value's flexible size.
* Offset values are only useful when used in conjunction with [_MEM](_MEM) or [DECLARE LIBRARY](DECLARE-LIBRARY) procedures.
* OFFSET values are used as a part of the [_MEM](_MEM) variable [Variable Types](Variable-Types) in QB64. Variable.OFFSET returns or sets the current position in memory.
* API [DECLARE LIBRARY](DECLARE-LIBRARY) parameter or [TYPE](TYPE) names may include **lp, ptr** or **p** which designates them as a pointer type.
* **Warning: [_OFFSET](_OFFSET) values cannot be cast to other variable type values reliably.**
* **Warning: Variable length [STRING](STRING) values can move about in memory at any time.** If you get the [_OFFSET](_OFFSET) of a variable length sting on one code line and use it on the next it may not be there anymore.** To be safe, move variable length strings into fixed length strings first.**

## Example(s)

The SHBrowseForFolder function receives information about the folder selected by the user in Windows XP and 7.

```vb

DECLARE CUSTOMTYPE LIBRARY
    FUNCTION FindWindow& (BYVAL ClassName AS _OFFSET, WindowName$)
END DECLARE

_TITLE "Super Window"
hwnd& = FindWindow(0, "Super Window" + CHR$(0))

TYPE BROWSEINFO  'typedef struct _browseinfo '[Microsoft MSDN](http://msdn.microsoft.com/en-us/library/bb773205%28v=vs.85%29.aspx)
  hwndOwner AS LONG '              '  HWND 
  pidlRoot AS _OFFSET '            '  PCIDLIST_ABSOLUTE
  pszDisplayName AS _OFFSET '      '  LPTSTR 
  lpszTitle AS _OFFSET '           '  LPCTSTR       
  ulFlags AS _UNSIGNED LONG        '  UINT   
  lpfn AS _OFFSET '                '  BFFCALLBACK  
  lParam AS _OFFSET '              '  LPARAM  
  iImage AS LONG '                 '  int  
END TYPE  'BROWSEINFO, *PBROWSEINFO, *LPBROWSEINFO;

DECLARE DYNAMIC LIBRARY "shell32"
  FUNCTION SHBrowseForFolder%& (x AS BROWSEINFO) '[Microsoft MSDN](http://msdn.microsoft.com/en-us/library/bb762115%28v=vs.85%29.aspx)
  SUB SHGetPathFromIDList (BYVAL lpItem AS _OFFSET, BYVAL szDir AS _OFFSET) '[Microsoft MSDN](http://msdn.microsoft.com/en-us/library/bb762194%28VS.85%29.aspx)
END DECLARE

DIM b AS BROWSEINFO
b.hwndOwner = hwnd
DIM s AS STRING * 1024
b.pszDisplayName = _OFFSET(s$)
a$ = "Choose a folder!!!" + CHR$(0)
b.lpszTitle = _OFFSET(a$)
DIM o AS _OFFSET
o = SHBrowseForFolder(b)
IF o THEN
    PRINT LEFT$(s$, INSTR(s$, CHR$(0)) - 1)
    DIM s2 AS STRING * 1024
    SHGetPathFromIDList o, _OFFSET(s2$)
    PRINT LEFT$(s2$, INSTR(s2$, CHR$(0)) - 1)
ELSE
    PRINT "Cancel?"
END IF 

```

## See Also

* [_WINDOWHANDLE](_WINDOWHANDLE)
* [Using _OFFSET](Using--OFFSET)
* [_OFFSET (function)](_OFFSET-(function)), [_MEM](_MEM)
* [DECLARE LIBRARY](DECLARE-LIBRARY)
* [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY)
* [Variable Types](Variable-Types)
