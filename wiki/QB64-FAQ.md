As with everything else, this list will be updated to detail progress of QB64, so please make sure that you are using the latest version of **QB64**. Please note that it may take a short time to update this list with implemented changes.

**It's recommended that you exclude (whitelist) "qb64.exe" (and the *internal* folder) from any real-time anti-virus scanning to prevent IDE Module Errors.**

## Q: What is QB64?

A: **QB64** is a BASIC-compatible editor and C++ emitter that creates working executable files from QBasic BAS files.  These files can be run on 32- and 64-bit PCs using **Windows** (XP to 10), **Linux** or **macOS**. The goal is to be 100% compatible with QuickBASIC 4.5, while adding hundreds of new capabilities such as program icons, custom-sized windows and a retro-style editor with built-in help. 

**New keywords** add some **new features**, such as playing **music or sound** files and instant access to **32-bit graphics** file images. **TCP/IP** internet communication is also available to **download** files, **email** messages and play **internet games**. Use of **DLL libraries** adds more programming options, and QB64 can incorporate USB game **controllers** and **printers**.

QB is an abbreviation for **QBasic** or **QuickBASIC**, an easy-to-learn programming language very popular in the 90's. QB uses simple syntax but holds great potential - there are methods to achieve nearly anything. 

**QBasic is more alive than ever with QB64!**

[Keywords currently not supported](Keywords-currently-not-supported-by-QB64)

## Q: Does QB64 have modern features? Do they HAVE to be used?

A: QB64 has plenty of modern features, but they do not have to be used. You may just want to run some of your old favorites.
**QB64 was created to run your old QBasic 4.5 (or less) programs on newer operating systems without any changes.**
You may code using the original QuickBASIC syntax all the way through and it should work as you expect it, or even better - QB64 is often faster and has none of the memory limitations that plagued QBasic in the past.

QB64 is not meant to run PDS (7.1) QBX code. Most GW-Basic code will run with minor changes.

The modern statements are designed to go along with the BASIC philosophy and propel QBasic into the future!

**QB64 FEATURES INCLUDE:**

```text

  1) Full graphical functions for [_NEWIMAGE](_NEWIMAGE) up to 32-bit color. [_ALPHA](_ALPHA) transparency supported.

  2) Instant [_LOADIMAGE](_LOADIMAGE) of image files, including BMP, PNG, JPEG, GIF and more.

  3) Supports [_SNDOPEN](_SNDOPEN) files like WAV, OGG and MP3, with speaker and volume control and more.

  4) Animation, using [_DISPLAY](_DISPLAY) instead of page flipping, to achieve flicker-free graphics.

  5) [_CLIPBOARD$](_CLIPBOARD$) reading and writing support.

  6) Networking over TCP/IP and Email.

  7) True type [_FONT](_FONT) and [Unicode](Unicode) support for many languages.

  8) Integrated [_MOUSEINPUT](_MOUSEINPUT) and [_DEVICES](_DEVICES) input including [_MOUSEWHEEL](_MOUSEWHEEL) support.

  9) Support for C++, OpenGL, Windows API and other custom Dynamic Link [Libraries](Libraries).

```

## Q: How do I install QB64 on Windows, Linux, macOS?

A: See below for specific install instructions.

**Windows NT (XP), Windows Vista, Windows 7, 8 and 10:**

> **1)** Download the appropriate package, specific to your OS, from [GitHub](http://github.com/QB64Official/qb64/releases).

> **2)** Unpack the package contents to any location on your computer. Avoid unpacking to Program Files or other system folders that may require administrative privileges, as QB64 requires full write permissions to its own folder.

Executable programs are portable between like systems by copying the executable file.

----

**Most distributions of Linux, both 32- and 64-bit**

> **1)** Download the appropriate package, specific to your OS, from [GitHub](http://github.com/QB64Official/qb64/releases).

> **2)** After extracting the downloaded package, run the installation batch/script titled *./setup_lnx.sh* in the main *qb64* folder to set up QB64.

Note:  Most dependencies should be automatically downloaded by the setup script, but these are the ones you should look for, if compilation fails: OpenGL developement libraries, ALSA development libraries, GNU C++ Compiler (g++)

Executable programs are portable between like systems by copying the executable file.

**Note: Some QB64 keywords and procedures are not available for Linux.**               

----
**macOS**

> **1)** You must install Apple's **Xcode command line tools** for C++ compilation from their website. The simplest way to do so is by opening a terminal window and typing the following command: **xcode-select --install** (more info here: [http://developer.apple.com/technologies/tools/xcode.html Xcode download])
>     (You won't be using the Xcode interface, QB64 just needs to have access to the C++ compiler and libraries it installs.)

> **2)** Download the appropriate package from [GitHub](http://github.com/QB64Official/qb64/releases).
>     Extract the downloaded package and run *./setup_osx.command*, found in the QB64 folder to install the QB64 compiler.

**After installation, you should run **./qb64** or **./qb64_start_osx.command** to start qb64.**

Executable programs are portable between macOS systems by copying the executable file. To help launch executables without a console, a file called *programname_start.command* is created along with the program.

**Note: Some QB64 keywords and procedures are not available for macOS.**

[Keywords currently not supported](Keywords-currently-not-supported-by-QB64)

----

## Q: Why won't QB64 work on my computer?

QB64 currently supports Windows versions from XP to the latest version. Most Linux and macOS versions are also supported.

> **Don't move QB64 executable out of the QB64 folder. The various sub-folders hold the C++ compiler files and libraries.**

> **QB64 does not change any settings on your machine. All required files are in the QB64 folder.**

## Q: Are there any known incompatibilities?

A: There are some things that QB64 cannot do, like direct hardware access, which makes older programs using [CALL ABSOLUTE](CALL-ABSOLUTE), [INTERRUPT](INTERRUPT), [PEEK](PEEK), [POKE](POKE) and [OUT](OUT) unable to work properly. Although some older functionality is emulated, if your program doesn't use these statements, you probably won't notice any difference between QB 4.5 and QB64 (and if you do, report it as a bug in the forums). You can expect the most common addresses for interrupts, etc. to be functioning. 

See: [Keywords currently not supported](Keywords-currently-not-supported-by-QB64)

You should be careful with **CPU usage**. QB64 is a lot faster than QBasic and does not have many of the size limitations that limited QBasic programming abilities. Having said that, **care must be taken to ensure that programs do not hog resources.** To do that, use speed limits when possible to keep the resources used to a minimum. Also, **Monitor Task Manager** while your programs are running to determine which and how system resources are being used in different parts of a program. 

The following keywords can reduce the impact of your programs on those resources by releasing them to other programs:

> [_LIMIT](_LIMIT): Limits the loops per second in any loop and thus lowers the overall CPU usage.

> [_DELAY](_DELAY): Pauses a procedure and releases unused resources for other programs.

> [SLEEP](SLEEP): Stops or delays program procedures and shares resources.

> [INPUT](INPUT) and [INPUT$](INPUT$) stop program procedures until an entry or keypress is provided.

QB64 can be fast when you need it to be, but take the time to consider the impact of your program on other programs, as people seldom have only one program running and the OS has tasks it must do too. 

## Q: How do I update the information in QB64's help system?

A: The help provided in the QB64 IDE Help System fetches the pages from this wiki. Use the **Update current page** in the IDE Help menu selection to update a page. Use the **Update all pages** choice to update them all, but this may take longer. 

## Q: Can I use the same libraries with QB64 that I used with QB 4.5?

A: If the libraries are pure QB 4.5 code then yes, otherwise no. QLB files are not supported but you can easily copy your favorite SUBs or FUNCTIONs to a text BI file and [$INCLUDE]($INCLUDE) them at the end of any program. Include them after all SUB and FUNCTION code in the BAS file.

[DECLARE LIBRARY](DECLARE-LIBRARY) allows users to reference C, Windows, OpenGL and other DLL libraries. If you find some functions that you like, please share them with us at the forum! Our members have found and tested working functions on the following pages list:

[C Libraries](C-Libraries), [DLL Libraries](DLL-Libraries), [Windows Libraries](Windows-Libraries)

## Q: I can't get my QB 4.5 source code to work in QB64! Why?

A: QB64 is 99% compatible with QB4.5 programs. The commands that haven't been implemented are either obsolete or are too obscure and have been replaced by modern functionality. 

See: [Keywords currently not supported](Keywords-currently-not-supported-by-QB64)

## Q: What files are required to run my QB64 compiled program in my OS?

A: Programs compiled by QB64 (version 1.000 and up) are stand-alone, so no external files are required to be included with your program's EXE file. 

## Q: Is there a way to use QB64 from the command line?

A: Yes! Just type QB64 -? at the command prompt to see a list of available options.

* **QB64 -c yourfile.BAS**
* **QB64 -x yourfile.BAS** *(compiles using the console only)*
* **QB64 -c yourfile.BAS -o destination_path\destination executable_name.exe** *(compiles the .BAS file and outputs the executable to a separate folder)*

> The **-z** option does not even create an executable file, it performs the first compile pass only (syntax checking and generate C code).

```text

Usage: qb64 [switches] <file>

Options:
  <file>                  Source file to load
  -c                      Compile instead of edit
  -o <output file>        Write output executable to <output file>
  -x                      Compile instead of edit and output the result to the
                             console
  -w                      Show warnings
  -q                      Quiet mode (does not inhibit warnings or errors)
  -m                      Do not colorize compiler output (monochrome mode)
  -e                      Enable OPTION _EXPLICIT, making variable declaration
                             mandatory (per-compilation; doesn't affect the
                             source file or global settings)
  -s[:switch=true/false]  View/edit compiler settings
  -l:<line number>        Start the IDE at the specified line number
  -p                      Purge all pre-compiled content first
  -z                      Generate C code without compiling to executable

```

## Q: How do I link modules or include SUB procedures in QB64?

A: QB64 allows you to [$INCLUDE]($INCLUDE) code or BAS modules into one module when it is compiled. Text .BI files containing SUB or FUNCTION code or entire BAS modules can be included in one module that will be compiled. 

After the EXE is compiled, you do not have to even use the added code anymore. The EXE will contain ALL of the program code as ONE stand-alone program. This also allows you to add SUB code to any program that you desire. 

See: [$INCLUDE]($INCLUDE)

## Q: Some screens look small. Can I enlarge them or make them fullscreen?

* You can use the [_FULLSCREEN](_FULLSCREEN) statement to make your programs run fullscreen.
* [$RESIZE]($RESIZE) can be added to a program so you can track window resize events.
* You can also create custom-size screens with page flipping and up to 32-bit colors using [_NEWIMAGE](_NEWIMAGE).
* Page flipping is available in most screens and the new [_DISPLAY](_DISPLAY) feature allows the images to be displayed when YOU desire.
* Picture or image files such as BMP, PNG, JPEG and GIF load using [_LOADIMAGE](_LOADIMAGE).
* Once images are loaded, all you have to do is use the image handle with any of the new statements and functions.
* [_PUTIMAGE](_PUTIMAGE) GETs and PUTs images fast in ONE call. It can even stretch or compress the image sizes.

## Q: Can I have background music as well as [SOUND](SOUND), [PLAY](PLAY) and [BEEP](BEEP)?

A: Yes, they are emulated to use the soundcard.

**There are also new sound capabilities that allow the use of WAV, OGG, MP3 files and more.**

Capabilities include:

* Multiple sound tracks
* Volume and speaker control
* Background music

**Get started with [_SNDOPEN](_SNDOPEN):**

> [_SNDCLOSE](_SNDCLOSE) (statement), [_SNDCOPY](_SNDCOPY) (function), [_SNDGETPOS](_SNDGETPOS) (function), [_SNDLEN](_SNDLEN) (function), [_SNDLIMIT](_SNDLIMIT) (statement)

> [_SNDLOOP](_SNDLOOP) (statement), [_SNDOPEN](_SNDOPEN) (function), [_SNDPAUSE](_SNDPAUSE) (statement), [_SNDPAUSED](_SNDPAUSED) (function), [_SNDPLAY](_SNDPLAY) (statement)

> [_SNDPLAYCOPY](_SNDPLAYCOPY) (statement), [_SNDPLAYFILE](_SNDPLAYFILE) (statement), [_SNDPLAYING](_SNDPLAYING) (function), [_SNDSETPOS](_SNDSETPOS) (statement)

> [_SNDRAW](_SNDRAW) (statement), [_SNDSTOP](_SNDSTOP) (statement), [_SNDVOL](_SNDVOL) (statement)

## Q: If QB64 creates BASIC programs why is there no Immediate Window?

A: Because there is no **QB64** interpreter. All C code has to be compiled before it can be run.

**QB64** uses the Immediate window area to suggest syntax for keyword entries and to indicate the compiler status when compiling.

## Q: Does QB64 work on Windows 98 or any OS older than Windows 2000?

A: No, it doesn't. QB64 is made to run on newer operating systems (Windows XP and up, Linux and macOS).

## Q: Does QB64 support CURRENCY values from PDS or VB programs?

A: Not directly, but [_FLOAT](_FLOAT) currency values up to 4 decimal places can be multiplied by 10000(10 ^ 4) and converted to MKC$ string values using [_MK$](_MK$) with an [_INTEGER64](_INTEGER64) value. [_CV](_CV) with an [_INTEGER64](_INTEGER64) value divided by 10000 converts it back to [_FLOAT](_FLOAT) values.

[PUT](PUT) can write a PDS or VB, 8-byte currency string by multiplying the currency amount by 10000 and using an [_INTEGER64](_INTEGER64) variable.

[GET](GET) can read a [_FLOAT](_FLOAT) CURRENCY value as an [INTEGER64](INTEGER64) variable value divided by 10000.

## Q: Do you provide changelogs?

A: We do.  For all recent changelogs, check [QB64.com](https://qb64.com) or [GitHub](https://github.com/QB64Official/qb64/blob/master/CHANGELOG.md).

## Q: Where I can view the C++ code before it gets compiled?

Look in the QB64 **internal\temp** folder for **main.txt** to get the C code used to compile the latest program.
