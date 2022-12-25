```text

                        **Comparing the Base Numbering Systems**

     **Decimal (base 10)    Binary (base 2)    Hexadecimal (base 16)    Octal (base 8)**

          0                  0000                  0                     0
          1                  0001                  1                     1
          2                  0010                  2                     2
          3                  0011                  3                     3
          4                  0100                  4                     4
          5                  0101                  5                     5
          6                  0110                  6                     6
          7                  0111                  7                     7 -- maxed
          8                  1000                  8                    10
  maxed-- 9                  1001                  9                    11
         10                  1010                  A                    12
         11                  1011                  B                    13
         12                  1100                  C                    14
         13                  1101                  D                    15
         14                  1110                  E                    16
         15  -------------   1111 <--- Match --->  F  ----------------  17 -- max 2
         16                 10000                 10                    20
        
      When the Decimal value is 15, the other 2 base systems are all maxed out!
      The Binary values can be compared to all of the HEX value digit values so
      it is possible to convert between the two quite easily. To convert a HEX
      value to Binary just add the 4 binary digits for each HEX digit place so:

                        F      A      C      E 
              &HFACE = 1111 + 1010 + 1100 + 1101 = &B1111101011001101

      To convert a Binary value to HEX you just need to divide the number into
      sections of four digits starting from the right(LSB) end. If one has less
      than 4 digits on the left end you could add the leading zeros like below:
 
             &B101011100010001001 = 0010 1011 1000 1000 1001  
                       hexadecimal =  2  + B  + 8 +  8  + 9 = &H2B889 

    See the Decimal to Binary conversion function that uses **[HEX$](HEX$)** on the **[&H](&H)** page.

```

## See Also

* [HEX$](HEX$), [OCT$](OCT$), [VAL](VAL)
* [&H](&H) (hexadecimal), [&O](&O) (octal), [&B](&B) (binary)   
