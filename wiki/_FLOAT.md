**_FLOAT** numerical values offer the maximum floating-point decimal precision available using **QB64**.

## Syntax
 
> [DIM](DIM) variable AS [_FLOAT](_FLOAT)

## Description

* **QB64** always allocates 32 bytes to store this value. 
* It is safe to assume this value is at least as precise as [DOUBLE](DOUBLE). 
* Under the current implementation it is stored in a 10-byte floating point variable.
* [_FLOAT](_FLOAT) variables can also use the ## variable name type suffix.
* Values returned may be expressed using exponential or [scientific notation](scientific-notation) using **E** for SINGLE or **D** for DOUBLE precision.
* According to [IEEE-754](http://babbage.cs.qc.edu/courses/cs341/IEEE-754references.html) this can store a value of up to 1.1897E+4932 compared to a DOUBLE which goes up to 1.7976E+308. 
* Floating decimal point numerical values cannot be [_UNSIGNED](_UNSIGNED).
* Values can be converted to 32 byte [ASCII](ASCII) strings using [_MK$](_MK$) and back with [_CV](_CV).
* **When a variable has not been assigned or has no type suffix, the value defaults to [SINGLE](SINGLE).**
* Note: OpenGL's [_GL_FLOAT](_GL-FLOAT) constant is a [SINGLE](SINGLE) (4 byte) floating point number, while a native QB64 _FLOAT is a 10-byte floating point number.

## See Also

* [DOUBLE](DOUBLE), [SINGLE](SINGLE)
* [_MK$](_MK$), [_CV](_CV)
* [_DEFINE](_DEFINE), [DIM](DIM)
* [PDS (7.1) Procedures](PDS-(7.1)-Procedures)
* [Variable Types](Variable-Types)
