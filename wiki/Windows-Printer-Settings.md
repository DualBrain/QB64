There are some **Windows command line statements** that allow one to *(i)* identify the current Windows default printer (as well as other printers associated with a PC) and *(ii)* change the default to a different printer. 

A program can use [SHELL](SHELL) statements in QB64 to execute those operating system commands. See the following examples provided by forum member **DonW**:

## Contents

* This code issues the command to display a PC's list of printers and routes the output to a text file:

```vb

SHELL _HIDE "CMD /C" + "wmic printer get name,default > default.txt"

```

A sample of the contents of the resulting file is as follows. Notice that the default printer is listed as "TRUE":

```text

Default  Name                           
  FALSE    Microsoft XPS Document Writer 
  TRUE     HP Photosmart C7200 series     
  FALSE    HP Officejet Pro 8600         
  FALSE    Fax

```

* Here is the code to set the default printer to the "HP Officejet Pro 8600" listed in the sample above:

```vb

SHELL _HIDE "CMD /C" + "wmic printer where name='HP Officejet Pro 8600' call setdefaultprinter" 

```

Then running the *get default* [SHELL](SHELL) code again, we see the following contents of the text file:

```text

Default  Name                           
  FALSE    Microsoft XPS Document Writer 
  FALSE    HP Photosmart C7200 series     
  TRUE     HP Officejet Pro 8600         
  FALSE    Fax

```

Now we see that the "HP Officejet Pro 8600" is marked as "TRUE", and thus is now the default printer for [LPRINT](LPRINT) and [_PRINTIMAGE](_PRINTIMAGE).

## Notes

* These SHELL commands work in Windows XP, 7, 8.1 and 10.

## See Also

* [SHELL](SHELL), [_HIDE](_HIDE)
* [LPRINT](LPRINT)

### External Links

* [http://www.computerhope.com/wmic.htm Windows WMI commands]
* [http://www.cups.org/documentation.php/options.html Linux Printer Commands]
