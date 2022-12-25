[INP](INP) and [OUT](OUT) are often used to access port registers, but in QB64 this capability is limited so here are some DLL Libraries:

## InpOut32 (x64)

> The following download links have the DLL and sample BAS file to show how it works with an LPT (parallel) port at &H378(888):

[Phillip Gibbons' InpOut32 (x64)](https://www.highrez.co.uk/downloads/inpout32/default.htm)

If you intend to utilize InpOut32 You can find more information regarding InpOut32, be sure to check out the [InpOut32 (x64) @ Highrez Forums](https://forums.highrez.co.uk/viewforum.php?f=7&sid=190f94db1f44e85c26bf6ceef6081dbf)

There is also an attempt at continuing the InpOut32 (x64) project located at [InpOutNG (github.com)](https://github.com/Feo-d-oR/InpOutNG)

Note: QB64 requires all DLL files to either be with the program or in the `C:\WINDOWS\SYSTEM32` or WOW folder!

At one point there was a sample made available via *dropbox* demonstrating the InpOut32 (x64) libraries with QB64 - but that link has disappeared/expired and the sample is now lost to history.

~~[Download InpOut32.DLL and example program](http://dl.dropbox.com/u/8440706/inpout32.zip)~~

## LPT Ports

**Parallel Ports do Not Require an External LPT Device Connection to Function.**

> Reading the Parallel Port Data, Status and Control register settings before and after reversing it.

```vb

DECLARE DYNAMIC LIBRARY "inpout32"
    FUNCTION Inp32% (BYVAL PortAddress AS INTEGER)
    SUB Out32 (BYVAL PortAddress AS INTEGER, BYVAL Value AS INTEGER)
END DECLARE

baseadd = 888 'base address for most LPT printers is &H378

LPTport (baseadd)
_DELAY 2

Out32 baseadd + 2, 32 'set control bit 6(C5) high to reverse port to read incoming data
_DELAY 2 'sets Data port to 0. may not work on all parallel ports
LPTport (baseadd)

_DELAY 2

Out32 baseadd + 2, 12 'control port is normally set to 12
Out32 baseadd, 227 'any ASCII code value from 0 to 255. Code 227 prints p character

LPTport (baseadd)

SUB LPTport (address)
basedata% = Inp32(address)
PRINT "Data:"; basedata%; CHR$(basedata%) 'read or write
PRINT "Status:"; Inp32(address + 1) 'base + 1 read only status from device!
PRINT "Control:"; Inp32(address + 2) 'base + 2 read or write. 32 or over reverses port
PRINT
END SUB 

```

```text

Data: 255
Status: 120
Control: 12

Data: 0
Status: 120
Control: 32

Data: 227 π
Status: 120
Control: 12

```

## Parallel Port Registers

*Note:* The normal LPT1 base port is **&H378**(888), but it could also be **&H278**(632) or **&H3BC**(956).

```text

              __________________________________________________________   
              \                                                        /
               \  13  12  11  10   9   8   7   6   5   4   3   2   1  /
                \ S4  S5  S7  S6  D7  D6  D5  D4  D3  D2  D1  D0  C0 /
                 \  25  24  23  22  21  20  19  18  17  16  15  14  /
                  \ G7  G6  G5  G4  G3  G2  G1  G0  C3  C2  S3  C1 /
                   \______________________________________________/
 
                                    DB-25 Female
             10 Ack, 11 Busy, 12 PaperOut, 13 Select, 14 LFeed, 15 Error

```

[Parallel Port Pinout](https://www.google.com/search?q=LPT+pinout&biw=1209&bih=569&tbm=isch&imgil=NfwoAN_aS0iIbM:;_8oZPMerY-hDtM;http://www.firewall.cx/networking-topics/cabling-utp-fibre/120-network-parallel-cable.html&source=iu&pf=m&fir=NfwoAN_aS0iIbM:,_8oZPMerY-hDtM,_&usg=__9NooKAtd0Kyj3aYOxNGvzhfYryk=&ved=0ahUKEwjYjY6JyrPLAhXMdT4KHfhNBo4QyjcIJw&ei=eRPgVpjtCczr-QH4m5nwCA#imgrc=xZhuzmkJ7DEvbM:)

> **DO NOT RUN HIGH CURRENT DEVICES with the 5 volt DC output! Use [opto-isolators!](http://en.wikipedia.org/wiki/Opto-isolator) with a separate power supply. Use appropriate grounding between devices with the 8 ground pins(green in Pinout diagram) provided!**

### Data Register (BaseAddress)

**Read or Write** in normal operation.  D0 to D7 data byte values from 0 to 255 can be converted to [ASCII](ASCII) characters in a device. Setting the byte value can turn certain pins on or off to control switching devices. **Read only** to read input in reverse mode set by C5 bit on.

> **Software control in normal output mode. Data pin voltages can be set to 0 or 5 volts DC in Reverse mode only!**

Pin [_BIT](_BIT) values on: **D0**(+ 1), **D1**(+ 2), **D2**(+ 4), **D3**(+ 8), **D4**(+ 16), **D5**(+ 32), **D6**(+ 64), **D7**(+ 128)

**Note:** The Data port will be in normal output mode and set to 255 with all pins on at startup or reboot!
Reverse read only mode may set all byte values to 0 or 255 if all pins are held high by the port for pull down input.

### Status Register (BaseAddress + 1)

**Read only!** Register normally used to **monitor the status of a printer or other device that is connected to the parallel port**. Pins S3 to S6 are held high by resistors so that it will read 120(or 127) when nothing is connected to the pins. A device can manipulate the read only status port value by grounding certain pins. When 5 volts is fed to a pin, bit will stay on. S7 is inverted so that it adds 128 to the port value when it is grounded. Otherwise S7 is 0 by default. S0, the timeout bit, can be reset off by software when set by EPP mode. Bits S1 and S2 are not used. **If the port reads 255 the parallel port is not installed.**

Pin voltages can be set to 0 or 5 volts DC by chip devices or grounding switches to turn bits 3 to 6 off or bit 7 on.

* **S0** Low can be set in EPP mode timeout only(normally off). **INP32**(889) [AND](AND) 1 = 1 when bit is on **(no pin)**
* **S3** Low for error, off-line or paper end(normally on). **INP32**(889) [AND](AND) 8 = 8 when bit is on, pin is high
* **S4** High for printer selected(normally on). **INP32**(889) [AND](AND) 16 = 16 when bit is on, pin is high
* **S5** High for out of paper(normally on). **INP32**(889) [AND](AND) 32 = 32 when bit is on, pin is high
* **S6** Low for Acknowledge(normally on). **INP32**(889) [AND](AND) 64 = 64 when bit is on, pin is high
* **S7** High for busy, off-line, error.(normally off) **INP32**(889) [AND](AND) 128 = 128 when bit is on, pin is pulled low

Bit S0 has no pin and can be set at a timeout or reset to 0 by software in EPP mode only.

Pin S7 is inverted so that a low pin signal turns the bit on.

4 bit binary data can be read using pins S3 to S6. The port byte value can be divided by 8 to get the decimal values 0 to 15.

### Control Register (BaseAddress + 2)

**Read or Write.** Register is used to send messages to a printer or other device that is connected to the port. Usually the port sets itself to read 12(C2 and C3 on) after about 30 seconds. The C0, C1, and C3 pins are inverted while C2 is not. Inverted pins are set on when a bit is set low(off). C4 and C5 have no pins, but can be set internally by a program. Setting C4(16) can turn off the IRQ interrupt. When C5 is on(32) the Data port is reversed to read data sent from a device.

> **WARNING! Software or port hardware controls the port. Do NOT attempt to change pin voltages!**

* **C0** Low(bit on) pulse strobe data sent.(normally off) **OUT32** 890, **INP32**(890) [OR](OR) 1 turns bit on, pin low
* **C1** Low(bit on) linefeed or auto feed.(normally off) **OUT32** 890, **INP32**(890) [OR](OR) 2 turns bit on, pin low
* **C2** Low(bit off) pulse Initiate.(normally on) **OUT32** 890, **INP32**(890) [OR](OR) 4 turns bit on, pin high
* **C3** Low(bit on) printer select in.(normally on) **OUT32** 890, **INP32**(890) [OR](OR) 8 turns bit on, pin low
* **C4** High(bit on) IRQ interrupt off(normally off). **OUT32** 890, **INP32**(890) [OR](OR) 16 turns bit on **(no pin)**
* **C5** High(bit on) reverse data port for input read only(normally off). **OUT32** 890, **INP32**(890) [OR](OR) 32 turns bit on **(no pin)**

Red pin numbers are inverted so that bits on set corresponding output pins low and bits off set pins high. 

Bits C4 and C5 designate internal(no pin) software enabled control port register bits

Use OUT32 with [OR](OR) to turn a bit on or [XOR](XOR) to change the current bit status. INP32 with [AND](AND) can determine if a bit is on or off(0).

## COM Ports

**Serial Communication Ports Require an External Serial Device or PC COM Port Connection to function!**

A 3 wire Teletype program that allows two computers to serially communicate through each keyboard:

```vb

DECLARE DYNAMIC LIBRARY "inpout32"
  FUNCTION Inp32% (BYVAL PortAddress AS INTEGER)
  SUB Out32 (BYVAL PortAddress AS INTEGER, BYVAL Value AS INTEGER)
END DECLARE

Baseadd% = &H3F8 'any valid COM port address (see the Windows Hardware COM port Properties)
Out32 Baseadd% + 3, &H80 'set Divisor Latch Access Bit using 128 Hex (LCR)
  'Out32 Baseadd%, &H60 '  1200 baud    96   Write DL Low Byte
  'Out32 Baseadd%, &H30 '  2400         48
  'Out32 Baseadd%, &H18 '  4800         24
Out32 Baseadd%, &HC '      9600         12  Maximum baud rate in QB!
Out32 Baseadd% + 1, &H0   'Write DL High Byte 
  'Set Base and IER back to normal registers, and set Data requirements
Out32 Baseadd% + 3, &H3 'set 8 bit word(bit0 + bit1=3), 1 Stop Bit(0ff), No Parity(0ff)
  'COM should now be set as N, 8, 1 by the LCR. Like an OPEN statement.
Out32 Baseadd% + 2, &H3   'Flush receiver FIFO buffer, enable FIFO (FCR)
DO: x$ = INKEY$
  IF x$ = CHR$(27) THEN EXIT DO          'Escape key quits
  IF x$ > "" THEN Out32 Baseadd%, ASC(x$)     'Write Transmit buffer data
  IF (Inp32(Baseadd% + 5) AND 1) THEN         'Data ready = 1 (LSR)
    PRINT CHR$(Inp32(Baseadd%));              'Display Receive buffer data"
  END IF                                  
LOOP 

```

Possible port addresses are &H3F8(1016) = COM1, &H2F8(760) = COM2, &H3E8(1000) = COM3 and &H2E8(744) = COM 4.

Connect each COM port transmit line to the opposing receive line on the other PC. Connect both COM grounds together.

**Serial Communication Ports Require an External Serial Device or PC COM Port Connection to function!**

## Serial Communication Registers

Two PC's can communicate between the COM ports using a [Null modem cable](http://www.lammertbies.nl/comm/info/RS-232_null_modem.html).

```text

                            _______________________________
                            \                             /
                             \   5    4    3    2    1   /
                              \ GND  DTR  TXD  RXD  DCD / 
                               \   9    8    7    6    /
                                \ RI   CTS  RTS  DSR  /
                                 \___________________/ 

                                  RS-232 Female (DB-9)

```

[Serial Communication Port Pinouts](https://www.google.com/search?q=com+port+pinout&hl=en&prmd=imvns&tbm=isch&tbo=u&source=univ&sa=X&ei=6OivT5arEcjq0gG87riHDA&sqi=2&ved=0CHwQsAQ&biw=970&bih=610)

DCD = Data Carrier Detect, RXD = Receive Data, TXD = Transmit Data, DTR = Data Terminal Ready, GND = Signal Ground

DSR = Data Set Ready, RTS = Request to Send, CTS = Clear to Send, RI = Ring Indicator

**Serial Communication Ports Require an External Serial Device or PC COM Port Connection to function!**

A Serial port can use extra Registers due to the use of a UART chip. When the Base Address is Read, the chip supplies the data from the FIFO(First In First Out) Receive Buffer. When Written to, it sends data to the FIFO Transmit Buffer. If the DLA Bit is On in the LCR register, then the UART base register accepts the Divisor Latch Low Byte data.

```text

         **Address       DLAB   INP/OUT      Abb.     Register Name**

	 Base + 0      Off     Write        -     Transmitter Hold Buffer
	               Off     Read         -     Receiver Buffer
		       On    Read/Write     -     Divisor Latch Low Byte
	 Base + 1      Off   Read/Write    IER    Interrupt Enable Register
		       On    Read/Write     -     Divisor Latch High Byte
	 Base + 2      --    Read Only     IIR    Interrupt ID Register
		       --    Write Only    FCR    FIFO Control Register
	 Base + 3      *Set*   Read/Write    LCR    Line Control Register(*DLAB On/Off*)
	 Base + 4      --    Read/Write    MCR    Modem Control Register
	 Base + 5      --    Read Only     LSR    Line Status Register
	 Base + 6      --    Read Only     MSR    Modem Status Register"
	 Base + 7      --    Read/Write     -     Scratch Register (Unused)"

```

Also there are two Base + 1 Registers. The IER and the DL High Byte. The two Base + 2 Registers (IIR & FCR) act similar to the Base Buffers. The UART chips also use FIFO buffers to receive and send data at the same time. The most common UARTS used today are the 16550 series chips. You can add the bit values to determine the bits you want Written or Read in each register!

### The COM Data Register (BaseAddress)

Like the bi-directional Parallel port, the COM Base Address can send data to a device and also can receive data at the same time. It accomplishes this by using two FIFO (First In First Out) buffers. To send Data you can use [PRINT (file statement)](PRINT-(file-statement)) or [OUT](OUT) a value to the Base Address. To read data you can use [INP](INP)(base address) or use [OPEN COM](OPEN-COM) with [INPUT$](INPUT$) (bytes, [OPEN COM](OPEN-COM)) while [LOC](LOC)([OPEN COM](OPEN-COM)) checks for data in the receive buffer. The Base can also set the **Divisor Latch Low Byte**, which can also help set the baud rate of the port.

### Interrupt Enable Register (BaseAddress + 1)

This register is fairly simple to use. The only bits used are 0 to 3. You simply set a bit high to enable the appropriate Interrupt.

```text

            **Bit #      Bit Value         Interrupt Description**
	       3           8         Enable Modem Status Interrupt
	       2           4         Enable Receiver Line Status Interrupt
	       1           2         Enable Transmit Hold Register Empty Interrupt
	       0           1         Enable Received Data Available Interrupt

```

Once the Interrupts are set, you can monitor the port Interrupts in the Read only **IIR** Interrupt Identification Register in a COM program routine. You just add the bit on values to use more than one Interrupt Enable and use OUT BaseAdd + 1, bitstotal. The IIR will tell if an Interrupt occurs! The IER register also can be read to find the present settings with INP. Like the Base, the IER is used in DLAB Mode for the Divisor High Byte."

### Interrupt Identification Register (BaseAddress + 2)

This register is a **Read Only** Register! It monitors the FIFO status and Interrupts sent to the CPU. The Interrupts are enabled in the IER. You can use INP to read it using INP(BaseAddress + 2) AND 2 ^ bitnumber to see if a bit is on or off. The FIFO and Interrupt Status read 2 bits as below:

```text

               **Bit #          INP Value       Description** 
	      7 and 6                     FIFO status
	      1     1           192         FIFO Enabled
	      0     1            64         FIFO Enabled but Unusable  
	      0     0          < 64         No FIFO Available 
	         5               32       64 Byte Fifo Enabled (16750 UART)
	         4                0       Reserved (not used)
	         3                0       Reserved on 8250 and 16450 UART's
	                          8       16550 UART(or higher) Time-out Pending
	      2 and 1                     Interrupt Status (Bit value Priority)
	      1     1             6         Receiver Line Status Interrupt (Highest)
	      1     0             4         Received Data Available Interrupt
	      0     1             2         Transmitter Hold Register Empty Inter.
              0     0             0         Modem Status Interrupt (Lowest)
	         0                1       1 = No Interrupt Pending. 0 = Interrupt Pending
	
                      < denotes a byte value less than designated INP value

```

For FIFO status, just compare the INP status with 192 using AND as below:

IF (Inp32(BaseAdd% + 2) AND 192) THEN PRINT "FIFO Enabled"

### First In / First Out Control Register (BaseAddress + 2)

This Register also uses the BaseAddress + 2 address, but it is **Write Only**! You can NOT try to Read it! That just returns data from the **IIR** Register ONLY! The **FCR** register is just used to set Interrupt triggers and clear the data from the Recieve or Transmit buffers of 16550 or higher UARTS.

```text

	       **Bit #            OUT Value     Description **
	      7 and 6                       Interrupt Trigger Level  
	      1     1             192         14 Byte Trigger 
	      1     0             128         8 Byte Trigger 
              0     1              64         4 Byte Trigger  
	      0     0            < 64         1 Byte Trigger
	         5                 32       Enable 64 Byte FIFO (16750 UART only)
                 4                  0       Reserved (not used) 
	         3                  8       DMA Mode Select (mode 1 or 2)
	         2                  4       Clear Transmit FIFO 
	         1                  2       Clear Receive FIFO 
	         0                  1       Enable FIFO's. 0 = Disabled FIFO"
			    
                     < denotes a byte value less than designated OUT value

```

If the trigger bytes are found in the FIFO buffer, then the Data Receive Available Interrupt in the IIR will trigger. Bits 1 and 2 clear the buffer when set hi. They will automatically reset to 0 when done. Data is lost when cleared or if bit 0 is set to 0. Be aware of this and use carefully! This register is only normally used to clear the buffers and enable them. The 0 bit must be set to 1 or both FIFO buffers are disabled! Reset it!

### Line Control Register (BaseAddress + 3)

This Register can determine the Word Length, Stop Bits, Parity and help set the Baud Rate of the Serial Port. For instance, OUT (BaseAddress + 3), 3 will set the Word Length to 8 with 1 Stop Bit and No Parity. Similar to OPEN COM, but you can also open COM ports other than COM1 or COM2 in this register. **Be sure to Write a Register value less than 128 after the DLAB baud is set!**

```text

                **Bit #         Bit Value      Description**
	         7              128        Divisor Latch Access Bit (set baud rate)
	                      < 128        Access Receive & Transmit buffers & IER
	         6                0        Set Break Enable. 64 = Break in Receiver TD"
	      5, 4, 3                      Parity Select 
              X  X  0             0          No Parity (bit 3 off only)"
	      0  0  1             8          Odd Parity  
	      0  1  1            24          Even Parity  
	      1  0  1            40          High Parity (Sticky) 
	      1  1  1            56          Low Parity (Sticky) 
	         2                0        One Stop Bit (normal)
	                          4        2 Stop bits(wordlength 6,7,8) or 1.5 (5)"
	      1 and 0                      Set Word Length 
	      1     1             3          8 Bit Word (normal)
	      1     0             2          7 Bit Word  
	      0     1             1          6 Bit Word
	      0     0             0          5 Bit Word  

                     < denotes a byte value less than designated OUT value

```

### The Divisor Latch Access Bit and Setting the Baud Rate

You can set the Baud Rate first by sending 128 to the LCR with OUT. This forces the **Base** and **IER** Registers to accept the Divisor Latch Low and High Byte values respectively. In DLAB mode both registers can be written to or read to find the current Divisor byte settings! The Divisor value is the number that 115200 must be divided by to attain the baud rate:

```text

        **Speed (BPS)      Divisor    High Byte(to Base + 1)  Low Byte(to Base)**
	       50         2304             &H9  (2304)            &H0    (0) 
	      300          384             &H1  (256)             &H80   (128)
              600          192             &H0                    &HC0   (192) 
	     1200           96             &H0                    &H60   (96) 
	     2400           48             &H0                    &H30   (48)
	     4800           24             &H0                    &H18   (24)
	     9600           12             &H0                    &HC    (12)
	    19200            6             &H0                    &H6    (6)
	   115200            1             &H0                    &H1    (1)

```

The divisor is based on 115,200 as the maximum Baud Rate. Speeds above 300 just send 0 to the IER, but it must be sent too! Below is a routine to set up any COM port without an OPEN statement. Simply use OUT to set it up:

```text

        BaseAdd% = &H3F8         'use any valid COM base address on your PC
	Out32 BaseAdd% + 3, &H80 'set DLAB baud rate divisor bit 7 on with 128 (LCR)
	Out32 BaseAdd% + 1, &H0  'set DL High Byte on IE Register
	Out32 BaseAdd%, &H60     'set DL Low Byte to 1200 baud (96) on Base Register
	Out32 BaseAdd% + 3, &H3  'sets 8 bit Word, 1 Stop Bit, and No Parity (LCR) *	 

```

> *Explanation:* Setting the LCR register's value below 128 resets it from DLAB mode to normal Base Buffer and **IER** operations

### Modem Control Register (BaseAddress + 4)

Like the LCR Register, it is Read and Write! Bit 4 sets Loopback Mode that sends TD data back to RD buffer. Bits 1 and 0 force RTS and DTR signals. The Auxiliary Outputs are seldom used anymore! Just set those bits to 0.

```text

             **Bit #         Bit Value         Description**
	       4              16          LoopBack Mode (Test UART operation)
	       3               8          Aux Output 2(control by other circuitry)
	       2               4          Aux Output 1(MIDI, normally disconnected)
	       1               2          Force Request to Send (RTS) 
	       0               1          Force Data Terminal Ready (DTR)

```

### Line Status Register (BaseAddress + 5)

**Read Only** status register used to detect data buffer activity and errors. If ANY data error occurs, bit 7 will be turned on. Specific errors are also listed. Normally only Bit 0 is read, as these errors do not stop the port! Use this register to check for transfer errors.

```text

             **Bit #         INP Value         Description**
               7              128         Error in Received FIFO 
	       6               64         Empty Data Hold Registers(TD and RD Idle)
	       5               32         Empty Transmitter Hold Register(TD empty)
	       4               16         Break Interrupt (RD Word Time Out)
	       3                8         Framing Error (last bit not a Stop Bit)
	       2                4         Parity Error
	       1                2         Overrun Error (cannot read fast enough)
	       0                1         Data Ready (Receiver ready to be read)

```

### Modem Status Register (BaseAddress + 6)

This **Read Only** register monitors each bit each time read. Delta type bits denote any changes since the last time read. Bit 2 On indicates that there was a change from low to high on the RI line since the last read. Often used in modem data transfers!

```text

              **Bit #         INP Value         Description**
                7              128         Carrier Detect (CD) 
                6               64         Ring Indicator (RI) 
                5               32         Data Set Ready (DSR)
                4               16         Clear To Send (CTS) 
                3                8         Delta Data Carrier Detect 
                2                4         Trailing Edge Ring Indicator 
                1                2         Delta Data Set Ready 
                0                1         Delta Clear to Send 

```

### The Scratch Register (BaseAddress + 7)

This unused register can be Read and Written to. You can use it to hold data for later use. It can also be used to test for a valid COM port with a device or loopback plug on it. To test a port, Read this register and try to change it. Then Read it again. If the second reading has changed, then the COM port is accessible and ready to use with a device. Normally a Scratch Register will always read 255 if there is no device connected! **COM port registers will not work if the port is not connected to a serial device!**

## See Also

* [DECLARE DYNAMIC LIBRARY](DECLARE-DYNAMIC-LIBRARY)
* [INP](INP), [OUT](OUT)
* [Windows Libraries](Windows-Libraries)
