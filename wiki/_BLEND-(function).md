The [_BLEND (function)](_BLEND-(function)) function returns enabled or disabled for the current window or a specified image handle when 32 bit.

## Syntax

> result% = [_BLEND (function)](_BLEND-(function))  [(imageHandle&)] 

## Description

* _BLEND returns -1 if enabled or 0 if disabled by [_DONTBLEND](_DONTBLEND) statement.
* **Note: [_DONTBLEND](_DONTBLEND) is faster than the default [_BLEND](_BLEND) unless you really need to use it in 32 bit.**

## See Also

* [_DONTBLEND](_DONTBLEND), [_BLEND](_BLEND)
* [Images](Images)
