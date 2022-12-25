The [_SNDOPENRAW](_SNDOPENRAW) function opens a new channel to fill with _SNDRAW content to manage multiple dynamically generated sounds.

## Syntax

> pipeHandle& = [_SNDOPENRAW](_SNDOPENRAW)

## Description

* You can manage multiple dynamically generated sounds at once without having to worry about mixing.
* Use [_SNDCLOSE](_SNDCLOSE) to remove the pipe sound handles from memory.

## Example(s)

Combining 2 sounds without worrying about mixing:

```vb

a = _SNDOPENRAW
b = _SNDOPENRAW

FOR x = 1 TO 100000
    _SNDRAW SIN(x / 10), , a 'fill with a tone
    _SNDRAW RND * 1 - 0.5, , b 'fill with static
NEXT

_SNDCLOSE a
_SNDCLOSE b 

```

## See Also

* [_SNDRAWDONE](_SNDRAWDONE)
* [_SNDRAW](_SNDRAW)
* [_SNDCLOSE](_SNDCLOSE)
