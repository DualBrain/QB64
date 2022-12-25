The [LPRINT](LPRINT) statement sends string text or numerical values to a parallel port (LPT1) printer in QBasic or a USB printer in **QB64**.

## Syntax

> [LPRINT](LPRINT) [expression] [{;|,}]

## Description

* expression is one or more text or numerical expressions separated by a semi-colon (;) or comma (,).
* Syntax is the same as [PRINT](PRINT), but cannot use a port number.
* Program does not have to [OPEN](OPEN) the LPT1: parallel port.
* Assumes a 80 character wide page. **[Keywords currently not supported by QB64](Keywords-currently-not-supported-by-QB64)**
* [LPRINT USING](LPRINT-USING) can print formatted text data to a page identically to how [PRINT USING](PRINT-USING) formats a program screen.
* [COLOR](COLOR)ed text and images can be printed using [_PRINTIMAGE](_PRINTIMAGE) which stretches them to fit the default printer's paper size.
* LPRINT will only print to the default USB or LPT printer set up in Windows.  **[Keywords currently not supported](Keywords-currently-not-supported-by-QB64)**
  * To print in Linux, see [Connecting to printer via TCP/IP](Connecting-to-printer-via-TCP-IP).
* Note: Printer *escape codes* starting with [CHR$](CHR$)(27) will not work with LPRINT and may produce text printing errors.

## See Also

* [LPRINT USING](LPRINT-USING)
* [_PRINTIMAGE](_PRINTIMAGE) (prints color images to page size)
* [PRINT](PRINT), [PRINT USING](PRINT-USING)
* [Windows Printer Settings](Windows-Printer-Settings)
