**TYPE** definitions are used to create variables that can hold more than one element.

## Syntax

> **TYPE** typename
>
>> element-name1 [**AS**](AS) type
>>
>> element-name2 [**AS**](AS) type
>>
>> (...)
>>
>> element-nameN [**AS**](AS) type
>
> **END TYPE**

> **TYPE** typename
>>
>> [**AS**](AS) type element-list1
>>
>> [**AS**](AS) type element-list2
>>
>> (...)
>>
>>
>> [**AS**](AS) type element-listN
>>
> **END TYPE**

## Description

* Typename is an undefined type name holder as it can hold any variable types.
* TYPE definitions are usually placed in the main module before the start of the program code execution.
* TYPE definitions cam also be placed in [SUB](SUB) or [FUNCTION](FUNCTION) procedures.
* TYPE definitions cannot contain Array variables. Arrays can be [DIM](DIM)ensioned as a TYPE definition.
* TYPE definitions cannot be inside of another TYPE definition, but variables can be defined AS another type.(See Example 4)
* TYPE definitions must be ended with [END TYPE](END-TYPE).
* A TYPE variable must be assigned to the type after it is defined. Array variables are allowed.
* Type variables must be defined in every SUB or FUNCTION unless the type variable is [DIM](DIM)ensioned as [SHARED](SHARED).
* Type variables use DOT variable names to read or write specific values. They do not use type suffixes as they can hold ANY variable type values! The name before the dot is the one you defined after the type definition and the name after is the variable name used inside of the TYPE. The name of the dimensioned type variable alone can be used to [PUT](PUT) # or [GET](GET) # all of the data at once!
* Once the TYPE variable is created you can find the record or byte size by using [LEN](LEN)(typevariable).
* TYPE definitions can also be placed in [$INCLUDE]($INCLUDE) .BI text files such as [QB.BI](QB.BI) is used by [INTERRUPT](INTERRUPT) and [INTERRUPTX](INTERRUPTX).
* You can mix the **element-name AS type** syntax with the **AS type element-list** syntax in the same TYPE block.
* **[_BIT](_BIT) is not supported in User Defined [TYPE](TYPE)s**.

### Numerical Types

| Type Name | Symbol | Minimum Value | Maximum Value |
| --------- | ------ | ------------- | ------------- |
| _BIT | ` | -1 | 0 |
| _BIT * n | `n | -128 | 127 |
| _UNSIGNED _BIT | ~` | 0 | 1 |
| _BYTE | %% | -128 | 127 |
| _UNSIGNED _BYTE | ~%% | 0 | 255 |
| INTEGER | % | -32,768 | 32,767 |
| _UNSIGNED INTEGER | ~% | 0 | 65,535 |
| LONG | & | -2,147,483,648 | 2,147,483,647 |
| _UNSIGNED LONG | ~& | 0 | 4,294,967,295 |
| _INTEGER64 | && | -9,223,372,036,854,775,808 | 9,223,372,036,854,775,807 |
| _UNSIGNED _INTEGER64 | ~&& | 0 | 18,446,744,073,709,551,615 |
| SINGLE | ! or none | -2.802597E-45 | +3.402823E+38 |
| DOUBLE | # | -4.490656458412465E-324 | +1.797693134862310E+308 |
| _FLOAT | ## | -1.18E−4932 | +1.18E+4932 |
| _OFFSET | %& | -9,223,372,036,854,775,808 | 9,223,372,036,854,775,807 |
| _UNSIGNED _OFFSET | ~%& | 0 | 18,446,744,073,709,551,615 |
| _MEM | none | combined memory variable type | N/A |

*Note: For the floating-point numeric types [SINGLE](SINGLE) (default when not assigned), [DOUBLE](DOUBLE) and [_FLOAT](_FLOAT), the minimum values represent the smallest values closest to zero, while the maximum values represent the largest values closest to ±infinity. OFFSET dot values are used as a part of the [_MEM](_MEM) variable type in QB64 to return or set the position in memory.*

### String Text Type

| Type Name | Symbol | Minimum Length | Maximum Length | Size (Bytes) |
| --------- | ------ | -------------- | -------------- | ------------ |
| STRING | $ | 0 | 2,147,483,647 | Use LEN |
| STRING * *n* | $n | 1 | 2,147,483,647 | n |

*Note: For the fixed-length string type [STRING * n](STRING), where n is an integer length value from 1 (one) to 2,147,483,647.*

## Examples

Creating a mouse [INTERRUPT](INTERRUPT) TYPE definition. Each [INTEGER](INTEGER) value is 2 bytes.

```vb

TYPE RegType
  AX AS INTEGER    ' mouse function to use
  BX AS INTEGER    ' mouse button
  CX AS INTEGER    ' mouse graphic column position
  DX AS INTEGER    ' mouse graphic row position
  BP AS INTEGER    ' not used by mouse, but required *
  SI AS INTEGER    ' not used by mouse, but required *
  DI AS INTEGER    ' not used by mouse, but required *
  Flags AS INTEGER ' not used by mouse but required *
  DS AS INTEGER    ' used by INTERRUPTX only
  ES AS INTEGER    ' used by INTERRUPTX only
END TYPE

DIM SHARED InRegs AS RegType, OutRegs AS RegType ' create dot variables

InRegs.AX = 3 ' sets the mouse function to read the mouse buttons and position.

CALL INTERRUPT(&H33, InRegs, OutRegs)

column% = OutRegs.CX ' returns the current mouse column position

```

> *Explanation:* InRegs and OutRegs become the DOT variable prefix name for the TYPE definition's variables.

> Each TYPE variable is designated as the DOT variable's suffix.

*** Note: Omitting variables in the RegType definition can change other program variable values.**

Simplifying the TYPE from Example 1 using the alternative TYPE syntax.

```vb

TYPE RegType
  AS INTEGER AX, BX, CX, DX, BP, SI, DI, Flags, FS, ES
END TYPE

```

> *Explanation:* By using **AS type element-list** you reduce typing in your TYPE definition, while achieving the same results.

Creating an addressbook database for a [RANDOM](RANDOM) file.

```vb

TYPE ContactInfo
  First AS STRING * 10
  Last AS STRING * 15
  Address1 AS STRING * 30
  Address2 AS STRING * 30
  City AS STRING * 15
  State AS STRING * 2
  Zip AS LONG   ' (4 bytes)
  Phone AS STRING * 12
END TYPE

DIM Contact AS ContactInfo 'create contact record variable for RANDOM file 
RecordLEN% = LEN(Contact) ' 118 bytes
' define values
Contact.First = "Ted" ' the fixed string length value will contain 7 extra spaces
Contact.Zip = 15236 ' LONG value that can be used to search certain zip code numbers.

PUT #1, 5, Contact  'place contact info into fifth record position

```

> *Explanation:* Use the assigned type variable to find the RANDOM record length which is 118 bytes.

Defining a TYPE variable as another variable type from a previous TYPE definition in QB64.

```vb

TYPE bar
  b AS STRING * 10
END TYPE

TYPE foo
  a AS SINGLE
  c AS bar          'define variable as a bar type
END TYPE

DIM foobar AS foo   'create a variable to use the foo type
foobar.a = 15.5
foobar.c.b = "this is me"

PRINT foobar.a, foobar.c.b 
END 

```

A bitmap header information TYPE [$INCLUDE]($INCLUDE) File.

```vb

' ********
'Bitmap.BI can be included at start of program

 TYPE BMPHeaderType        ' Description                  Bytes      **QB64**
  ID AS STRING * 2        ' File ID is "BM"                2 
  Size AS LONG            ' Size of the data file          4 
  Res1 AS INTEGER         ' Reserved 1 should be 0         2 
  Res2 AS INTEGER         ' Reserved 2 should be 0         2 
  Offset AS LONG          ' Start position of pixel data   4 
  Hsize AS LONG           ' Information header size        4 
  PWidth AS LONG          ' Image width                    4       _WIDTH (QB64) 
  PDepth AS LONG          ' Image height                   4       _HEIGHT
  Planes AS INTEGER       ' Number of planes               2 
  BPP AS INTEGER          ' Bits per pixel(palette)        2       _PIXELSIZE
  Compress AS LONG        ' Compression                    4
  ImageBytes AS LONG      ' Width * Height = ImageSIZE     4
  Xres AS LONG            ' Width in PELS per metre        4
  Yres AS LONG            ' Depth in PELS per metre        4
  NumColors AS LONG       ' Number of Colors               4
  SigColors AS LONG       ' Significant Colors             4
END TYPE                  '          Total Header bytes = 54  

```

```vb

'$INCLUDE: 'Bitmap.BI'  'use only when including a BI file 

DIM SHARED BMPHead AS BMPHeaderType 

GET #1, , BMPHead  'get the entire bitmap header information

```

> *Explanation:* Use one [GET](GET) to read all of the header information from the start of the bitmap file opened AS [BINARY](BINARY). It reads all 54 bytes as [STRING](STRING), [INTEGER](INTEGER) and [LONG](LONG) type DOT variable values.

> NOTE: BPP returns 4(16 colors), 8(256 colors) or 24(16 million colors) bits per pixel in QBasic. 24 bit can only be in greyscale.

> Then use the DOT variable name values like this [GET (graphics statement)](GET-(graphics-statement)) after you load the bitmap image to the screen:

```vb

GET (0, 0)-(BMPHead.PWidth - 1, BMPHead.PDepth - 1), Image(48) 'indexed for 4 BPP colors

```

> The bitmap image is now stored in an array to BSAVE to a file. The RGB color information follows the file header as [ASCII](ASCII) character values read using ASC. The color values could be indexed at the start of the Array with the image being offset to: index = NumberOfColors * 3. As determined by the SCREEN mode used. In SCREEN 13(256 colors) the index would be 768.

## See Also

* [DIM](DIM), [REDIM](REDIM)
* [INTEGER](INTEGER), [SINGLE](SINGLE), [DOUBLE](DOUBLE)
* [LONG](LONG), [_INTEGER64](_INTEGER64), [_FLOAT](_FLOAT)
* [STRING](STRING), [_BYTE](_BYTE), [_BIT](_BIT), [_OFFSET](_OFFSET)
* [GET](GET), [PUT](PUT), [BINARY](BINARY)
* [GET (graphics statement)](GET-(graphics-statement)), [PUT (graphics statement)](PUT-(graphics-statement))
* [LEN](LEN), [LOF](LOF), [EOF](EOF)
* [Bitmaps](Bitmaps), [Creating Icon Bitmaps](Creating-Icon-Bitmaps)
