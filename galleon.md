[Home](https://qb64.com) • [News](news.md) • [GitHub](github.md) • [Discord](discord.md) • [Forum](forum.md) • [Wiki](wiki.md) • [Podcast](podcast.md) • [YouTube](youtube.md) • [Rolodex](rolodex.md) • [More...](more.md)

## Interview with Rob Galleon (May 26th 2008)
-- *by E.K.Virtanen*

I'm not sure how many of you have heard of Rob (Galleon is his nickname). But you might know of some of his projects, the current project is called QB64 and aims to present programmers with a QB clone language that is capable of running in all modern Operating Systems (Such as Windows XP, Vista and Linux). This project can be followed in this sub forum on The QBasic Forum Community. Here I interviewed Galleon to present this individual to you and let him talk about himself. As the old saying goes, you can only get the truth about someone by asking that person the questions, which is what I did, right here.

> Let’s start with the "stats". Who, what and where?

**What?**

QB64 is a programming language designed "from the ground up" to be 100% compatible with QB4.5/QBASIC. It will also extend upon this compatibility to support: 

- Using all available memory
- External libraries
- New data types (64 bit integers, etc.)
- Pointers
- Better graphics (.bmp, .jpg, etc. and 3D via OPENGL)
- Better audio (wav, midi, mp3, etc.)
- Better input methods (mouse, joypads, web-cams, etc.)
- Networking (TCP/IP, etc.)
- Unicode support
- and more!

The QB64 compiler converts BASIC code into C++ code, and then uses a third-party C++ compiler (GCC) to compile the C++ code into an executable file. C is an "enduring", processor independent language and ensures QB64 will be compatible with most OSs for many years to come. The actual compiler is written in BASIC! So QB64 compiles itself (self-compiles), also ensuring future compatibility.

**Who?**

I, Rob (aka. Galleon), from Sydney Australia am developing QB64 independently atm, however I am lucky to have the support/help of the QBASIC community who report problems and provide guidance/ideas. Later this year QB64 will become fully open source (atm only the inbuilt C++ code/functions are, not the compiler itself) after I have included user defined types and other critical essentials.

**Why?**

- Running QBASIC programs is becoming increasingly difficult on modern OSs. DOSBOX is fantastic; however it runs programs slowly and provides little/no possibility of extending/upgrading programs to take advantage of modern systems.
- The preservation of the QB language and its many many programs.
- More speed.
- Portability. QB programs are not easy to run on Linux or Mac/OS X. QB64 uses multi-platform C libraries which make this easy.

> Uh! You just answered in to my next 5 questions at once :) World is full of BASIC dialects what can do same than you just told. Some of them are very close of QB syntax. When you are working with QB64, do you feel like you are doing the job for hardcore QB fans or/and possibly extending life of this legendary compiler?

QB64 is about the past, present and future of QBASIC. It is designed to run all existing programs, provide avenues for QB fans to distribute their work and provides a range of new, easy to use high level commands for use with modern technology. It's not just for hardcore QB coders, it's also for those who find a QBASIC program on the net and want to run it without any hassles. One important goal of QB64 is to run all QBASIC programs without any modifications required to the original code.

> There is a bunch of QB'rs waiting for this software to get finished. You ever feel that pressures are too high?

Pressure? I don't really think of it as pressure, probably because I'm just as excited about getting QB64 to each new milestone as everybody else. I think progress is important, but sometimes perceived progress and actual progress can differ, and when that's the case I try to throw in a few "fun" things. I also think cutting corners is extremely dangerous when developing a programming language; ultimately they lead to having to recode lots of things again. Being only human, other priorities pop up from time to time, but I am very passionate about this project. After the QB64 compiler's source is released later this year my role in QB64's development will undoubtedly change significantly.

> Have you ever thought a future, life after releasing QB64 as open source? Is there motivation to program smaller projects (such as games) or is developing QB64 all and everything?

I doubt my work and input into QB64 will ever be finished, though as years go on the intensity of that work will slow down. I've already got plans to port a (C++) MMORPG I wrote into QB64 to make it more manageable, but this is dependent on the implementation of many advanced features in QB64 first. As for QB64 being all and everything for me, it certainly feels like that at the moment.

> I have received three questions from a third person for you. I’ll paste them here.

*Does he already have a plan made for an IDE for QB64 or is he open to suggestions? Does he have requirements IE does it have to be made in qb64 (It would be interesting if it was, but is it a prerequisite) :-).*

I will be developing an IDE for QB64. Essentially, it will be 2 modules which can optionally be built with the compiler itself. The first module will control how the IDE looks and the interface, the second module will be used to communicate between the "interface" module and the compiler itself. The benefits of doing things this way is a) As the compiler advances, the IDE need not be continuously updated to recognize new features. b) The IDE and the compiler can interact throughout all stages of compilation (including pre-compilation & syntax checking). c) Multiple IDE "interfaces" can easily be made (I intend to write a "classic" one which will look and feel like QBASIC). Of course, it will still be possible to use general IDEs designed to compile a variety of languages with QB64's compiler.

*What does he believe it will represent (work wise) when he starts porting this to other OSes? Did he make efforts so far to keep the code as portable as possible and can he pinpoint where the concerns are in the code base?* 

QB64 will port very easily to Linux and Mac and many other OSs. For starters, there is no assembly code, it is pure C++. Secondly, only multi-platform libraries which support Windows, Linux and Mac have been chosen. There are some minor changes that will have to happen (like MessageBox, which displays an error message in a separate window being a Windows specific command), but we are just talking about a few #ifdef changes. There's debate over the SHELL command and whether its parameters should be interpreted or not so that a Windows DIR command would work on a Linux/Mac machine.

*What kind of first big program or game would he like to do or see done when QB64 hits the mainstream? Would he want that done as a sign of QB64's capabilities? Or just out of personal challenge?*

At first, I'd be very happy to see many existing QBASIC programs/games being improved to take advantage of the new possibilities QB64 offers, this would of course showcase QB64's capabilities (Net Nibbles anyone?). As for the first large project in QB64, I'd like to hope someone else will produce that. QB64 is after all, my "Magnum Opus". In terms of what I'd like to see that person produce, I hope it will be the sort of program which is unique and easy for new programmers to "tweak" and learn from.

> In generally speaking, how you see Basic genre and programming with all those dialects today? What do you think that "BASIC" is or it should be?

I began programming in GWBASIC after a friend (whose father was a computer programmer) showed me a program that displayed a cake and played happy birthday. My grandfather had recently purchased a new PC which came with a GWBASIC manual too (you don't get those with your OS today!) and this allowed me to self-teach myself programming at a very young age. The school micro-bees also got a good work out, whether they had a green or orange screen. For me that's what BASIC should be, so simple a child (with the right amount of enthusiasm) can program in it. With this in mind I feel that more modern versions of BASIC (like Visual Basic) are far too complex for beginners. VB confronts you with a zillion options and it can be difficult for new programmers to understand how to get the toolbar-selected objects to interact with each other. There are of course, many derivatives of BASIC each with a particular focus. QB64's focus is on QBASIC compatibility and extending this capability. Which BASIC you use depends on what you want to achieve.

> You want to send any greetings to someone(s) now at the end of this interview?

I'd like to thank everyone who has helped in the development of QB64 so far. To name a few; MystikShadows, Qbguy, Mac, Rpgfan, Dav, Roy, Mennonite, The PhyloGenesis, Pete, Computerghost, Clippy... there are of course many more. QB64 development could not have progressed as quickly as it has without your enthusiasm and encouragement. QB64 could not have been this stable without your testing and feedback. Nor could it have run on all versions of Windows if I was not alerted to several incompatibilities between windows versions. I love your INPUT! Finally, thank you E.K.Virtanen for giving me the opportunity for this interview. It is the efforts of people like you who truly keep BASIC alive!

> It was nice to interview you Galleon, thank you.

(Rescued via [WaybackMachine](http://www.petesqbsite.com/sections/zines/pcopy/pcopy70.html).)