The [_MOUSEPIPEOPEN](_MOUSEPIPEOPEN) function creates a pipe handle value for a mouse when using a virtual keyboard.

## Syntax

> vkMousePipe = [_MOUSEPIPEOPEN](_MOUSEPIPEOPEN)

## Description

* The pipe handle value can be used optionally with [_MOUSEINPUT](_MOUSEINPUT), [_MOUSEX](_MOUSEX), [_MOUSEY](_MOUSEY), and [_MOUSEBUTTON](_MOUSEBUTTON) when required.

## Example(s)

The following snippet isn't runnable/compilable, but it showcases the use of the [_MOUSEPIPEOPEN](_MOUSEPIPEOPEN) function.

```vb

    mDown = 0
    mUp = 0
    mEvent = 0

IF VkMousePipe = 0 THEN	
	VkMousePipe = _MOUSEPIPEOPEN 'create new pipe
END IF

        DO WHILE _MOUSEINPUT(VkMousePipe)
            mb = _MOUSEBUTTON(1, VkMousePipe)

            mx = _MOUSEX(VkMousePipe)
            my = _MOUSEY(VkMousePipe)

            IF _PIXELSIZE = 0 THEN 'screen 0 adjustment
                mx = mx * 8 - 4
                my = my * 16 - 8
            END IF
            IF mb = -1 AND omb = 0 THEN mDown = -1: mEvent = 1: EXIT DO

	    if VkMousePipeCapture=0 then
                _MOUSEINPUTPIPE VkMousePipe
	    end if

            IF mb = 0 AND omb = -1 THEN
		VkMousePipeCapture=0
		mUp = -1
		mEvent = 1
		EXIT DO
	    end if

        LOOP
        omb = mb


    rootId = VkByRole("ROOT")
    editMode = VK(rootId).locked

    IF mDown THEN	
        mDownX = mx
        mDownY = my
        i2 = 0

        FOR internal = 1 TO 0 STEP -1
            FOR i = VkLast TO 1 STEP -1
                IF VK(i).active THEN
                    IF VK(i).internal = internal THEN
                        x = VK(i).x * VkUnitSize
                        y = VK(i).y * VkUnitSize
                        w = VK(i).w
                        h = VK(i).h
                        x1 = INT(x)
                        x2 = INT(x + VkUnitSize * w) - 1
                        y1 = sy - 1 - INT(y)
                        y2 = sy - 1 - INT(y + VkUnitSize * h) + 1
                        IF mx >= x1 AND mx <= x2 AND my >= y2 AND my <= y1 THEN
                            i2 = i
                            EXIT FOR
                        END IF
                    END IF
                END IF
            NEXT
            IF i2 THEN EXIT FOR
        NEXT
        IF i2 THEN
            VkI = i2
            VKoldX = VK(i2).x
            VKoldY = VK(i2).y
            VKdragging = 0
            VKstart = TIMER(0.001)
            'VK(i2).held = -1
            VkKeyDown i2
	    VkMousePipeCapture=1
        END IF
        IF VkMousePipeCapture = 0 THEN _MOUSEINPUTPIPE VkMousePipe
    END I

```

> When using the [$VIRTUALKEYBOARD]($VIRTUALKEYBOARD), the keyboard captures mouse input appropriately whilst selectively letting presses originating on non-key areas of the screen filter through to the default mouse queue.

## See Also

* [$VIRTUALKEYBOARD]($VIRTUALKEYBOARD)
