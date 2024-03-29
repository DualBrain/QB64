[Home](https://qb64.com) • [Forums](https://qb64.boards.net/) • [News](news.md) • [GitHub](https://github.com/QB64Official/qb64) • [Wiki](wiki.md) • [Samples](samples.md) • [InForm](inform.md) • [GX](gx.md) • [QBjs](qbjs.md) • [Community](community.md) • [More...](more.md)

<img src="images/qb64.png" alt="TUI Interface" title="TUI Interface" style="display:block;margin-left:auto;margin-right:auto">

**Our [forums have](https://qb64.boards.net/) returned, check them out [here](https://qb64.boards.net/)!**

## Get QB64

Please select the correct package for your OS.

### Version 2.1

Please download the correct package for your operating system.

| Operating System | Package |
| - | - |
| Windows x64 | [Download](https://github.com/QB64Official/qb64/releases/download/v2.1/qb64_dev_2022-09-08-07-14-00_47f5044_win-x64.7z) |
| Windows x86/32-bit | *See below.* |
| Linux | [Download](https://github.com/QB64Official/qb64/releases/download/v2.1/qb64_dev_2022-09-08-07-14-00_47f5044_lnx.tar.gz) |
| macOS | [Download](https://github.com/QB64Official/qb64/releases/download/v2.1/qb64_dev_2022-09-08-07-14-00_47f5044_osx.tar.gz) |

*Windows x86/32-bit: Due to an error during the build process, the 32-bit build of QB64 v2.1 is not available; however, this issue is confirmed to be fixed with the next release (v2.1.1). We apologize for the inconvenience this may have caused and ask for your understanding as we continue to iron out the finer details related to the overall release process.*

> NOTE: For additional instructions on how to setup/configure, please visit the [source repo](github.md).

## Introduction

**How BASIC made its way into the 21st century**

<img src="images/colorwin10.png" alt="TUI Interface" title="Settings" style="float:right;width:214px;height:144px;padding:6px">

The BASIC language has been the gateway into programming for countless people. Popular as a beginner programming language in the 80’s and evolving into a powerful professional tool in 90’s, BASIC (and its successor QBasic), helped many people develop a love for programming. These languages provided the foundational learning platform for most of today’s professional developers.

<img src="images/dllwin10.png" alt="TUI Interface" title="In this sample code, internal keywords are colored blue, metacommands and user procedures in green and strings in orange. Notice the DECLARE LIBRARY block used to access Windows' API." style="float:left;width:214px;height:144px;padding:6px">

The QB64 project has evolved over the last decade to bring the magic and educational potential of BASIC from its 20th century roots into the modern era. The QB64 project is already in use in both educational and professional contexts and has an active and helpful user community.

Unlike traditional BASIC and QBasic code, QB64 gets compiled automatically into machine code – allowing exceptional performance, easy distribution, and the ability to link with external C and C++ programming libaries. Compatible with most QBasic 4.5 code, QB64 adds a number of extensions, such as OpenGL and other modern features, providing the perfect blend of classic and modern program development.

QB64 is available for all recent Windows, Linux, and macOS versions.

## Who created QB64?

For some of the early history of QB64, check out [these interviews](galleon.md).

## Additional/Complementary Tools

There are several people in the community with projects that serve to compliment QB64; extending the reach and capability of the QB64 developer.

- [InForm](inform.md): Rapid Application Development (GUI) for QB64.
- [GX](gx.md): A game engine for QB64 that also allows you to extend your reach to the web.
- [QBjs](qbjs.md): An implementation of the BASIC programming language for the web, with multimedia support and easy sharing of programs that aims compatibility with QBasic, QB4.5 and QB64.
- [QB64 Interpreter](https://github.com/FellippeHeitor/QB64-interpreter): Run QB64 commands on the fly or load a file and run it, no compilation required - written in QB64.
- [L-BASIC](https://github.com/flukiluke/L-BASIC): The L-BASIC compiler and interpreter implemented in QB64.  There is also this [forum thread](https://qb64forum.alephc.xyz/index.php?topic=2778.0) for some interesting background on the project.
- [Roslyn](https://github.com/dotnet/roslyn): Open-source MIT-licensed implementation of latest direct *"commercial"* decendant of QBasic/QB4.5 that targets the [.NET](https://dotnet.microsoft.com/) platform.
- [PC-BASIC](https://robhagemans.github.io/pcbasic/): Free, cross-platform emulator for the GW-BASIC family of interpreters.

### What is InForm?

![InForm1](images/inform_designer_v1_3.png)

[InForm](inform.md) is a Rapid Application Development tool for QB64. It consists of a library of graphical routines and a WYSIWYG editor that allows you to design forms and export the resulting code to generate an event-driven QB64 program.

Want to build graphical UI applications across Windows, Linux and/or Mac? Check out [InForm](inform.md)!

### What is GX?

[GX](gx.md) is a basic game engine... literally. This is a Game(G) Engine(X) built with and for QB64, a QBasic/QuickBASIC IDE and compiler with modern extensions. [GX](gx.md) supports basic 2D gaming: platformer, top-down, etc.; you know, classic NES/SNES type games.

Interested in extending your QB64 reach to the web?  Check out [GX](gx.md).

### What is QBjs?

[![QBjs](images/qbjs.png)](https://qbjs.org)

[QBjs](qbjs.md) can be considered a sort of *sister* project of QB64. It is heavily inspired by folks that have a huge appreciation for QB64 and the main developer that is working on this is "simply" continuing forward on a project that originally grew out of a pet project of his for QB64. This (previous) project, written in QB64, allows you to write your code in QB64 and then "convert" it to Javascript. The [QBjs](qbjs.md) project is taking this further by providing the necessary tools to write your code in the browser directly.

Interested in playing with QBasic/QB64 in the browser?  Check out [QBjs](qbjs.md).

### What is QB64 Interpreter?

Run QB64 commands on the fly or load a file and run it, no compilation required. Written in QB64!  Check it out at [QB64 Interpreter](https://github.com/FellippeHeitor/QB64-interpreter).

### What is L-BASIC?

[L-BASIC](https://github.com/flukiluke/L-BASIC) is a new BASIC language and compiler; a language variant that is reasonably close to QB64. However, it doesn't attempt to be 100% compatibile; willing to break compatibility with programs from 1985 when needed.  What makes this project interesting is that not only is it written in QB64, but it serves to explore ideas that "could be". This isn't to suggest that what [L-BASIC](https://github.com/flukiluke/L-BASIC) is doing will make it's way into QB64, but it does serve as an interesting thought experiment and visible example of what you could do if you desired to start with QB64 and "make it your own".  Check it out at [L-BASIC](https://github.com/flukiluke/L-BASIC).

### What is Roslyn?

Although a bit controversial to include this on this list, [Roslyn](https://github.com/dotnet/roslyn) notably includes self-hosting versions of the Visual Basic for [.NET](https://dotnet.microsoft.com/) compiler – a compiler written in the language itself. The compiler is available via the traditional command-line programs but also as APIs available natively from within [.NET](https://dotnet.microsoft.com/) code. [Roslyn](https://github.com/dotnet/roslyn) exposes modules for syntactic (lexical) analysis of code, semantic analysis, dynamic compilation to CIL, and code emission. This project was started in 2010, made open source in 2014 (Apache License 2.0) and released first version in Visual Studio 2015. At some point the license was transitioned to use the same license as [.NET](https://dotnet.microsoft.com/) (MIT-licensed). You can either work with this directly from command-line tools via [.NET](https://dotnet.microsoft.com/) or by installing the *Community Edition* (Free) of [Visual Studio](https://visualstudio.microsoft.com/). It is included in this list as a lot of the skills / foundation gained by working in QB64 can easily applied to VB and the scope of what can be done with [.NET](https://dotnet.microsoft.com/) is pretty impressive.

### What is PC-BASIC?

[PC-BASIC](https://robhagemans.github.io/pcbasic/): Free, cross-platform emulator for the GW-BASIC family of interpreters that allows you to run classic games and legacy BASIC applications designed for MS-DOS systems, IBM PC, PCjr or Tandy 1000. [PC-BASIC](https://robhagemans.github.io/pcbasic/) aims for "bug-for-bug compatibility with Microsoft GW-BASIC". In other words, it has a very similar mission to QB64, but instead of QBasic and/or QB4.5 compatibility [PC-BASIC](https://robhagemans.github.io/pcbasic/) is focused on the BASIC that was prior to QBasic/QB4.5 ([GW-BASIC](https://gw-basic.com/)) and is an excellent alternative/replacement to [GW-BASIC](https://gw-basic.com/) on modern platforms. Because of this, it might be able to execute *line-number* BASIC programs that aren't compatible with QBasic, QB4.5 and QB64.

## FAQ

### What about the qb64.net website/domain?

Please make note that the .net domain for QB64 is highly suspect. Apparently the story goes that someone forgot to renew the domain name and it was snipped by a questionable party that subsequently mirrored the previous websites information and spammed it with dubious advertising. At this point it has nothing to do with QB64 and, ultimately, should be completely avoided given that the content could contain suspect binaries potentially containing malware. Additionally, it's been stated in the community has potentially having malware as part of the site - potentially infecting your machine by simply browsing to it. So, in the end, if you do venture there be sure to exercise caution.
