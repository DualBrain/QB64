[COMMON](COMMON) shares common variable values with other linked or [CHAIN](CHAIN)ed modules.

## Legacy Support

* The multi-modular technique goes back to when QBasic and QuickBASIC had module size constraints. In QB64 [COMMON](COMMON) has been implemented so that that older code can still be compiled, though **it is advisable to use single modules for a single project (not counting [$INCLUDE]($INCLUDE) libraries), for ease of sharing and also because the module size constraints no longer exist.**

## Syntax

> [COMMON](COMMON) [SHARED] variableList 

## Description

* COMMON must be called before any executable statements.
* [SHARED](SHARED) makes the variables shared within [SUB](SUB) and [FUNCTION](FUNCTION) procedures within that module.
* variableList is the list of common variables made available separated by commas.
* Remember to keep the variable type *order* the same in all modules, as the variables names don't matter.
* [COMMON SHARED](COMMON-SHARED) is most commonly used to share the variables with subs and functions of that module.
* **Note: Values assigned to shared variables used as procedure call parameters will not be passed to other procedures. The shared variable value must be assigned inside of the [SUB](SUB) or [FUNCTION](FUNCTION) procedure to be passed.**

## See Also

* [COMMON SHARED](COMMON-SHARED), [CHAIN](CHAIN)
* [DIM](DIM), [REDIM](REDIM), [SHARED](SHARED)
* [DEFSTR](DEFSTR), [DEFLNG](DEFLNG), [DEFINT](DEFINT), [DEFSNG](DEFSNG), [DEFDBL](DEFDBL)
