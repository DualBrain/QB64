'-----------------------------------------------------------------------------------------------------
' QB64 game by Cyperium
' https://wiki.qb64.org/wiki/A_Small_Game_Tutorial
'-----------------------------------------------------------------------------------------------------

'-----------------------------------------------------------------------------------------------------
' These are some metacommands and compiler options for QB64 to write modern & type-strict code
'-----------------------------------------------------------------------------------------------------
' This will disable prefixing all modern QB64 calls using a underscore prefix.
$NoPrefix
' Whatever indentifiers are not defined, should default to signed longs (ex. constants and functions).
DefLng A-Z
' All variables must be defined.
Option Explicit
' All arrays must be defined.
Option ExplicitArray
' Array lower bounds should always start from 1 unless explicitly specified.
' This allows a(4) as integer to have 4 members with index 1-4.
Option Base 1
' All arrays should be static by default. Allocate dynamic array using ReDim
'$Static
' This allows the executable window & it's contents to be resized.
$Resize:Smooth
Title "Space 64"
'-----------------------------------------------------------------------------------------------------

Dim asteroidx(100), asteroidy(100), asteroidspeed(100)

Screen 13
FullScreen SquarePixels , Smooth

Dim y As Integer, x As Integer
Dim c As Integer, k As Integer
Dim lives As Integer, explosion As Integer
Dim collected As Integer, numAsteroids As Integer
Dim asteroid As Integer, removeAsteroid As Integer
Dim shipX As Integer, shipY As Integer
Dim expl As Integer, rand As Integer
Dim heart As Integer, heartSpeed As Single, heartX As Integer, heartY As Integer
Dim number As Integer, numberSpeed As Single, numberX As Integer, numberY As Integer
Dim ship As Long, obstacle As Long, life As Long

Data 000,000,000,000,000,000,000,000,000,000
Data 000,000,015,015,015,015,015,000,000,000
Data 000,015,015,015,015,007,007,015,000,000
Data 000,015,015,015,015,015,015,015,015,000
Data 000,015,015,015,015,015,015,015,015,015
Data 000,015,015,015,015,015,015,015,015,000
Data 000,000,015,015,015,015,015,015,000,000
Data 000,000,000,000,000,000,000,000,000,000
Data 000,000,000,000,000,000,000,000,000,000
Data 000,000,000,000,000,000,000,000,000,000

For y = 1 To 10
    For x = 1 To 10

        Read c
        PSet (x, y), c
    Next
Next

ship = NewImage(11, 11, 13)

PutImage (1, 1)-(10, 10), , ship, (1, 1)-(10, 10)

Cls

Data 000,000,000,000,000,000,000,000,000,000
Data 000,000,000,006,006,006,000,000,000,000
Data 000,000,006,006,006,006,006,000,000,000
Data 000,006,012,006,006,006,006,006,000,000
Data 000,006,006,006,006,012,006,006,000,000
Data 000,006,006,006,006,006,006,006,000,000
Data 000,000,006,006,012,006,006,000,000,000
Data 000,000,006,006,006,006,000,000,000,000
Data 000,000,000,006,006,000,000,000,000,000
Data 000,000,000,000,000,000,000,000,000,000

For y = 1 To 10
    For x = 1 To 10

        Read c
        PSet (x, y), c
    Next
Next

obstacle = NewImage(11, 11, 13)

PutImage (1, 1)-(10, 10), , obstacle, (1, 1)-(10, 10)

Cls

Data 000,000,000,000,000,000,000,000,000,000
Data 000,000,004,004,000,004,004,000,000,000
Data 000,004,012,012,004,012,012,004,000,000
Data 000,004,012,012,012,012,012,004,000,000
Data 000,004,012,012,012,012,012,004,000,000
Data 000,004,012,012,012,012,012,004,000,000
Data 000,000,004,012,012,012,004,000,000,000
Data 000,000,000,004,012,004,000,000,000,000
Data 000,000,000,000,004,000,000,000,000,000
Data 000,000,000,000,000,000,000,000,000,000


For y = 1 To 10
    For x = 1 To 10

        Read c
        PSet (x, y), c
    Next
Next

life = NewImage(11, 11, 13)

PutImage (1, 1)-(10, 10), , life, (1, 1)-(10, 10)

Cls

lives = 3

shipX = 10 'we set the x position of the ship to 10 and the y position is set
shipY = 95 'at the middle of the screen (middle of the ship is 5 hence 100-5=95).

Do

    Limit 60
    Cls

    If explosion = 0 Then
        PutImage (shipX, shipY), ship 'let's only display it when explosion = 0

        'we can make some fire behind the ship by randomly setting some red pixels behind it.
        For k = 1 To 10: PSet (shipX - Int(Rnd * 5), shipY + Int(Rnd * 6) + 2), 4: Next
    End If


    'display lives:
    If lives > 0 Then
        For k = 1 To lives
            PutImage (k * 10, 0), life
        Next

    End If

    'display number of numbers collected:
    PrintString (0, 2), LTrim$(Str$(collected))


    If KeyDown(CVI(Chr$(0) + "H")) Then shipY = shipY - 1
    If KeyDown(CVI(Chr$(0) + "P")) Then shipY = shipY + 1
    If KeyDown(CVI(Chr$(0) + "K")) Then shipX = shipX - 1
    If KeyDown(CVI(Chr$(0) + "M")) Then shipX = shipX + 1
    If KeyDown(27) Then End


    If shipX + 10 > 319 Then shipX = 319 - 10
    If shipX < 0 Then shipX = 0
    If shipY + 10 > 199 Then shipY = 199 - 10
    If shipY < 0 Then shipY = 0


    If numAsteroids > 0 Then
        For asteroid = 1 To numAsteroids

            PutImage (asteroidx(asteroid), asteroidy(asteroid)), obstacle

            If explosion = 0 Then 'this is added so that the ship doesn't explode twice (it is invulnerable for a while)

                If shipX + 10 >= asteroidx(asteroid) And shipX <= asteroidx(asteroid) + 10 Then
                    If shipY + 10 >= asteroidy(asteroid) And shipY <= asteroidy(asteroid) + 10 Then


                        explosion = 1
                        lives = lives - 1

                    End If
                End If

            End If

            asteroidx(asteroid) = asteroidx(asteroid) - asteroidspeed(asteroid)



            If asteroidx(asteroid) < 0 - 10 Then
                removeAsteroid = asteroid
            End If


        Next
    End If


    If removeAsteroid <> 0 Then
        For k = removeAsteroid To numAsteroids
            asteroidx(k) = asteroidx(k + 1)
            asteroidy(k) = asteroidy(k + 1)
            asteroidspeed(k) = asteroidspeed(k + 1)
        Next
        numAsteroids = numAsteroids - 1
        removeAsteroid = 0
    End If




    If explosion = 1 Then
        expl = expl + 1

        For k = 1 To expl
            PSet (shipX - Int(Rnd * k), shipY - Int(Rnd * k)), Int(Rnd * 255)
            PSet (shipX + Int(Rnd * k), shipY + Int(Rnd * k)), Int(Rnd * 255)
            PSet (shipX - Int(Rnd * k), shipY + Int(Rnd * k)), Int(Rnd * 255)
            PSet (shipX + Int(Rnd * k), shipY - Int(Rnd * k)), Int(Rnd * 255)
        Next
        If expl > 30 Then expl = 0: explosion = 0
    End If


    rand = Int(Rnd * (30 - (collected * 3))) + 1 '(collected*3) makes the asteroids more frequent
    If rand = 1 Then
        numAsteroids = numAsteroids + 1
        asteroidx(numAsteroids) = 319 + 10
        asteroidy(numAsteroids) = Int(Rnd * 219) + 1
        asteroidspeed(numAsteroids) = Rnd * 1.5 + .5 + ((collected + 1) / 50) '(collected+1)/50 makes them faster
    End If



    If heart = 0 Then 'only if heart is 0 should we create one (it is already created otherwise)
        rand = Int(Rnd * 1000) + 1 'very seldom does a heart arrive
        If rand = 1 Then
            heart = 1
            heartX = 319 + 10
            heartY = Int(Rnd * 219) + 1
            heartSpeed = Rnd * 1.5 + .5
        End If
    End If

    'here we display the heart and handles the collision for the heart:
    If heart = 1 Then
        PutImage (heartX, heartY), life
        heartX = heartX - heartSpeed

        If heartX < -10 Then heart = 0 'remove it if it goes outside the screen.

        If shipX + 10 >= heartX And shipX <= heartX + 10 Then
            If shipY + 10 >= heartY And shipY <= heartY + 10 Then
                'it collided with the heart!
                heart = 0 'set heart to 0 to remove it
                lives = lives + 1 'add 1 to lives

            End If
        End If

    End If

    'we do the same for the numbers as with the heart:
    If number = 0 Then
        rand = Int(Rnd * 500) + 1 'very seldom does a number arrive
        If rand = 1 Then
            number = 1
            numberX = 319 + 10
            numberY = Int(Rnd * 219) + 1
            numberSpeed = Rnd * 1.5 + .5
        End If
    End If

    'here we display the number and handle the collision for the number:
    If number = 1 Then
        PrintString (numberX, numberY), Str$(collected + 1) 'we use printstring to represent the number
        numberX = numberX - numberSpeed
        If numberX < -10 Then number = 0
        If shipX + 10 >= numberX And shipX <= numberX + 10 Then
            If shipY + 10 >= numberY And shipY <= numberY + 10 Then
                'it collided with the number!
                collected = collected + 1 'add one to the collected numbers
                number = 0 'set number to 0 to remove it
            End If
        End If
    End If



    'loose:
    If lives < 0 Then
        Locate 10, 15: Print "GAME OVER"
        Display: End
    End If

    'win:
    If collected = 9 Then
        Locate 10, 16: Print "YOU WIN"
        Display: End
    End If



    Display
Loop

