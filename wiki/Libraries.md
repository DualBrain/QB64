**DLL, C++ and the Windows API Libraries**

* Working with QB64 Declarations: [C Libraries](C-Libraries), [DLL Libraries](DLL-Libraries), [Windows Libraries](Windows-Libraries)
* QB64 Library Keywords: [DECLARE LIBRARY](DECLARE-LIBRARY), [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY), [ALIAS](ALIAS), [BYVAL](BYVAL)
* [PEEK](PEEK) and [POKE](POKE) Library: [PEEK and POKE Library](PEEK-and-POKE-Library)
* COM and LPT *Inpout32.dll* [OUT](OUT): [Port Access Libraries](Port-Access-Libraries)
* Setting Windows environment values and changing them in the Registry: [Windows Environment](Windows-Environment)
* SFML sound library: [SFML Library](SFML-Library)
* Windows program [Windows Libraries](Windows-Libraries) and [Windows Libraries](Windows-Libraries) that do not require focus of the program.
* Windows Registry Library: [Windows_Registry_Access](Windows-Registry-Access)
* Windows or Linux SQL Database Library: [SQL Client](SQL-Client)

**Creating your own $INCLUDE Text Libraries**

To create your own libraries of your favorite Basic subs and functions, just copy the QB64 code to a text file and save it as a BI or BM file. Then all you need to do is [$INCLUDE]($INCLUDE) the text file name after all of the [SUB](SUB) and [FUNCTION](FUNCTION) code in the program. Once it is compiled, the text file is no longer needed. Save it for other programs you create! No more Object or QLB files to mess with either!

* Variable DEF, [DIM](DIM), [SHARED](SHARED), [TYPE](TYPE) and [DATA](DATA) statements should be [$INCLUDE]($INCLUDE)d in a **BI** text file at the start of the program.

* [SUB](SUB) and [FUNCTION](FUNCTION) code should be [$INCLUDE]($INCLUDE)d at the very bottom of the QB64 BAS code module in a **BM** text file.

* QB64 also allows [TYPE](TYPE) declarations to be placed inside of [SUB](SUB) or [FUNCTION](FUNCTION) procedures!

**Note: QB64 requires all DLL files to either be with the program or in the C:\WINDOWS\SYSTEM32 folder!**

## C++ Variable Types

The following C++ variable types should be used when converting sub-procedure parameters from Libraries to QB64 variable types.



**QB64 Library Conversion Types**

| C Name    |    Description                | Size    | Signed     Range      | Unsigned |
| --------- | ----------------------------- | ------- | --------------------- | -------- |
| [_BYTE](_BYTE) | Character or small integer. |  1 byte  | -128 to 127 |    0 to 255|
| [INTEGER](INTEGER)  | Short Integer(Word)    |  2 byte  | -32768 to 32767    |  0 to 65535 |
| [LONG](LONG)    |  Integer(Dword)             |  4 byte  |  -2147483648 to 2147483647 |  0 to 4294967295 | 
| [LONG](LONG)    | Int32, Long integer or Long | 4 byte |  -2147483648 to 2147483647 | 0 to 4294967295 |
| [_INTEGER64](_INTEGER64) |  Long long (Qword)  | 8 byte |  -9223372036854775808 to 9223372036854775807 | 0 to 18,446,744,073,709,551,615 |
| [Boolean](Boolean)   |  Boolean value true or false. | 1 byte  |  true or false | - |
| [SINGLE](SINGLE)   |    Floating point number    |    4 byte  |  +/- 3.4E+/-38 (~7 digits) | -  |
| [DOUBLE](DOUBLE) |   Double precision floating. |   8 byte  |  1.7976E+308 (~15 digits) | -  |
| [_FLOAT](_FLOAT) | Long double precision float |  10 byte  | 1.1897E+4932 (~22 digits) | - |
| [Unicode](Unicode)  |   Wide character([Unicode](Unicode)) |	  2 or 4   | 1 wide character | - |
| [_OFFSET](_OFFSET)   |    void pointer(void *)     |      ANY    |  Pointer or offset | - |



The values of the columns Size and Range depend on the system the program is compiled. The values shown above are those found on most 32-bit systems, but for other systems, the general specification is that int has the natural size suggested by the system architecture (one "word") and the four integer types char, short, int and long must each be at least as large as the numerical type preceding it, with char being always one byte in size. The same applies to the floating point types float, double and long double, where each one must provide at least as much precision as the one that preceded it.



**Windows API Data Structures**

| Name |              Description   |            Bits            |        QB64 Type |
| ---- | -------------------------- | -------------------------- | ---------------- | 
| bit  |         8 bits in one byte |            1               |        [_BIT](_BIT) |
| nybble          |      2 nybbles in one byte  |        4        |                [_BIT](_BIT) * 4| 
| byte            |        1 byte (2 nybbles)  |           8             |        [_BYTE](_BYTE)| 
| Char(FunctionA) | [ASCII](ASCII) character   | 8 ([LEN](LEN)(buffer))  |      [_BYTE](_BYTE)| 
| WORD            |   2 bytes         |              16          |              [INTEGER](INTEGER) | 
| CharW(FunctionW) |   [Unicode](Unicode) wide character   |  16 ([LEN](LEN)(buffer) \ 2)    |   [_BYTE](_BYTE) * 2 | 
| DWORD           |      4 bytes      |                 32              |          [LONG](LONG) | 
| QWORD           |      8 bytes      |                 64              |          [_INTEGER64](_INTEGER64) | 
| Ptr or LP       |      Short or Long Pointer name |   ANY             |          [_OFFSET](_OFFSET) | 


