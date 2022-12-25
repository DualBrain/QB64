Sometimes your program may need to place a shaped sprite over background objects. To do that you cannot use the default [PUT (graphics statement)](PUT-(graphics-statement)) using XOR. [XOR](XOR) only works on black backgrounds! It distorts underlying colors. You could use the PSET option, but that places a square sprite only. To get irregularly shaped objects you need to create a "mask" of the sprite. After you have created your sprite with a BLACK background, GET the image to an [Arrays](Arrays). You can [BSAVE](BSAVE) it if you wish. Then create a mask of the sprite at the sprites current location. Use the GET box area coordinates(minX, maxX and minY, maxY) of sprite in the following routine:

<sub>Code by: Ted Weissgerber</sub>

```vb

FOR xx = minX TO maxX                                   
    FOR yy = minY TO maxY
        IF POINT(xx, yy) = 0 THEN PSET (xx, yy), 15 ELSE PSET (xx, yy), 0
    NEXT yy
NEXT xx
GET (minX, minY)-(maxX, maxY), Mask(0)

```

The mask routine simply changes all black portions of the sprite image to white and all other colors black. If your sprite uses black in it, you will need to assign the areas to another color attribute and change the RGB values to 0 using [OUT](OUT) or the background will show through the final image. Color 8 could be dark enough. 

GET the background at the sprite's starting position before trying to place a sprite or move it when necessary. Next we position the mask and PUT it with the [AND](AND) option. Then the actual sprite is PUT over the mask as shown below: 

```vb

GET (x, y)-(x + 60, y + 60), BG   ' GET BG at start position before sprite is set
PUT (x, y), Mask, AND             ' PUT mask at start position
PUT (x, y), Sprite                ' XOR will work fine on a mask 

```

The two PUTs use the same coordinate so moving objects is fairly simple. All you need is a keypress reading loop. Use INP(&H60) [Scancodes](Scancodes) for diagonal moves. 

But what about the background? Once you create the background you will need to [GET (graphics statement)](GET-(graphics-statement)) the sprite's box area at the starting position. You can PUT the background back to erase the sprite when moving. PX and PY are the previous x and y positions before they were changed by the user in a keypress routine:

```vb

'user keypress or programmed coordinate changes
IF x <> PX OR y <> PY THEN               ' look for a changed coordinate value
    WAIT 936, 8                          ' vertical retrace delay
    PUT (PX, PY), BG, PSET               ' replace previous BG first
    GET (x, y)-(x + 60, y + 60), BG      ' GET BG at new position before box is set
    PUT (x, y), Mask, AND                ' PUT mask at new position
    PUT (x, y), Sprite                   ' XOR will work fine on the mask
END IF
PX = x: PY = y 

```

In **QB64** [_CLEARCOLOR](_CLEARCOLOR) can also be used before using [_PUTIMAGE](_PUTIMAGE) to mask any sprite background color.

**See the [GET and PUT Demo](GET-and-PUT-Demo) to see how it works!**

## See Also

* [INP](INP), [Scancodes](Scancodes)(Example 3)
* [GET (graphics statement)](GET-(graphics-statement)), [PUT (graphics statement)](PUT-(graphics-statement)) 
* [Icons and Cursors](Icons-and-Cursors)
* [Creating Icons from Bitmaps](Creating-Icons-from-Bitmaps)
