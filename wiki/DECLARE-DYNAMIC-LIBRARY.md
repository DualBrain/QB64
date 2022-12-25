**DECLARE DYNAMIC LIBRARY** allows you to dynamically link your program to functions in dynamically linkable libraries. At present, '**.dll**' , '**.so**' and '**.dylib**' files are supported. These libraries are loaded when your program begins. For **STATIC** library's '**.lib**', '**.h**', '**.hpp**', '**.a**', '**.o**' and '**.dylib**' files are also supported.

## Syntax

> **DECLARE** [**DYNAMIC**|**CUSTOMTYPE**|**STATIC**] **LIBRARY** [*"Library_file"*,_"other_lib_files"_]
>
>> {[SUB](SUB)|[FUNCTION](FUNCTION)} [*procedure_name* **ALIAS**] *library_procedure* (**BYVAL** *parameter(s)* [AS](AS) varType,...)
>>
>> ... 'other Library sub-procedures for named *DLL*
>
> **END DECLARE**

## Description

* The dynamic library file can be located in the QB64 folder (alongside your programs '.EXE'), in Windows' system32 folder, or in a relative/absolute path specified along with the library name.
* **Declarations must be made at the program start and only one file can be specified in each declaration block.**
* *Library_file* is the *library* file's name with a specified path when not in the QB64 or in the WINDOWS\SYSTEM32 folder. **Don't add the file extension**.
* *Library filename*s can be listed to combine more than one DLL or Header file name or path into one DECLARE LIBRARY block.
* *Procedure_name* is any procedure name you want to designate by using [ALIAS](ALIAS) with the *Library_procedure* name following. 
* *Parameters* used by the Library procedure must be passed by value ([BYVAL](BYVAL)) except for [STRING](STRING) values.
* ***.h* header files cannot be used with DECLARE DYNAMIC LIBRARY. Existence of any *.h* file of the same name as the *.DLL* file will cause DECLARE DYNAMIC LIBRARY to fail.**
* **IMPORTANT:** [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY) let's you specify any SUB/FUNCTION calling with the format you wish, but **if the size of the parameter list does not match the size expected within the library, then your code will probably cause a GPF (General Protection Fault).
* **STATIC** is the same as [DECLARE LIBRARY](DECLARE-LIBRARY) except that it prioritizes linking to static libraries (*.a/*.o) over shared object (*.so) libraries, if both exist. As Windows doesn't really use shared libraries (DLLs are a bit different) this does not affect Windows users.
* The [_OFFSET](_OFFSET) in memory can be used in **CUSTOMTYPE**, **STATIC** and **DYNAMIC LIBRARY** declarations.
* [SUB](SUB) procedures using DECLARE CUSTOMTYPE LIBRARY API procedures **may error**. Try DYNAMIC with the DLL name.
* Declarations can be made inside of [SUB](SUB) or [FUNCTION](FUNCTION) procedures. Declarations do not need to be at program start.
* **NOTE: It is up to the user to document and determine the suitability of all Libraries and procedures they choose to use. QB64 cannot guarantee that any procedure will work and cannot quarantee any troubleshooting help.**

## Availability

* Version 0.923 and up (Windows).
* Version 0.94 and up (Linux and macOS).

## Example(s)

This example plays Midi files using the *playmidi32.dll* documented here: [http://libertybasicuniversity.com/lbnews/nl110/midi3.htm Liberty Basic University]. Download the following DLL file to your main QB64 folder: [https://www.qb64.org/resources/Playmidi32.dll PlayMidi32.dll]

```vb

DECLARE DYNAMIC LIBRARY "playmidi32"
    FUNCTION PlayMIDI& (filename AS STRING)
END DECLARE
result = PlayMIDI(".\samples\qb64\original\ps2battl.mid" + CHR$(0))
PRINT result

```

> **Note:** Filename needs to be [CHR$](CHR$)(0) terminated. QB64 [STRING](STRING)s are passed to external libraries as pointers to first character.

Using a CUSTOMTYPE LIBRARY to return the [Unicode](Unicode) version of the current running program's name.

```vb

SCREEN 12

DECLARE CUSTOMTYPE LIBRARY 'Directory Information using KERNEL32 provided by Dav
    FUNCTION GetModuleFileNameA& (BYVAL hModule AS LONG, lpFileName AS STRING, BYVAL nSize AS LONG)
    FUNCTION GetModuleFileNameW& (BYVAL hModule AS LONG, lpFileName AS STRING, BYVAL nSize AS LONG)
END DECLARE

'=== SHOW CURRENT PROGRAM
FileName$ = SPACE$(512)

Result = GetModuleFileNameA(0, FileName$, LEN(FileName$))
IF Result THEN PRINT "CURRENT PROGRAM (ASCII): "; LEFT$(FileName$, Result)

'load a unicode font
f = _LOADFONT("cyberbit.ttf", 24, "UNICODE")
_FONT f
Result = GetModuleFileNameW(0, FileName$, LEN(FileName$) \ 2)
LOCATE 2, 1
PRINT QuickCP437toUTF32$("CURRENT PROGRAM (UTF): ") + QuickUTF16toUTF32$(LEFT$(FileName$, Result * 2))
_FONT 16 'restore CP437 font

FUNCTION QuickCP437toUTF32$ (a$)
b$ = STRING$(LEN(a$) * 4, 0)
FOR i = 1 TO LEN(a$)
    ASC(b$, i * 4 - 3) = ASC(a$, i)
NEXT
QuickCP437toUTF32$ = b$
END FUNCTION

FUNCTION QuickUTF16toUTF32$ (a$)
b$ = STRING$(LEN(a$) * 2, 0)
FOR i = 1 TO LEN(a$) \ 2
    ASC(b$, i * 4 - 3) = ASC(a$, i * 2 - 1)
    ASC(b$, i * 4 - 2) = ASC(a$, i * 2)
NEXT
QuickUTF16toUTF32$ = b$
END FUNCTION 

```

> **Note:** SUB procedures using CUSTOMTYPE LIBRARY API procedures inside may error. Try DYNAMIC with "KERNEL32".

**QB64 version 1.000 and up produce standalone executables. External DLL files must be distributed with your program.**
**Note: QB64 versions prior to 1.000 require all default DLL files to either be with the program or in the C:\WINDOWS\SYSTEM32 folder.**

## See Also

* [DECLARE LIBRARY](DECLARE-LIBRARY)
* [SUB](SUB), [FUNCTION](FUNCTION)
* [BYVAL](BYVAL), [ALIAS](ALIAS)
* [_OFFSET (function)](_OFFSET-(function)), [_OFFSET](_OFFSET) (variable type)
* [C Libraries](C-Libraries), [DLL Libraries](DLL-Libraries), [Windows Libraries](Windows-Libraries)
* [Port Access Libraries](Port-Access-Libraries)
