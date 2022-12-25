The [EXP](EXP) math function calculates the exponential function (**e** raised to the power of a numericExpression).

## Syntax

>  result = [EXP](EXP)(numericExpression)

## Description

* **e** is defined as the base of natural logarithms or as the limit of (1 + 1 / n) ^ n, as n goes to infinity.
* The numericExpression must be less than or equal to **88.02969** or an [ERROR Codes](ERROR-Codes) will occur.
* Value returned is **e** to the exponent parameter (**e = 2.718282** approximately).
* Values returned are [SINGLE](SINGLE) by default but will return [DOUBLE](DOUBLE) precision if the result is a variable of type [DOUBLE](DOUBLE).
* Positive exponent values indicate the number of times to multiply **e** by itself.
* Negative exponent values indicate the number of times to divide by **e**. Example: e<sup>-3</sup> = 1 / e<sup>3</sup> = 1 / (e * e * e)

## See Also

*[LOG](LOG) 
*[Mathematical Operations](Mathematical-Operations)
