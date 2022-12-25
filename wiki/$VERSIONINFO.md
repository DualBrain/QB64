The [$VERSIONINFO]($VERSIONINFO) [Metacommand](Metacommand) adds text metadata to the resulting executable for identification purposes across the OS. Windows-only.

## Syntax

>  [$VERSIONINFO]($VERSIONINFO):key=value

## Parameter(s)

* Text *keys* can be: **Comments, CompanyName, FileDescription, FileVersion, InternalName, LegalCopyright, LegalTrademarks, OriginalFilename, ProductName, ProductVersion, Web**
* Numeric keys can be:**FILEVERSION#** and **PRODUCTVERSION#** 

## Description

* Text and numerical values are string literals without quotes entered by programmer. **No variables are accepted.** (variable names would be interpreted as literals).
* Numeric key=*value* must be 4 comma-separated numerical text values entered by programmer which usually stand for major, minor, revision and build numbers).
* A manifest file is automatically embedded into the resulting .exe file so that Common Controls v6.0 gets linked at runtime, if required.
* [Keywords currently not supported](Keywords-currently-not-supported-by-QB64).

## Availability

* Build 20170429/52 and up.

## Example(s)

Adding metadata to a Windows exe compiled with QB64:

```vb

$VERSIONINFO:CompanyName=Your company name goes here
$VERSIONINFO:FILEVERSION#=1,0,0,0
$VERSIONINFO:PRODUCTVERSION#=1,0,0,0

``` 

## See Also

* [$EXEICON]($EXEICON) 
* [_ICON](_ICON)
* [VERSIONINFO resource (MSDN)](https://msdn.microsoft.com/library/windows/desktop/aa381058(v=vs.85).aspx)
