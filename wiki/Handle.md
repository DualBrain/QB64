In QB64 **handles** are created and used by various statements and functions to reference screen surfaces, images, sounds, fonts and IP users.

## Syntax

> **handle& =** _NEWIMAGE(800, 600, 32)

> _FREEIMAGE **handle&**

## Usage

* [SCREEN](SCREEN) and image handles in use cannot be freed without error! Change screens or fonts before freeing the handle from memory!
* The actual value of the handle is only important if it fails to return a value in the range specified. **A bad return value may create errors!**

## Handle Functions

* Image: [_NEWIMAGE](_NEWIMAGE) creates a screen surface, [_LOADIMAGE](_LOADIMAGE) holds a file image and  [_FREEIMAGE](_FREEIMAGE) releases valid handles from memory.
  - Valid [LONG](LONG) handle returns are less than -1. Failed [_LOADIMAGE](_LOADIMAGE) handle values of -1,  zero or positive values are invalid.
* TCP/IP: [_OPENHOST](_OPENHOST), [_OPENCLIENT](_OPENCLIENT) and [_OPENCONNECTION](_OPENCONNECTION) open access and [CLOSE](CLOSE) frees negative handle values from memory.
* Memory: [_MEM (function)](_MEM-(function)) and [_MEMNEW](_MEMNEW) create memory storage areas and [_MEMFREE](_MEMFREE) MUST release those areas for other uses.
* Sound: [_SNDOPEN](_SNDOPEN) opens a sound file and [_SNDCLOSE](_SNDCLOSE) closes the file and releases valid handles above zero from memory.
* Fonts: [_LOADFONT](_LOADFONT) loads a font file and [_FREEFONT](_FREEFONT) releases valid handle values above zero from memory.
* Event: [_FREETIMER](_FREETIMER) finds a free [TIMER](TIMER) event [INTEGER](INTEGER) value which is freed by [TIMER (statement)](TIMER-(statement)) FREE.
* Files: [FREEFILE](FREEFILE) finds a free file [INTEGER](INTEGER) value which is used in [OPEN](OPEN) statements and file functions and is freed by [CLOSE](CLOSE)

## See Also

* [_SOURCE](_SOURCE), [_DEST](_DEST)
