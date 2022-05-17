[Home](https://qb64.com) • [News](news.md) • [GitHub](github.md) • [Wiki](wiki.md) • [Games](games.md) • [Media](media.md) • [Community](community.md) • [Rolodex](rolodex.md) • [More...](more.md)

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

## Interview with Galleon, developer of QB64 (March 18th 2012)
-- *from [BASIC Gaming Issue #5](https://games.freebasic.net/BASICGaming/Issue5/)*

Galleon was kind enough to give an interview for BASIC Gaming and share some information about himself, the development of QB64 and his thoughts on the future of the compiler.

> Can you tell us a bit about your programming starts, your growth as a programmer and the path that led you to where you are today, as a programmer?

I began with Micro-Bee BASIC and GW-BASIC in primary/elementary school before progressing to QBASIC. Whilst studying a one unit TAFE college course on IT during high school I was lucky enough to meet a fellow programmer with skills in assembly language. From his examples I then expanded on my knowledge using x86 assembly language texts. QBASIC became too limited for my needs (speed and graphics were a problem) and assembly language was too much of a chore for exploring new programming ideas. So I invented a simple programming language called 'Lylat' which was a limited form of BASIC using TASM (turbo assembler) for compilation. Lylat was much faster than QBASIC/QB4.5 and featured texture mapping and other graphical tools. It used 'flat real mode' to access all of the computer's memory. I submitted Lylat as my 'major work' for the TAFE course. Lylat was flawed though, it had no order of operations or concepts of scope or functions. So I began to explore other languages like VB and Visual C/C++. VB at that stage felt 'clunky', the GUI elements were fine, but speed-wise I remember being disappointed, so I chose Visual C/C++ (my knowledge of assembly language came in handy). I developed many small games/programs, notably a 3D game which used Newtonian physics to model galaxies which you could explore in space ships (it was supposed to become a MMORPG/shooter, but I couldn't find an effective way to manage the stellar distances ships would travel with combat interceptions). Deciding to aim for something simpler I created a 2D MMORPG called 'Ultima 6 Online', I learned a lot about programming from its development and implementation, including the ever growing need for cross-platform compatibility. Then I stumbled upon the qb45.com forums (soon became the network54 forum). Inspired (for my love of QBASIC had never really been lost) I attempted to make a decent gaming library for QB4.5 called DQBSVGA (Direct QB existed but it was only 320x200x256). QB4.5 on the other hand, seemed to defy my attempts to improve it and I found that (after adding safe support for sound, MIDI, decent device input and graphics) the amount of remaining conventional memory (when the QB4.5 interpreter was running) was next to nothing. But Microsoft was the real DQBSVGA killer, because it announced Vista would relegate it (and QBASIC) to a tool only usable in DOSBOX. The programming language QBASIC was about to die. FreeBASIC was the only viable alternative, but I and others at the QBASIC forum felt it wasn't BASIC or QBASIC enough. So, I began work on QB64, a programming language which would strive for the highest possible level of QBASIC compatibility and would seamlessly integrate 16-bit and 32/64/etc-bit code.

> How would you describe QB64 to someone not familiar with it? What is its structure? How it is compiled/built?

QB64 can be summed up as QBASIC with improvements. It is possibly, in my opinion, the most beginner-friendly multiplatform programming language in existence. It is a procedural-style language and not, at this stage, object orientated. The QB64 code you write into the QB64 IDE is automatically converted to C++ code, compiled and then run as a native executable program.

> What were your goals back then and what are you current goals/plans with QB64?

Not much. There has been a notable drop in demand for the emulation of more 286 opcodes and DEF FN, so their implementation has become less of a priority. QB64 development is prioritized in response to the needs of the QB64 community. The need for integrated 3D, GUI widgets, capture (sound/video) and playback of video is high atm. In terms of the language itself, management of memory blocks will be implemented soon as well as support for proper precompiled modules and being able to specify a custom syntax for SUB/FUNCTION calls. Static & dynamic arrays within TYPEs are not far away as well as the beginnings of object orientated programming style support for TYPEs by allowing the definition of (automatically called) construction and deconstruction SUBs.

> How do you rate the current state of QB64 and what do you think needs to be done to improve it?

QB64 should probably not be used as the control program to launch nuclear warheads or to run a bank just yet. There are bugs which need to be fixed, and given the breadth of utilization QB64's commands cover, the development of this language with one primary developer will continue to take time. The base executable size and memory footprint are too high, but this can be improved. QB64 also needs to use alternative methods to make installation easier, particularly on Linux & MacOSX. The IDE continuously improves and the recent addition of the help system makes it easy for newcomers to load/paste-in a program and press F1 to instantly see what the commands are doing. As for the underscores before some commands, I have plans to make that easier too within the IDE. Overall, the language is reliable and the cross-platform compatibility of QB64 is excellent (such as the way it automatically changes directory separation slashes to Linux/Windows appropriate forms automatically at runtime).

> How do you rate the QB64 community at the moment and what would you like to see in it? More developers? More utilities or games being developed?

The QB64 community is fantastic at providing feedback and many willingly help new programmers with problems. We probably need more active developers at a C++ or QB64 compiler level which is why I created the google-code project to verify the open-source nature of QB64 and allow/encourage outside development. QB64's community appears to be growing. We also have a lot of 'lurkers' who use QB64 as a product/tool, but do not post about it unless they have a problem, which is fine because at the end of the day that's what QB64 is.

> Beside developing this compiler, what other sort of things do you like to program?

Programs to test concepts (eg. my 3D raycasters, AI simulations), educational software and games using innovative ideas. I also develop software tools to assist with my professional obligations (and for colleagues in my team) as an educator.

> What is your opinion of FreeBASIC and FreeBASIC community? Do you consider it a rival community/compiler or a phenomenon you can co-exist with in a potentially positive manner?

I think it's important to consider the sources of our userbases. Neither FB nor QB64 can expand by sourcing its userbase from the other or similar BASICs. There is a much greater untapped userbase within the broader community they need to appeal to in order to build their communities. It's my opinion that the way they will succeed or fail is primarily in how user-friendly they can make their tools. I strongly disagree with the premise behind many of FB's major development decisions (except for its C emitter) and see a disconnect between the language it set out to be and the one it ended up being. Apart from their original common tie to QBASIC I don't really see how future versions of FB or QB64 will be able to benefit each other much, the changes being made to them are just too different. I think they can co-exist happily, but I think the general public will have final say on how long they exist for.

> Would you be interested in sharing some personal details with the community? Like your age, where you live and what do you do professionally.

**Name:** Rob(ert)
**Public Aliases:** Galleon, GalleonDragon
**Age:** It's a secret! (Consider it a puzzle…)
**Location:** Sydney, Australia
**Profession:** School Teacher
**Email:** d***@gmail.com

> Any message for the community?

Creative programming ideas can be forged using a variety of programming mediums, but I think the straightforwardness of BASIC allows the coder to quickly prototype and explore more ideas. For me, in that lies the real fun of BASIC. I encourage everyone to support Lachie by developing content for this BASIC Gaming E-zine.

> If you want to download QB64 and join the QB64 community, start by visiting the official compiler website: [qb64.com](https://qb64.com)

## Philosophy Regarding Contributions To QB64

> Please note that I have no idea when this was originally written; and it should also be made clear that at some point Rob was apparently feeling a bit of burnout regarding the project - so without knowing when this was written, it's hard to have a full understanding what kind of mindset Rob was in at the time he replied with this. With that out of the way, it is at least something that reflects at least some point in time regarding Rob's stance regarding contributions to QB64. (The following was found as part of a [forum post](https://qb64forum.alephc.xyz/index.php?topic=2738.msg119618#msg119618) reponding to a question.)

I was recently asked for guidelines about the process for contributing to QB64's source code/core functionality.

I am supportive of ANY change to QB64 which:

1. Will not break existing functionality in any way
2. Is multi-platform compatible
3. Does not grossly/negatively interfere with the QB64 programming experience
4. Does not contain any known bugs
5. Is/Will be clearly documented so others can use it (either on the forum or in the WIKI)
6. Does not allow mixed language/CPU specific command integration (such as inline C++ code, assembly, etc)
7. Is not malicious in any way

Does your idea meet all of the above criteria? If so your next steps are...

1. Code it! (make sure you note any files you change and where for your own reference)
2. Submit it.
  - If you are a QB64 repository contributor, grab the latest version of the repository, make your changes and push them (I and the community will test the next dirty build [which is automatically created from the repository] and as long as it works, job done!) or...
  - Become a repository contributor by asking me on the Q&A forum

Everybody has a different opinion about what QB64 can/should be. But unless we make it what the individuals in our community want it to be then we all lose. So even if we personally don't want/need things like...

- Path finding
- Sorting
- A suite of string commands
- University-degree level math operations
- A circle fill command
- ODBC functionality
- OOP
- Name spaces
- Option explicit
- Web server interoperability
- Nullable/Reference types

...someone does.

My new philosophy is to let QB64 be what the community want it to be. Even if we end up with 1000s of commands that barely get used by the majority, it is better than QB64 not being used at all. And if someone implements something incredibly stupid/unnecessary (such as a _HELLOWORLD command) the beauty of a repository is that it can always be rolled back later. Because of this philosophy, you won't see me standing in the way of any changes.

## Forum Links

- [THE QBASIC FORUM](https://www.tapatalk.com/groups/qbasic/qb64-project-f585676/)
- [The QB64 (previously QB32) Demo #2 (September 08, 2007)](https://www.tapatalk.com/groups/qbasic/viewtopic.php?p=157971#p157971)
- [DOWNLOAD QB64 DEMO #5 (January 28th, 2008)](https://comp.lang.basic.misc.narkive.com/CnGTVTIa/download-qb64-demo-5)
- [DOWNLOAD QB64 DEMO #5 NOW! (January 28th, 2008)](https://www.tapatalk.com/groups/qbasic/download-qb64-demo-5-now-t36498-s40.html)