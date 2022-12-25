The **PUT** graphics statement is used to place [GET (graphics statement)](GET-(graphics-statement)) or [BSAVE](BSAVE) file images stored in the designated array.

## Syntax

> **PUT** [[STEP](STEP)]**(*column*, *row*), Array(**[*index*]**)**[,] [[_CLIP](_CLIP)]  [{PSET|PRESET|AND|OR|XOR}]][, *omitcolor*]

## Parameter(s)

* The [STEP](STEP) keyword can be used to for coordinates relative to the last graphic coordinates used.
* *column* and *row* [INTEGER](INTEGER) coordinate values designate the top left corner where the image is to be placed and cannot be off screen.
* The [INTEGER](INTEGER) *array* holds data of an image box area created by [GET (graphics statement)](GET-(graphics-statement)). The brackets can be empty or designate a starting *index*.
* [_CLIP](_CLIP) can be used in QB64 when part of an image must be off screen.
* [XOR](XOR), [PSET](PSET), [PRESET](PRESET), [OR](OR) or [AND](AND) actions will affect the coloring of the image on certain background colors. See below.
* *omitcolor* is the pixel color attribute to ignore in QB64 only. This may be used instead of using an [AND](AND) mask.

## Usage

* **The entire box area of the image MUST be on the screen or an "Illegal function call" [ERROR Codes](ERROR-Codes) will occur!**
* In **QB64** [_CLIP](_CLIP) can be used when part of the image may be off of the screen. This will also prevent off screen errors!
  - PUT (-10, 10), mypic(0), PSET ' this causes an illegal function call without [_CLIP](_CLIP)
  - PUT (-10, 10), mypic(0), _CLIP PSET ' allows a graphic to be placed partially off-screen
  - PUT (-10, 10), mypic(0), _CLIP ' uses the default PUT XOR operation
  - PUT (-10, 10), mypic(0), _CLIP PSET, 4 ' doesn't place the red pixels of the image
* In **QB64** a background color attribute can be removed from the PUT image using the *omit color* option instead of creating a mask.
* The [arrays](arrays) must have image data at the array index given. [GET (graphics statement)](GET-(graphics-statement)) or [BLOAD](BLOAD) should be used to place image data into the array.
* The [INTEGER](INTEGER) array size can be calculated as slightly larger than the box area width times the height. A closer estimate can be done by reading the array indices from [UBOUND](UBOUND) to [LBOUND](LBOUND) after a [GET (graphics statement)](GET-(graphics-statement)) of a white box area. In QB64 a [LONG](LONG) array can be used for large or full screen images.
* If no [arrays](arrays) index (brackets optional in QB) is designated, the image will be assumed to be at the array's starting index.
* The first two indices of the [arrays](arrays) or array offset will hold the width and height of the stored image area. In [SCREEN](SCREEN) 13 divide the width by 8.
* More than one image can be stored in the [INTEGER](INTEGER) array by indexing the [GET (graphics statement)](GET-(graphics-statement)) array offset. Be sure the index is not already used!
* A [_DEST](_DEST) [handle](handle) can be set to PUT images elsewhere other than on the current screen. Use [_SOURCE](_SOURCE) to [GET (graphics statement)](GET-(graphics-statement)) images there.
* If no color action is listed after the image array, the action will be assumed to be the default [XOR](XOR). 
  * [XOR](XOR) may blend with background colors, but can be used to erase an image when placed a second time.
  * [PSET](PSET) completely overwrites any background with the identical image.
  * [PRESET](PRESET) creates a inverted coloring of the original image completely overwriting the background.
  * [AND](AND) merges background colors with the black areas of the image where a white image mask is used.
  * [OR](OR) blends the background and foreground colors together.
* In QB64 [_PUTIMAGE](_PUTIMAGE) is recommended over PUT as it can also do the [GET (graphics statement)](GET-(graphics-statement)) directly from the image source without requiring an array.
* [PUT](PUT) and [GET](GET) file statements can also write and read image array data using [BINARY](BINARY) files instead of using [BSAVE](BSAVE) or [BLOAD](BLOAD).

## Example(s)

How [GET](GET) and PUT can be used with images loaded with [_LOADIMAGE](_LOADIMAGE). The background color is omitted or "masked".

```vb

SCREEN _NEWIMAGE(640, 480, 256)
_SCREENMOVE _MIDDLE
image& = _LOADIMAGE("QB64.png")  'replace with your own image

wide& = _WIDTH(image&): deep& = _HEIGHT(image&)
DIM Array(wide& * deep&) AS INTEGER

_SOURCE image&              'REQUIRED to GET the proper image area!
GET (0, 0)-(wide& - 1, deep& - 1), Array(0)

_DEST 0
_COPYPALETTE image&, 0      'necessary for custom image colors other than screen defaults
PUT(10, 10), Array(0), PSET , _RGB(255, 255, 255)   'mask white background color
END 

```

> *Explanation:* **QB64** allows one PUT color to be "masked" to allow odd shaped sprite image backgrounds to be transparent.

Using a [STRING](STRING) instead of an [arrays](arrays) to store [GET](GET) image data that can be PUT later. For images up to 256 colors only.

```vb

a$ = SPACE$(4 + 100)            '4 byte header + 100 pixels for a 10 X 10 image
SCREEN 13
LINE (0, 0)-(319, 199), 4, BF   'color 4 = CHR$(4) = ♦
LINE (40, 40)-(49, 49), 14, B   'color 14 = CHR$(14) = ♫
GET (40, 40)-(49, 49), a$

K$ = INPUT$(1)

CLS
PRINT a$                        'display string data. Width = CHR$(10 * 8) = "P"
PUT(100, 100), a$, PSET 

```

> *Explanation:* The header holds the [INTEGER](INTEGER) width and depth of the image area as 2 bytes each. Screen 13 width is multiplied by 8.

## See Also
 
* [_PUTIMAGE](_PUTIMAGE), [_LOADIMAGE](_LOADIMAGE)
* [_MAPTRIANGLE](_MAPTRIANGLE)
* [GET (graphics statement)](GET-(graphics-statement)), [BSAVE](BSAVE), [BLOAD](BLOAD)
* [SCREEN (statement)](SCREEN-(statement)), [Scancodes](Scancodes)(Example 3)
* [Creating Sprite Masks](Creating-Sprite-Masks) (for non-box shaped sprites)
* [GET and PUT Demo](GET-and-PUT-Demo)
* [Bitmaps](Bitmaps) 
