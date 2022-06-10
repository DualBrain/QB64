$Resize:Smooth
$ExeIcon:'.\ARCTIC_OLD.ico'
_Title "QDigger"

DefInt A-Z

' options
Const lifecost = 5000
Const emercost = 25
Const emer8cost = 250
Const goldcost = 500
Const monstercost = 250
Const eatcost = 250
Const bonuscost = 1000
Const hiscorefile$ = "qdigger.sco"
                                                                
' "system" constants
Const FALSE = 0, TRUE = Not FALSE, OLD = -2
Const scrmode = 1, nopal = TRUE
Const namelen = 14

'colors in colortable
Const blackclr = 0
Const greenclr = 1
Const redclr = 2
Const goldclr = 3

Type SCORETYPE
    uname As String * Namelen
    score As Long
End Type
Type PICPAR
    sequence As Integer
    frame As Integer
End Type
Type TIMEINT
    starttime As Single
    interval As Single
End Type
Type DIGGERTYPE
    x As Integer
    y As Integer
    startx As Integer
    starty As Integer
    dx As Integer
    dy As Integer
    pic As PICPAR
    mode As Integer
    eye As Integer
    lives As Integer
    score As Long
    teye As TIMEINT
End Type
Type ENEMYTYPE
    x As Integer
    y As Integer
    stpx As Integer
    stpy As Integer
    trgx As Integer
    trgy As Integer
    dir As Integer
    pic As PICPAR
    chaseflee As Integer
    mode As Integer
    thob As TIMEINT
    tdead As TIMEINT
End Type
Type NESTTYPE
    x As Integer
    y As Integer
    COUNT As Integer
End Type
Type PICKUPTYPE
    x As Integer
    y As Integer
    mode As Integer
    pic As PICPAR
    use As Integer
    misc As Integer
    fally As Integer
    dx As Integer
    dy As Integer
    dir As Integer
    t As TIMEINT
End Type
Type BONUSTYPE
    x As Integer
    y As Integer
    use As Integer
    iwait As Single
    ilen As Single
    t As TIMEINT
End Type

'enemy states
Const enm.creating = 1
Const enm.nobbin = 2
Const enm.hobbin = 3
Const enm.dying = 4
Const enm.dead = 5

' mazecell inner stats
Const mz.filled = -1
Const mz.empty = 0
Const mz.half = 1
Const mz.init = -100

Const gr.winner = 1
Const gr.gameover = 2
Const gr.abort = 0

Const hiscorec = 10
Const scores.y = 8
Const scores.x = 40

'ADD constants
Const newemerald = 1
Const newbag = 2
Const newnobbin = 4
Const newgold = 5

'sound codes
Const snd.emerald = 1
Const snd.gold = 2
Const snd.bonus = 3
Const snd.dead = 5
Const snd.killenemy = 7
Const snd.bagswing = 6
Const snd.bagshift = 4
Const snd.bagfall = 8
Const snd.baglanding = 9
Const snd.hit = 10
Const snd.shoot = 11
Const snd.dig = 12

' palette modes
Const pal.loading = -1
Const pal.normal = 0
Const pal.bonus = 1

' digger constants
Const diggerspeedy = 3
Const diggerspeedx = 4
Const dgr.left = 1
Const dgr.right = 2
Const dgr.up = 3
Const dgr.down = 4
Const dgr.dead = 5
Const dgr.falling = 6

' playing screen & maze properties
Const viewx = 12, viewy = 6 ' from left&top of playing field
Const cellw = 15 + 5 ' = 20    ' screen cell size
Const cellh = 14 + 4 ' = 18
Const mazex = 15 ' maze size
Const mazey = 10

' game field size
Const f.x = 0
Const f.y = 12
Const f.w = cellw * mazex + 20
Const f.h = cellh * mazey + 8

' time intervals, their modification params, and extreme values
Const tim.s.eye = 5
Const tim.s.hobbin = 3
Const tim.s.nobbin = 15
Const tim.d.nobbin = -1
Const tim.d.hobbin = 1
Const tim.min.nobbin = 7
Const tim.max.hobbin = 7

' animation indexes
Const ani.stat = 0
Const ani.bgrs = 1
Const ani.dgrleft = 2
Const ani.dgrright = 3
Const ani.dgrup = 4
Const ani.dgrdown = 5
Const anid.withouteye = 4
Const ani.dgrxleft = 6
Const ani.dgrxright = 7
Const ani.dgrxup = 8
Const ani.dgrxdown = 9
Const ani.dgrdie = 10
Const ani.nobbin = 11
Const ani.nobbindie = 12
Const ani.hobbinleft = 13
Const ani.hobbinright = 14
Const ani.hobbindieleft = 15
Const ani.hobbindieright = 16
Const ani.emerald = 17
Const ani.bag = 19
Const ani.bagleft = 18
Const ani.bagright = 20
Const ani.bagfall = 21
Const ani.bonus = 22
Const ani.coins = 23
Const ani.expl = 24
Const ani.fire = 25
Const ani.dig = 26
Const iblob.down = 79
Const iblob.left = iblob.down - 3
Const iblob.right = iblob.down - 2
Const iblob.up = iblob.down - 1

Const img1 = 0
Const framec = 1
Const mask = 1
Const pic = 0

Const opened = 0
Const leftwall = 1
Const rightwall = 2
Const upperwall = 4
Const lowerwall = 8
Const filled = 16

' bag movement modes
Const bagm.normal = 0
Const bagm.swinging = 1
Const bagm.left = 2
Const bagm.right = 3
Const bagm.falling = 4

Const maxcol = 15

Const emerw = 14, emerh = 10
Const goldw = 17, goldh = 15
Const imgw = 16, imgh = 16

Const gs.play = 0
Const gs.pause = 1
Const gs.killed = 2
Const gs.restart = 3
Const gs.newgame = 10
Const gs.quit = 100

Const eyem.normal = 0
Const eyem.expl = 1
Const eyew = 8, eyeh = 8

'$DYNAMIC
Dim Shared mapon As Integer
Dim Shared eye As PICKUPTYPE
Dim Shared bonus As BONUSTYPE
Dim Shared tim.hobbin As Single, tim.nobbin As Single, tim.eye As Single
Dim Shared maze(-1 To mazex * 2 + 1, -1 To mazey * 2 + 1) As Integer
Dim Shared graph(15835) As Integer, graphindex
Dim Shared img(90, 1) As Integer, imgc
Dim Shared anim(70, 1) As Integer

Dim Shared digger As DIGGERTYPE
Dim Shared enemy(1 To 5) As ENEMYTYPE, enemyc
Dim Shared bag(1 To 20) As PICKUPTYPE, bagc
Dim Shared gold(1 To 20) As PICKUPTYPE, goldc
Dim Shared emerald(1 To 100) As PICKUPTYPE, emeraldc
Dim Shared nest As NESTTYPE

Dim Shared hiscore(hiscorec - 1) As SCORETYPE
Dim Shared levidx(1 To 256) As Integer

Dim Shared bgrc, curbgr, consemer
Dim Shared curlevel, bonusmode, bonusscore
Dim Shared levelpack$, nosound
Dim Shared tcons As TIMEINT
Dim Shared gamestate
Dim Shared gameresult

'if your BASIC is qbasic.exe, simply comment next line.
cmd$ = Command$

If cmd$ = "/?" Then
    Print "Runs QDigger game."
    Print
    Print "QDIGGER [levelpackfile]"
    Print
    Print "You are Digger, an explorer of an old abandoned mine. This mine contains many"
    Print "levels, and many treasures buried inside. You must collect all emeralds"
    Print "moving from stage to stage; they cost 25 points each, and if you pick eight"
    Print "of them in a short time, you will get 250 bonus points. But be careful!"
    Print "Avoid Nobbins, angry mine monsters, they chase you to kill you. Sometimes"
    Print "they become extremely wild, and turn into wild wall-breaking Hobbins... =/"
    Print "You can use your fire against enemies by pressing <Space>. Remember, if you"
    Print "push big brown bag down, it will tear apart and gold coins appear, they cost"
    Print "500 points. There are some other features, reveal them yourself."
    End
End If

nosound = TRUE
Open "qdigger.ini" For Binary Access Read As #1
Seek #1, 1
a$ = Chr$(0)
Get #1, , a$
Close #1
If a$ <> Chr$(0) Then nosound = FALSE

levelpack$ = cmd$
INIT
Do
    curlevel = 0
    SETPAL pal.normal
    RESTOREFIELD
    NEWGAME
    ADDSCORE -1
    CHECKNEWHISCORE digger.score, gameresult
    If gamestate <> gs.quit Then SHOWHISCORE
Loop Until gamestate = gs.quit
QUIT


DataLevidx:
Data 43
Data 01,02,03,04,05,06,07,08,06,07,08
Data 05,06,07,08
Data 05,06,07,08
Data 05,06,07,08
Data 05,06,07,08
Data 05,06,07,08
Data 05,06,07,08
Data 05,06,07,08
Data 05,06,07,08

DataLevels:

Data "_mine #1"
Data " :::$:::::    e"
Data " ::77::7:: :$::"
Data " $:77::7:: ::::"
Data " ::77$:7$: :777"
Data " ::77::7:: :777"
Data "  :77::7:: :777"
Data ": ::::$:$: ::::"
Data ":    ::::: ::::"
Data "7::: ::::: :::7"
Data "77::   d   ::77"

Data "_mine #2"
Data "      ::$:$:: e"
Data ":77:: ::::::: :"
Data ":77:: :77777: :"
Data "$77$: :77777: :"
Data "7777: ::::::: :"
Data "7777: :$::    :"
Data ":77:: :77: ::::"
Data ":$$:: 7777 :77:"
Data "7:::: :77: :77:"
Data "77:::  d   ::::"

Data "_mine #3"
Data "     $:$:$    e"
Data "77:: :7:7: :$$:"
Data "7::: :7:7: :77:"
Data ":$$: :7:7: 7777"
Data "7777 :7:7: 7777"
Data "7777       :77:"
Data ":77::7: :7::77:"
Data ":77::7: :7:::::"
Data "7::::7: :7::::7"
Data "77:::7:d:7:::77"

Data "_mine #4"
Data "  $7777$7777$  "
Data "7 ::7777777:: 7"
Data "7   :77777:   7"
Data "7:: ::777:: ::7"
Data ":::   :7:   :::"
Data "::$:: :$: ::$::"
Data "::7:: 777 ::7::"
Data ":777:     :777:"
Data "77777:7 7:77777"
Data "77777:7d7:77777"

Data "_mine #5"
Data "              e"
Data " $7777$ 777777 "
Data " 777777 :77$7: "
Data " :7777: 77$777 "
Data " 777777 :7777: "
Data " :7777: $77777 "
Data " 77$777 :7777: "
Data " :77$7: 777777 "
Data " 777777 777777 "
Data "       d       "

Data "_mine #6"
Data "              e"
Data " 7$77 : : 77$7 "
Data " 777: $ $ :777 "
Data " 777  : :  777 "
Data " 77: :7 7: :77 "
Data " 77  :7 7:  77 "
Data " 7: :77 77: :7 "
Data " 7  $77 77$  7 "
Data " 7 7777 7777 7 "
Data "       d       "

Data "_mine #7"
Data "  77777 77777 e"
Data ": 7$7$7 7$7$7 :"
Data "$ 77777 77777 $"
Data "7  7777 7777  7"
Data "77 :777 777: 77"
Data "77   77 77   77"
Data "7777 :7 7: 7777"
Data "7777  : :  7777"
Data "77777 : : 77777"
Data "77777  d  77777"

Data "_mine #8"
Data "              e"
Data " :77$77777$77: "
Data "   7777$7777   "
Data " $ :7777777: $ "
Data " 7   77777   7 "
Data " 77$ :777: $77 "
Data " 777   7   777 "
Data " 7777: : :7777 "
Data " 77777 : 77777 "
Data "       d       "

Data "_end"

DataGfx:
'stats = 0
Data 11
Data 12,12
Data "011111111000"
Data "111111111100"
Data "110000001100"
Data "110000001100"
Data "110000001100"
Data "110000111100"
Data "110000111100"
Data "110000111100"
Data "110000111100"
Data "110000111100"
Data "111111111100"
Data "011111111000"
Data 12,12
Data "000001100000"
Data "000001100000"
Data "000001100000"
Data "000001100000"
Data "000001100000"
Data "000011100000"
Data "000011100000"
Data "000011100000"
Data "000011100000"
Data "000011100000"
Data "000011100000"
Data "000011100000"
Data 12,12
Data "011111111000"
Data "111111111100"
Data "110000001100"
Data "000000001100"
Data "000000001100"
Data "000000001100"
Data "011111111100"
Data "111111111000"
Data "111100000000"
Data "111100000000"
Data "111111111100"
Data "011111111100"
Data 12,12
Data "011111100000"
Data "111111110000"
Data "110000110000"
Data "110000110000"
Data "000000110000"
Data "001111111000"
Data "001111111100"
Data "000000011100"
Data "110000011100"
Data "110000011100"
Data "111111111100"
Data "011111111000"
Data 12,12
Data "110000000000"
Data "110000000000"
Data "110000110000"
Data "110000110000"
Data "110000110000"
Data "110000110000"
Data "110000110000"
Data "111111111100"
Data "011111111100"
Data "000001110000"
Data "000001110000"
Data "000001110000"
Data 12,12
Data "011111110000"
Data "111111110000"
Data "110000000000"
Data "110000000000"
Data "110000000000"
Data "111111111000"
Data "011111111100"
Data "000000111100"
Data "110000111100"
Data "110000111100"
Data "111111111100"
Data "011111111000"
Data 12,12
Data "011111111000"
Data "111111111100"
Data "110000001100"
Data "110000001100"
Data "110000000000"
Data "111111111000"
Data "111111111100"
Data "110000111100"
Data "110000111100"
Data "110000111100"
Data "111111111100"
Data "011111111000"
Data 12,12
Data "011111111000"
Data "011111111100"
Data "000000001100"
Data "000000001100"
Data "000000001100"
Data "000000001100"
Data "000000011100"
Data "000000011100"
Data "000000011100"
Data "000000011100"
Data "000000011100"
Data "000000011100"
Data 12,12
Data "000111110000"
Data "001111111000"
Data "001100011000"
Data "001100011000"
Data "001100011000"
Data "001111111000"
Data "011111111100"
Data "110000011100"
Data "110000011100"
Data "110000011100"
Data "111111111100"
Data "011111111000"
Data 12,12
Data "011111111000"
Data "111111111100"
Data "110000001100"
Data "110000001100"
Data "110000001100"
Data "111111111100"
Data "011111111100"
Data "000000111100"
Data "000000111100"
Data "000000111100"
Data "000000111100"
Data "000000111100"
Data 16,12
Data "4444444033044444"
Data "4444440333304444"
Data "0000040300300444"
Data "1111102222222044"
Data "1111112222222204"
Data "0000112222222220"
Data "1111112222222222"
Data "1111102002222002"
Data "0000040330220330"
Data "4444403003003003"
Data "4444403003003003"
Data "4444440330440330"

'backgrounds = 1
Data 8
Data 20,4
Data "22333333222233333322"
Data "32233332233223333223"
Data "33223322333322332233"
Data "33322223333332222333"
Data 20,4
Data "11221122112211221122"
Data "21122112211221122112"
Data "22112211221122112211"
Data "21122112211221122112"
Data 20,4
Data "22332233223322332233"
Data "32233223322332233223"
Data "33223322332233223322"
Data "23322332233223322332"
Data 20,4
Data "11333333111133333311"
Data "31133331133113333113"
Data "33113311333311331133"
Data "33311113333331111333"
Data 20,4
Data "22333333222233333322"
Data "31133331133113333113"
Data "33223322333322332233"
Data "33311113333331111333"
Data 20,4
Data "11221122112211221122"
Data "21122112211221122112"
Data "11221122112211221122"
Data "21122112211221122112"
Data 20,4
Data "22332233223322332233"
Data "31133113311331133113"
Data "33113311331133113311"
Data "23322332233223322332"
Data 20,4
Data "33223322332233223322"
Data "23322332233223322332"
Data "22332233223322332233"
Data "23322332233223322332"

'digger: left = 2
Data 3
Data 16,15
Data "4444444444444444"
Data "4444444033044444"
Data "4444440333304444"
Data "4444440300304444"
Data "4444440300304444"
Data "0000040300300444"
Data "1111102222222044"
Data "1111112222222204"
Data "0000112222222220"
Data "1111112222222002"
Data "1111102002220330"
Data "0000040330203003"
Data "4444403003003003"
Data "4444403003040330"
Data "4444440330444004"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444033044444"
Data "4444440333304444"
Data "4000040300304444"
Data "0111100300300444"
Data "0111112222222044"
Data "4001112222222204"
Data "4440112222222220"
Data "4001112002222222"
Data "0111110330022002"
Data "0111103003000330"
Data "4000003003003003"
Data "4444440330403003"
Data "4444444004440330"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444400444444"
Data "4400444033044444"
Data "4011040333304444"
Data "4011100300300444"
Data "4401112222222044"
Data "4440112222222204"
Data "4440112222222220"
Data "4440112222222002"
Data "4401112002220330"
Data "4011100330203003"
Data "4011003003003003"
Data "4400403003040330"
Data "4444440330444004"

'digger: right = 3
Data 3
Data 16,15
Data "4444444444444444"
Data "4444403304444444"
Data "4444033330444444"
Data "4444030030444444"
Data "4444030030444444"
Data "4440030030400000"
Data "4402222222011111"
Data "4022222222111111"
Data "0222222222110000"
Data "2002222222111111"
Data "0330222002011111"
Data "3003020330400000"
Data "3003003003044444"
Data "0330403003044444"
Data "4004440330444444"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444403304444444"
Data "4444033330444444"
Data "4444030030440004"
Data "4440030030001110"
Data "4402222222111110"
Data "4022222222111004"
Data "0222222222110444"
Data "2222222002111004"
Data "2002220330111110"
Data "0330203003001110"
Data "3003003003040004"
Data "3003040330444444"
Data "0330444004444444"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444403304440044"
Data "4444033330401104"
Data "4440030030011104"
Data "4402222222111044"
Data "4022222222110444"
Data "0222222222110444"
Data "2002222222110444"
Data "0330222002111044"
Data "3003020330011104"
Data "3003003003001104"
Data "0330403003040044"
Data "4004440330444444"

'digger: up = 4
Data 3
Data 16,15
Data "4440110110444444"
Data "4440110110444444"
Data "4440110110444444"
Data "4440110110444444"
Data "4004011104444444"
Data "0330222220000444"
Data "3003022223333044"
Data "3003022220003304"
Data "0330222220003304"
Data "4000222223333044"
Data "4400222220000444"
Data "4033022220444444"
Data "0300302204444444"
Data "0300302044444444"
Data "4033020444444444"
Data 16,15
Data "4401104011044444"
Data "4401104011044444"
Data "4401110111044444"
Data "4401111111044444"
Data "4400111110444444"
Data "4033022220004444"
Data "0300302223330444"
Data "0300302220033044"
Data "4033022220033044"
Data "4400022223330444"
Data "4000222220004444"
Data "0330222220444444"
Data "3003022204444444"
Data "3003022444444444"
Data "0330224444444444"
Data 16,15
Data "4400444440044444"
Data "4011044401104444"
Data "4011100011104444"
Data "4401111111044444"
Data "4000111110444444"
Data "0330222220044444"
Data "3003022223304444"
Data "3003022220330444"
Data "0330222220330444"
Data "4000222223304444"
Data "4400222220044444"
Data "4033022220444444"
Data "0300302204444444"
Data "0300302044444444"
Data "4033020444444444"

'digger: down = 5
Data 3
Data 16,15
Data "4444444402033044"
Data "4444444020300304"
Data "4444440220300304"
Data "4444402222033044"
Data "4400002222200444"
Data "4033332222200044"
Data "0330002222203304"
Data "0330002222030034"
Data "4033332222030034"
Data "4400002222203304"
Data "4444440111040044"
Data "4444401111104444"
Data "4444401101104444"
Data "4444401101104444"
Data "4444401101104444"
Data 16,15
Data "4444444402203304"
Data "4444444022030034"
Data "4444440222030034"
Data "4444402222203304"
Data "4440002222200044"
Data "4403332222000444"
Data "4033002222033044"
Data "4033002220300304"
Data "4403332220300304"
Data "4440002222033044"
Data "4444401111000444"
Data "4444011101110444"
Data "4444011040110444"
Data "4444011040110444"
Data "4444011040110444"
Data 16,15
Data "4444444402033044"
Data "4444444020300304"
Data "4444440220300304"
Data "4444402222033044"
Data "4444002222200444"
Data "4440332222200044"
Data "4403302222203304"
Data "4403302222030034"
Data "4440332222030034"
Data "4444002222203304"
Data "4444401111100044"
Data "4444011111110444"
Data "4440111000111044"
Data "4440110444011044"
Data "4444004444400444"

'digger: leftx = 6
Data 3
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444400444444"
Data "4444444033044444"
Data "0000040333300444"
Data "1111102222222044"
Data "1111112222222204"
Data "0000112222222220"
Data "1111112222222002"
Data "1111102002220330"
Data "0000040330203003"
Data "4444403003003003"
Data "4444403003040330"
Data "4444440330444004"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444400444444"
Data "4000044033044444"
Data "0111100333300444"
Data "0111112222222044"
Data "4001112222222204"
Data "4440112222222220"
Data "4001112002222222"
Data "0111110330022002"
Data "0111103003000330"
Data "4000003003003003"
Data "4444440330403003"
Data "4444444004440330"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4400444400444444"
Data "4011044033044444"
Data "4011100333300444"
Data "4401112222222044"
Data "4440112222222204"
Data "4440112222222220"
Data "4440112222222002"
Data "4401112002220330"
Data "4011100330203003"
Data "4011003003003003"
Data "4400403003040330"
Data "4444440330444004"

'digger: rightx = 7
Data 3
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444440044444444"
Data "4444403304444444"
Data "4440033330400000"
Data "4402222222011111"
Data "4022222222111111"
Data "0222222222110000"
Data "2002222222111111"
Data "0330222002011111"
Data "3003020330400000"
Data "3003003003044444"
Data "0330403003044444"
Data "4004440330444444"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444440044444444"
Data "4444403304440004"
Data "4440033330001110"
Data "4402222222111110"
Data "4022222222111004"
Data "0222222222110444"
Data "2222222002111004"
Data "2002220330111110"
Data "0330203003001110"
Data "3003003003040004"
Data "3003040330444444"
Data "0330444004444444"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444440044440044"
Data "4444403304401104"
Data "4440033330011104"
Data "4402222222111044"
Data "4022222222110444"
Data "0222222222110444"
Data "2002222222110444"
Data "0330222002111044"
Data "3003020330011104"
Data "3003003003001104"
Data "0330403003040044"
Data "4004440330444444"

'digger: upx = 8
Data 3
Data 16,15
Data "4440110110444444"
Data "4440110110444444"
Data "4440110110444444"
Data "4440110110444444"
Data "4004011104444444"
Data "0330222220444444"
Data "3003022223044444"
Data "3003022223304444"
Data "0330222223304444"
Data "4000222223044444"
Data "4400222220444444"
Data "4033022220444444"
Data "0300302204444444"
Data "0300302044444444"
Data "4033020444444444"
Data 16,15
Data "4401104011044444"
Data "4401104011044444"
Data "4401110111044444"
Data "4401111111044444"
Data "4400111110444444"
Data "4033022220444444"
Data "0300302223044444"
Data "0300302223304444"
Data "4033022223304444"
Data "4400022223044444"
Data "4000222220444444"
Data "0330222220444444"
Data "3003022204444444"
Data "3003022044444444"
Data "0330220444444444"
Data 16,15
Data "4400444440044444"
Data "4011044401104444"
Data "4011100011104444"
Data "4401111111044444"
Data "4000111110444444"
Data "0330222220444444"
Data "3003022223044444"
Data "3003022223304444"
Data "0330222223304444"
Data "4000222223044444"
Data "4400222220444444"
Data "4033022220444444"
Data "0300302204444444"
Data "0300302044444444"
Data "4033020444444444"

'digger: downx = 9
Data 3
Data 16,15
Data "4444444402033044"
Data "4444444020300304"
Data "4444440220300304"
Data "4444402222033044"
Data "4444402222200444"
Data "4444032222200044"
Data "4440332222203304"
Data "4440332222030034"
Data "4444032222030034"
Data "4444402222203304"
Data "4444440111040044"
Data "4444401111104444"
Data "4444401101104444"
Data "4444401101104444"
Data "4444401101104444"
Data 16,15
Data "4444444402203304"
Data "4444444022030034"
Data "4444440222030034"
Data "4444402222203304"
Data "4444402222200044"
Data "4444032222000444"
Data "4440332222033044"
Data "4440332220300304"
Data "4444032220300304"
Data "4444402222033044"
Data "4444401111000444"
Data "4444011101110444"
Data "4444011040110444"
Data "4444011040110444"
Data "4444011040110444"
Data 16,15
Data "4444444402033044"
Data "4444444020300304"
Data "4444440220300304"
Data "4444402222033044"
Data "4444402222200444"
Data "4444032222200044"
Data "4440332222203304"
Data "4440332222030034"
Data "4444032222030034"
Data "4444402222203304"
Data "4444401111100044"
Data "4444011111110444"
Data "4440111000111044"
Data "4440110444011044"
Data "4444004444400444"

'digger: die = 10
Data 6
Data 16,15
Data "4444444004444004"
Data "4444440330440330"
Data "4444403303003333"
Data "4400003333003303"
Data "0011100330220330"
Data "1111112002222002"
Data "1100112222222220"
Data "0011112222222204"
Data "1111102222222044"
Data "1100040300330444"
Data "0044440030300444"
Data "4444440300330444"
Data "4444444033330444"
Data "4444444403304444"
Data "4444444440044444"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444440004444444"
Data "4444001110044444"
Data "4400113331100444"
Data "4011333333311044"
Data "4013333333331044"
Data "0000000000000004"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444440004444444"
Data "4444001110044444"
Data "4400113331100444"
Data "4011333333311044"
Data "4013333333331044"
Data "0100003333333104"
Data "0103303033333104"
Data "0000000000000004"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444440004444444"
Data "4444001110044444"
Data "4400113331100444"
Data "4011333333311044"
Data "4013333333331044"
Data "0100003333333104"
Data "0103303033333104"
Data "0100003030000104"
Data "0100333030330104"
Data "0000000000000004"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444440004444444"
Data "4444001110044444"
Data "4400113331100444"
Data "4011333333311044"
Data "4013333333331044"
Data "0100003333333104"
Data "0103303033333104"
Data "0100003030000104"
Data "0100333030330104"
Data "0103033030000104"
Data "0103303030333104"
Data "0133333030333104"
Data "0000000000000004"
Data 16,15
Data "4444440004444444"
Data "4444001110044444"
Data "4400113331100444"
Data "4011333333311044"
Data "4013333333331044"
Data "0100003333333104"
Data "0103303033333104"
Data "0100003030000104"
Data "0100333030330104"
Data "0103033030000104"
Data "0103303030333104"
Data "0133333030333104"
Data "0133333330333104"
Data "0133333333333104"
Data "0000000000000004"

'nobbin: walk = 11
Data 3
Data 16,15
Data "4440004444000444"
Data "4403330000333044"
Data "4033333113333304"
Data "4030033113003304"
Data "4030033113003304"
Data "4403331111333044"
Data "4440111111110444"
Data "4440011111100444"
Data "4402201001022044"
Data "4022001111002204"
Data "4022040110402204"
Data "4022044004022220"
Data "4022044440222222"
Data "0222204444000000"
Data "2222220444444444"
Data 16,15
Data "4440004444000444"
Data "4403330000333044"
Data "4033333113333304"
Data "4033003113300304"
Data "4033003113300304"
Data "4403331111333044"
Data "4440111111110444"
Data "4440011001100444"
Data "4402201001022044"
Data "4022001111002204"
Data "4022040110402204"
Data "4022044004402204"
Data "0222244444022220"
Data "2222224440222222"
Data "0000004444000000"
Data 16,15
Data "4440004444000444"
Data "4403330000333044"
Data "4033003113300304"
Data "4033003113300304"
Data "4033333113333304"
Data "4403331111333044"
Data "4440111001110444"
Data "4440011001100444"
Data "4402201001022044"
Data "4022001001002204"
Data "4022040110402204"
Data "0222204004402204"
Data "2222220444402204"
Data "0000004444022220"
Data "4444444440222222"

'nobbin: die = 12
Data 1
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4440004444000444"
Data "4403330000333044"
Data "4030033113300304"
Data "4030033113300304"
Data "4033333113333304"
Data "4403331111333044"
Data "4440111001110444"
Data "4440011001100444"
Data "4402201001022044"
Data "4022001001002204"
Data "0222200110022220"
Data "2222220000222222"
Data "0000004444000000"

'hobbin: left = 13
Data 3
Data 16,15
Data "4444010333010444"
Data "4440103333301044"
Data "4440103300301104"
Data "4401103300301110"
Data "4011110333011110"
Data "0111111000111110"
Data "4022222111111104"
Data "4400000211111044"
Data "4022222111110444"
Data "4401111111104444"
Data "4440000220044444"
Data "4444440220444444"
Data "4444440220444444"
Data "4444402222044444"
Data "4444022222204444"
Data 16,15
Data "4444010333010444"
Data "4440103333301044"
Data "4401103003301104"
Data "4011103003301110"
Data "0111110333011110"
Data "0222111000111110"
Data "4000222111111104"
Data "4444000211111044"
Data "4400022111110444"
Data "4022211111104444"
Data "4411100220044444"
Data "4440040220444444"
Data "4444402222044444"
Data "4444022222204444"
Data "4444400000044444"
Data 16,15
Data "4444010333010444"
Data "4440103003301044"
Data "4401103003301104"
Data "4011103333301110"
Data "0221110333011110"
Data "4002211000111110"
Data "4440022111111104"
Data "4444000211111044"
Data "4400022111110444"
Data "4402211111104444"
Data "4421100220044444"
Data "4440002222044444"
Data "4444022222204444"
Data "4444400000044444"
Data "4444444444444444"

'hobbin: right = 14
Data 3
Data 16,15
Data "4440103330104444"
Data "4401033333010444"
Data "4011030033010444"
Data "0111030033011044"
Data "0111103330111104"
Data "0111110001111110"
Data "4011111112222204"
Data "4401111120000044"
Data "4440111112222204"
Data "4444011111111044"
Data "4444400220000444"
Data "4444440220444444"
Data "4444440220444444"
Data "4444402222044444"
Data "4444022222204444"
Data 16,15
Data "4440103330104444"
Data "4401033333010444"
Data "4011033003011444"
Data "0111033003011144"
Data "0111103330111114"
Data "0111110001112224"
Data "4011111112220044"
Data "4401111120004444"
Data "4440111112200044"
Data "4444011111122204"
Data "4444400220011144"
Data "4444440220400444"
Data "4444402222044444"
Data "4444022222204444"
Data "4444400000044444"
Data 16,15
Data "4440103330104444"
Data "4401033003010444"
Data "4011033003011044"
Data "0111033333011104"
Data "0111103330111220"
Data "0111110001122004"
Data "4011111112200444"
Data "4401111120044444"
Data "4440111112200444"
Data "4444011111122004"
Data "4444400220011204"
Data "4444402222000044"
Data "4444022222204444"
Data "4444400000044444"
Data "4444444444444444"

'hobbin: dieleft = 15
Data 1
Data 16,14
Data "4444400000004444"
Data "4444010333010444"
Data "4440103003301044"
Data "4401103003301104"
Data "4011103333301110"
Data "0221110333011110"
Data "4002211000111110"
Data "4440022111111104"
Data "4440022211111044"
Data "4402221111110444"
Data "4222111111104444"
Data "4400002222044444"
Data "4444022222204444"
Data "4444400000044444"

'hobbin: dieright = 16
Data 1
Data 16,15
Data "4444444444444444"
Data "4444000000044444"
Data "4440103330104444"
Data "4401033003010444"
Data "4011033003011044"
Data "0111033333011104"
Data "0111103330111220"
Data "0111110001122004"
Data "4011111112200444"
Data "4401111122244444"
Data "4440111111222444"
Data "4444011111112224"
Data "4444402222000004"
Data "4444022222204444"
Data "4444400000044444"

'emerald = 17
Data 1
Data 14,10
Data "44400000000044"
Data "44001111111004"
Data "40011311111100"
Data "00113111111110"
Data "40011311110100"
Data "44001111101004"
Data "44400111010044"
Data "44440011100444"
Data "44444001004444"
Data "44444400044444"

'goldbag: moveleft = 18
Data 1
Data 16,15
Data "4444400004444444"
Data "4444033330444444"
Data "4444403304444444"
Data "4444033330044444"
Data "4440333333304444"
Data "4403330033330444"
Data "4030000000033044"
Data "0300330033333304"
Data "0300000000003304"
Data "0333330033003304"
Data "0300330033003304"
Data "0330000000033044"
Data "4033330033330444"
Data "4400333333004444"
Data "4444000000444444"

'goldbag: normal = 19
Data 1
Data 16,15
Data "4444400000044444"
Data "4444403333044444"
Data "4444440330444444"
Data "4444003333004444"
Data "4440333333330444"
Data "4403333003333044"
Data "4033000000003304"
Data "0330033003333330"
Data "0330000000000330"
Data "0333333003300330"
Data "0330033003300330"
Data "0333000000003330"
Data "4033333003333304"
Data "4400333333330044"
Data "4444000000004444"

'goldbag: moveright = 20
Data 1
Data 16,15
Data "4444444000044444"
Data "4444440333304444"
Data "4444440033044444"
Data "4444403333304444"
Data "4444033333330444"
Data "4440333300333044"
Data "4403300000000304"
Data "4033003300333330"
Data "4033000000000030"
Data "4033333300330030"
Data "4033003300330030"
Data "4403300000000304"
Data "4440333300333044"
Data "4444003333300444"
Data "4444440000044444"

'goldbag: fall = 21
Data 1
Data 16,15
Data "4444403003044444"
Data "4444440330444444"
Data "4444440330444444"
Data "4444403333044444"
Data "4444033333304444"
Data "4440333003330444"
Data "4403000000003044"
Data "4030033003333304"
Data "4030000000000304"
Data "4033333003300304"
Data "4030033003300304"
Data "4403000000003044"
Data "4440333003330444"
Data "4444033333304444"
Data "4444400330044444"

'bonus = 22
Data 1
Data 16,15
Data "4000000011100004"
Data "0000000111110000"
Data "0000000110110000"
Data "0000001100011000"
Data "0000001100001100"
Data "0000011000101101"
Data "0000011000011110"
Data "0010110100001100"
Data "0001111000022200"
Data "0002220000233220"
Data "0023322002332222"
Data "0223222202222222"
Data "0222222200222220"
Data "0022222000022200"
Data "4002220000000004"

'falling coins = 23
Data 3
Data 16,15
Data "4444444004444444"
Data "4444440330444444"
Data "4444003333044444"
Data "4440330333044444"
Data "4403333030304444"
Data "4033333303330444"
Data "4033333303333044"
Data "4403333033333044"
Data "4440330033330444"
Data "4403003300004444"
Data "4033330303304444"
Data "4333333033330444"
Data "0333333033333044"
Data "4033330333333044"
Data "4403303033330444"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444004444"
Data "4444004440330444"
Data "4440330403333044"
Data "4403333033333304"
Data "4033333303333304"
Data "4033333300333044"
Data "4403333033030444"
Data "4400330333304444"
Data "4033003333030444"
Data "4333300330333044"
Data "0333330003333304"
Data "4033330303333304"
Data "4403303330333044"
Data 16,15
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4444444444444444"
Data "4440044444400444"
Data "4403304000033044"
Data "4033330330333304"
Data "0333333033033330"
Data "0333333033303330"
Data "4033330033300004"
Data "4003300333033304"
Data "0330030000333330"
Data "0333330330333330"
Data "4033303333033304"

'explosion = 24
Data 3
Data 8,8
Data "00444400"
Data "03000030"
Data "40322304"
Data "44022044"
Data "40322304"
Data "03000030"
Data "00444400"
Data "44444444"
Data 8,8
Data "30444403"
Data "03044030"
Data "40244204"
Data "44044044"
Data "40244204"
Data "03044030"
Data "30444403"
Data "44444444"
Data 8,8
Data "20444402"
Data "03044030"
Data "40444404"
Data "44444444"
Data "40444404"
Data "03044030"
Data "20444402"
Data "44444444"

' fire = 25
Data 3
Data 8,8
Data "40033004"
Data "02302332"
Data "03233030"
Data "33033323"
Data "03303330"
Data "03033030"
Data "43032304"
Data "44444444"
Data 8,8
Data "40232424"
Data "03302232"
Data "00223024"
Data "33032322"
Data "22302032"
Data "22032202"
Data "42432024"
Data "44444444"
Data 8,8
Data "40220224"
Data "02032202"
Data "20222022"
Data "23032220"
Data "02222322"
Data "22032203"
Data "40222024"
Data "44444444"

' digleft = 26
Data 1
Data 8,18
Data "44444400"
Data "44440000"
Data "44400000"
Data "44000000"
Data "44000000"
Data "40000000"
Data "00000000"
Data "00000000"
Data "00000000"
Data "00000000"
Data "00000000"
Data "00000000"
Data "40000000"
Data "44000000"
Data "44000000"
Data "44400000"
Data "44444004"
Data "44440044"

' digright = 27
Data 1
Data 8,18
Data "44004444"
Data "00004444"
Data "00000444"
Data "00000044"
Data "00000044"
Data "00000004"
Data "00000000"
Data "00000000"
Data "00000000"
Data "00000000"
Data "00000000"
Data "00000000"
Data "00000004"
Data "00000044"
Data "00000444"
Data "00000444"
Data "40044444"
Data "00444444"

'digup = 28
Data 1
Data 24,6
Data "444444444000000444444444"
Data "444444400000000004444444"
Data "444444000000000000044444"
Data "444000000000000000000444"
Data "440000000000000000004444"
Data "444400000000000000000044"

'digdown = 29
Data 1
Data 24,6
Data "444000000000000000000444"
Data "440000000000000000004444"
Data "444400000000000000000044"
Data "444440000000000000044444"
Data "444444400000000004444444"
Data "444444444000000444444444"

Rem $STATIC
Sub ADDOBJ (obj, cx, cy)
    GETCELLCOORDS cx, cy, x, y
    Select Case obj
        Case newnobbin
            enemyc = enemyc + 1
            enemy(enemyc).mode = enm.nobbin
            enemy(enemyc).x = x: enemy(enemyc).y = y
            enemy(enemyc).stpx = x: enemy(enemyc).stpy = y
            enemy(enemyc).trgx = cx: enemy(enemyc).trgy = cy
            enemy(enemyc).thob.starttime = Timer: enemy(enemyc).thob.interval = tim.nobbin
            enemy(enemyc).pic.sequence = ani.nobbin: enemy(enemyc).pic.frame = 0
        Case newemerald
            emeraldc = emeraldc + 1
            emerald(emeraldc).x = x: emerald(emeraldc).y = y + 3 ' +3 - чтобы был по центру клетки
            emerald(emeraldc).mode = 0
            emerald(emeraldc).pic.sequence = ani.emerald
            emerald(emeraldc).pic.frame = 0
            DRAWPIC emerald(emeraldc).x, emerald(emeraldc).y, emerald(emeraldc).pic, FALSE
        Case newbag
            bagc = bagc + 1
            bag(bagc).x = x
            bag(bagc).y = y
            bag(bagc).mode = gld.normal
            bag(bagc).misc = 0
            bag(bagc).fally = 0
            bag(bagc).pic.sequence = ani.bag
            DRAWPIC x, y, bag(bagc).pic, FALSE
        Case newgold
            goldc = goldc + 1
            gold(goldc).x = x
            gold(goldc).y = y
            gold(goldc).pic.sequence = ani.coins
            gold(goldc).pic.frame = -1
            gold(goldc).t.interval = 10
            gold(goldc).t.starttime = Timer
    End Select
End Sub

Sub ADDSCORE (amount)
    Static addition As Long
    Static t As TIMEINT: t.interval = .01
    Static newlife As Long
    Static palflag
    If amount < 0 Then
        digger.score = digger.score + addition
        SHOWSCORE digger.score, digger.lives
        addition = 0
    Else
        addition = addition + amount
        If TEVENT(t) Then
            If digger.score = 0 Then newlife = lifecost
            If palflag >= 1 Then
                palflag = palflag - 1
                If palflag = 0 And bonusmode = FALSE Then SETPAL pal.normal
            End If
            If digger.score + addition >= newlife Then
                SETPAL pal.bonus
                palflag = 3
                newlife = newlife + lifecost
                If digger.lives < 9 Then digger.lives = digger.lives + 1
            End If
            For i = 1 To addition \ 5 + 1
                If addition <= 0 Then Exit For
                addition = addition - 1
                digger.score = digger.score + 1
            Next
        End If
    End If
End Sub

Sub ANIMATE (x, y, P As PICPAR, redr)
    If redr Then
        If P.frame >= 0 Then ERASEPIC x, y, P
        P.frame = (P.frame + 1) Mod anim(P.sequence, framec)
        DRAWPIC x, y, P, FALSE
    Else
        P.frame = (P.frame + 1) Mod anim(P.sequence, framec)
    End If
End Sub

Function BOXCOLL (x, y, w, h, ax, ay, aw, ah)
    x2 = x + w - 1
    y2 = y + h - 1
    ax2 = ax + aw - 1
    ay2 = ay + ah - 1
    If x > ax Then xr1 = x Else xr1 = ax
    If y > ay Then yr1 = y Else yr1 = ay
    If x2 < ax2 Then xr2 = x2 Else xr2 = ax2
    If y2 < ay2 Then yr2 = y2 Else yr2 = ay2
    wr = xr2 - xr1
    hr = yr2 - yr1
    If wr < 0 Or hr < 0 Then BOXCOLL = FALSE Else BOXCOLL = TRUE
End Function

Function CHECKBAGSHIFT (x, y, dir)
    For i = 1 To bagc
        If BOXCOLL(x + dir, y, imgw, imgh, bag(i).x, bag(i).y, cellw - 1, cellh) Then
            If bag(i).mode = bagm.normal And dir <> 0 Then r = SHIFTBAG(i, dir * diggerspeedx)
            CHECKBAGSHIFT = TRUE
            Exit Function
        End If
    Next
    CHECKBAGSHIFT = FALSE
End Function

Sub CHECKBONUS (x, y, scoreflag)
    If bonus.use Then
        bx = bonus.x
        by = bonus.y
        If BOXCOLL(x, y, imgw, imgh, bx, by, imgw, imgh) Then
            ERASEIMG bx, by, anim(ani.bonus, img1)
            bonusmode = TRUE
            bonus.use = FALSE
            bonus.t.starttime = Timer
            If scoreflag Then ADDSCORE bonuscost
            SETPAL pal.bonus
        Else
            DRAWIMG bx, by, anim(ani.bonus, img1), FALSE
        End If
    End If
End Sub

Sub CHECKEMERALDS (plx, ply, scoreflag)
    For i = emeraldc To 1 Step -1
        If BOXCOLL(plx, ply, imgw, imgh, emerald(i).x, emerald(i).y, emerw, emerh) Then
            If scoreflag Then
                ADDSCORE emercost
                consemer = consemer + 1
                tcons.starttime = Timer
                If consemer = 8 Then ADDSCORE emer8cost: consemer = 0
                PLAYSOUND snd.emerald
            End If
            ERASEPIC emerald(i).x, emerald(i).y, emerald(i).pic
            Swap emerald(emeraldc), emerald(i)
            emeraldc = emeraldc - 1
        End If
    Next
End Sub

Sub CHECKGOLD (plx, ply, scoreflag)
    For i = goldc To 1 Step -1
        If BOXCOLL(plx, ply, imgw + 2, imgh + 2, gold(i).x, gold(i).y + imgh * .4, imgw + 3, imgh * (1 - .4)) Then
            If scoreflag Then ADDSCORE goldcost
            PLAYSOUND snd.gold
            ERASEPIC gold(i).x, gold(i).y, gold(i).pic
            REDRAW gold(i).x, gold(i).y, emerald(), emeraldc
            Swap gold(goldc), gold(i)
            goldc = goldc - 1
        End If
    Next
End Sub

Sub CHECKKILL
    Const d = 4
    For i = enemyc To 1 Step -1
        If (enemy(i).mode = enm.hobbin Or enemy(i).mode = enm.nobbin) And BOXCOLL(enemy(i).x + d, enemy(i).y + d, imgw - d * 2, imgh - d * 2, digger.x, digger.y, imgw, imgh) Then
            If Not bonusmode Then
                gamestate = gs.killed
                ERASEPIC enemy(i).x, enemy(i).y, enemy(i).pic
                ERASEPIC digger.x, digger.y, digger.pic
                digger.pic.sequence = ani.dgrdie
                digger.pic.frame = -1
                digger.mode = dgr.dead
                PLAYSOUND snd.dead
                Exit For
            Else
                ERASEPIC enemy(i).x, enemy(i).y, enemy(i).pic
                Swap enemy(i), enemy(enemyc)
                enemyc = enemyc - 1
                bonusscore = bonusscore + eatcost
                ADDSCORE bonusscore
            End If
        End If
    Next
End Sub

Sub CHECKNEWHISCORE (score As Long, gameresult)
    '  score = hiscore(hiscorec - 1).score + 1
    cw = 8: ch = 14
    If score > hiscore(hiscorec - 1).score Then
        For i = 0 To hiscorec - 1
            If hiscore(i).score < score Then
                For j = hiscorec - 1 To i + 1 Step -1
                    hiscore(j) = hiscore(j - 1)
                Next
                hiscore(i).score = score
                View
                Line (cw * 10 - 8, ch * 4)-Step(cw * 22 + 1 + 16, ch * 6 + 1), 0, BF
                If gameresult = gr.gameover Then
                    Locate 10, 14: Print "   GAME OVER!   "
                ElseIf gameresult = gr.winner Then
                    Locate 10, 14: Print "CONGRATULATIONS!"
                Else
                    Locate 10, 14: Print "  HIGH SCORE!!  "
                End If
                Line (cw * 10 + 2 - 8, ch * 4 + 2)-Step(cw * 22 - 3 + 16, ch * 6 - 3), 2, B
                Locate 13, 14: Print "Enter your name:"
                Locate 15, 15: Print String$(namelen, ".")
                Do
                    Do: k$ = InKey$: Loop While Len(k$) = 0
                    Select Case Asc(k$)
                        Case Is >= 32: If Len(name$) < namelen Then name$ = name$ + k$
                        Case 8: If Len(name$) > 0 Then name$ = Left$(name$, Len(name$) - 1)
                    End Select
                    Locate 15, 15: Print name$ + String$(namelen - Len(name$), ".")
                Loop Until k$ = Chr$(13)
                hiscore(i).uname = name$ + String$(namelen - Len(name$), ".")
                UPDATESCORES
                Exit For
            End If
        Next
    End If
End Sub

Sub CLOSELEVEL
    If levelpack$ <> "" Then Close #1
End Sub

Sub DELAY (sec!)
    ct! = Timer
    Do Until ct! + sec! <= Timer
        a = Len(InKey$)
    Loop
End Sub

Sub DRAWHOLE (x, y)
    SCANMAZECELL x, y, 0, l, r, u, d
    SCANMAZECELL x + 1, y, rc, 0, 0, 0, 0
    SCANMAZECELL x - 1, y, lc, 0, 0, 0, 0
    SCANMAZECELL x, y + 1, dc, 0, 0, 0, 0
    SCANMAZECELL x, y - 1, uc, 0, 0, 0, 0
    GETCELLCOORDS x, y, cx, cy
    If l = FALSE Or (x = 0 And (y = 0 Or y = mazey - 1 Or r = FALSE)) Then
        For i = cx - 5 To cx + 10 Step diggerspeedx
            DRAWIMG i, cy - 1, iblob.left, FALSE
        Next
    End If
    If r = FALSE Or (x = mazex - 1 And (y = 0 Or y = mazey - 1 Or l = FALSE)) Then
        If lc = mz.empty Then delta = 1 Else delta = 0
        For i = cx + 10 + 1 - diggerspeedx * (3 + delta) To cx + 10 + 1 Step diggerspeedx
            DRAWIMG i, cy - 1, iblob.right, FALSE
        Next
    End If
    If u = FALSE Or (y = 0 And (x = mazex - 1 Or x = 0)) Then
        If uc = FALSE Then delta = 1 Else delta = 0
        For i = cy - 3 - diggerspeedy * delta To cy - 3 + diggerspeedy * 4 Step diggerspeedy
            DRAWIMG cx - 5, i, iblob.up, FALSE
        Next
    End If
    If d = FALSE Or (y = 0 And (x = mazex - 1 Or x = 0)) Then
        If dc = mz.empty And u = FALSE Then delta = 1 Else delta = 0
        For i = cy + 12 - diggerspeedy * (4) To cy + 12 + diggerspeedy * delta Step diggerspeedy
            DRAWIMG cx - 5, i, iblob.down, FALSE
        Next
    End If
End Sub

Sub DRAWIMG (x, y, imgn, disablemask)
    If Not disablemask Then Put (x, y), graph(img(imgn, mask)), And
    Put (x, y), graph(img(imgn, pic)), Or
End Sub

Sub DRAWPIC (x, y, P As PICPAR, disablemask)
    If P.frame >= 0 Then DRAWIMG x, y, anim(P.sequence, img1) + P.frame, disablemask
End Sub

Sub ERASEIMG (x, y, im)
    Put (x, y), graph(img(im, mask)), And
End Sub

Sub ERASEPIC (x, y, P As PICPAR)
    ERASEIMG x, y, anim(P.sequence, img1) + P.frame
End Sub

Sub FILLBGR (num)
    n = anim(ani.bgrs, img1) + num
    GETIMAGE n, w, h, idx
    For y = 0 To f.h - 1 Step h
        For x = 0 To f.w - 1 Step w
            Put (x, y), graph(idx), PSet
        Next
    Next
End Sub

Sub FILLMAZECELL (x, y, i, l, r, u, d)
    If x < 0 Or y < 0 Or x > mazex - 1 Or y > mazey - 1 Then Exit Sub
    x2 = x * 2
    y2 = y * 2
    If i <> OLD Then
        Select Case i
            Case mz.init: maze(x2, y2) = mz.filled
            Case mz.filled: If maze(x2, y2) <> mz.empty And maze(x2, y2) <> mz.half Then maze(x2, y2) = i
            Case mz.half: If maze(x2, y2) <> mz.empty Then maze(x2, y2) = i
            Case mz.empty: maze(x2, y2) = i
        End Select
    End If
    If l <> OLD Then
        If x2 <> 0 Then maze(x2 - 1, y2) = l Else maze(x2 - 1, y2) = TRUE
    End If
    If r <> OLD Then
        If x2 <> (mazex - 1) * 2 Then maze(x2 + 1, y2) = r Else maze(x2 + 1, y2) = TRUE
    End If
    If u <> OLD Then
        If y2 <> 0 Then maze(x2, y2 - 1) = u Else maze(x2, y2 - 1) = TRUE
    End If
    If d <> OLD Then
        If y2 <> (mazey - 1) * 2 Then maze(x2, y2 + 1) = d Else maze(x2, y2 + 1) = TRUE
    End If
End Sub

Sub GETCELLCOORDS (x, y, rx, ry)
    rx = x * cellw + viewx
    ry = y * cellh + viewy
End Sub

Sub GETIMAGE (i, x, y, idx)
    idx = img(i, pic)
    Def Seg = VarSeg(graph(idx))
    x = Peek(VarPtr(graph(idx))) \ 2
    y = Peek(VarPtr(graph(idx)) + 2)
    Def Seg
End Sub

Sub GETINPUTS
    Static cheat$, i$
    Static tch As TIMEINT
    Static tctl As TIMEINT
    tctl.interval = .045
    tch.interval = 1
    z$ = InKey$
    If z$ <> "" Then i$ = z$
    If gamestate <> gs.play Then i$ = ""
    If z$ = Chr$(0) + Chr$(59) Then
        If gamestate = gs.play Then
            gamestate = gs.pause
            SHOWHISCORE
            gamestate = gs.play
        End If
    Else
        Select Case z$
            Case Chr$(0) + Chr$(68): gamestate = gs.quit: gameresult = gr.abort
            Case Chr$(0) + Chr$(63): gamestate = gs.newgame
            Case Chr$(0) + Chr$(66): nosound = Not nosound
            Case " "
                GETMAZECELL digger.x, digger.y, dx, dy
                SCANMAZECELL dx - 1, dy, l, 0, 0, 0, 0
                SCANMAZECELL dx + 1, dy, r, 0, 0, 0, 0
                SCANMAZECELL dx, dy - 1, u, 0, 0, 0, 0
                SCANMAZECELL dx, dy + 1, d, 0, 0, 0, 0
                l = (l = mz.empty)
                d = (d = mz.empty)
                u = (u = mz.empty)
                r = (r = mz.empty)
                    IF (digger.mode = dgr.left AND digger.x > imgw AND l) OR (digger.mode = dgr.up AND digger.y > imgh AND u) OR (digger.mode = dgr.right AND digger.x < f.w - imgw * 2 AND r) OR (digger.mode = dgr.down AND digger.y < f.h - imgh * 2 AND d) THEN _

                    If digger.eye Then
                        digger.eye = FALSE
                        digger.teye.starttime = Timer
                        Select Case digger.mode
                            Case dgr.left: SHOOT -1, 0
                            Case dgr.right: SHOOT 1, 0
                            Case dgr.up: SHOOT 0, -1
                            Case dgr.down: SHOOT 0, 1
                        End Select
                        ERASEPIC digger.x, digger.y, digger.pic
                        digger.pic.sequence = digger.pic.sequence + anid.withouteye
                        DRAWPIC digger.x, digger.y, digger.pic, TRUE
                    End If
                End If
        End Select
    End If
    
    If gamestate = gs.play And (z$ >= "a" And z$ <= "z") Or (z$ >= "0" And z$ <= "9") Then
        tch.starttime = Timer
        cheat$ = cheat$ + z$
        Select Case cheat$
            Case "afterlong": Locate 11, 20: Input " level"; li: curlevel = li: LOADLEVEL li: cheat$ = "": Exit Sub
            Case "thecure": digger.lives = 9: cheat$ = ""
            Case "nomercy": digger.teye.interval = 0: digger.eye = TRUE: cheat$ = ""
            Case "nlev": NEXTLEVEL: cheat$ = "": Exit Sub
        End Select
    Else
        If z$ <> "" Then
            cheat$ = ""
        ElseIf TEVENT(tch) Then
            cheat$ = ""
        End If
        If TEVENT(tctl) And gamestate = gs.play Then
            Select Case i$
                Case Chr$(0) + Chr$(72): MOVEDIGGER 0, -1
                Case Chr$(0) + Chr$(75): MOVEDIGGER -1, 0
                Case Chr$(0) + Chr$(80): MOVEDIGGER 0, 1
                Case Chr$(0) + Chr$(77): MOVEDIGGER 1, 0
            End Select
            i$ = ""
            If Not digger.eye Then
                If TEVENT(digger.teye) Then
                    digger.eye = TRUE
                    ERASEPIC digger.x, digger.y, digger.pic
                    digger.pic.sequence = digger.pic.sequence - anid.withouteye
                    DRAWPIC digger.x, digger.y, digger.pic, TRUE
                End If
            End If
        End If
    End If
End Sub

Function GETLEVIDX$ (num)
    If levelpack$ = "" Then
        GETLEVIDX$ = NUMTOSTR(levidx(num) + 0)
    Else
        GETLEVIDX$ = NUMTOSTR$(num + 0)
    End If
End Function

Sub GETMAZECELL (x, y, rx, ry)
    If x - viewx < 0 Then
        rx = -1
    Else
        rx = (x - viewx) \ cellw
    End If
    If y - viewy < 0 Then
        ry = -1
    Else
        ry = (y - viewy) \ cellh
    End If
End Sub

Function GETPATH (sx, sy, tx, ty, PL) Static
    Const x = 0, y = 1, size = mazex * mazey
    Dim d(3, 1), wl(3)
    Dim mzf(mazex, mazey)
    Dim pp(size, 1, 0 To 1)
    Dim bx(20), by(20)

    For i = 0 To mazex - 1
        For j = 0 To mazey - 1
            mzf(i, j) = 0
        Next
    Next

    dc = 4
    d(0, x) = -1: d(0, y) = 0
    d(1, x) = 1: d(1, y) = 0
    d(2, x) = 0: d(2, y) = -1
    d(3, x) = 0: d(3, y) = 1

    pf = 1
    pp(0, x, 0) = tx
    pp(0, y, 0) = ty
    pc1 = 1
    w = 0
    mzf(tx, ty) = w + 1
    For j = 1 To bagc: GETMAZECELL bag(j).x, bag(j).y, bx(j), by(j): Next
    Do
        w = w + 1
        If pf = 0 Then
            pf = 1
            pf2 = 0
        Else
            pf = 0
            pf2 = 1
        End If
        pc = pc1
        pc1 = 0
        fw = FALSE
        For i = 0 To pc - 1
            SCANMAZECELL pp(i, x, pf), pp(i, y, pf), 0, wl(0), wl(1), wl(2), wl(3)
            For j = 1 To bagc
                If bx(j) = pp(i, x, pf) And by(j) = pp(i, y, pf) Then
                    wl(2) = TRUE
                    wl(3) = TRUE
                    Exit For
                End If
            Next
            For dr = 0 To dc - 1
                x1 = pp(i, x, pf) + d(dr, x)
                y1 = pp(i, y, pf) + d(dr, y)
                If x1 >= 0 And y1 >= 0 And x1 <= mazex - 1 And y1 <= mazey - 1 Then
                    If mzf(x1, y1) = 0 Then
                        SCANMAZECELL x1, y1, v, 0, 0, 0, 0
                        If wl(dr) = FALSE And v = mz.empty Then
                            If x1 = sx And y1 = sy Then
                                Select Case dr
                                    Case 0: dirc = 1
                                    Case 1: dirc = 0
                                    Case 2: dirc = 3
                                    Case 3: dirc = 2
                                End Select
                                PL = w
                                GETPATH = dirc
                                GoTo exitfunc
                            End If
                            pp(pc1, x, pf2) = x1
                            pp(pc1, y, pf2) = y1
                            mzf(x1, y1) = w + 1
                            pc1 = pc1 + 1
                        End If
                    End If
                End If
            Next
        Next
    Loop Until pc1 = 0
    PL = -1
    GETPATH = -1
    GoTo exitfunc
    exitfunc:
    Exit Function
    DRW:
    Const cw = 5, ch = 5
    Const mvx = 639 - mazex * cw, mvy = 349 - mazey * ch
    View (mvx, mvy)-(mvx + mazex * cw, mvy + mazey * ch)
    For q = 0 To mazex - 1
        For j = 0 To mazey - 1
            Select Case mzf(q, j)
                Case Is = 0: col = goldclr
                Case Is <> 0: col = greenclr
            End Select
            Line (q * cw, j * ch)-Step(cw, ch), col, BF
        Next
    Next
    RESTOREFIELD
    Return
End Function

Sub GETRANDOMCELL (dx, dy)
    Do
        dx = Int(Rnd * mazex)
        dy = Int(Rnd * mazey)
        SCANMAZECELL dx, dy, v, 0, 0, 0, 0
    Loop Until v = mz.empty
End Sub

Function IMGSIZE (w, h) Static
    size = (4 + Int((w * 8 + 7) \ 8) * h) \ 2 + 1
    IMGSIZE = size
End Function

Sub INIT
    Randomize Timer
    Out &H60, &HF3: s! = Timer: Do: Loop While s! + .1 > Timer: Out &H60, 0
    Screen scrmode
    _AllowFullScreen _SquarePixels , _Smooth
    LOADLEVIDX
    LOADGRAPHICS
    LOADSCORES hiscorefile, hiscore()
End Sub

Sub INITDIGGER
    digger.dx = -1
    digger.pic.sequence = ani.dgrleft: digger.mode = dgr.left
    digger.eye = TRUE
    digger.x = digger.startx
    digger.y = digger.starty
End Sub

Sub LOADGRAPHICS
    graphindex = 0
    animc = 0
    Restore DataGfx
    For i = 1 To 30
        Read framecount
        anim(animc, framec) = framecount
        anim(animc, img1) = imgc
        animc = animc + 1
        For f = 1 To framecount
            LOADIMAGE w, h, index
        Next
    Next
    bgrc = anim(ani.bgrs, framec)
    curbgr = -1
    Cls
End Sub

Sub LOADIMAGE (w, h, index)
 
    Read w, h
    For y = 0 To h - 1
        Read B$
        For x = 0 To w - 1
            c = Asc(Mid$(B$, x + 1, 1)) - Asc("0")
            c1 = 0
            Select Case c
                Case 0: c = 0
                Case 1: c = greenclr
                Case 2: c = redclr
                Case 3: c = goldclr
                Case 4: c = 0: c1 = maxcol
            End Select
            PSet (x, y), c
            PSet (x + w, y), c1
        Next
    Next

    index = imgc

    ' save image
    img(imgc, pic) = graphindex
    Get (0, 0)-(w - 1, h - 1), graph(graphindex)
    graphindex = graphindex + IMGSIZE(w, h)

    ' save mask
    img(imgc, mask) = graphindex
    Get (0 + w, 0)-(w - 1 + w, h - 1), graph(graphindex)
    graphindex = graphindex + IMGSIZE(w, h)
 
    imgc = imgc + 1
End Sub

Sub LOADLEVEL (levidx As Integer)
    If Not OPENLEVEL(GETLEVIDX$(levidx)) Then
        For i = 1 To digger.lives: ADDSCORE lifecost: Next
        WINGAME
        gameresult = gr.winner: gamestate = gs.quit
    Else
        eye.use = FALSE

        tim.nobbin = tim.s.nobbin
        tim.nobbin = fnmax(tim.s.nobbin - levidx / 2, 10)
        If tim.nobbin < tim.min.nobbin Then tim.nobbin = tim.min.nobbin
        tim.hobbin = tim.s.hobbin + levidx * tim.d.hobbin: If tim.hobbin > tim.max.hobbin Then tim.hobbin = tim.max.hobbin
        gamestate = gs.play
        bonus.use = FALSE
        emeraldc = 0
        bagc = 0
        goldc = 0
        enemyc = 0
        For i = 0 To mazex - 1
            For j = 0 To mazey - 1
                FILLMAZECELL i, j, mz.init, TRUE, TRUE, TRUE, TRUE
            Next
        Next
        curbgr = (levidx - 1) Mod bgrc
        FILLBGR curbgr
        bonus.t.starttime = Timer
        For y = 0 To 9
            s$ = READLEVELSTR$
            If Left$(s$, 1) = "_" Then
                y = y - 1
                '' script ''
                ' no additional commands. '
            Else
                '' level_data ''
                For x = 0 To 14
                    ch$ = Mid$(s$, x + 1, 1)
                    Select Case ch$
                        Case "#", " ": FILLMAZECELL x, y, mz.empty, TRUE, TRUE, TRUE, TRUE
                        Case "e":
                            nest.x = x
                            nest.y = y
                            GETCELLCOORDS x, y, bonus.x, bonus.y
                            bonus.use = FALSE
                            bonus.iwait = levidx * 5 + 30
                            bonus.t.interval = bonus.iwait
                            bonus.ilen = 20 - levidx: If bonus.ilen < 3 Then bonus.ilen = 3
                            nest.COUNT = levidx \ 3 + 2: If nest.COUNT > 5 Then nest.COUNT = 5
                            FILLMAZECELL x, y, mz.empty, TRUE, TRUE, TRUE, TRUE
                        Case "d":
                            GETCELLCOORDS x, y, digger.startx, digger.starty
                            FILLMAZECELL x, y, mz.empty, FALSE, FALSE, TRUE, TRUE
                        Case "7": ADDOBJ newemerald, x, y
                        Case "$": ADDOBJ newbag, x, y
                    End Select
                Next
            End If
        Next
        bonusmode = FALSE
        bonusscore = 0
        SETPAL pal.normal
        CLOSELEVEL
        For i = 0 To mazey - 1
            For j = 0 To mazex - 1
                SCANMAZECELL j, i, v, 0, 0, 0, 0
                SCANMAZECELL j - 1, i, l, 0, 0, 0, 0
                SCANMAZECELL j + 1, i, r, 0, 0, 0, 0
                SCANMAZECELL j, i - 1, u, 0, 0, 0, 0
                SCANMAZECELL j, i + 1, d, 0, 0, 0, 0
                If v = mz.empty Then
                    n = l + r + u + d
                    FILLMAZECELL j, i, mz.empty, (l = mz.filled), (r = mz.filled), (u = mz.filled), (d = mz.filled)
                    If r = mz.empty Or l = mz.empty Then FILLMAZECELL j, i, mz.empty, FALSE, FALSE, OLD, OLD
                    If n < -2 Then FILLMAZECELL j, i, mz.empty, FALSE, FALSE, FALSE, FALSE
                End If
            Next
        Next
        GETMAZECELL digger.startx, digger.starty, cx, cy
        FILLMAZECELL cx, cy, mz.empty, FALSE, FALSE, OLD, OLD
        GETMAZECELL bonus.x, bonus.y, cx, cy
        FILLMAZECELL cx, cy, mz.empty, FALSE, FALSE, OLD, OLD
        For i = 0 To mazey - 1
            For j = 0 To mazex - 1
                SCANMAZECELL j, i, v, 0, 0, 0, 0
                If v = mz.empty Then DRAWHOLE j, i
                a$ = InKey$
            Next
        Next
        INITDIGGER
    End If
End Sub

Sub LOADLEVIDX
    Restore DataLevidx
    Read c
    For i = 1 To c
        Read levidx(i)
    Next
End Sub

Sub LOADSCORES (file$, scorebuf() As SCORETYPE)
    Open hiscorefile$ For Binary As #1
    For i = 0 To hiscorec - 1
        Get #1, , hiscore(i)
    Next
    Close #1
End Sub

Sub MOVEBAGS
    For i = bagc To 1 Step -1
        Select Case bag(i).mode
            Case bagm.normal
                GETMAZECELL bag(i).x, bag(i).y, mx, my
                SCANMAZECELL mx, my + 1, f, 0, 0, 0, 0
                GETCELLCOORDS mx, my, bx, by
                If f <> mz.filled And bag(i).x = bx And bag(i).y = by Then
                    bag(i).mode = bagm.swinging
                    bag(i).misc = 0
                    FILLMAZECELL mx, my, mz.empty, OLD, OLD, OLD, FALSE
                End If
            Case bagm.swinging
                ERASEPIC bag(i).x, bag(i).y, bag(i).pic
                Select Case bag(i).misc Mod 3
                    Case 0: bag(i).pic.sequence = ani.bagleft
                    Case 1: bag(i).pic.sequence = ani.bag
                    Case 2: bag(i).pic.sequence = ani.bagright
                End Select
                bag(i).misc = bag(i).misc + 1
                If bag(i).misc > 6 Then
                    bag(i).mode = bagm.falling
                    bag(i).pic.sequence = ani.bagfall
                    GETMAZECELL bag(i).x, bag(i).y, 0, bag(i).fally
                    For B = 0 To 4: DRAWIMG bag(i).x - 5, bag(i).y + 12 - B * diggerspeedy, iblob.up, FALSE: Next
                End If
                DRAWPIC bag(i).x, bag(i).y, bag(i).pic, TRUE
                REDRAW bag(i).x, bag(i).y, emerald(), emeraldc
                PLAYSOUND snd.bagswing
            Case bagm.falling
                'erase bag and dig through soil under it.
                ERASEPIC bag(i).x, bag(i).y, bag(i).pic
                For B = 0 To 2
                    DRAWIMG bag(i).x - 5, bag(i).y + 12 - B * diggerspeedy, iblob.up, FALSE
                Next

                'move bag
                bag(i).y = bag(i).y + diggerspeedy * 2
                If BOXCOLL(digger.x, digger.y, imgw, imgh, bag(i).x, bag(i).y, imgw, imgh) Then
                    digger.mode = dgr.falling
                    ERASEPIC digger.x, digger.y, digger.pic
                    digger.pic.sequence = ani.dgrdie
                    digger.pic.frame = 0
                    digger.x = bag(i).x
                    digger.y = bag(i).y
                    gamestate = gs.killed
                End If

                'check for landing
                GETMAZECELL bag(i).x, bag(i).y, bx, by
                SCANMAZECELL bx, by + 1, v, 0, 0, 0, 0
                FILLMAZECELL bx, by, mz.empty, OLD, OLD, 2 * (by = bag(i).fally), 2 * (v = mz.filled)
                f = TRUE
                If v = mz.filled Then
                    PLAYSOUND snd.baglanding
                    If digger.x = bag(i).x And digger.y = bag(i).y Then
                        PLAYSOUND snd.dead
                        digger.mode = dgr.dead
                    End If
                    If by - bag(i).fally > 1 Then
                        GETMAZECELL bag(i).x, bag(i).y, x, y
                        ADDOBJ newgold, x, y
                        f = FALSE
                    Else
                        bag(i).mode = bagm.normal
                        bag(i).pic.sequence = ani.bag
                    End If
                End If

                'check for enemy killing
                For j = 1 To enemyc
                    If BOXCOLL(bag(i).x, bag(i).y, imgw, imgh, enemy(j).x, enemy(j).y, imgw, imgh) And enemy(j).mode <> enm.dead Then
                        ' if bag is falling, enemy is falling with it, else ...
                        If f And bag(i).mode <> bagm.normal Then
                            enemy(j).mode = enm.dying
                            ERASEPIC enemy(j).x, enemy(j).y, enemy(j).pic
                            enemy(j).y = bag(i).y
                            enemy(j).x = bag(i).x ' <== if not, enemy can corrupt ground
                            If enemy(j).mode = enm.nobbin Then
                                enemy(j).pic.sequence = ani.nobbindie
                            ElseIf enemy(j).mode = enm.hobbin Then
                                enemy(j).pic.sequence = enm.nobbin
                            End If
                            enemy(j).pic.frame = 0
                            DRAWPIC enemy(j).x, enemy(j).y, enemy(j).pic, TRUE
                        Else
                            ' ... else enemy is dead
                            enemy(j).mode = enm.dead
                            enemy(j).tdead.starttime = Timer: enemy(j).tdead.interval = .5
                            ERASEPIC enemy(j).x, enemy(j).y, enemy(j).pic
                            enemy(j).y = bag(i).y
                        End If
                    End If
                Next

                If f Then
                    DRAWPIC digger.x, digger.y, digger.pic, TRUE
                    DRAWPIC bag(i).x, bag(i).y, bag(i).pic, FALSE
                    REDRAW bag(i).x, bag(i).y, emerald(), emeraldc
                Else
                    Swap bag(i), bag(bagc)
                    bagc = bagc - 1
                    MOVEGOLD
                End If
            Case bagm.left, bagm.right
                moveit = TRUE
                If bag(i).mode = bagm.left Then dx = -diggerspeedx Else dx = diggerspeedx
                ERASEPIC bag(i).x, bag(i).y, bag(i).pic

                ' if collides to digger or enemy, don't move
                If BOXCOLL(bag(i).x + dx, bag(i).y, cellw, cellh, digger.x, digger.y, imgw, imgh) And digger.x * Sgn(dx) > (bag(i).x + dx) * Sgn(dx) Then moveit = FALSE
                For j = 1 To enemyc
                    If BOXCOLL(bag(i).x + dx, bag(i).y, cellw, cellh, enemy(j).x, enemy(j).y, imgw, imgh) And enemy(j).mode <> bagm.dead Then moveit = FALSE
                Next

                If moveit = TRUE Then
                    If dx > 0 Then For j = 0 To 10 Step diggerspeedx: DRAWIMG bag(i).x - j + 3, bag(i).y - 1, iblob.left, FALSE: Next Else For j = 0 To 10 Step diggerspeedx: DRAWIMG bag(i).x + imgw - 8 - j + 3, bag(i).y - 1, iblob.right, FALSE: Next
                    bag(i).x = bag(i).x + dx

                    ' check whether shift has been done
                    GETMAZECELL bag(i).x, bag(i).y, bgx, bgy
                    GETCELLCOORDS bgx, bgy, bgx0, bgy0
                    If bag(i).x = bgx0 Then
                        bag(i).mode = bagm.normal
                        bag(i).pic.sequence = ani.bag
                        SCANMAZECELL bgx, bgy + 1, v, 0, 0, 0, 0
                        FILLMAZECELL bgx, bgy, FALSE, (Not (dx > 0)) * 2, (Not (dx < 0)) * 2, OLD, OLD
                        If v <> mz.filled Then
                            bag(i).mode = bagm.falling
                            bag(i).fally = bgy
                        End If
                    End If
                    DRAWPIC bag(i).x, bag(i).y, bag(i).pic, FALSE
                    REDRAW bag(i).x - dx, bag(i).y, emerald(), emeraldc
                    REDRAW bag(i).x, bag(i).y, emerald(), emeraldc
                    PLAYSOUND snd.bagshift
                Else
                    If bag(i).mode = bagm.left Then
                        bag(i).mode = bagm.right
                        bag(i).pic.sequence = ani.bagright
                    Else
                        bag(i).mode = bagm.left
                        bag(i).pic.sequence = ani.bagleft
                    End If
                    DRAWPIC bag(i).x, bag(i).y, bag(i).pic, FALSE
                    REDRAW bag(i).x, bag(i).y, emerald(), emeraldc
                End If
        End Select
    Next
End Sub

Sub MOVEDIGGER (dx, dy)
    ' *** check for out of bounds *** '
    PLAYSOUND snd.dig
    newx = digger.x + diggerspeedx * dx
    newy = digger.y + diggerspeedy * dy
    GETMAZECELL newx, newy, nx, ny
    GETCELLCOORDS nx, ny, n1x, n1y
    If nx < 0 Or ny < 0 Or ((nx >= mazex - 1 And newx <> n1x And dx > 0) Or (ny >= mazey - 1 And newy <> n1y And dy > 0)) Then Exit Sub

    ' *** adjust for maze cells *** '
    If ((n1y <> newy And dx <> 0) Or (n1x <> newx And dy <> 0)) And (dx <> digger.dx Or dy <> digger.dy) Then
        ' *** if not in cell, move it in currently used direction
        dx = digger.dx
        dy = digger.dy
        amode = digger.pic.sequence
    Else
        ' *** if in cell, change direction *** '
        If dx < 0 Then digger.mode = dgr.left: amode = ani.dgrleft
        If dx > 0 Then digger.mode = dgr.right: amode = ani.dgrright
        If dy < 0 Then digger.mode = dgr.up: amode = ani.dgrup
        If dy > 0 Then digger.mode = dgr.down: amode = ani.dgrdown
        If Not digger.eye Then amode = amode + anid.withouteye
    End If
 
    ' *** calculate new position *** '
    newx = digger.x + diggerspeedx * dx
    newy = digger.y + diggerspeedy * dy

    ' *** check gold bags *** '
    If CHECKBAGSHIFT(newx, newy, dx) Then Exit Sub

    digger.dx = dx
    digger.dy = dy
 
    ' *** adjust maze *** '
    GETMAZECELL newx - 1, newy, clx, cy
    GETMAZECELL newx, newy - 1, cx, cuy
    GETMAZECELL digger.x - 1, digger.y, olx, oy
    GETMAZECELL digger.x, digger.y - 1, ox, ouy
    If dx < 0 Then
        If clx <> olx Then FILLMAZECELL clx + 1, cy, mz.empty, FALSE, OLD, OLD, OLD
        SCANMAZECELL clx, cy, v, 0, 0, 0, 0
        FILLMAZECELL clx, cy, (2 * (olx <> clx) + 1) * mz.half * Abs(v), OLD, FALSE, OLD, OLD
    End If
    If dx > 0 Then
        If ox <> cx Then FILLMAZECELL cx, cy, mz.empty, OLD, FALSE, OLD, OLD
        SCANMAZECELL cx + 1, cy, v, 0, 0, 0, 0
        FILLMAZECELL cx + 1, cy, (2 * (ox <> cx) + 1) * mz.half * Abs(v), FALSE, OLD, OLD, OLD
    End If
    If dy < 0 Then
        If cuy <> ouy Then FILLMAZECELL cx, cuy + 1, mz.empty, OLD, OLD, FALSE, OLD
        SCANMAZECELL cx, cuy, v, 0, 0, 0, 0
        FILLMAZECELL cx, cuy, (2 * (ouy <> cuy) + 1) * mz.half * Abs(v), OLD, OLD, OLD, FALSE
    End If
    If dy > 0 Then
        If cy <> oy Then FILLMAZECELL cx, cy, mz.empty, OLD, OLD, OLD, FALSE
        SCANMAZECELL cx, cy + 1, v, 0, 0, 0, 0
        FILLMAZECELL cx, cy + 1, (2 * (oy <> cy) + 1) * mz.half * Abs(v), OLD, OLD, FALSE, OLD
    End If
    'DRAWMAZE

    ' *** dig through the ground *** '
    Select Case digger.mode
        Case dgr.left: DRAWIMG newx - 5, newy - 1, iblob.left, FALSE
        Case dgr.right: DRAWIMG newx + 10 + 1, newy - 1, iblob.right, FALSE
        Case dgr.up: DRAWIMG newx - 5, newy - 3, iblob.up, FALSE
        Case dgr.down: DRAWIMG newx - 5, newy + 12, iblob.down, FALSE
    End Select

    ERASEPIC digger.x, digger.y, digger.pic
    digger.x = newx
    digger.y = newy
    digger.pic.sequence = amode
    DRAWPIC digger.x, digger.y, digger.pic, TRUE

    CHECKEMERALDS digger.x, digger.y, TRUE
    CHECKGOLD digger.x, digger.y, TRUE
End Sub

Sub MOVEENEMIES
    Dim w(3)
    Dim delta(3, 1)
    Const xd = 0, yd = 1
    delta(0, xd) = -1
    delta(1, xd) = 1
    delta(2, yd) = -1
    delta(3, yd) = 1
    For i = enemyc To 1 Step -1
        If (enemy(i).stpx = enemy(i).x And enemy(i).stpy = enemy(i).y) And gamestate = gs.play And enemy(i).mode <> enm.dying Then
            If TEVENT(enemy(i).thob) Then
                enemy(i).thob.starttime = Timer
                If Not bonusmode Then
                    If enemy(i).mode = enm.nobbin Then
                        ERASEPIC enemy(i).x, enemy(i).y, enemy(i).pic
                        enemy(i).pic.sequence = ani.hobbinleft
                        enemy(i).pic.frame = 0
                        enemy(i).mode = enm.hobbin
                        enemy(i).chaseflee = TRUE
                        enemy(i).thob.interval = tim.hobbin
                    Else
                        ERASEPIC enemy(i).x, enemy(i).y, enemy(i).pic
                        enemy(i).pic.sequence = ani.nobbin
                        enemy(i).pic.frame = 0
                        enemy(i).mode = enm.nobbin
                        enemy(i).thob.interval = tim.nobbin
                    End If
                End If
            End If
            GETMAZECELL enemy(i).x, enemy(i).y, cx, cy
            If enemy(i).mode = enm.nobbin Then
                If Int(Rnd * 1000) < 70 Or (cx = enemy(i).trgx And cy = enemy(i).trgy) Or enemy(i).chaseflee = TRUE Then
                    If Int(Rnd * 100) < (20 + 15 * (enemy(i).chaseflee = TRUE)) And Not bonusmode Then
                        enemy(i).chaseflee = FALSE
                        GETRANDOMCELL dx, dy
                        enemy(i).trgx = dx
                        enemy(i).trgy = dy
                    Else
                        enemy(i).chaseflee = TRUE
                        GETMAZECELL digger.x, digger.y, dx, dy
                        If bonusmode Then
                            temp = GETPATH(cx, cy, dx, dy, pl0)
                            If pl0 <> -1 Then
                                SCANMAZECELL cx, cy, 0, w(0), w(1), w(2), w(3)
                                f = FALSE
                                Do
                                    For j = 0 To 3
                                        If w(j) = FALSE Then
                                            SCANMAZECELL cx + delta(j, xd), cy + delta(j, yd), v, 0, 0, 0, 0
                                            If v = mz.empty Then
                                                temp = GETPATH(dx, dy, cx + delta(j, xd), cy + delta(j, yd), PL)
                                                If PL > pl0 Then
                                                    If Int(Rnd * 3) = 0 Then
                                                        dx = cx + delta(j, xd)
                                                        dy = cy + delta(j, yd)
                                                        Exit Do
                                                    End If
                                                    f = TRUE
                                                End If
                                            End If
                                        End If
                                    Next ' j
                                    If Not f Then
                                        enemy(i).trgx = cx
                                        enemy(i).trgy = cy
                                        Exit Do
                                    End If
                                Loop
                            Else
                                GETRANDOMCELL dx, dy
                                enemy(i).trgx = dx
                                enemy(i).trgy = dy
                                enemy(i).chaseflee = FALSE
                            End If
                        Else
                            enemy(i).chaseflee = TRUE
                        End If
                    End If
                End If
                FILLMAZECELL cx, cy, mz.empty, OLD, OLD, OLD, OLD
                SCANMAZECELL dx, dy, v, 0, 0, 0, 0
                Do
                    If enemy(i).chaseflee = TRUE Then
                        If v <> mz.empty Then
                            If digger.dx <> 0 Then
                                dx = dx + 1
                            ElseIf digger.dy <> 0 Then
                                dy = dy + 1
                            End If
                        End If
                            
                        r = GETPATH(cx, cy, dx, dy, 0)
                        enemy(i).trgx = dx
                        enemy(i).trgy = dy
                    Else
                        r = GETPATH(cx, cy, enemy(i).trgx, enemy(i).trgy, 0)
                    End If
                    If r = -1 Then
                        GETRANDOMCELL dx, dy
                        enemy(i).chaseflee = FALSE
                        enemy(i).trgx = dx
                        enemy(i).trgy = dy
                    Else
                        Exit Do
                    End If
                Loop
                Select Case r
                    Case 0: cx = cx - 1
                    Case 1: cx = cx + 1
                    Case 2: cy = cy - 1
                    Case 3: cy = cy + 1
                End Select
            ElseIf enemy(i).mode = enm.hobbin Then ' it's hobbin
                d = enemy(i).dir
                FILLMAZECELL cx, cy, FALSE, (d <> 1) * 2, (d <> 2) * 2, (d <> 3) * 2, (d <> 4) * 2
                Do
                    enemy(i).chaseflee = Int(Rnd * 200) < 20 - 160 * enemy(i).chaseflee
                    If enemy(i).chaseflee = TRUE Then
                        rx = Abs(digger.x - enemy(i).x)
                        ry = Abs(digger.y - enemy(i).y)
                        btime! = Timer
                        Do
                            enemy(i).dir = Int(Rnd * 4) + 1
                            Select Case enemy(i).dir
                                Case 1, 2:
                                    If Not ((enemy(i).dir = 1 And cx = 0) Or (enemy(i).dir = 2 And cx = mazex - 1)) Then
                                        If (Abs(digger.x - (enemy(i).x - ((enemy(i).dir = 2) * 2 + 1) * diggerspeedx)) - rx) * Sgn(bonusmode * 2 + 1) < 0 Then Exit Do
                                    End If
                                Case 3, 4:
                                    If Not ((enemy(i).dir = 3 And cy = 0) Or (enemy(i).dir = 4 And cy = mazey - 1)) Then
                                        If (Abs(digger.y - (enemy(i).y - ((enemy(i).dir = 4) * 2 + 1) * diggerspeedy)) - ry) * Sgn(bonusmode * 2 + 1) < 0 Then Exit Do
                                    End If
                            End Select
                            If btime! + .1 < Timer Then
                                enemy(i).chaseflee = FALSE
                                Exit Do
                            End If
                        Loop
                    Else
                        If enemy(i).dir = 0 Or Int(Rnd * 5) = 2 Then enemy(i).dir = Int(Rnd * 4) + 1
                    End If
                    Select Case enemy(i).dir
                        Case 1: If cx = 0 Then enemy(i).dir = 0 Else cx = cx - 1
                        Case 2: If cx = mazex - 1 Then enemy(i).dir = 0 Else cx = cx + 1
                        Case 3: If cy = 0 Then enemy(i).dir = 0 Else cy = cy - 1
                        Case 4: If cy = mazey - 1 Then enemy(i).dir = 0 Else cy = cy + 1
                    End Select
                    d = enemy(i).dir
                    FILLMAZECELL cx, cy, OLD, (d <> 2) * 2, (d <> 1) * 2, (d <> 4) * 2, (d <> 3) * 2
                Loop Until enemy(i).dir <> 0
            End If
            GETCELLCOORDS cx, cy, enemy(i).stpx, enemy(i).stpy
        End If
        If enemy(i).mode = enm.dead Then
            If TEVENT(enemy(i).tdead) Then
                ERASEPIC enemy(i).x, enemy(i).y, enemy(i).pic
                REDRAWOBJS gold(), goldc, FALSE
                REDRAWOBJS bag(), bagc, FALSE
                Swap enemy(i), enemy(enemyc)
                enemyc = enemyc - 1
                ADDSCORE monstercost
            Else
                DRAWPIC enemy(i).x, enemy(i).y, enemy(i).pic, FALSE
                REDRAWOBJS gold(), goldc, FALSE
            End If
        Else
            If enemy(i).mode <> enm.dying And enemy(i).mode <> enm.dead Then
                nx = enemy(i).x + diggerspeedx * Sgn(enemy(i).stpx - enemy(i).x)
                ny = enemy(i).y + diggerspeedy * Sgn(enemy(i).stpy - enemy(i).y)
                ERASEPIC enemy(i).x - 1, enemy(i).y, enemy(i).pic
                If enemy(i).mode = enm.hobbin Or Not CHECKBAGSHIFT(nx, ny, Sgn(enemy(i).stpx - enemy(i).x)) Then
                    If enemy(i).mode = enm.hobbin Then
                        For j = bagc To 1 Step -1
                            If bag(j).mode <> bagm.falling And BOXCOLL(nx, ny, imgw, imgh, bag(j).x + 1, bag(j).y + 1, imgw - 2, imgh - 2) Then
                                ERASEPIC bag(j).x, bag(j).y, bag(j).pic
                                Swap bag(bagc), bag(j)
                                bagc = bagc - 1
                            End If
                        Next
                        Select Case enemy(i).dir
                            Case 1: DRAWIMG nx - 5, ny - 1, iblob.left, FALSE
                            Case 2: DRAWIMG nx + 10 + 1, ny - 1, iblob.right, FALSE
                            Case 3: DRAWIMG nx - 5, ny - 3, iblob.up, FALSE
                            Case 4: DRAWIMG nx - 5, ny + 12, iblob.down, FALSE
                        End Select
                        If nx < enemy(i).x Then enemy(i).pic.sequence = ani.hobbinleft
                        If nx > enemy(i).x Then enemy(i).pic.sequence = ani.hobbinright
                    End If
                    CHECKGOLD nx, ny, FALSE
                    CHECKEMERALDS nx, ny, FALSE
                    enemy(i).x = nx
                    enemy(i).y = ny
                    ANIMATE enemy(i).x, enemy(i).y, enemy(i).pic, FALSE
                End If
                DRAWPIC enemy(i).x - 1, enemy(i).y, enemy(i).pic, FALSE
            End If
        End If
    Next
End Sub

Sub MOVEEYE
    ERASEPIC eye.x, eye.y, eye.pic
    REDRAW eye.x, eye.y, bag(), bagc
    REDRAW eye.x, eye.y, emerald(), emeraldc
    REDRAW eye.x, eye.y, gold(), goldc
    ANIMATE eye.x, eye.y, eye.pic, FALSE
    If eye.mode = eyem.normal Then
        eye.x = eye.x + eye.dx * diggerspeedx * 2
        eye.y = eye.y + eye.dy * diggerspeedy * 2
        For i = enemyc To 1 Step -1
            If BOXCOLL(enemy(i).x, enemy(i).y, imgw, imgh, eye.x, eye.y, eyew, eyeh) Then
                ERASEPIC enemy(i).x - 1, enemy(i).y, enemy(i).pic
                eye.pic.sequence = ani.expl
                eye.pic.frame = 0
                eye.mode = eyem.expl
                ADDSCORE monstercost
                Swap enemy(i), enemy(enemyc)
                enemyc = enemyc - 1
                PLAYSOUND snd.hit
                PLAYSOUND snd.killenemy
                Exit For
            End If
        Next
        GETMAZECELL eye.x - (eye.dx > 0) * (diggerspeedx + eyew + 5), eye.y - (eye.dy > 0) * (diggerspeedy + eyeh + 5), x, y
        SCANMAZECELL x, y, i, 0, 0, 0, 0
        If i = mz.filled Then
            PLAYSOUND snd.hit
            eye.pic.sequence = ani.expl
            eye.pic.frame = 0
            eye.mode = eyem.expl
        End If
    Else
        If eye.pic.frame = anim(ani.expl, framec) - 1 Then eye.use = FALSE
    End If
    If eye.use Then DRAWPIC eye.x, eye.y, eye.pic, FALSE
End Sub

Sub MOVEGOLD
    For i = goldc To 1 Step -1
        If gold(i).pic.frame <> 2 Then
            ANIMATE gold(i).x, gold(i).y, gold(i).pic, TRUE
            REDRAW gold(i).x, gold(i).y, bag(), bagc
            DRAWPIC gold(i).x, gold(i).y, gold(i).pic, FALSE
            REDRAW gold(i).x, gold(i).y, emerald(), emeraldc
        End If
        GETMAZECELL gold(i).x, gold(i).y, x, y
        SCANMAZECELL x, y + 1, v, 0, 0, 0, 0
        If v <> mz.filled Then gold(i).t.interval = 5
        If TEVENT(gold(i).t) Then
            ERASEPIC gold(i).x, gold(i).y, gold(i).pic
            REDRAW gold(i).x, gold(i).y, bag(), bagc
            REDRAW gold(i).x, gold(i).y, emerald(), emeraldc
            Swap gold(i), gold(goldc)
            goldc = goldc - 1
        End If
    Next
End Sub

Sub NEWGAME
    Dim tbags As TIMEINT
    Dim tstat As TIMEINT
    Dim tdgra As TIMEINT
    Dim tgold As TIMEINT
    Dim tbon As TIMEINT
    Dim tenem As TIMEINT
    Dim teani As TIMEINT
    Dim tenew As TIMEINT
    RESTOREFIELD
    gameresult = 0
    tbon.interval = .1
    tbags.interval = .1
    tstat.interval = .05
    tdgra.interval = .08
    tgold.interval = .1
    tcons.interval = 1
    tenem.interval = .045
    teani.interval = .1
    tenew.interval = 3
    tim.eye = 1
    digger.lives = 0
    digger.score = 0
    digger.teye.interval = tim.eye
    NEXTLEVEL
    Do
        ADDSCORE 0
        GETINPUTS
        If gamestate = gs.newgame Or gamestate = gs.quit Then Exit Sub
        If gamestate <> gs.killed Then
            If emeraldc = 0 Then
                NEXTLEVEL
                If gamestate = gs.quit Then Exit Sub
            End If
            If bonusmode Then
                s! = (bonus.t.interval - (Timer - bonus.t.starttime)) * 2
                If s! < 9 And Abs(Int(s!) - s!) < .2 Then SETPAL s! Mod 2
            End If
            If TEVENT(tenew) Then
                If enemyc < nest.COUNT And Not bonusmode Then ADDOBJ newnobbin, nest.x, nest.y
                'REDRAWOBJS emerald(), emerc, FALSE
            End If
            tenem.interval = .045
            If TEVENT(tenem) Then
                MOVEENEMIES
                If eye.use Then MOVEEYE
                CHECKKILL
            End If
            If TEVENT(bonus.t) Then
                If bonusmode Then
                    bonusmode = FALSE
                    SETPAL pal.normal
                    bonus.t.starttime = Timer
                    bonus.iwait = bonus.iwait + 5
                    bonus.t.interval = bonus.iwait
                Else
                    bonus.t.interval = bonus.ilen
                    bonus.t.starttime = Timer
                    bonus.use = TRUE
                End If
            End If
            If TEVENT(tbon) Then CHECKBONUS digger.x, digger.y, TRUE
            If TEVENT(tcons) Then consemer = 0 ' <== remove emerald octave
        Else
            tdgra.interval = .14
            If digger.pic.frame = anim(ani.dgrdie, framec) - 1 Then
                If Not RESTART Then Exit Sub
                tdgra.interval = .08
            End If
        End If
        If TEVENT(tgold) Then
            MOVEGOLD
            If gamestate <> gs.play Then DRAWPIC digger.x, digger.y, digger.pic, FALSE
        End If
        If TEVENT(tbags) Then MOVEBAGS
        If TEVENT(tstat) Then
            SHOWSCORE digger.score, digger.lives
        End If
        If TEVENT(tdgra) And digger.mode <> dgr.falling Then
            ANIMATE digger.x, digger.y, digger.pic, TRUE
        End If
    Loop
End Sub

Sub NEXTLEVEL
    curlevel = curlevel + 1
    LOADLEVEL curlevel
End Sub

Function NUMTOSTR$ (n As Long)
    NUMTOSTR = LTrim$(RTrim$(Str$(n)))
End Function

Function OPENLEVEL (idx$)
    If levelpack$ = "" Then
        Restore DataLevels
        Do
            Read s$
            s$ = LTrim$(RTrim$(s$))
            If s$ = "_end" Then
                OPENLEVEL = FALSE
                Exit Function
            End If
        Loop Until s$ = "_mine #" + idx$
        OPENLEVEL = TRUE
    Else
        'read from file
        Open levelpack$ For Input As #1
        Do
            Line Input #1, s$
            s$ = LTrim$(RTrim$(s$))
            If s$ = "_end" Then
                OPENLEVEL = FALSE
                Close #1
                Exit Function
            End If
        Loop Until s$ = "_mine #" + idx$
        OPENLEVEL = TRUE
    End If
End Function

Sub PLAYSOUND (sndcode)
    If nosound Then Exit Sub
    Select Case sndcode
        'CASE snd.dig: SOUND 37, RND * .03 + .01
        Case snd.killenemy: For i = 85 To 100: Sound ((i - 84) ^ 3) / 40 + 37 + (i Mod 3) * 40, i / 400: Next
        Case snd.shoot: Sound 1000 + Rnd * 1000 + 37, .3
        Case snd.hit: Sound Rnd * 1000 + 237, Rnd * .04 + .04
        Case snd.dead: For j = 0 To 14: Sound Abs(Sin(j / 5)) * 2700 + 37, .21: Next
        Case snd.bagshift: Sound Rnd * 100 + 37, Rnd * .04 + .04
        Case snd.baglanding: For j = 1 To 10: Sound Rnd * 200 + 40, Rnd * .17: Next
        Case snd.emerald: a = Rnd * 1400: For i = 1 To 70: Sound i + 37 + (i Mod 3) * 100 + 8000 + a, i / 2800: Next
        Case snd.gold: a = 30: For i = 1 To 10: a = a * 1.5: Sound a + Rnd * 200 + 400, .1: Next
    End Select
End Sub

Sub QUIT
    Screen 0
    Width 80, 25
    Print "QDigger v1.4b, 2002-2008"
    Print "Better luck next time!"
    End
End Sub

Function READLEVELSTR$
    If levelpack$ = "" Then
        Read s$
        READLEVELSTR$ = s$
    Else
        Line Input #1, s$
        READLEVELSTR$ = s$
    End If
End Function

Sub REDRAW (x, y, obj() As PICKUPTYPE, objc)
    For j = 1 To objc
        If BOXCOLL(x, y, cellw, cellh, obj(j).x, obj(j).y, imgw, imgh) Then
            DRAWPIC obj(j).x, obj(j).y, obj(j).pic, FALSE
            Exit Sub
        End If
    Next
End Sub

Sub REDRAWOBJS (arr() As PICKUPTYPE, n, maskfl)
    For i = 1 To n
        DRAWPIC arr(i).x, arr(i).y, arr(i).pic, Not maskfl
    Next
End Sub

Function RESTART
    DELAY 1
    While InKey$ <> "": Wend
    digger.lives = digger.lives - 1
    If digger.lives < 0 Then
        digger.lives = 0
        RESTART = FALSE
        gameresult = gr.gameover
        Exit Function
    End If
    If bonus.use = FALSE Then bonus.t.starttime = Timer
    For i = 1 To enemyc
        ERASEPIC enemy(i).x, enemy(i).y, enemy(i).pic
    Next
    For i = bagc To 1 Step -1
        If bag(i).mode = bagm.falling Then
            ERASEPIC bag(i).x, bag(i).y, bag(i).pic
            Swap bag(i), bag(bagc)
            bagc = bagc - 1
        End If
    Next
    enemyc = 0
    If eye.use Then
        ERASEPIC eye.x, eye.y, eye.pic
        eye.use = FALSE
    End If
    ERASEPIC digger.x, digger.y, digger.pic
    INITDIGGER
    gamestate = gs.play
    REDRAWOBJS gold(), goldc, TRUE
    REDRAWOBJS bag(), bagc, TRUE
    REDRAWOBJS emerald(), emeraldc, TRUE
    While Len(InKey$) <> 0: Wend
    RESTART = TRUE
End Function

Sub RESTOREFIELD
    View (f.x, f.y)-(f.x + f.w - 1, f.y + f.h - 1)
End Sub

Sub SCANMAZECELL (cx, cy, inner, lw, rw, uw, dw)
    cx2 = cx * 2
    cy2 = cy * 2
    If cx < 0 Or cy < 0 Or cx > mazex - 1 Or cy > mazey - 1 Then
        inner = mz.filled
        lw = TRUE
        rw = TRUE
        uw = TRUE
        dw = TRUE
    Else
        inner = maze(cx2, cy2)
        lw = maze(cx2 - 1, cy2)
        rw = maze(cx2 + 1, cy2)
        uw = maze(cx2, cy2 - 1)
        dw = maze(cx2, cy2 + 1)
    End If
End Sub

Sub SETPAL (palmode As Integer)
    Select Case palmode
        Case pal.normal: Color , 0
        Case pal.bonus: Color , 1
    End Select
End Sub

'
' this function checks whether bag #num can be moved in (dir) direction.
' can't move (FALSE) if:
'   bag's direction (dir) = 0
'   bag is on the end of the maze
'   bag collides with the digger or an enemy
' else
'   accept (TRUE); change bag mode and params
'
Function SHIFTBAG (num, dir)
    If dir = 0 Then SHIFTBAG = FALSE: Exit Function

    GETMAZECELL bag(num).x, bag(num).y, bx, by
    If bx = 0 Or bx = mazex - 1 Then SHIFTBAG = FALSE: Exit Function

    If BOXCOLL(bag(num).x + dir, bag(num).y, cellw, cellh, digger.x, digger.y, imgw, imgh) Then SHIFTBAG = FALSE: Exit Function
    For i = 1 To bagc
        If i <> num Then
            If BOXCOLL(bag(num).x + dir, bag(num).y, cellw, cellh, bag(i).x, bag(i).y, cellw - 1, imgh) And bag(i).mode = bagm.normal And bag(num).x * Sgn(dir) < bag(i).x * Sgn(dir) Then
                If SHIFTBAG(i, dir) = FALSE Then SHIFTBAG = FALSE: Exit Function
            End If
        End If
    Next

    SHIFTBAG = TRUE
    GETMAZECELL bag(num).x, bag(num).y, cx, cy
    FILLMAZECELL cx, cy, FALSE, OLD, OLD, OLD, OLD
    If dir < 0 Then
        bag(num).mode = bagm.left
        bag(num).pic.sequence = ani.bagleft
        GETCELLCOORDS bx, by, x, y
        If x = bag(num).x And y = bag(num).y Then d = 1 Else d = 0
        GETCELLCOORDS bx - d, by, bag(num).dx, 0
    Else
        bag(num).mode = bagm.right
        bag(num).pic.sequence = ani.bagright
        GETCELLCOORDS bx + 1, by, bag(num).dx, 0
    End If
End Function

Sub SHOOT (dx, dy)
    If eye.use Then Exit Sub
    eye.x = digger.x - 5 * (dx = 0 And dy < 0) - imgw * (dx > 0) + eyew * (dx < 0)
    eye.y = digger.y - 2 * (dy = 0) - imgh * (dy > 0) + eyeh * (dy < 0)
    eye.dx = dx
    eye.dy = dy
    eye.use = TRUE
    eye.mode = eyem.normal
    eye.pic.sequence = ani.fire
    eye.pic.frame = 0
    PLAYSOUND snd.shoot
End Sub

Sub SHOWHISCORE
    cw = 8: ch = 14
    Dim buf(IMGSIZE(cw * 22 + 1 + 16 + 8 + 16 + 8, 117 + 16 + 8))
    View
    Get (cw * 10 - 16 - 8 - 8, 45 - 16)-(cw * 10 - 16 - 8 - 8 + cw * 22 + 1 + 16 + 8 + 16 + 8, 45 - 16 + 117 + 16 + 8), buf()
    Line (cw * 10 - 16 - 8 - 8, 45 - 16)-Step(cw * 22 + 1 + 16 + 8 + 16 + 8, 117 + 16 + 8), 0, BF
    Line (cw * 10 - 16 - 8 - 8 + 2, 45 + 2 - 16)-Step(cw * 22 + 8 + 1 + 16 + 16 + 8 - 4, 117 + 16 - 4 + 8), 1, B
    Line (127 - 16, 64 - 8)-Step(87, 0), 2
    Locate 7, 15: Print "HIGH SCORES"
    For i = 0 To hiscorec - 1
        If Left$(hiscore(i).uname, 1) = Chr$(0) And hiscore(i).score = 0 Then Exit For
        Locate 10 + i, 11: Print hiscore(i).uname; " "; NUMTOSTR$(hiscore(i).score)
    Next
    While InKey$ <> "": Wend
    While InKey$ = "": Wend
    Put (cw * 10 - 16 - 8 - 8, 45 - 16), buf(), PSet
    RESTOREFIELD
End Sub

Sub SHOWSCORE (score As Long, lives As Integer)
    Dim ind(1 To 8) As Integer
    Dim im(0 To 10, 0 To 2) As Integer
    a$ = LTrim$(RTrim$(Str$(score)))
    a$ = String$(7 - Len(a$), "0") + a$
    For i = 1 To Len(a$)
        ind(i) = Asc(Mid$(a$, i, 1)) - Asc("0") + img0
    Next
    indc = Len(a$)

    For i = 0 To 10
        GETIMAGE anim(ani.stat, img1) + i, im(i, 1), im(i, 2), im(i, 0)
    Next

    View (0, 0)-(f.w + f.x - 1, 14)
    x = f.x
    For i = 1 To indc
        Put (x, 0), graph(im(ind(i), 0)), PSet
        x = x + im(ind(i), 1) + 3
    Next
    View (7 * 15 + f.x + 2, 0)-(319, 13)
    GETIMAGE anim(ani.stat, img1) + 10, w, 0, idx
    For i = 0 To lives - 1
        Put (i * (w + 5), 0), graph(idx), PSet
    Next
    Line (lives * (w + 5), 0)-Step(w * 2, 11), 0, BF
    RESTOREFIELD
End Sub

Function TEVENT (t As TIMEINT)
    Dim tmr As Single
    tmr = Timer
    If tmr >= t.starttime + t.interval Or Abs(tmr - t.starttime) > 10000 Then
        t.starttime = Timer
        TEVENT = TRUE
    Else
        TEVENT = FALSE
    End If
End Function

Sub UPDATESCORES
    Open hiscorefile$ For Binary Access Write As #1
    Seek #1, 1
    For i = 0 To hiscorec - 1
        Put #1, , hiscore(i)
    Next
    Close #1
    LOADSCORES hiscorefile, hiscore()
End Sub

Sub WINGAME
    View
    ww = 200 - 2: wh = 65: wx = (320 - ww) / 2 + 9: wy = (200 - wh) / 2 - 2
    Line (wx, wy)-Step(ww, wh), 0, BF
    Line (wx + 1, wy + 1)-Step(ww - 2, wh - 2), 3, B
    Line (wx + 1, wy + 1)-Step(ww - 2, wh - 2), 2, B , &HAAAF
    Locate 12, 17: Print "WELL DONE!"
    Locate 14, 13: Print "you win the game!!"
    While i$ <> Chr$(13) And i$ <> " ": i$ = InKey$: Wend
End Sub

Function fnmax (x, y)
    If x > y Then fnmax = x Else fnmax = y
End Function

