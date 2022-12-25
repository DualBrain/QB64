The [INTERRUPTX](INTERRUPTX) statement is an assembly routine for accessing computer information registers.

## Legacy Support

* Registers are emulated in **QB64** to allow older programs to be compiled. To enable mouse input in your programs, the recommended practice is to use [_MOUSEINPUT](_MOUSEINPUT) and related functions.

## Syntax

> [CALL](CALL) [INTERRUPTX](INTERRUPTX)(intNum, inRegs, outRegs)

## Parameter(s)

* Registers are emulated in QB64 and there is no support for intNum 33h mouse functions above 3 or intNum requests other than 33.
* inRegs are the values placed into the call and outRegs are the register return values.

## QBasic

* Available in QuickBASIC versions 4 and up and required an external library to be loaded. <!-- Command line: QB.EXE /L in QB4.5 --> **QB64** emulates the statement without an external library.
* intNum is the interrupt reference vector table address. For historic reference, see: [Ralf Brown's Interrupt List](http://www.ctyme.com/intr/cat.htm)
* The [TYPE](TYPE) definition below will work for both [INTERRUPT](INTERRUPT) and INTERRUPTX statement calls
* INTERRUPT can use all of the below TYPE elements when they are required.

```text

TYPE RegTypeX
   ax AS INTEGER
   bx AS INTEGER
   cx AS INTEGER
   dx AS INTEGER
   bp AS INTEGER
   si AS INTEGER
   di AS INTEGER
   flags AS INTEGER
   ds AS INTEGER
   es AS INTEGER
END TYPE 

```

```vb

DIM SHARED inregs AS RegTypeX, outregs AS RegTypeX

```

> QBasic's *RegType.BI* $INCLUDE file can be used by INTERRUPT or [INTERRUPTX](INTERRUPTX)


## See Also

* [$INCLUDE]($INCLUDE)
* [QB.BI](QB.BI), [CALL ABSOLUTE](CALL-ABSOLUTE)
* [INTERRUPT](INTERRUPT)
* Ethan Winer's free QBasic Book and Programs: [WINER.ZIP](http://www.ethanwiner.com/fullmoon.html)
