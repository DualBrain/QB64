The [_DIR$](_DIR$) function returns common paths in **Windows** only such as My Documents, My Pictures, My Music, Desktop.

## Syntax

> d$ = [_DIR$](_DIR$)("folderspecification")

## Parameter(s)

* *folderspecification* may be "desktop", "download", "documents", "music", "video", "pictures", "appdata", "program data", "local data", "program files", "program files (x86)", "temp".
* Some variation is accepted for the folder specification:
    * MY DOCUMENTS, TEXT, DOCUMENT, DOCUMENTS, DOWNLOAD, DOWNLOADS
    * MY MUSIC, MUSIC, AUDIO, SOUND, SOUNDS
    * MY PICTURES, PICTURE, PICTURES, IMAGE, IMAGES, PHOTO, PHOTOS, DCIM, CAMERA, CAMERA ROLL
    * MY VIDEOS, VIDEO, VIDEOS, MOVIE, MOVIES,
    * DATA, APPDATA, APPLICATION DATA, PROGRAM DATA, LOCAL DATA, LOCALAPPDATA, LOCAL APPLICATION DATA, LOCAL PROGRAM DATA

## Description

* The path returned ends with a backslash (Windows).
* A nonexistent folder specification usually defaults to the Desktop folder path.
* In Linux and macOS the function always returns **"./"**

## Example(s)

Displaying default paths in Windows only.

```vb

PRINT "DESKTOP=" + _DIR$("desktop")
PRINT "DOWNLOADS=" + _DIR$("download")
PRINT "DOCUMENTS=" + _DIR$("my documents")
PRINT "PICTURES=" + _DIR$("pictures")
PRINT "MUSIC=" + _DIR$("music")
PRINT "VIDEO=" + _DIR$("video")
PRINT "APPLICATION DATA=" + _DIR$("data")
PRINT "LOCAL APPLICATION DATA=" + _DIR$("local application data")

```

```text

DESKTOP=C:\Documents and Settings\Administrator\Desktop\
DOWNLOADS=C:\Documents and Settings\Administrator\Downloads\
DOCUMENTS=C:\Documents and Settings\Administrator\My Documents\
PICTURES=C:\Documents and Settings\Administrator\My Documents\My Pictures\
MUSIC=C:\Documents and Settings\Administrator\My Documents\My Music\
VIDEO=C:\Documents and Settings\Administrator\My Documents\My Videos\
APPLICATION DATA=C:\Documents and Settings\Administrator\Application Data\
LOCAL APPLICATION DATA=C:\Documents and Settings\Administrator\Local Settings\Application Data\ 

```

## See Also

* [_CWD$](_CWD$)
* [_STARTDIR$](_STARTDIR$)
