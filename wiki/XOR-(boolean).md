[XOR (boolean)](XOR-(boolean)) evaluates two conditions and if either of them is True then it returns True, if both of them are True then it returns False, if both of them are False then it returns False.

## Syntax

> `condition [XOR (boolean)](XOR-(boolean)) condition2`

## Description

* Either condition or condition2 must be True for the evaluation to return True.
* It is called **"exclusive OR"** because the conditions cannot both be True for it to return True like the [OR (boolean)](OR-(boolean)) evaluation.
* condition and condition2 can themselves contain XOR evaluations.

## Example(s)

## Example(s)
 Dilemma...

```vb

True = NOT False
AndersWon = True
PeterWon = True

IF AndersWon = True XOR PeterWon = True THEN
  PRINT "Thank you for your honesty!"
ELSE
  PRINT "You can't both have won (or lost)!"
END IF

```

```text

You can't both have won (or lost)!

```

## See Also

* [OR (boolean)](OR-(boolean)), [AND (boolean)](AND-(boolean))
* [IF...THEN](IF...THEN)
