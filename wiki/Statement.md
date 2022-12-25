A **statement** is, as far as BASIC is concerned, a keyword that can be executed in run-time which doesn't return any value. It can contain several [argument](argument)s or no arguments at all.

The arguments in a statement are usually not enclosed with paranteses. When a graphical x-coordinate and y-coordinate is to be specified they are enclosed with paranteses though.

## Example(s)

Demonstrates how x- and y-coordinates are enclosed with paranteses (in graphics).

```vb

SCREEN 13
x = 160
y = 100
PSET (x, y), 15

```

Demonstrates how row- and column-coordinates are not enclosed with paranteses (in text).

```vb

row = 12
column = 40
LOCATE row, column
PRINT "X"

```

## See Also

*[Function (explanatory)](Function-(explanatory))
*[Argument](Argument)
