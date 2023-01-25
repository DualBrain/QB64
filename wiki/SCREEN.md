The [SCREEN](SCREEN) statement sets the video display mode and size of the program window's workspace. 

## Syntax

> **SCREEN** {*mode%*|*imagehandle&*} [, , active_page, visual_page] 

## Parameter(s)
 
* The SCREEN *mode* [INTEGER](INTEGER) values available today are 0 to 2 and 7 to 13 listed below. 
* **QB64** can use a [LONG](LONG) [_NEWIMAGE](_NEWIMAGE) page or [_LOADIMAGE](_LOADIMAGE) file *image handle* value instead.
* The empty comma disables color when any value is used. **DO NOT USE!** Include the comma ONLY when using page flipping.
* If the SCREEN mode supports pages, the *active page* is the page to be worked on while *visual page* is the one displayed.

## Usage
 
* No SCREEN statement in a program defaults to [SCREEN](SCREEN) 0 text ONLY mode.
* A SCREEN statement that changes screen modes also clears the screen like [CLS](CLS). Nothing on the screen is retained.
* Some screen mode text sizes are adjustable with [WIDTH](WIDTH) and all **QB54** screens support [PCOPY](PCOPY) and page flipping. 

```text

                       **LEGACY SCREEN MODES AT A GLANCE**

 **Screen      Text           Graphics          Colors      Video    Text      Default** 
  **Mode   Rows   Columns   Width   Height  Attrib.   BPP   Pages    Block    QB64 Font**

   0   25/43/50  80/40    No graphics     16/16 DAC  4     0-7     -----    _FONT 16
   1      25      40      320     200     16/4 BG    4     none    8 X 8    _FONT 8 
   2      25      80      640     200      2/mono    1     none    8 X 8    _FONT 8 
   ................................................................................. 
   7      25      40      320     200     16/16 DAC  4     0-7     8 X 8    _FONT 8 
   8      25      80      640     200     16/16      4     0-3     8 X 8    _FONT 8 
   9      25      80      640     350     16/64 DAC  4     0-1     8 X 14   _FONT 14
  10      25      80      640     350     4/2 GScale 2     none    8 X 14   _FONT 14
  11     30/60    80      640     480      2/mono    1     none    8 X 16   _FONT 16
  12     30/60    80      640     480     16/262K    4     none    8 X 16   _FONT 16
  13      25      40      320     200     256/65K    8     none    8 X 8    _FONT 8 

              **QB64 allows video paging and [PCOPY](PCOPY) in ALL screen modes!** 

```

> **QB64 Custom Screen Modes**

## QB64 Syntax
  
> [SCREEN](SCREEN) *imagehandle&* [, , *active_page*, *visual_page*]

> [SCREEN](SCREEN) [_NEWIMAGE](_NEWIMAGE)(*wide&*, *high&*[, {*mode*|*256*|*32*}]) [, , *active_page*, *visual_page*]

> [SCREEN](SCREEN) [_LOADIMAGE](_LOADIMAGE)(*file$*[, {*mode*|*256*|*32*}]) [, , *active_page*, *visual_page*]

* Custom screen modes can be created using a [_NEWIMAGE](_NEWIMAGE) or [_LOADIMAGE](_LOADIMAGE) function *imagehandle* return value. 
* **QB64** screen modes 0 to 2 and 7 to 13 can be emulated with the same color depth and text block size and different dimensions.
* [_NEWIMAGE](_NEWIMAGE) screens can be any set size. A screen mode can be emulated or 256 or 32 bit colors can be designated.
* The [_LOADIMAGE](_LOADIMAGE) screen size will be the size of the image loaded. Can designate a *mode* or 256 or 32 bit colors.
* **QB64** allows page flipping or a [PCOPY](PCOPY) in ANY SCREEN mode. [_DISPLAY](_DISPLAY) can also be used to reduce flickering in animations.
* All SCREEN modes are Windows in QB64. Use [_FULLSCREEN](_FULLSCREEN) to set the window area to full screen.
* [_SCREENMOVE](_SCREENMOVE) can position a window or the _MIDDLE option can center it on the desktop.

## Legacy Screen Modes

* **[SCREEN](SCREEN) 0** (default mode) is a **text only** screen mode. 64 (VGA) colors with hi-intensity(blinking) colors 16 to 31. ([DAC](DAC) attrib 6, 8 to 15). 8 Background colors intensities only(0 - 7). No graphics are possible! Normally runs in a window. ALT-Enter switches from a window to fullscreen. To automatically run in **QBasic** fullscreen, use another Screen mode before using [SCREEN (statement)](SCREEN-(statement)) 0.  Can use [PCOPY](PCOPY) with video pages 0 to 7. Text is 25, 43 or 50 rows by 40 or 80 columns. Default is 25 by 80. See [WIDTH](WIDTH).

>  **Note:** Use [OUT](OUT) or [_PALETTECOLOR](_PALETTECOLOR) to create higher intensity color backgrounds than [COLOR](COLOR) , 7.  

> **All other available [SCREEN](SCREEN) modes can use text and graphics and are fullscreen in QBasic ONLY.**

* **[SCREEN](SCREEN) 1** has 4 background color attributes. 0 = black, 1 = blue, 2 = green, 3 = grey. White foreground only. Text is 25 by 40. White graphics is 320 by 200. 

* **[SCREEN](SCREEN) 2** is **monochrome** with black background and white foreground. Text is 25 by 80. White graphics 640 by 200. NO [COLOR](COLOR) keyword allowed.
 
* **[SCREEN](SCREEN) 3 to 6 are no longer supported** on most computers! Using them will cause a video [ERROR Codes](ERROR-Codes)! 

* **[SCREEN](SCREEN) 7** has 16 color attributes ([DAC](DAC) attrib. 8 to 15) with background colors. Text 25 rows by 40 columns. Graphics 320 columns by 200 rows. Video  pages 0 to 7 for flipping or [PCOPY](PCOPY).

* **[SCREEN](SCREEN) 8** has 16 color attributes with background. Text is 25 by 80. Graphics is 640 by 200. Video pages 0 to 3.

* **[SCREEN](SCREEN) 9** has 64 DAC color hues for ([DAC](DAC) attrib. 6, 8 to 15) with background colors. Text is 25 by 80. Graphics is 640 by 350. Video pages 0 and 1 for flipping or [PCOPY](PCOPY). 

* **[SCREEN](SCREEN) 10** has 4 gray scale color attributes with black background. 1 = normal white, 2 = blinking white and 3 = bright white. Text is 25 by 80. Graphics is 640 by 350.

* **[SCREEN](SCREEN) 11** is **monochrome** with black background and white foreground. Text is 30 or 60 by 80 columns(see [WIDTH](WIDTH)). White graphics is 640 by 480. NO [COLOR](COLOR) keyword allowed.

* **[SCREEN](SCREEN) 12** has 16 color attributes, black background. 256K possible color hues. Text is 30 or 60 by 80 columns(see [WIDTH](WIDTH)). Graphics 640 by 480. 

* **[SCREEN](SCREEN) 13** has 256 color attributes, black background. 256K possible color hues. Text is 25 by 40. Graphics is 320 by 200. 

## Modern Syntax

* **[SCREEN](SCREEN) [_NEWIMAGE](_NEWIMAGE)**(wide&, deep&, mode%) can imitate any size screen mode or use 32 bit or 256 color modes in **QB64**.

* **[SCREEN](SCREEN) [_LOADIMAGE](_LOADIMAGE)**(imagehandle&, colors) can load a program screen of an image file handle in **QB64** using 256 or 32 bit. 

**QB64 can use page flipping with any number of pages in any screen mode!**

## Text and Graphics

> **Text Coordinates:** 

* Are a minimum of 1 and the values given above are the maximums. [LOCATE](LOCATE) 1, 1 is the top left [SCREEN](SCREEN) text position.
* Text characters occupy a certain sized pixel box adjusted by [WIDTH](WIDTH) in some screen modes.
* Text [PRINT](PRINT) cursor positions can be read by [CSRLIN](CSRLIN) and [POS](POS) to [LOCATE](LOCATE) text [PRINT](PRINT)s.
* The [SCREEN (function)](SCREEN-(function)) can be used to read the [ASCII](ASCII) character code or color of text in SCREEN 0 only.
* [VIEW PRINT](VIEW-PRINT) can be used to designate a text view port area.
* In **QB64** the [_WIDTH (function)](_WIDTH-(function)) and [_HEIGHT](_HEIGHT) functions will return the text block dimensions in SCREEN 0 only.

> **Graphic Coordinates:**

* The minimum on screen graphics pixel coordinates are 0 for columns and rows in the top left corner.
* Maximum pixel coordinates are one less than the maximum dimensions above because the pixel count starts at 0.
* Graphic objects such as [PSET](PSET), [PRESET](PRESET), [LINE](LINE), [CIRCLE](CIRCLE) and [DRAW](DRAW) can be placed partially off of the screen.
* [GET (graphics statement)](GET-(graphics-statement)) and [PUT (graphics statement)](PUT-(graphics-statement)) screen image operations MUST be located completely on the screen in QBasic!
* [VIEW](VIEW) can be used to designate a graphic view port area of the screen.
* [WINDOW](WINDOW) can be used to set the graphics SCREEN coordinates to almost any size needed. Use the SCREEN option for normal row coordinate values. Row coordinates are Cartesian(decrease in value going down the screen) otherwise.
* In **QB64** the [_WIDTH (function)](_WIDTH-(function)) and [_HEIGHT](_HEIGHT) functions will return the graphic pixel dimensions in SCREENs other than 0.

> **QB64 Screen Statements and Functions:**

* For file image screens that adopt the image dimensions and image color settings use: [_LOADIMAGE](_LOADIMAGE)
* To create custom sized screen modes or pages and 256 or 32 bit colors use: [_NEWIMAGE](_NEWIMAGE)
* [_PUTIMAGE](_PUTIMAGE) can stretch or reduce the size of images to fit the SCREEN size.
* [PUT (graphics statement)](PUT-(graphics-statement)) can use [_CLIP](_CLIP) to set objects partially off screen. [GET (graphics statement)](GET-(graphics-statement)) can read objects off screen as a color in QB64 ONLY.
* A [_DISPLAY](_DISPLAY) statement can be used to only display an image after changes instead of using page flipping or [PCOPY](PCOPY).
* The current desktop screen resolution can be found using the [_SCREENIMAGE](_SCREENIMAGE) handle value with [_WIDTH (function)](_WIDTH-(function)) and [_HEIGHT](_HEIGHT).
* **NOTE: Default 32 bit backgrounds are clear black or [_RGBA](_RGBA)(0, 0, 0, 0)! Use [CLS](CLS) to make the black opaque!**
*  **Images are not deallocated when the [SUB](SUB) or [FUNCTION](FUNCTION) they are created in ends. Free them with [_FREEIMAGE](_FREEIMAGE).**

## Example(s)

> Shows an example of each legacy screen mode available to QBasic and QB64.

```vb

SCREEN 0
PRINT "This is SCREEN 0 - only text is allowed!"
FOR S = 1 TO 13
   IF S < 3 OR S > 6 THEN 
     DO: SLEEP: LOOP UNTIL INKEY$ <> ""
     SCREEN S
     PRINT "This is SCREEN"; S; " - can use text and graphics!"
       IF S = 2 OR S = 11 THEN PRINT "Monochrome - no COLOR statements!"
       IF S = 10 THEN 
         COLOR 2: PRINT "This SCREEN has only 4 colors. Black and 3 white: 2 blinks.
         CIRCLE (100,100), 50, 2
       ELSE : CIRCLE (100,100), 100, S
       END IF
   END IF
NEXT 
SLEEP
SYSTEM 

```

```text

This is SCREEN 0 - only text is allowed!

```

> Displays each [SCREEN (statement)](SCREEN-(statement)) mode one at a time with a [CIRCLE](CIRCLE) (except for [SCREEN (statement)](SCREEN-(statement)) 0)

Making ANY **QB64 legacy screen mode** larger using a SUB that easily converts PRINT to [_PRINTSTRING](_PRINTSTRING). 

```vb

Scr13& = _NEWIMAGE(320, 200, 13)  'this is the old SCREEN 13 image page to set the image
Big13& = _NEWIMAGE(640, 480, 256) 'use 4 X 3 aspect ratio that Qbasic used when full screen

SCREEN Big13&
_DEST Scr13&
image1& = _LOADIMAGE("Howie.BMP", 256)  'see the download link below for 2 image files
image2& = _LOADIMAGE("Howie2.BMP", 256)
_PUTIMAGE (10, 20), image1&, Scr13&
_PUTIMAGE (160, 20), image2&, Scr13&
_COPYPALETTE image1&, Scr13&
COLOR 151: LOCATE 2, 4: PRINTS "Screen 13 Height Reduction to 83%" 
LOCATE 22, 22: PRINTS CHR$(24) + " 4 X 3 Proportion"  'use concatenation
LOCATE 24, 21: PRINTS CHR$(27) + " Stretched at 100%" 'instead of a semicolon!
_COPYPALETTE Scr13&, Big13&  'required when imported image colors are used
_PUTIMAGE , Scr13&, Big13&   'stretches the screen to double the size
K$ = INPUT$(1)
END

SUB PRINTS (Text$)
row% = (CSRLIN - 1) * _FONTHEIGHT      'finds current screen page text or font row height
col% = (POS(0) - 1) * _PRINTWIDTH("W") 'finds current page text or font column width
_PRINTSTRING (col%, row%), Text$
END SUB 

```
<sub>Code by Ted Weissgerber</sub>

> *Explanation:* The procedure above creates a larger version of a SCREEN 13 window by stretching it with [_PUTIMAGE](_PUTIMAGE). It cannot stretch PRINTed text so [_PRINTSTRING](_PRINTSTRING) must be used instead. [LOCATE](LOCATE) sets the PRINT cursor position for [CSRLIN](CSRLIN) and [POS](POS)(0) to read. The SUB then converts the coordinates to graphical ones. Then **change** [PRINT](PRINT) to PRINTS using the **Search Menu**.

[Download of Example 2 Bitmap images](http://dl.dropbox.com/u/8440706/HOWIE.zip)

You can easily change PRINT to the PRINTS sub-procedure name in your code using the IDE *Search*  Menu *Change* option.

## See Example(s)

* [SAVEIMAGE](SAVEIMAGE) (QB64 Image to Bitmap SUB by Galleon)
* [Program ScreenShots](Program-ScreenShots) (Member program for legacy screen modes)
* [ThirtyTwoBit SUB](ThirtyTwoBit-SUB) (QB64 Image area to bitmap)
* [SelectScreen](SelectScreen) (Member Screen mode function)

## See Also

* [COLOR](COLOR), [CLS](CLS), [WIDTH](WIDTH)
* [_NEWIMAGE](_NEWIMAGE), [_LOADIMAGE](_LOADIMAGE), [_SCREENIMAGE](_SCREENIMAGE)
* [_LOADFONT](_LOADFONT), [_FONT](_FONT)
* [_DISPLAY](_DISPLAY), [_COPYIMAGE](_COPYIMAGE), [_SCREENMOVE](_SCREENMOVE)
* [PALETTE](PALETTE), [OUT](OUT), [PCOPY](PCOPY), 
* [GET (graphics statement)](GET-(graphics-statement)), [PUT (graphics statement)](PUT-(graphics-statement)) (graphics)
* [VIEW](VIEW), [WINDOW](WINDOW)-(graphic-viewport), [VIEW PRINT](VIEW-PRINT) (text view port)
* [SCREEN (function)](SCREEN-(function)) (text only), [POINT](POINT) (graphic pixel colors)
* [Screen Memory](Screen-Memory), [Screen Saver Programs](Screen-Saver-Programs)
