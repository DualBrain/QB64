[CHAIN](CHAIN) is used to change seamlessly from one module to another one in a program.

## Legacy Support

* The multi-modular technique goes back to when QBasic and QuickBASIC had module size constraints. In QB64 [CHAIN](CHAIN) has been implemented so that that older code can still be compiled, though **it is advisable to use single modules for a single project (not counting [$INCLUDE]($INCLUDE) libraries), for ease of sharing and also because the module size constraints no longer exist.**

## Syntax

> [CHAIN](CHAIN) moduleName$

## Parameter(s)

* moduleName$ is a variable or a literal [STRING](STRING) value in quotation marks with the optional EXE or BAS file name extension.

## Description

* CHAIN requires that both the invoking and called modules are of either .BAS or .EXE file types.
* In Windows, **QB64** will automatically compile a CHAIN referenced BAS file if there is no EXE file found.
* CHAIN looks for a file extension that is the same as the invoking module's extension.
* The module's filename extension is not required. To save editing at compile time just omit the extensions in the calls.
* To pass data from one module to the other use [COMMON SHARED](COMMON-SHARED). The COMMON list should match [Variable Types](Variable-Types)s and names.
* **QB64 does not retain the [SCREEN](SCREEN) mode like QBasic did.** 
* Variable data can be passed in files instead of using [COMMON SHARED](COMMON-SHARED) values. **QB64** uses files to pass [COMMON](COMMON) lists.
* [Keywords currently not supported](Keywords-currently-not-supported-by-QB64)**.

## Example(s)

CHAIN looks for same file type extension as program module (BAS or EXE).

```vb

 CHAIN "Level1" 

```

*Explanation:* The file referred to is "Level1.BAS" if the program module using the call is a BAS file. If the program was compiled, it would look for "Level1.EXE".

## See Also
 
* [RUN](RUN)
* [COMMON](COMMON), [COMMON SHARED](COMMON-SHARED)
* [SHARED](SHARED)
