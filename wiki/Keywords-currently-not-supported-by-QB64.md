The keywords listed here are not supported in QB64. QB64 is meant to be compatible with **QB 4.5 or lower** versions. **PDS (7.1) is not supported**. Older code that uses these keywords won't generate errors, as these are ignored by the compiler.

* [ALIAS](ALIAS) (supported in [DECLARE LIBRARY](DECLARE-LIBRARY) only)
* ANY (See [DECLARE LIBRARY](DECLARE-LIBRARY))
* [BYVAL](BYVAL) (supported in [DECLARE LIBRARY](DECLARE-LIBRARY) only)
* CALLS
* CDECL
* DATE$ (statement) (reading the current [DATE$](DATE$) is supported)
* DECLARE (non-BASIC statement)
* DEF FN, EXIT DEF, END DEF
* ERDEV, ERDEV$
* FILEATTR
* FRE
* IOCTL, IOCTL$
* [OPEN](OPEN) with devices like **LPT, CON, KBRD**, and other devices is not supported. [LPRINT](LPRINT) and [OPEN COM](OPEN-COM) are supported.
* ON PEN, PEN (statement), PEN (function)
* ON PLAY(n), PLAY(n) ON/OFF/STOP. ([PLAY](PLAY) music is supported.)
* ON UEVENT
* SETMEM
* SIGNAL
* TIME$ (statement) (reading the current [TIME$](TIME$) is supported)
* TRON, TROFF
* **[WIDTH](WIDTH) [LPRINT](LPRINT)** combined statement is not supported.

## Keywords Not Supported in Linux or MAC OSX versions

The commands listed here contain platform-specific calls and may be implemented in the future in Linux and macOS. These commands currently result in stub calls which do nothing.

NOTE: The IDE does not support the opening or retrieval of more than one program at a time, but multiple instances of the IDE can be used simultaneously.

Some OS Specific window/desktop calls:

* [_ACCEPTFILEDROP](_ACCEPTFILEDROP), [_TOTALDROPPEDFILES](_TOTALDROPPEDFILES), [_DROPPEDFILE](_DROPPEDFILE), [_FINISHDROP](_FINISHDROP)
* [_SCREENPRINT](_SCREENPRINT)
* [_SCREENCLICK](_SCREENCLICK)
* [_SCREENMOVE](_SCREENMOVE) (available in macOS, and available in MOST Linux distros)
* [_CLIPBOARDIMAGE](_CLIPBOARDIMAGE), [_CLIPBOARDIMAGE (function)](_CLIPBOARDIMAGE-(function))
* [_WINDOWHASFOCUS](_WINDOWHASFOCUS) (available in Linux, not available in macOS)
* [_WINDOWHANDLE](_WINDOWHANDLE)
* [_CAPSLOCK](_CAPSLOCK), [_NUMLOCK](_NUMLOCK), [_SCROLLLOCK](_SCROLLLOCK) (statements and functions)

Modular: QB64 has no limit on file size so BAS file modules can be combined.

* [CHAIN](CHAIN)
* [RUN](RUN)

Mouse related:

* [_MOUSEWHEEL](_MOUSEWHEEL) (available in Linux, not available in macOS)

Printing:

* [LPRINT](LPRINT)
* [_PRINTIMAGE](_PRINTIMAGE)

Port access:

* [OPEN COM](OPEN-COM)

File locking:

* [LOCK](LOCK)
* [UNLOCK](UNLOCK)

## Reference

* [QB64 FAQ](QB64-FAQ)
