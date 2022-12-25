**_OFFSET Explanation By Michael Calkins**

An **_OFFSET** means a pointer. Use it any time that you need to pass or receive a pointer. With the API, types that start with P or LP, and parameters that start with p or lp are generally pointers.

As for when to use the [_OFFSET](_OFFSET) data type, it is basically any time that you need to pass a pointer to a function as a parameter, or have a pointer returned from a function as a return value. The _OFFSET type is basically the same as a void pointer in C. A pointer is a variable that holds a memory address. (I sometimes refer to the memory address itself as being a pointer, but usually, "pointer" means a variable that holds a memory address.) The symbol for a pointer in C is the asterisk, *, following some other type name. 

So for example in C: **void *** means a void pointer, that is, a pointer to a variable of any type.

Also, for example: **CHAR *** means a pointer to a CHAR.

**Example using QueryDosDeviceA to enumerate COM ports**

```vb

'public domain by Michael Calkins, sept 2011, 

DECLARE DYNAMIC LIBRARY "kernel32"
 FUNCTION QueryDosDeviceA~& (BYVAL lpDeviceName AS _UNSIGNED _OFFSET, BYVAL lpTargetPath AS _UNSIGNED _OFFSET, BYVAL ucchMax AS _UNSIGNED LONG)
 FUNCTION GetLastError~& ()
END DECLARE

DIM sizeofbuffer AS _UNSIGNED LONG
DIM buffer AS STRING
DIM i AS _UNSIGNED LONG
DIM x AS _UNSIGNED LONG
DIM n AS _UNSIGNED LONG
sizeofbuffer = 1024
buffer = SPACE$(sizeofbuffer)

DO
 x = 0
 IF QueryDosDeviceA~&(0, _OFFSET(buffer), sizeofbuffer) = 0 THEN
  x = GetLastError~&
  IF x = &H7A THEN
   sizeofbuffer = sizeofbuffer + 1024
   buffer = SPACE$(sizeofbuffer)
  ELSE
   PRINT "Error: 0x"; HEX$(x)
   END
  END IF
 END IF
LOOP WHILE x = &H7A

i = 1
n = 0
DO WHILE ASC(MID$(buffer, i, 1))
 x = INSTR(i, buffer, CHR$(0))
 PRINT MID$(buffer, i, x - i)
 IF MID$(buffer, i, 3) = "COM" THEN
  REDIM _PRESERVE comports(0 TO (n * 2) + 1) AS STRING
  comports(n * 2) = MID$(buffer, i, (x - i) + 1)
  n = n + 1
 END IF
 i = x + 1
LOOP

PRINT
PRINT n; "COM ports:"
IF n THEN
 FOR i = 0 TO n - 1
  DO
   x = 0
   IF QueryDosDeviceA~&(_OFFSET(comports(i * 2)), _OFFSET(buffer), sizeofbuffer) = 0 THEN
    x = GetLastError~&
    IF x = &H7A THEN
     sizeofbuffer = sizeofbuffer + 1024
     buffer = SPACE$(sizeofbuffer)
    ELSE
     PRINT "Error: 0x"; HEX$(x)
     END
    END IF
   END IF
  LOOP WHILE x = &H7A
  comports((i * 2) + 1) = LEFT$(buffer, INSTR(buffer, CHR$(0)) - 1)
  comports(i * 2) = LEFT$(comports(i * 2), LEN(comports(i * 2)) - 1)
  PRINT CHR$(&H22); comports(i * 2); CHR$(&H22); " is mapped to: "; CHR$(&H22); comports((i * 2) + 1); CHR$(&H22)
 NEXT
END IF

buffer = ""
END 

```

So, you would look at the function prototype in the MSDN article, and match the data types of all of the parameters and the return value to QB64 data types. _OFFSET is the type to use for any kind of pointer. MSDN has a list of data types:

[MSDN list of Data types](http://msdn.microsoft.com/en-us/library/aa383751(v=vs.85).aspx)

You can look up the types in that article. Note that many types are derived from other types, so you may have to follow the chain back, looking up each type that the other type was derived from, until you get back to a standard type like int or void*. Deriving types in C is accomplished with typedef. (Just as a note: the current version of that article on the web seems to have a problem, where the #ifdef UNICODE blocks aren't displaying properly, at least in my browser. I am going by an older version of that article that I saved.)

For example, let's look at the **QueryDosDevice** function that is used above:

```text

DWORD WINAPI QueryDosDevice(
  __in_opt  LPCTSTR lpDeviceName,
  __out     LPTSTR lpTargetPath,
  __in      DWORD ucchMax
); 

```

[http://msdn.microsoft.com/en-us/library/aa365461(v=VS.85).aspx](http://msdn.microsoft.com/en-us/library/aa365461(v=VS.85).aspx)

So, the function returns a DWORD, and accepts 3 parameters: an LPCTSTR, an LPTSTR, and a DWORD.

* **For the return type:**

If the return type were void, it would be a [SUB](SUB). Any return type other than void means a [FUNCTION](FUNCTION). Look up "DWORD" in the data type list. (The URL is given above.)

```text

A 32-bit unsigned integer. The range is 0 through 4294967295 decimal

This type is declared in WinDef.h as follows:

typedef unsigned long DWORD;

```

> Obviously, the QB64 type that corresponds to this is [_UNSIGNED](_UNSIGNED) [LONG](LONG).

```text

QueryDosDeviceW (Unicode) and QueryDosDeviceA (ANSI)

```

> In this instance, I chose to use the [ASCII](ASCII) version of the function **QueryDosDeviceA** instead of the [Unicode](Unicode) version (**QueryDosDeviceW**) for simplicity. (A stands for ANSI, W stands for wide, as in wide char.)

So, we have:

```text

   **FUNCTION QueryDosDeviceA~& (**

```

* **First parameter:**

Look up LPCTSTR in the data type list:

```text

An LPCWSTR if UNICODE is defined, an LPCSTR otherwise. 
For more information, see Windows Data Types for Strings.

This type is declared in WinNT.h as follows:

<nowiki>#ifdef UNICODE
 typedef LPCWSTR LPCTSTR; 
#else
 typedef LPCSTR LPCTSTR;
#endif
</nowiki>

```

> As noted above, I have chosen to use the ASCII version of the function, so it corresponds to LPCSTR. Look that up:

```text

A pointer to a constant null-terminated string of 8-bit Windows (ANSI) characters. 

For more information, see Character Sets Used By Fonts.

This type is declared in WinNT.h as follows:

    typedef __nullterminated CONST CHAR *LPCSTR;

```

> This tells us that it is a pointer to a string. Since it is a pointer, the QB64 type it corresponds to is [_OFFSET](_OFFSET).

By the way, all parameters, including pointers, will be passed [BYVAL](BYVAL). So, we have:

```text

**FUNCTION QueryDosDeviceA~& (BYVAL lpDeviceName AS _UNSIGNED _OFFSET,**

```

* **Second parameter:**

Look up LPTSTR in the data type list:

```text

LPTSTR   

An LPWSTR if UNICODE is defined, an LPSTR otherwise. 
For more information, see Windows Data Types for Strings.

This type is declared in WinNT.h as follows:
<nowiki>
#ifdef UNICODE
 typedef LPWSTR LPTSTR;
#else
 typedef LPSTR LPTSTR;
#endif </nowiki>

```

>  Again, I decided not to use Unicode this time, so look up LPSTR:

```text

A pointer to a null-terminated string of 8-bit Windows (ANSI) characters. 
For more information, see Character Sets Used By Fonts.

This type is declared in WinNT.h as follows:

typedef CHAR *LPSTR;

```

>  Again, it is a pointer to a string. Again, pointers correspond to [_OFFSET](_OFFSET).

```text

**FUNCTION QueryDosDeviceA~& (BYVAL lpDeviceName AS _UNSIGNED _OFFSET, BYVAL lpTargetPath AS _UNSIGNED _OFFSET,**

```

* **Third parameter:**

This is a DWORD. We have already looked up DWORD, and we know it is an [_UNSIGNED](_UNSIGNED) [LONG](LONG). We have finished our function declaration:

```text

** FUNCTION QueryDosDeviceA~& (BYVAL lpDeviceName AS _UNSIGNED _OFFSET, BYVAL lpTargetPath AS _UNSIGNED _OFFSET, BYVAL ucchMax AS _UNSIGNED LONG)**

```

* Based on the above example, it should be trivial to figure out the declaration for GetLastError:

[http://msdn.microsoft.com/en-us/library/windows/desktop/ms679360(v=vs.85).aspx](http://msdn.microsoft.com/en-us/library/windows/desktop/ms679360(v=vs.85).aspx)

```text

DWORD WINAPI GetLastError(void);

```

> The void in the parameter list means that it accepts no parameters. For the return value, we already know that a DWORD is an [_UNSIGNED](_UNSIGNED) [LONG](LONG):

```text

**FUNCTION GetLastError~& ()**

```

**QueryDosDeviceA Function Usage**

Now that I have declared the function, notice how I use it.

**The first usage of the QueryDosDevice Function:**

```vb

IF QueryDosDeviceA~&(0, _OFFSET(buffer), sizeofbuffer) = 0 THEN

```

* **The first parameter:**

```text

lpDeviceName [in, optional]

 An MS-DOS device name string specifying the target of the query. The device name cannot have a trailing backslash; for example, use "C:", not "C:\".

 This parameter can be NULL. In that case, the QueryDosDevice function will store a list of all existing MS-DOS device names into the buffer pointed to by lpTargetPath.

```

> lpDeviceName is an optional pointer to a null terminated ASCII string holding the device name. In this case, I want a list of all of the DOS device names, so I give it a null pointer, 0. This is in harmony with: "If lpDeviceName is NULL, the function retrieves a list of all existing MS-DOS device names." This is why it is referred to as optional, because the pointer can be left null, 0.

* **The second parameter:**

```text

lpTargetPath [out]

    A pointer to a buffer that will receive the result of the query. The function fills this buffer with one or more null-terminated strings. The final null-terminated string is followed by an additional NULL.

    If lpDeviceName is non-NULL, the function retrieves information about the particular MS-DOS device specified by lpDeviceName. The first null-terminated string stored into the buffer is the current mapping for the device. The other null-terminated strings represent undeleted prior mappings for the device.

    If lpDeviceName is NULL, the function retrieves a list of all existing MS-DOS device names. Each null-terminated string stored into the buffer is the name of an existing MS-DOS device, for example, \Device\HarddiskVolume1 or \Device\Floppy0.

```

> lpTargetPath is a pointer to a buffer to receive the data as null terminated ASCII strings. I give it a pointer to [_OFFSET](_OFFSET)(buffer).

* **The third parameter:**

```text

ucchMax [in]

The maximum number of TCHARs that can be stored into the buffer pointed to by lpTargetPath.

```

> We need to know what a TCHAR is, since it is involved both in ucchMax and in the return value. Look up TCHAR in the data type list:

```text

A WCHAR if UNICODE is defined, a CHAR otherwise.

This type is declared in WinNT.h as follows:

#ifdef UNICODE
 typedef WCHAR TCHAR;
#else
 typedef char TCHAR;
#endif

```

> Since we are not using [Unicode](Unicode) this time, it is a char, a byte of an ASCII string. (Note that if we were using Unicode, a TCHAR would be two bytes, as you would find out by looking up WCHAR. Keep this in mind if you ever use [Unicode](Unicode) functions, as buffers will need two bytes per character in that instance.)

> **ucchMax** is an unsigned long specifying how large the buffer is. I give it an [_UNSIGNED](_UNSIGNED) [LONG](LONG), sizeofbuffer, containing the size of buffer in TCHARs.

> **It is very important that you don't report a size larger than the buffer actually is. The function has no other way of knowing how large the buffer is, and could overwrite other data if you specify a size that is too large. (Again, if you ever use a Unicode function, you will need 2 bytes per character, so the number of TCHARs would be LEN(buffer)\2.)**

* **First Return value:**

The function returns an [_UNSIGNED](_UNSIGNED) [LONG](LONG).

```text

If the function succeeds, the return value is the number of TCHARs stored into the buffer 
pointed to by lpTargetPath.

If the function fails, the return value is zero. To get extended error information, call 
GetLastError.

If the buffer is too small, the function fails and the last error code is ERROR_INSUFFICIENT_BUFFER.

```

> So, that is what I test for. If the return value is 0, then I check the error code using GetLastError~&. If the error code is ERROR_INSUFFICIENT_BUFFER, 0x7a, then I try again with a larger buffer.

After a successful call, buffer, the buffer pointed to by lpTargetPath, will contain a list of all of the DOS device names, each null terminated, with an extra null at the end of the list.

* **Second Return value:**

```vb

IF QueryDosDeviceA~&(_OFFSET(comports(i * 2)), _OFFSET(buffer), sizeofbuffer) = 0 THEN

```

> The difference this time is in the first parameter. By now I have gone through the list of all device names, and have picked out the ones that start with "COM". I now want to find the current mapping for each of them. lpDeviceName is a pointer to a null terminated ASCII string containing the device name. So I give it _OFFSET(comports(i * 2)), which is exactly that. (As I said in the original post, I leave a terminating null until after this call.)

After a successful call, buffer, the buffer pointed to by lpTargetPath, will contain one or more null terminated strings, with an extra null after the last. I am only interested in the first of these, which is the current mapping.

I hope that this answers the question, and adequately demonstrates how to use the Windows API from QB64. If not, inquire further, and I or someone else will try to answer it. Please point out any mistakes.

Regards,

Michael

* **Warning: QB64 variable length strings can move about in memory AT ANY TIME. If you get the _OFFSET of a variable length sting on one line and use it on the next it may not be there anymore. To be safe, move variable length strings into fixed length strings first.**

## See Also

* [_OFFSET](_OFFSET), [_OFFSET (function)](_OFFSET-(function))
* [BYVAL](BYVAL), [_UNSIGNED](_UNSIGNED)
* [DECLARE LIBRARY](DECLARE-LIBRARY)
