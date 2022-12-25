[BLOAD](BLOAD) loads a binary graphics file created by [BSAVE](BSAVE) to an array. 

## Legacy Support

* **QB64 can load larger arrays directly from binary files using [PUT](PUT) # and [GET](GET) # without BLOAD. For that reason, BLOAD isn't recommended practice anymore and is supported to maintain compatibility with legacy code.**

## Syntax

> [BLOAD](BLOAD) fileName$, [VARPTR](VARPTR)(imageArray%(Parameter))

## Parameter(s)

* fileName$ is the name of the file that the image should be [BSAVE](BSAVE)d to.
* imageArray%(index) is the [INTEGER](INTEGER) [arrays](arrays) start index to store the image loaded.

## Description

* There must be an [INTEGER](INTEGER) array of adequate size (up to 26K) to hold the graphic data.
* A [DEF SEG](DEF-SEG) pointing to the array is required. [DEF SEG](DEF-SEG) = [VARSEG](VARSEG)(imageArray%(index))
* index is the starting image element of the Array. Can also include RGB color settings at the start index.
* Fullscreen images in [SCREEN](SCREEN) 12 require 3 file BLOADs. A 26K array can hold 1/3 of screen.
* Custom RGB color settings can be embedded(indexed) at the start of the image array. 
* BLOAD can be used to load any array that was saved with [BSAVE](BSAVE), not just graphics.
* Array sizes are limited to 32767 Integer elements due to use of [VARPTR](VARPTR) in QBasic and **QB64**'s emulated conventional memory.

## Example(s)

Loading data to an array from a BSAVED file.

```vb

DEF SEG = VARSEG(Array(0))
  BLOAD filename$, VARPTR(Array(LBOUND(Array))) ' changeable index
DEF SEG 

```

> *Explanation:* Referance any type of array that matches the data saved. Can work with Integer, Single, Double, Long, fixed length Strings or [TYPE](TYPE) arrays. [LBOUND](LBOUND) determines the starting offset of the array or another index could be used.

Using a QB default colored image.  

```vb

DEF SEG = VARSEG(Image%(0)) ' pointer to first image element of an array
  BLOAD FileName$, VARPTR(Image%(0)) ' place data into array at index position 0
  PUT(Col, Row), Image%(0), PSET ' Put the image on the screen from index 0
DEF SEG 

```

> *Note:* [PSET](PSET) is used as a [PUT (graphics statement)](PUT-(graphics-statement)) action that places the image over any background objects.

## See Also

* [BSAVE](BSAVE), [OPEN](OPEN), [BINARY](BINARY)
* [PUT](PUT), [GET](GET) (file statement)
* [GET (graphics statement)](GET-(graphics-statement)), [PUT (graphics statement)](PUT-(graphics-statement))
* [VARSEG](VARSEG), [VARPTR](VARPTR)
* [DEF SEG](DEF-SEG)
* [Text Using Graphics](Text-Using-Graphics)
