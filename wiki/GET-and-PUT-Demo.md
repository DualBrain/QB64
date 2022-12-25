The following code demonstration shows how GET and PUT can be used to place a sprite on a background image using a mask.

```vb

DIM Image(3000) AS INTEGER
SCREEN 9

PALETTE 'reset colors to normal visible ones
PALETTE 12, 26 'Set DAC which do not respond to OUT
PALETTE 10, 0 'set palette values for DAC attributes

'set palette values for attributes that respond to OUT
OUT &H3C8, 0: OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, 12 'background: midnight blue
OUT &H3C8, 1: OUT &H3C9, 21: OUT &H3C9, 63: OUT &H3C9, 21 'green demo text
OUT &H3C8, 2: OUT &H3C9, 32: OUT &H3C9, 32: OUT &H3C9, 32 'medium ship gray
OUT &H3C8, 3: OUT &H3C9, 22: OUT &H3C9, 12: OUT &H3C9, 5 'meteor highlight brown
OUT &H3C8, 4: OUT &H3C9, 63: OUT &H3C9, 0: OUT &H3C9, 0 'bright red
OUT &H3C8, 5: OUT &H3C9, 52: OUT &H3C9, 52: OUT &H3C9, 52 'ship light gray

MaxWIDTH = 83 + 280: MaxDEPTH = 200 + 60: x = 280: y = 200
RESTORE ShipData
DO
  READ Count, Colr    'read RLE compressed data field
  FOR reps = 1 TO Count
    PSET (x, y), Colr
    x = x + 1
    IF x > MaxWIDTH THEN x = 280: y = y + 1
  NEXT reps
LOOP UNTIL y > MaxDEPTH 'y start + 60

Align 14, 2, "Working with Sprites and Masks"
COLOR 12: LOCATE 3, 4: PRINT "No matter how you create your sprite, you will need to GET it to an array"
LOCATE 4, 4: PRINT "so that you can place the image on the Active Page. The page is cleared"
LOCATE 5, 4: PRINT "and the image is placed at a slightly different position to give motion to"
LOCATE 6, 4: PRINT "the sprite. In a game a player can determine the motions also."
Align 12, 22, "The Sprite was produced using the compressed ShipData field."
Align 14, 23, "GET and PUT work much faster than redrawing an image every page!"
Press 13, 8, "Press a key to GET and PUT the ship!"
Align 12, 22, "PUT in default XOR mode has no problem with attribute 0 backgrounds!"
Align 12, 23, "However it will distort colors when PUT over other attribute colors."
GET (280, 200)-(83 + 280, 260), Image(0)
PUT(100, 200), Image(0)
COLOR 14: LOCATE 20, 15: PRINT "SPRITE";
_DELAY 3
Align 14, 8, "Creating a Mask to use with Backgrounds"
COLOR 12: LOCATE 9, 4: PRINT "Below I have created a sprite from the Chapter Introduction's DATA field."
LOCATE 10, 4: PRINT "We create the mask to use the advantages of the PUT AND action verb later."
LOCATE 11, 4: PRINT "That property allows white to display any colored objects underneath it!"
LOCATE 12, 4: PRINT "Change attribute 0 to 15 and all others black using a POINT and PSET scan:"
Press 13, 24, "Press a key to Create the Mask"
Eraser 8, 12: Eraser 22, 23
COLOR 11: LOCATE 8, 4: PRINT "   FOR xx = 0 TO 83  'scanned sprite was actually in top left corner"
LOCATE 9, 4: PRINT "     FOR yy = 0 TO 60"
LOCATE 10, 4: PRINT "     IF POINT(xx, yy) = 0 THEN PSET (xx, yy), 15 ELSE PSET (xx, yy), 0"
LOCATE 11, 4: PRINT "     NEXT yy"
LOCATE 12, 4: PRINT "   NEXT xx"
LOCATE 13, 4: PRINT "   GET (0, 0)-(83, 60), Image(1500)  'mask indexed into array"
Align 13, 22, "Mask procedure slowed for demonstration purposes!"
FOR xx = 280 TO 83 + 280
  _DELAY .03
  FOR yy = 200 TO 260
    IF POINT(xx, yy) = 0 THEN PSET (xx, yy), 15 ELSE PSET (xx, yy), 0
  NEXT yy
NEXT xx
GET (280, 200)-(83 + 280, 260), Image(1500)
COLOR 14: LOCATE 20, 38: PRINT "MASK"
Align 12, 22, "Now we have created a black background for PUT XOR to place the Sprite!"
Align 12, 23, "For black colors in an image, set RGB = 0 values to a non-0 attribute."
Press 13, 24, "Press a key to PUT the Mask on a background!"
Eraser 8, 13
Align 14, 8, "Using PUT to place the Mask in AND mode"
COLOR 12: LOCATE 9, 4: PRINT "First we create a background that is not black and PUT the Mask at a new"
LOCATE 10, 4: PRINT "position. Then we PUT the Sprite over the mask at the same coordinates: "
CIRCLE (496, 230), 40, 14: PAINT STEP(0, 0), 14
CIRCLE (500, 230), 40, 3: PAINT STEP(0, 0), 3
_DELAY 3
Align 11, 12, "PUT(440, 200), Image(1500), AND  'mask  "
PUT(440, 200), Image(1500), AND
Press 13, 24, "Press a key to PUT the Sprite over the Mask using XOR!"
PUT(440, 200), Image(0)
Align 11, 13, "PUT(440, 200), Image(0)          'sprite"
Eraser 22, 23
Align 12, 22, "The GET for the mask was array indexed 1500 from the Sprite's 0 index!"
Align 12, 23, "PUT in default XOR mode, only places the Sprite on the black portions."

END

ShipData:        'ship data and image created by Bob Sequin
DATA 34,0,1,5,73,0,7,5,4,7,1,15,73,0,6,5,1,7,77,0,6,5,1,7,77,0,6,5,1,7
DATA 77,0,5,5,2,7,77,0,4,5,3,7,77,0,3,5,5,7,76,0,8,7,76,0,9,7,75,0,10,7
DATA 74,0,11,7,73,0,12,7,69,0,2,5,1,2,7,7,3,5,3,7,3,5,2,7,61,0,1,8,3,5
DATA 1,2,6,7,1,5,3,7,1,5,3,7,10,5,55,0,1,8,2,7,2,2,6,7,1,2,3,7,1,2
DATA 4,7,7,5,2,2,1,15,54,0,1,8,2,7,2,2,6,7,1,2,3,7,1,2,5,7,6,5,2,2
DATA 1,15,54,0,1,8,1,7,3,2,7,7,3,2,12,7,2,2,1,5,46,0,1,8,7,5,1,8,4,2
DATA 22,7,2,2,1,5,46,0,1,8,7,5,1,8,4,2,22,7,2,2,47,0,1,8,12,5,22,7,44,0
DATA 4,4,2,8,6,7,8,5,2,7,11,2,7,7,1,5,41,0,2,4,4,14,2,8,6,7,6,2,3,5
DATA 1,7,1,2,9,7,1,2,8,7,1,5,39,0,1,4,2,14,4,15,2,8,6,7,9,2,1,5,1,2
DATA 9,7,1,2,8,7,2,5,37,0,1,4,1,14,6,15,2,8,6,7,21,2,7,7,5,5,2,9,1,15
DATA 1,4,1,15,2,9,1,7,1,5,27,0,1,4,2,14,4,15,2,8,6,7,13,2,13,7,10,5,8,7
DATA 1,15,25,0,2,4,4,14,2,8,7,7,15,2,9,7,13,5,6,7,1,5,27,0,4,4,2,8,25,2
DATA 36,5,21,0,2,8,10,2,36,5,2,10,4,9,1,15,2,9,2,7,6,5,1,15,18,0,2,8,8,7
DATA 2,2,36,7,4,10,2,9,1,5,4,9,1,5,6,12,1,5,17,0,2,8,8,7,2,2,36,7,4,10
DATA 2,9,1,7,4,9,1,5,6,12,1,5,6,15,11,0,2,8,8,7,2,2,36,7,4,10,2,9,1,7
DATA 4,9,1,5,6,12,1,5,17,0,2,8,8,5,38,2,2,10,4,9,1,2,2,9,8,7,1,5,14,0
DATA 4,4,2,8,25,5,36,2,15,0,2,4,4,14,2,8,7,7,15,5,12,7,10,5,6,7,1,5,24,0
DATA 1,4,2,14,4,15,2,8,6,7,13,5,13,7,10,5,8,7,1,15,23,0,1,4,1,14,6,15,2,8
DATA 5,7,1,2,11,5,10,2,2,7,10,5,2,9,1,15,1,4,1,15,2,9,1,7,1,5,27,0,1,4
DATA 2,14,4,15,2,8,4,7,2,2,9,5,2,2,9,7,1,2,1,7,9,5,39,0,2,4,4,14,2,8
DATA 3,7,3,2,6,5,3,2,1,7,1,2,9,7,1,2,9,5,42,0,4,4,2,8,2,7,12,2,2,7
DATA 11,2,8,5,48,0,1,8,14,2,8,7,12,5,49,0,1,8,7,2,1,8,3,5,1,2,9,7,15,5
DATA 47,0,1,8,7,2,1,8,3,5,1,2,8,7,10,5,1,7,3,5,2,2,1,15,54,0,1,8,3,5
DATA 1,2,6,7,1,5,1,7,2,15,7,5,1,7,4,5,2,2,1,15,54,0,1,8,8,7,2,5,1,7
DATA 3,5,1,15,5,5,2,7,4,5,2,2,1,5,54,0,1,8,2,7,2,2,4,7,2,5,1,7,3,5
DATA 1,7,4,5,2,7,5,5,2,2,1,5,54,0,1,8,1,7,3,2,3,7,3,5,1,7,3,5,1,7
DATA 3,5,3,7,5,5,2,2,57,0,3,2,3,7,4,5,3,7,3,5,5,2,66,0,4,7,8,5,72,0
DATA 6,7,5,5,73,0,5,7,5,5,74,0,5,7,4,5,75,0,5,7,3,5,76,0,6,7,2,5,76,0
DATA 7,7,77,0,7,7,77,0,7,7,77,0,7,7,77,0,7,7,76,0,11,7,1,15,82,0,1,5,49,0
DATA 16,0,6,4,3,0,3,4,5,14,2,0,2,4,2,14,5,15,1,0,2,4,1,14,7,15,2,0,2,4
DATA 2,14,5,15,3,0,3,4,5,14,5,0,6,4,60,0,6,4,3,0,3,4,5,14,2,0,2,4,2,14
DATA 5,15,1,0,2,4,1,14,7,15,2,0,2,4,2,14,5,15,3,0,3,4,5,14,5,0,6,4,11,0

  'sub programs are for demonstration text only
SUB Align (Tclr, Trow, txt$)
Tcol = 41 - (LEN(txt$) \ 2)
COLOR Tclr: LOCATE Trow, Tcol: PRINT txt$;
END SUB

SUB Press (Tclr, Trow, Text$)
DO: LOOP UNTIL INKEY$ = ""
Align Tclr, Trow, Text$
DO: SLEEP: LOOP UNTIL INKEY$ <> ""
Align Tclr, Trow, SPACE$(LEN(Text$))
END SUB

SUB Eraser (Srow, Erow)
FOR R = Srow TO Erow
  LOCATE R, 4: PRINT SPACE$(75)
NEXT
END SUB 

```
<sub>Code by Bob Seguin and Ted Weissgerber</sub>

> *Note:* The [DATA](DATA) is read as the number of pixels to color and the color attribute in the compressed the data field.

## See Also

* [Creating Sprite Masks](Creating-Sprite-Masks)
* [PUT (graphics statement)](PUT-(graphics-statement))
* [GET (graphics statement)](GET-(graphics-statement))
* [_PUTIMAGE](_PUTIMAGE), [_MAPTRIANGLE](_MAPTRIANGLE)
