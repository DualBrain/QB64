[DEF SEG](DEF-SEG) is used to define the area in memory to access QB64's emulated conventional memory.

## Legacy Support

* **QB64 implements memory access using [_MEM](_MEM) and related functions. For that reason, [DEF SEG](DEF-SEG) isn't recommended practice anymore and is supported to maintain compatibility with legacy code.**

## Syntax

>  [DEF SEG](DEF-SEG) [=][{segment|VARSEG(variable}]

## Description

* Used to set the pointer to a memory area of a variable/array or register.
* [PEEK](PEEK) and [POKE](POKE) require a segment memory address (often just 0) without using VARSEG.
* Important segments using [PEEK](PEEK) and [POKE](POKE) include &HB800 (text segment) and &HA000 (graphics segment).
* [BSAVE](BSAVE) and [BLOAD](BLOAD) require a VARSEG reference to the grahic array(0 index) used.
* Always use DEF SEG when the procedure is completed, in order to reset the segment to QBasic's default value.
* [DEF SEG](DEF-SEG), [VARSEG](VARSEG), [VARPTR](VARPTR), [PEEK](PEEK) and [POKE](POKE) access QB64's emulated 16 bit conventional memory block. **It is highly recommended to use QB64's [_MEM](_MEM) memory system to avoid running out of memory.**

## See Also
 
* [DEF SEG = 0](DEF-SEG-=-0)
* [VARPTR](VARPTR), [VARSEG](VARSEG) 
* [PEEK](PEEK), [POKE](POKE)
* [BSAVE](BSAVE), [BLOAD](BLOAD)
