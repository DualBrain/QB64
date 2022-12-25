The [_CLIP](_CLIP) option is used in a QB64 graphics [PUT (graphics statement)](PUT-(graphics-statement)) to allow placement of an image partially off of the screen.

## Syntax

> [PUT (graphics statement)](PUT-(graphics-statement)) [[STEP]([STEP)](column, row), image_array(start)[, [[_CLIP]]] [{XOR|PSET|AND|OR|PRESET}][, omitcolor]

## Description

* _CLIP should be placed immediately before the PUT action if used. XOR is default when not used.
* The offscreen portions of the image will be the omit color.
* [GET (graphics statement)](GET-(graphics-statement)) can get portions of the images off screen in **QB64**.

## Example(s)

Placing an image partially or fully offscreen.

```vb

DIM mypic(500)
SCREEN 13

CLS
CIRCLE (10,10),10
GET (0,0)-(20,20), mypic(0)

PRINT "This program puts an image off screen."
PRINT "Select which option you'd like to try."
PRINT "1 will produce an illegal function call."
PRINT "1 is putting without _CLIP."
PRINT "2 is putting with _CLIP PSET."
PRINT "3 is putting with _CLIP XOR."
PRINT "4 is putting with _CLIP PSET, 4."

INPUT sel
IF sel = 1 THEN PUT (-10, 10), mypic(0), PSET ' this causes an illegal function call
IF sel = 2 THEN PUT (-10, 10), mypic(0), _CLIP PSET ' allows graphic to be drawn off-screen
IF sel = 3 THEN PUT (-10, 10), mypic(0), _CLIP ' uses the default PUT XOR operation
IF sel = 4 THEN PUT (-10, 10), mypic(0), _CLIP PSET, 4 ' doesn't draw red pixels

END 

```

## See Also

* [PUT (graphics statement)](PUT-(graphics-statement))
* [GET (graphics statement)](GET-(graphics-statement))
* [STEP](STEP)
