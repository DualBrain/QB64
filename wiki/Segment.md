The memory **segment** is the hexadecimal byte address in relation to a segment register.

The value in a Segment register is multiplied by 16 or shifted one hexadecimal byte to the left(this adds an extra 0 to the end of the hex number). The value in the Offset register is added to it. So, the Absolute address for any combination of Segment and Offset is found using the formula:

> AbsoluteMemoryAddress = (Segment value * 16) + Offset value

## Example(s)

```text


           Segment Address =   F0000 ← shifted left
            Offset Address =  + FACE
                              ------
                               FFACE  or  1,047,246 

```

The Offset value is the position of a value after the segment address. Many pairs can be used to refer to the same memory position.

## See Also

* [DEF SEG](DEF-SEG), [DEF SEG = 0](DEF-SEG-=-0)
* [PEEK](PEEK), [POKE](POKE)
* [VARSEG](VARSEG), [VARPTR](VARPTR)
* [SADD](SADD)
