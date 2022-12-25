**$EXEICON** pre-compiler  metacommand embeds a designated icon file into the compiled EXE file to be viewed in Windows Explorer.

## Syntax

>  [$EXEICON]($EXEICON):'iconfile.ico'

## Parameter(s)

* 'iconfile.ico' is a valid [ICO file format](https://en.wikipedia.org/wiki/ICO)

## Description

* Calling [_ICON](_ICON) without an imageHandle& uses the embeded icon, if available.
  * Starting with **build 20170906/64**, the window will automatically use the icon embedded by [$EXEICON]($EXEICON), without having to call _ICON.
* **[Keywords currently not supported](Keywords-currently-not-supported-by-QB64)**.

## Example(s)

 Embeds a designated icon file into the compiled EXE which can be viewed in Windows Explorer folders.

```vb

$EXEICON:'mush.ico'
_ICON

```

## See Also

* [_ICON](_ICON)
* [_TITLE](_TITLE)
