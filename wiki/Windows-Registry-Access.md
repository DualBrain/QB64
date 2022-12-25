The following procedure demonstrates how Registry information can be altered by disabling and re-enabling the Autorun/Autoplay for the current user. It then reads the Registry to list some of the programs that auto start for all users.

<sub>Code courtesy of Michael Calkins</sub>

**WARNING! Use care when editing or altering Registry settings! YOU will be responsible for any damages incurred!**

```vb

' winreg.h
CONST HKEY_CLASSES_ROOT = &H80000000~&
CONST HKEY_CURRENT_USER = &H80000001~&
CONST HKEY_LOCAL_MACHINE = &H80000002~&
CONST HKEY_USERS = &H80000003~&
CONST HKEY_PERFORMANCE_DATA = &H80000004~&
CONST HKEY_CURRENT_CONFIG = &H80000005~&
CONST HKEY_DYN_DATA = &H80000006~&
CONST REG_OPTION_VOLATILE = 1
CONST REG_OPTION_NON_VOLATILE = 0
CONST REG_CREATED_NEW_KEY = 1
CONST REG_OPENED_EXISTING_KEY = 2

' **http://msdn.microsoft.com/en-us/library/ms724884(v=VS.85).aspx**
CONST REG_NONE = 0
CONST REG_SZ = 1
CONST REG_EXPAND_SZ = 2
CONST REG_BINARY = 3
CONST REG_DWORD_LITTLE_ENDIAN = 4  '   value is defined REG_DWORD in Windows header files
CONST REG_DWORD = 4 '                  32-bit number
CONST REG_DWORD_BIG_ENDIAN = 5 '       some UNIX systems support big-endian architectures
CONST REG_LINK = 6
CONST REG_MULTI_SZ = 7
CONST REG_RESOURCE_LIST = 8
CONST REG_FULL_RESOURCE_DESCRIPTOR = 9
CONST REG_RESOURCE_REQUIREMENTS_LIST = 10
CONST REG_QWORD_LITTLE_ENDIAN = 11  '  64-bit number in little-endian format
CONST REG_QWORD = 11 '                 64-bit number
CONST REG_NOTIFY_CHANGE_NAME = 1
CONST REG_NOTIFY_CHANGE_ATTRIBUTES = 2
CONST REG_NOTIFY_CHANGE_LAST_SET = 4
CONST REG_NOTIFY_CHANGE_SECURITY = 8

' **http://msdn.microsoft.com/en-us/library/ms724878(v=VS.85).aspx**
CONST KEY_ALL_ACCESS = &HF003F&
CONST KEY_CREATE_LINK = &H0020&
CONST KEY_CREATE_SUB_KEY = &H0004&
CONST KEY_ENUMERATE_SUB_KEYS = &H0008&
CONST KEY_EXECUTE = &H20019&
CONST KEY_NOTIFY = &H0010&
CONST KEY_QUERY_VALUE = &H0001&
CONST KEY_READ = &H20019&
CONST KEY_SET_VALUE = &H0002&
CONST KEY_WOW64_32KEY = &H0200&
CONST KEY_WOW64_64KEY = &H0100&
CONST KEY_WRITE = &H20006&

' winerror.h
' **http://msdn.microsoft.com/en-us/library/ms681382(v=VS.85).aspx**
CONST ERROR_SUCCESS = 0
CONST ERROR_FILE_NOT_FOUND = &H2&
CONST ERROR_INVALID_HANDLE = &H6&
CONST ERROR_MORE_DATA = &HEA&
CONST ERROR_NO_MORE_ITEMS = &H103&
'---------------------------------------------------------------------------------------------
' REGSAM is an ACCESS_MASK (winreg.h), which is a DWORD (winnt.h)

DECLARE DYNAMIC LIBRARY "advapi32"

 ' http://msdn.microsoft.com/en-us/library/ms724897(v=VS.85).aspx
 FUNCTION RegOpenKeyExA& (BYVAL hKey AS _OFFSET, BYVAL lpSubKey AS _OFFSET, BYVAL ulOptions AS _UNSIGNED LONG, BYVAL samDesired AS _UNSIGNED LONG, BYVAL phkResult AS _OFFSET)

 ' http://msdn.microsoft.com/en-us/library/ms724837(v=VS.85).aspx
 FUNCTION RegCloseKey& (BYVAL hKey AS _OFFSET)

 ' http://msdn.microsoft.com/en-us/library/ms724865(v=VS.85).aspx
 FUNCTION RegEnumValueA& (BYVAL hKey AS _OFFSET, BYVAL dwIndex AS _UNSIGNED LONG, BYVAL lpValueName AS _OFFSET, BYVAL lpcchValueName AS _OFFSET, BYVAL lpReserved AS _OFFSET, BYVAL lpType AS _OFFSET, BYVAL lpData AS _OFFSET, BYVAL lpcbData AS _OFFSET)

 ' http://msdn.microsoft.com/en-us/library/ms724911(v=VS.85).aspx
 FUNCTION RegQueryValueExA& (BYVAL hKey AS _OFFSET, BYVAL lpValueName AS _OFFSET, BYVAL lpReserved AS _OFFSET, BYVAL lpType AS _OFFSET, BYVAL lpData AS _OFFSET, BYVAL lpcbData AS _OFFSET)

 ' http://msdn.microsoft.com/en-us/library/ms724923(v=VS.85).aspx
 FUNCTION RegSetValueExA& (BYVAL hKey AS _OFFSET, BYVAL lpValueName AS _OFFSET, BYVAL Reserved AS _UNSIGNED LONG, BYVAL dwType AS _UNSIGNED LONG, BYVAL lpData AS _OFFSET, BYVAL cbData AS _UNSIGNED LONG)

 'untested:

 ' http://msdn.microsoft.com/en-us/library/ms724862(v=VS.85).aspx
 FUNCTION RegEnumKeyExA& (BYVAL hKey AS _OFFSET, BYVAL dwIndex AS _UNSIGNED LONG, BYVAL lpName AS _OFFSET, BYVAL lpcName AS _OFFSET, BYVAL lpReserved AS _OFFSET, BYVAL lpClass AS _OFFSET, BYVAL lpcClass AS _OFFSET, BYVAL lpftLastWriteTime AS _OFFSET)

 ' http://msdn.microsoft.com/en-us/library/ms724844(v=VS.85).aspx
 FUNCTION RegCreateKeyExA& (BYVAL hKey AS _OFFSET, BYVAL lpSubKey AS _OFFSET, BYVAL Reserved AS _UNSIGNED LONG, BYVAL lpClass AS _OFFSET, BYVAL dwOptions AS _UNSIGNED LONG, BYVAL samDesired AS _UNSIGNED LONG, BYVAL lpSecurityAttributes AS _OFFSET, BYVAL phkResult AS _OFFSET, BYVAL lpdwDisposition AS _OFFSET)

 ' http://msdn.microsoft.com/en-us/library/ms724851(v=VS.85).aspx
 FUNCTION RegDeleteValueA& (BYVAL hKey AS _OFFSET, BYVAL lpValueName AS _OFFSET) '<<< DANGER

 ' http://msdn.microsoft.com/en-us/library/ms724845(v=VS.85).aspx
 FUNCTION RegDeleteKeyA& (BYVAL hKey AS _OFFSET, BYVAL lpSubKey AS _OFFSET) '<<< DANGER

 ' http://msdn.microsoft.com/en-us/library/ms724905(v=VS.85).aspx
 FUNCTION RegQueryMultipleValuesA& (BYVAL hKey AS _OFFSET, BYVAL val_list AS _OFFSET, BYVAL num_vals AS _UNSIGNED LONG, BYVAL lpValueBuf AS _OFFSET, BYVAL ldwTotsize AS _OFFSET)

 ' http://msdn.microsoft.com/en-us/library/ms724902(v=VS.85).aspx
 FUNCTION RegQueryInfoKeyA& (BYVAL hKey AS _OFFSET, BYVAL lpClass AS _OFFSET, BYVAL lpcClass AS _OFFSET, BYVAL lpReserved AS _OFFSET, BYVAL lpcSubKeys AS _OFFSET, BYVAL lpcMaxSubKeyLen AS _OFFSET, BYVAL lpcMaxClassLen AS _OFFSET, BYVAL lpcValues AS _OFFSET, BYVAL lpcMaxValueNameLen AS _OFFSET, BYVAL lpcMaxValueLen AS _OFFSET, BYVAL lpcbSecurityDescriptor AS _OFFSET, BYVAL lpftLastWriteTime AS _OFFSET)
END DECLARE

 ' http://msdn.microsoft.com/en-us/library/ms725490(v=VS.85).aspx
TYPE VALENT 'for RegQueryMultipleValues
 ve_valuename AS _OFFSET
 ve_valuelen AS _UNSIGNED LONG
 ve_valueptr AS _OFFSET
 ve_type AS _UNSIGNED LONG
END TYPE

' example:

DIM hKey AS _OFFSET
DIM Ky AS _OFFSET
DIM SubKey AS STRING
DIM Value AS STRING
DIM bData AS STRING
DIM t AS STRING
DIM dwType AS _UNSIGNED LONG
DIM numBytes AS _UNSIGNED LONG
DIM numTchars AS _UNSIGNED LONG
DIM l AS LONG
DIM dwIndex AS _UNSIGNED LONG

Ky = HKEY_CURRENT_USER
SubKey = "Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" + CHR$(0)
Value = "NoDriveTypeAutoRun" + CHR$(0)
bData = SPACE$(4)
numBytes = LEN(bData)

DO
 PRINT "This value enables/disables AutoRun/AutoPlay for the current user:"
 l = RegOpenKeyExA(Ky, _OFFSET(SubKey), 0, KEY_READ, _OFFSET(hKey))
 IF l THEN
  PRINT "RegOpenKeyExA failed. Error: 0x" + LCASE$(HEX$(l))
 ELSE
  l = RegQueryValueExA(hKey, _OFFSET(Value), 0, _OFFSET(dwType), _OFFSET(bData), _OFFSET(numBytes))
  IF l THEN
   PRINT "RegQueryValueExA failed. Error: 0x" + LCASE$(HEX$(l))
  ELSE
   PRINT whatKey$(Ky) + "\" + SubKey
   PRINT whatType(dwType) + " " + Value + " = " + formatData(dwType, numBytes, bData)
  END IF
  l = RegCloseKey(hKey)
  IF l THEN
   PRINT "RegCloseKey failed. Error: 0x" + LCASE$(HEX$(l))
   END
  END IF
 END IF
 IF dwType <> REG_DWORD THEN
  PRINT "Oops. I expected that value to be a DWORD."
  EXIT DO
 END IF
 PRINT
 PRINT "Would you like to change that value? ";
 DO
  _LIMIT 20
  t = LCASE$(INKEY$)
 LOOP UNTIL (t = "y") OR (t = "n")
 PRINT t
 IF t = "y" THEN
  PRINT "I recommend setting this value to 0xff to disable AutoRun for the current user."
  PRINT "Enter a new DWORD value: 0x";
  LINE INPUT t
  bData = MKL$(VAL("&h" + t + "&"))
  t = "y"
  l = RegOpenKeyExA(Ky, _OFFSET(SubKey), 0, KEY_ALL_ACCESS, _OFFSET(hKey))
  IF l THEN
   PRINT "RegOpenKeyExA failed. Error: 0x" + LCASE$(HEX$(l))
  ELSE
   l = RegSetValueExA(hKey, _OFFSET(Value), 0, dwType, _OFFSET(bData), numBytes)
   IF l THEN
    PRINT "RegSetValueExA failed. Error: 0x" + LCASE$(HEX$(l))
   END IF
   l = RegCloseKey(hKey)
   IF l THEN
    PRINT "RegCloseKey failed. Error: 0x" + LCASE$(HEX$(l))
    END
   END IF
  END IF
  PRINT
 END IF
LOOP UNTIL t = "n"

PRINT
PRINT "This key lists some of the programs that auto start for all users:"
Ky = HKEY_LOCAL_MACHINE
SubKey = "SOFTWARE\Microsoft\Windows\CurrentVersion\Run" + CHR$(0)
Value = SPACE$(261) 'ANSI Value name limit 260 chars + 1 null
bData = SPACE$(&H7FFF) 'arbitrary

l = RegOpenKeyExA(Ky, _OFFSET(SubKey), 0, KEY_READ, _OFFSET(hKey))
IF l THEN
 PRINT "RegOpenKeyExA failed. Error: 0x" + LCASE$(HEX$(l))
ELSE
 PRINT whatKey$(Ky) + "\" + SubKey
 dwIndex = 0
 DO
  SLEEP 1
  numBytes = LEN(bData)
  numTchars = LEN(Value)
  l = RegEnumValueA(hKey, dwIndex, _OFFSET(Value), _OFFSET(numTchars), 0, _OFFSET(dwType), _OFFSET(bData), _OFFSET(numBytes))
  IF l THEN
   IF l <> ERROR_NO_MORE_ITEMS THEN
    PRINT "RegEnumValueA failed. Error: 0x" + LCASE$(HEX$(l))
   END IF
   EXIT DO
  ELSE
   PRINT whatType(dwType) + " " + LEFT$(Value, numTchars) + " = " + formatData(dwType, numBytes, bData)
  END IF
  dwIndex = dwIndex + 1
 LOOP
 PRINT dwIndex; "Values."
 l = RegCloseKey(hKey)
 IF l THEN
  PRINT "RegCloseKey failed. Error: 0x" + LCASE$(HEX$(l))
  END
 END IF
END IF

END

FUNCTION whatType$ (dwType AS _UNSIGNED LONG)
SELECT CASE dwType
 CASE REG_SZ: whatType = "REG_SZ"
 CASE REG_EXPAND_SZ: whatType = "REG_EXPAND_SZ"
 CASE REG_BINARY: whatType = "REG_BINARY"
 CASE REG_DWORD: whatType = "REG_DWORD"
 CASE REG_DWORD_BIG_ENDIAN: whatType = "REG_DWORD_BIG_ENDIAN"
 CASE REG_LINK: whatType = "REG_LINK"
 CASE REG_MULTI_SZ: whatType = "REG_MULTI_SZ"
 CASE REG_RESOURCE_LIST: whatType = "REG_RESOURCE_LIST"
 CASE REG_FULL_RESOURCE_DESCRIPTOR: whatType = "REG_FULL_RESOURCE_DESCRIPTOR"
 CASE REG_RESOURCE_REQUIREMENTS_LIST: whatType = "REG_RESOURCE_REQUIREMENTS_LIST"
 CASE REG_QWORD: whatType = "REG_QWORD"
 CASE ELSE: whatType = "unknown"
END SELECT
END FUNCTION

FUNCTION whatKey$ (hKey AS _OFFSET)
SELECT CASE hKey
 CASE HKEY_CLASSES_ROOT: whatKey = "HKEY_CLASSES_ROOT"
 CASE HKEY_CURRENT_USER: whatKey = "HKEY_CURRENT_USER"
 CASE HKEY_LOCAL_MACHINE: whatKey = "HKEY_LOCAL_MACHINE"
 CASE HKEY_USERS: whatKey = "HKEY_USERS"
 CASE HKEY_PERFORMANCE_DATA: whatKey = "HKEY_PERFORMANCE_DATA"
 CASE HKEY_CURRENT_CONFIG: whatKey = "HKEY_CURRENT_CONFIG"
 CASE HKEY_DYN_DATA: whatKey = "HKEY_DYN_DATA"
END SELECT
END FUNCTION

FUNCTION formatData$ (dwType AS _UNSIGNED LONG, numBytes AS _UNSIGNED LONG, bData AS STRING)
DIM t AS STRING
DIM ul AS _UNSIGNED LONG
DIM b AS _UNSIGNED _BYTE
SELECT CASE dwType
 CASE REG_SZ, REG_EXPAND_SZ, REG_MULTI_SZ
  formatData = LEFT$(bData, numBytes)
 CASE REG_DWORD
  t = LCASE$(HEX$(CVL(LEFT$(bData, 4))))
  formatData = "0x" + STRING$(8 - LEN(t), &H30) + t
 CASE ELSE
  IF numBytes THEN
   b = ASC(LEFT$(bData, 1))
   IF b < &H10 THEN
    t = t + "0" + LCASE$(HEX$(b))
   ELSE
    t = t + LCASE$(HEX$(b))
   END IF
  END IF
  FOR ul = 2 TO numBytes
   b = ASC(MID$(bData, ul, 1))
   IF b < &H10 THEN
    t = t + " 0" + LCASE$(HEX$(b))
   ELSE
    t = t + " " + LCASE$(HEX$(b))
   END IF
  NEXT
  formatData = t
END SELECT
END FUNCTION

```

> *Note:* This procedure lists most of the Constants and Registry functions available, but only uses a few of them in this demo. All of these functions, except RegCloseKey, have both ANSI (ending in A) and Unicode (ending in W) versions. I am not aware of any reason why both  versions could not be used in the same program. To add the Unicode version, duplicate the function declaration, but change the ending A to W. Be sure that you know how to use the [Unicode](Unicode) version!

**WARNING! Use care when editing or altering Registry settings! YOU will be responsible for any damages incurred!**

**Your code contribution using the above Registry Libraries could end up here!**

## See Also

* [Windows Libraries](Windows-Libraries)
* [DECLARE LIBRARY](DECLARE-LIBRARY)
* [_OFFSET](_OFFSET)
