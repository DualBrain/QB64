**COMMON SHARED** is used to pass variable values between 2 or more program modules and sub procedures within that module.

The multi-modular technique goes back to when QBasic and QuickBASIC had module size constraints. In QB64 it has been implemented so that that older code can still be compiled, though **it is advisable to use single modules for a single project (not counting [$INCLUDE]($INCLUDE) libraries), for ease of sharing and also because the module size constraints no longer exist.**

## Syntax

> **COMMON** [**SHARED**][/block_name/]variable_list

* COMMON statements must be made before any program code execution.
* The [SHARED](SHARED) statement allows the variable values to also be used in module [SUB](SUB) and [FUNCTION](FUNCTION) procedures.
* The list of variables(separated by commas) to pass MUST be in the same type order in ALL modules used! 
* [COMMON](COMMON) variable list names(but not variable types) can change between modules.
* The list can hold any variable type.
* The list cannot define a variable's value, but can use [AS](AS) to designate the type.
* Use [DIM](DIM) [SHARED](SHARED) variables when working in a module to pass variable values to SUB procedures.
* Data files could be used as an alternative to using COMMON SHARED values. 
* In **QB64** COMMON values are sent using files instead of memory presently.
* **Note: Values assigned to shared variables used as procedure call parameters will not be passed to other procedures! The shared variable value MUST be assigned INSIDE of the [SUB](SUB) or [FUNCTION](FUNCTION) procedure to be passed!**

## QBasic/QuickBASIC

* Quickbasic 4.5 required you to include BRUN45.EXE when you compile COMMON SHARED values between EXE modules.
* The COMMON block name designates a certain block of variables that certain program modules may use, the name must be within two forward slashes/ (Ex: /thename/ ). **[Keywords currently not supported by QB64](Keywords-currently-not-supported-by-QB64)**

## Example(s)

```vb

COMMON SHARED x%, y%, user$, speed!, score&

```

## See Also

* [CHAIN](CHAIN), [RUN](RUN) 
* [COMMON](COMMON)
* [SHARED](SHARED)
