The [_MAPUNICODE](_MAPUNICODE) statement maps a [Unicode](Unicode) value to an [ASCII](ASCII) character code value.

## Syntax

> [_MAPUNICODE](_MAPUNICODE) unicode& **TO** asciiCode%

* The [LONG](LONG) unicode& value is a [HEX$](HEX$) or decimal code value from a [Unicode](Unicode) [Code Pages](Code-Pages). 
* The asciiCode% [INTEGER](INTEGER) parameter is any [ASCII](ASCII) or Extended code value from 0 to 255.
* Use the Unicode Page Table values listed here: [DOS Code Pages](http://en.wikipedia.org/wiki/Category:DOS_code_pages) or [Windows Mapping](http://unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/)
* Once the codes are mapped, key entries will display the unicode character in the **monospace ** [_FONT](_FONT) selected.
* The [_MAPUNICODE (function)](_MAPUNICODE-(function)) function can be used to verify or read the present [Unicode](Unicode) UTF32 code point settings.
* **[_MAPUNICODE](_MAPUNICODE) can place the Unicode characters TO any [ASCII](ASCII) code space you desire (0 to 255)**.

## Example(s)

Converting the extended [ASCII](ASCII) characters to other characters using DATA from the Unicode [Code Pages](Code-Pages).

```vb

SCREEN 0
_FONT _LOADFONT("C:\windows\fonts\cour.ttf", 20, "MONOSPACE")

RESTORE Microsoft_pc_cpMIK
FOR ASCIIcode = 128 TO 255
  READ unicode
  _MAPUNICODE Unicode TO ASCIIcode
NEXT

FOR i = 128 TO 255
  PRINT CHR$(i) + " ";
  cnt = cnt + 1
  IF cnt MOD 16 = 0 THEN PRINT
NEXT
END

Microsoft_pc_cpMIK:
DATA 1040,1041,1042,1043,1044,1045,1046,1047,1048,1049,1050,1051,1052,1053,1054,1055
DATA 1056,1057,1058,1059,1060,1061,1062,1063,1064,1065,1066,1067,1068,1069,1070,1071
DATA 1072,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1086,1087
DATA 1088,1089,1090,1091,1092,1093,1094,1095,1096,1097,1098,1099,1100,1101,1102,1103
DATA 9492,9524,9516,9500,9472,9532,9571,9553,9562,9566,9577,9574,9568,9552,9580,9488
DATA 9617,9618,9619,9474,9508,8470,167,9559,9565,9496,9484,9608,9604,9612,9616,9600
DATA 945,223,915,960,931,963,181,964,934,920,937,948,8734,966,949,8745
DATA 8801,177,8805,8804,8992,8993,247,8776,176,8729,183,8730,8319,178,9632,160 

```

> *Note:* The Unicode data field is created by adding DATA before each line listed for the appropriate [Code Pages](Code-Pages).

## See Also

* [_MAPUNICODE (function)](_MAPUNICODE-(function)) 
* [ASCII](ASCII), [Unicode](Unicode), [_FONT](_FONT)
* [_KEYHIT](_KEYHIT), [_KEYDOWN](_KEYDOWN)
* [ASC](ASC), [INKEY$](INKEY$), [CHR$](CHR$)
* [Code Pages](Code-Pages) (by region)
* [Text Using Graphics](Text-Using-Graphics)
