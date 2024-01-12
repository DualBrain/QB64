which = 0

DIM sampleData AS _MEM

IF which = 0 THEN
  
  CONST N = 512
  
  'dim shared pi as double
  PI = 4 * ATN(1)
  
  DIM x_r(N - 1), x_i(N - 1)
  DIM xx_r(N - 1), xx_i(N - 1)
  
  'create signal
  FOR i = 0 TO N - 1
    x_r(i) = 100 * SIN(2 * PI * 62.27 * i / N) + 25 * COS(2 * PI * 132.27 * i / N)
    x_i(i) = 0
  NEXT
  
  fft xx_r(), xx_i(), x_r(), x_i(), N
  
  FOR i = 0 TO N - 1
    PRINT xx_r(i), xx_i(i), x_r(i), x_i(i)
  NEXT
  
END IF

IF which = 1 THEN
  
  'defdbl a-z
  
  sw = 1024
  sh = 600
  
  DIM SHARED PI AS DOUBLE
  'pi = 2*asin(1)
  PI = 4 * ATN(1)
  
  DECLARE SUB rfft(xx_r(), xx_i(), x_r(), N)
  DECLARE SUB fft(xx_r(), xx_i(), x_r(), x_i(), N)
  DECLARE SUB dft(xx_r(), xx_i(), x_r(), x_i(), N)
  
  
  DIM x_r(sw - 1), x_i(sw - 1)
  DIM xx_r(sw - 1), xx_i(sw - 1)
  DIM t AS DOUBLE
  
  FOR i = 0 TO sw - 1
    x_r(i) = 100 * SIN(2 * PI * 62.27 * i / sw) + 25 * COS(2 * PI * 132.27 * i / sw)
    x_i(i) = 0
  NEXT
  
  'screenres sw, sh, 32
  SCREEN _NEWIMAGE(sw, sh, 32)
  
  PSET(0, sh / 4 - x_r(0))
  FOR i = 0 TO sw - 1
    LINE - (i, sh / 4 - x_r(i)), _RGB(100, 100, 100)
  NEXT
  
  dft xx_r(), xx_i(), x_r(), x_i(), sw
  PSET(0, 3 * sh / 4 - 0.1 * SQR(xx_r(0) * xx_r(0) + xx_i(0) * xx_i(0))), _RGB(0, 255, 0)
  FOR i = 0 TO sw - 1
    LINE - (i, 3 * sh / 4 - 0.1 * SQR(xx_r(i) * xx_r(i) + xx_i(i) * xx_i(i))), _RGB(0, 255, 0)
  NEXT
  LINE(0, 3 * sh / 4) - STEP(sw, 0), _RGB(0, 255, 0), , &h5555
  
  t = TIMER
  FOR i = 0 TO 50
    fft xx_r(), xx_i(), x_r(), x_i(), sw
  NEXT
  LOCATE 1, 1
  PRINT "50x fft ";timer - t
  
  PSET(0, 50 + 3 * sh / 4 - 0.1 * SQR(xx_r(0) * xx_r(0) + xx_i(0) * xx_i(0))), _RGB(255, 0, 0)
  FOR i = 0 TO sw - 1
    LINE - (i, 50 + 3 * sh / 4 - 0.1 * SQR(xx_r(i) * xx_r(i) + xx_i(i) * xx_i(i))), _RGB(255, 0, 0)
  NEXT
  LINE(0, 50 + 3 * sh / 4) - STEP(sw, 0), _RGB(255, 0, 0), , &h5555
  
  
  FOR i = 0 TO sw - 1
    xx_r(i) = 0
    xx_i(i) = 0
  NEXT
  
  t = TIMER
  FOR i = 0 TO 50
    rfft xx_r(), xx_i(), x_r(), sw
  NEXT
  LOCATE 2, 1
  PRINT "50x rfft ";timer - t
  
  PSET(0, 100 + 3 * sh / 4 - 0.1 * SQR(xx_r(0) * xx_r(0) + xx_i(0) * xx_i(0))), _RGB(255, 255, 0)
  FOR i = 0 TO sw - 1
    LINE - (i, 100 + 3 * sh / 4 - 0.1 * SQR(xx_r(i) * xx_r(i) + xx_i(i) * xx_i(i))), _RGB(255, 255, 0)
  NEXT
  LINE(0, 100 + 3 * sh / 4) - STEP(sw, 0), _RGB(255, 255, 0), , &h5555
  
  SLEEP
  SYSTEM
  
END IF

IF which = 2 THEN
  
  'defdbl a-z
  
  sw = 512
  sh = 600
  
  'dim shared pi as double
  'pi = 2*asin(1)
  PI = 4 * ATN(1)
  
  DECLARE SUB fft(xx_r(), xx_i(), x_r(), x_i(), N)
  
  DIM x_r(sw - 1), x_i(sw - 1)
  DIM xx_r(sw - 1), xx_i(sw - 1)
  'dim t as double
  
  FOR i = 0 TO sw - 1
    'x_r(i) = 100*sin(2*pi*62.27*i/sw) + 25*cos(2*pi*132.27*i/sw)
    x_r(i) = 100 * SIN(0.08 * i) + 25 * COS(i)
    x_i(i) = 0
  NEXT
  
  'screenres sw, sh, 32
  SCREEN _NEWIMAGE(sw * 2, sh, 32)
  
  'plot input signal
  PSET(0, sh / 4 - x_r(0))
  FOR i = 0 TO sw - 1
    LINE - (i, sh / 4 - x_r(i)), _RGB(255, 0, 0)
  NEXT
  LINE(0, sh / 4) - STEP(sw, 0), _RGB(255, 0, 0), , &h5555
  COLOR _RGB(255, 0, 0)
  _PRINTSTRING(0, 0), "input signal"
  
  fft xx_r(), xx_i(), x_r(), x_i(), sw
  
  'plot its fft
  PSET(0, 50 + 3 * sh / 4 - 0.01 * SQR(xx_r(0) * xx_r(0) + xx_i(0) * xx_i(0))), _RGB(255, 255, 0)
  FOR i = 0 TO sw / 2
    LINE - (i * 2, 50 + 3 * sh / 4 - 0.01 * SQR(xx_r(i) * xx_r(i) + xx_i(i) * xx_i(i))), _RGB(255, 255, 0)
  NEXT
  LINE(0, 50 + 3 * sh / 4) - STEP(sw, 0), _RGB(255, 255, 0), , &h5555
  
  'set unwanted frequencies to zero
  FOR i = 50 TO sw / 2
    xx_r(i) = 0
    xx_i(i) = 0
    xx_r(sw - i) = 0
    xx_i(sw - i) = 0
  NEXT
  
  'plot fft of filtered signal
  PSET(sw, 50 + 3 * sh / 4 - 0.01 * SQR(xx_r(0) * xx_r(0) + xx_i(0) * xx_i(0))), _RGB(255, 255, 0)
  FOR i = 0 TO sw / 2
    LINE - (sw + i * 2, 50 + 3 * sh / 4 - 0.01 * SQR(xx_r(i) * xx_r(i) + xx_i(i) * xx_i(i))), _RGB(0, 155, 255)
  NEXT
  LINE(sw, 50 + 3 * sh / 4) - STEP(sw, 0), _RGB(0, 155, 255), , &h5555
  
  'take inverse fft
  FOR i = 0 TO sw - 1
    xx_i(i) = - xx_i(i)
  NEXT
  
  fft x_r(), x_i(), xx_r(), xx_i(), sw
  
  FOR i = 0 TO sw - 1
    x_r(i) = x_r(i) / sw
    x_i(i) = x_i(i) / sw
  NEXT
  
  'plot filtered signal
  PSET(sw, sh / 4 - x_r(0))
  FOR i = 0 TO sw - 1
    LINE - (sw + i, sh / 4 - x_r(i)), _RGB(0, 255, 0)
  NEXT
  LINE(sw, sh / 4) - STEP(sw, 0), _RGB(0, 255, 0), , &h5555
  
  COLOR _RGB(0, 255, 0)
  _PRINTSTRING(sw, 0), "filtered signal"
  
  SLEEP
  SYSTEM
  
END IF

IF which = 3 THEN
  
  'defdbl a-z
  
  sw = 1024
  sh = 600
  
  'dim shared pi as double
  'pi = 2*asin(1)
  PI = 4 * ATN(1)
  
  DECLARE SUB rfft(xx_r(), xx_i(), x_r(), N)
  
  DIM x_r(sw - 1), x_i(sw - 1)
  DIM xx_r(sw - 1), xx_i(sw - 1)
  'dim t as double
  
  FOR i = 0 TO sw - 1
    x_r(i) = 100 * SIN(2 * PI * (sw * 2000 / 44000) * i / sw) + (100 * RND - 50)
  NEXT
  
  'screenres sw, sh, 32
  SCREEN _NEWIMAGE(sw, sh, 32)
  
  'plot signal
  PSET(0, sh / 4 - x_r(0))
  FOR i = 0 TO sw - 1
    LINE - (i, sh / 4 - x_r(i)), _RGB(255, 0, 0)
  NEXT
  LINE(0, sh / 4) - STEP(sw, 0), _RGB(255, 0, 0), , &h5555
  
  _PRINTSTRING(0, 0), "2000 kHz signal with RND noise sampled at 44 kHz in 1024 samples"
  
  rfft xx_r(), xx_i(), x_r(), sw
  
  'plot its fft
  PSET(0, 50 + 3 * sh / 4 - 0.005 * SQR(xx_r(0) * xx_r(0) + xx_i(0) * xx_i(0))), _RGB(255, 255, 0)
  FOR i = 0 TO sw / 2
    LINE - (i * 2, 50 + 3 * sh / 4 - 0.005 * SQR(xx_r(i) * xx_r(i) + xx_i(i) * xx_i(i))), _RGB(255, 255, 0)
  NEXT
  LINE(0, 50 + 3 * sh / 4) - STEP(sw, 0), _RGB(255, 255, 0), , &h5555
  
  'find peak
  'dim max as double, d as double
  max1 = 0
  m = 0
  FOR i = 0 TO sw / 2
    d = 0.01 * SQR(xx_r(i) * xx_r(i) + xx_i(i) * xx_i(i))
    IF d > max1 THEN
      max1 = d
      m = i
    END IF
  NEXT
  
  _PRINTSTRING(0, sh / 2), "m_peak ="+str$(m)
  _PRINTSTRING(0, sh / 2 + 16), "f_peak = m_peak * 44 kHz / 1024 samples = "+str$(m*44000/1024)+" Hz"
  
  'apply frequency correction, only works for some signals
  DIM c AS DOUBLE
  DIM u_r AS double, u_i AS DOUBLE
  DIM v_r AS double, v_i AS DOUBLE
  
  u_r = xx_r(m - 1) -xx_r(m + 1)
  u_i = xx_i(m - 1) -xx_i(m + 1)
  v_r = 2 * xx_r(m) - xx_r(m - 1) -xx_r(m + 1)
  v_i = 2 * xx_i(m) - xx_i(m - 1) -xx_i(m + 1)
  c = (u_r * v_r + u_i * v_i) /(v_r * v_r + v_i * v_i)
  
  _PRINTSTRING(0, sh / 2 + 2 * 16), "f_corrected = "+str$((m+c)*44000/1024)+" Hz"
  
  SLEEP
  SYSTEM
  
END IF

IF which = 10 THEN
  
  song& = _SNDOPEN("empire.mp3")
  IF song& = 0 THEN
    PRINT "Failed to load song!"
    END
  END IF
  
  _SNDPLAY song&
  
  sampleData = _MEMSOUND(song&, 1)
  IF sampleData.SIZE = 0 THEN
    PRINT "Failed to access sound sample data."
    END
  END IF
  
  'DIM i AS _UNSIGNED _INTEGER64
  'DIM si AS INTEGER
  'DIM sz AS _UNSIGNED _INTEGER64
  
  'DIM rf AS SINGLE, lf AS SINGLE
  
  sz = _CV(_UNSIGNED _INTEGER64, _MK$(_OFFSET, sampleData.ELEMENTSIZE)) ' sz is the total size of the SOUND in bytes
  
  DO UNTIL _KEYHIT = 27 OR NOT _SNDPLAYING(song&) OR i + (_WIDTH * sz) > sampleData.SIZE
    
    CLS : PRINT i; "/"; sampleData.SIZE, "Frame Size ="; sz, "Data Type ="; sampleData.TYPE
    
    $Checking:OFF
    IF SampleData.TYPE = 4 THEN ' Floating POINT stereo OR mono
      total = 0
      min1 = 0
      max1 = 0
      FOR x& = 0 TO _WIDTH - 1
        lf = _MEMGET(SampleData, SampleData.OFFSET + i + x& * sz, SINGLE) ' GET SOUND DATA
        total = total + ABS(lf)
        IF lf < min1 THEN min1 = lf
        IF lf > max1 THEN max1 = lf
        rf = _MEMGET(SampleData, SampleData.OFFSET + 4 + i + x& * sz, SINGLE) ' GET SOUND DATA
        'LINE (x&, _HEIGHT / 2)-STEP(0, rf * 300), _RGB32(0, 111, 0) ' Plot wave
      NEXT
      LOCATE 2, 1 : PRINT INT(min1 * 100), INT(max1 * 100), INT(ABS(total / _WIDTH) * 100)
      DIM vu AS INTEGER : vu = INT(ABS(total / _WIDTH) * 40)
      DIM pk AS INTEGER : pk = INT(max1 * 40) : IF pk < 1 THEN pk = 1
      LOCATE 3, 1 : PRINT STRING$(vu, "=") + SPACE$(40 - vu)
      LOCATE 3, pk : PRINT "|"
    END IF
    $Checking:ON
    
    i = FIX(_SNDGETPOS(song&) * _SNDRATE) * sz ' Calculate the new sample frame position
    
  LOOP
  
  _SNDCLOSE song& ' Closing the SOUND releases the MEM blocks
  _AUTODISPLAY
  
  END
  
END IF

IF which = 20 THEN
  
  SCREEN _NEWIMAGE(800, 327, 32)
  
  PRINT "Loading...";
  song& = _SNDOPEN("empire.mp3")
  IF song& = 0 THEN
    PRINT "Failed to load song!"
    END
  END IF
  PRINT "Done!"
  
  _SNDPLAY song&
  
  sampleData = _MEMSOUND(song&, 1)
  IF sampleData.SIZE = 0 THEN
    PRINT "Failed to access sound sample data."
    END
  END IF
  
  'DIM i AS _UNSIGNED _INTEGER64
  'DIM sf AS SINGLE
  'DIM si AS INTEGER
  'DIM sz AS _UNSIGNED _INTEGER64
  
  'DIM rf AS SINGLE, lf AS SINGLE
  
  sz = _CV(_UNSIGNED _INTEGER64, _MK$(_OFFSET, sampleData.ELEMENTSIZE)) ' sz is the total size of the SOUND in bytes
  
  DO UNTIL _KEYHIT = 27 OR NOT _SNDPLAYING(song&) OR i + (_WIDTH * sz) > sampleData.SIZE
    
    CLS : PRINT i; "/"; sampleData.SIZE, "Frame Size ="; sz, "Data Type ="; sampleData.TYPE
    
    $Checking:OFF
    IF SampleData.TYPE = 130 THEN ' INTEGER stereo OR mono
      FOR x& = 0 TO _WIDTH - 1
        si = _MEMGET(SampleData, SampleData.OFFSET + i + x& * sz, INTEGER) ' GET SOUND DATA
        LINE(x&, _HEIGHT / 2) - STEP(0, 300 * si / 32768), _RGB32(0, 111, 0) ' Plot wave
      NEXT
    ELSEIF SampleData.TYPE = 4 THEN ' Floating POINT stereo OR mono
      '   DIM total AS DOUBLE: total = 0
      '   DIM min1 AS SINGLE: min1 = 0
      '   DIM max1 AS SINGLE: max1 = 0
      FOR x& = 0 TO _WIDTH - 1
        lf = _MEMGET(SampleData, SampleData.OFFSET + i + x& * sz, SINGLE) ' GET SOUND DATA
        ' total = total + ABS(lf)
        ' IF lf < min1 THEN min1 = lf
        ' IF lf > max1 THEN max1 = lf
        rf = _MEMGET(SampleData, SampleData.OFFSET + 4 + i + x& * sz, SINGLE) ' GET SOUND DATA
        LINE(x&, _HEIGHT / 2) - STEP(0, rf * 300), _RGB32(0, 111, 0) ' Plot wave
      NEXT
      '   LOCATE 2, 1: PRINT INT(min1 * 100), INT(max1 * 100), INT(ABS(total / _WIDTH) * 100)
      '   DIM vu AS INTEGER: vu = INT(ABS(total / _WIDTH) * 40)
      '   Dim pk AS INTEGER: pk = INT(max1 * 40): IF pk < 1 THEN pk = 1
      '   LOCATE 3, 1: PRINT STRING$(vu, "=") + SPACE$(40 - vu)
      '   LOCATE 3, pk: PRINT "|"
    ELSEIF sz = 2 AND SampleData.TYPE = 0 THEN ' INTEGER mono(QB64 OpenAL stuff)
      FOR x& = 0 TO _WIDTH - 1
        si = _MEMGET(SampleData, SampleData.OFFSET + i + x& * sz, INTEGER) ' GET SOUND DATA
        LINE(x&, _HEIGHT / 2) - STEP(0, 300 * si / 32768), _RGB32(0, 111, 0) ' Plot wave
      NEXT
    END IF
    $Checking:ON
    
    _DISPLAY
    _LIMIT 60
    
    i = FIX(_SNDGETPOS(song&) * _SNDRATE) * sz ' Calculate the new sample frame position
    
  LOOP
  
  _SNDCLOSE song& ' Closing the SOUND releases the MEM blocks
  _AUTODISPLAY
  
  END
  
END IF

IF which = 30 THEN
  
  DIM Texture AS SINGLE
  DIM diY AS SINGLE
  DIM VOL AS SINGLE
  DIM DW AS SINGLE
  DIM DH AS SINGLE
  DIM ShiftIt AS SINGLE
  DIM rows AS SINGLE
  DIM Depth AS SINGLE
  DIM ra AS SINGLE
  DIM Z AS SINGLE
  DIM X AS SINGLE
  DIM HX AS SINGLE
  DIM HX2 AS SINGLE
  DIM HZ AS SINGLE
  DIM HZ2 AS SINGLE
  DIM HY1 AS SINGLE
  DIM HY2 AS SINGLE
  DIM HY3 AS SINGLE
  DIM HY4 AS SINGLE
  DIM HY11 AS SINGLE
  DIM HY12 AS SINGLE
  DIM HY13 AS SINGLE
  DIM HY14 AS SINGLE
  DIM FillCache AS SINGLE
  DIM CLL AS SINGLE
  DIM CLR AS SINGLE
  DIM DL AS SINGLE
  
  Texture = _NEWIMAGE(255, 255, 32)
  _DEST Texture
  CLS, &HFFFF0000
  FOR diY = 0 TO 100
    LINE(diY + 20, diY + 20) -(235 - diY, 235 - diY), _RGB32(diY, 0, 0), B
  NEXT
  _DEST 0
  DIM SND AS LONG
  DIM position AS LONG
  'DIM FillCachem AS Long
  DIM HT AS LONG
  DIM AS _FLOAT IL, IR, IntensityLeft, IntensityRight
  DIM AS _MEM L ', R
  DIM AS _UNSIGNED _BYTE Rc, Gc, Bc
  REDIM LightsL(10) AS _UNSIGNED _BYTE
  REDIM LightsR(10) AS _UNSIGNED _BYTE
  DIM M3D(90, 90) AS SINGLE
  DIM M2D(90, 90) AS SINGLE
  SND = _SNDOPEN("empire.mp3") '            <-----------------  insert here your sound file name!
  VOL = 10
  _SNDVOL SND, VOL / 20
  L = _MEMSOUND(SND, 1)
  IF L.SIZE = 0 THEN PRINT "ERROR1": BEEP: END
  ' R = MemSound(SND, 2)
  ' IF R.SIZE = 0 THEN PRINT "ERROR2": BEEP: END
  DW = _DESKTOPWIDTH
  DH = _DESKTOPHEIGHT
  HT = _COPYIMAGE(Texture, 33)
  _FREEIMAGE Texture
  SCREEN _NEWIMAGE(DW, DH, 32)
  _FULLSCREEN
  _SNDPLAY SND
  DO UNTIL position >= L.SIZE - 8192
    ShiftIt = 89
    DO UNTIL ShiftIt < 0
      FOR rows = 0 TO 90
        SWAP M3D(rows, ShiftIt), M3D(rows, ShiftIt + 1)
        SWAP M2D(rows, ShiftIt), M2D(rows, ShiftIt + 1)
      NEXT
      ShiftIt = ShiftIt - 1
    LOOP
    Depth = 0
    DO UNTIL Depth = 720 '90000
      IF Depth + position > L.SIZE THEN END
      M3D(ra, 0) = _MEMGET(L, L.OFFSET + position + Depth, SINGLE) * 3.7 ' / 32768 * 1.7
      M2D(ra, 0) = _MEMGET(L, L.OFFSET + position + Depth + 4, SINGLE) * 3.7 ' / 32768 * 1.7
      Depth = Depth + 8 '1000
      ra = ra + 1
    LOOP
    ra = 0
    FOR Z = 0 TO 89
      FOR X = 0 TO 89
        HX = -45 + X
        HX2 = HX + 1
        HZ = -89 + Z
        HZ2 = HZ + 1
        HY1 = -3 + M3D(X, Z) : HY2 = -3 + M3D(X + 1, Z) : HY3 = -3 + M3D(X, Z + 1) : HY4 = -3 + M3D(X + 1, Z + 1)
        HY11 = 3 - M2D(X, Z) : HY12 = 3 - M2D(X + 1, Z) : HY13 = 3 - M2D(X, Z + 1) : HY14 = 3 - M2D(X + 1, Z + 1)
        _MAPTRIANGLE(0, 0) -(255, 0) -(0, 255), HT TO(HX, HY1, HZ) -(HX2, HY2, HZ) -(HX, HY3, HZ2), 0, _Smooth
        _MAPTRIANGLE(255, 0) -(0, 255) -(255, 255), HT TO(HX2, HY2, HZ) -(HX, HY3, HZ2) -(HX2, HY4, HZ2), 0, _Smooth
        _MAPTRIANGLE(0, 0) -(255, 0) -(0, 255), HT TO(HX, HY11, HZ) -(HX2, HY12, HZ) -(HX, HY13, HZ2), 0, _Smooth
        _MAPTRIANGLE(255, 0) -(0, 255) -(255, 255), HT TO(HX2, HY12, HZ) -(HX, HY13, HZ2) -(HX2, HY14, HZ2), 0, _Smooth
      NEXT X, Z
      
    '----------------------------------------------------------------------------------------------------------- CIRCLES --------------------------------------------------------------
    FillCache = 0
    IntensityLeft = 0
    IntensityRight = 0
    DIM count AS INTEGER : count = 0
    DO UNTIL FillCache = 8192
      IntensityLeft = IntensityLeft + ABS(_MEMGET(L, L.OFFSET + position + FillCache, SINGLE)) ' / 32768)
      IntensityRight = IntensityRight + ABS(_MEMGET(L, L.OFFSET + position + FillCache + 4, SINGLE)) ' / 32768)
      FillCache = FillCache + 8 '2
      count = count + 1
    LOOP
    IL = (IntensityLeft / count) * 512 ' / 2 ' recalc values AS decimal
    IR = IntensityRight ' / 2
    REDIM LightsL(10) AS _UNSIGNED _BYTE
    REDIM LightsR(10) AS _UNSIGNED _BYTE
    CLL = 0
    DO UNTIL IL <= 0
      IF IL > 28 THEN LightsL(CLL) = 255 ELSE LightsL(CLL) = IL * 8
      IL = IL - 28
      CLL = CLL + 1
      MAX CLL, 10
    LOOP
    CLR = 0
    DO UNTIL IR <= 0
      IF IR > 28 THEN LightsR(CLR) = 255 ELSE LightsR(CLR) = IR * 8
      IR = IR - 28
      CLR = CLR + 1
      MAX CLR, 10
    LOOP
    IL = 0
    IR = 0
    FOR DL = 0 TO 10
      SELECT CASE DL
        CASE 0 TO 5
          Rc = 0 : Gc = 255 : Bc = 0
        CASE 6 TO 8
          Rc = 255 : Gc = 255 : Bc = 0
        CASE is > 8
          Rc = 255 : Gc = 0 : Bc = 0
      END SELECT
      CircleFill WIDTH / 2 - 50 - DL * 80, HEIGHT / 2, 30, &HFF000000
      CircleFill WIDTH / 2 - 50 - DL * 80, HEIGHT / 2, 30, _RGBA32(Rc, Gc, Bc, LightsL(DL))
      CircleFill WIDTH / 2 + 50 + DL * 80, HEIGHT / 2, 30, &HFF000000
      CircleFill WIDTH / 2 + 50 + DL * 80, HEIGHT / 2, 30, _RGBA32(Rc, Gc, Bc, LightsR(DL))
    NEXT
    _DISPLAY
    _LIMIT 120
    position = _SNDGETPOS(SND) * _SNDRATE * 2
  LOOP
  
  END
    
END IF
  
SUB MAX(value, mv)
  IF value > mv THEN value = mv
END SUB

SUB CircleFill(cx AS Integer, cy AS Integer, r AS Integer, c AS _UNSIGNED LONG)
  ' CX = center x coordinate
  ' CY = center y coordinate
  '  R = radius
  '  C = fill color
  DIM Radius AS Integer, RadiusError AS INTEGER
  DIM X AS Integer, Y AS INTEGER
  Radius = ABS(R)
  RadiusError = - Radius
  X = Radius
  Y = 0
  IF Radius = 0 THEN PSET(CX, CY), c : EXIT SUB
  LINE(CX - X, CY) -(CX + X, CY), C, BF
  WHILE X > Y
    RadiusError = RadiusError + Y * 2 + 1
    IF RadiusError >= 0 THEN
      IF X <> Y + 1 THEN
        LINE(CX - Y, CY - X) -(CX + Y, CY-X), C, BF
        LINE(CX - Y, CY + X) -(CX + Y, CY + X), C, BF
      END IF
      X = X - 1
      RadiusError = RadiusError - X * 2
    END IF
    Y = Y + 1
    LINE(CX - X, CY - Y) -(CX + X, CY-Y), C, BF
    LINE(CX - X, CY + Y) -(CX + X, CY + Y), C, BF
  WEND
END SUB
  
SUB fft(xx_r(), xx_i(), x_r(), x_i(), N)

  DIM w_r AS double, w_i AS double, wm_r AS double, wm_i AS DOUBLE
  DIM u_r AS double, u_i AS double, v_r AS double, v_i AS DOUBLE
  
  log2n = LOG(N) / LOG(2)
  
  'bit rev copy
  FOR i = 0 TO N - 1
    rev = 0
    FOR j = 0 TO log2n - 1
      IF i AND (2^j) THEN rev = rev + (2^(log2n - 1 - j))
    NEXT
    xx_r(i) = x_r(rev)
    xx_i(i) = x_i(rev)
  NEXT
  
  FOR i = 1 TO log2n
    m = 2^i
    wm_r = COS(-2 * PI / m)
    wm_i = SIN(-2 * PI / m)
    FOR j = 0 TO N - 1 STEP m
      w_r = 1
      w_i = 0
      FOR k = 0 TO m / 2 - 1
        p = j + k
        q = p + (m \ 2)
        u_r = w_r * xx_r(q) - w_i * xx_i(q)
        u_i = w_r * xx_i(q) + w_i * xx_r(q)
        v_r = xx_r(p)
        v_i = xx_i(p)
        xx_r(p) = v_r + u_r
        xx_i(p) = v_i + u_i
        xx_r(q) = v_r - u_r
        xx_i(q) = v_i - u_i
        u_r = w_r
        u_i = w_i
        w_r = u_r * wm_r - u_i * wm_i
        w_i = u_r * wm_i + u_i * wm_r
      NEXT
    NEXT

  NEXT

END SUB

SUB rfft(xx_r(), xx_i(), x_r(), N)
  DIM w_r AS double, w_i AS double, wm_r AS double, wm_i AS DOUBLE
  DIM u_r AS double, u_i AS double, v_r AS double, v_i AS DOUBLE
  
  log2n = LOG(N / 2) / LOG(2)
  
  FOR i = 0 TO N / 2 - 1
    rev = 0
    FOR j = 0 TO log2n - 1
      IF i AND (2^j) THEN rev = rev + (2^(log2n - 1 - j))
    NEXT
    
    xx_r(i) = x_r(2 * rev)
    xx_i(i) = x_r(2 * rev + 1)
  NEXT
  
  FOR i = 1 TO log2n
    m = 2^i
    wm_r = COS(-2 * PI / m)
    wm_i = SIN(-2 * PI / m)
    
    FOR j = 0 TO N / 2 - 1 STEP m
      w_r = 1
      w_i = 0
      
      FOR k = 0 TO m / 2 - 1
        p = j + k
        q = p + (m \ 2)
        
        u_r = w_r * xx_r(q) - w_i * xx_i(q)
        u_i = w_r * xx_i(q) + w_i * xx_r(q)
        v_r = xx_r(p)
        v_i = xx_i(p)
        
        xx_r(p) = v_r + u_r
        xx_i(p) = v_i + u_i
        xx_r(q) = v_r - u_r
        xx_i(q) = v_i - u_i
        
        u_r = w_r
        u_i = w_i
        w_r = u_r * wm_r - u_i * wm_i
        w_i = u_r * wm_i + u_i * wm_r
      NEXT
    NEXT
  NEXT
  
  xx_r(N / 2) = xx_r(0)
  xx_i(N / 2) = xx_i(0)
  
  FOR i = 1 TO N / 2 - 1
    xx_r(N / 2 + i) = xx_r(N / 2 - i)
    xx_i(N / 2 + i) = xx_i(N / 2 - i)
  NEXT
  
  DIM xpr AS double, xpi AS DOUBLE
  DIM xmr AS double, xmi AS DOUBLE
  
  FOR i = 0 TO N / 2 - 1
    xpr = (xx_r(i) + xx_r(N / 2 + i)) / 2
    xpi = (xx_i(i) + xx_i(N / 2 + i)) / 2
    
    xmr = (xx_r(i) - xx_r(N / 2 + i)) / 2
    xmi = (xx_i(i) - xx_i(N / 2 + i)) / 2
    
    xx_r(i) = xpr + xpi * COS(2 * PI * i / N) - xmr * SIN(2 * PI * i / N)
    xx_i(i) = xmi - xpi * SIN(2 * PI * i / N) -xmr * COS(2 * PI * i / N)
  NEXT
  
  'symmetry, complex conj
  FOR i = 0 TO N / 2 - 1
    xx_r(N / 2 + i) = xx_r(N / 2 - 1 - i)
    xx_i(N / 2 + i) = - xx_i(N / 2 - 1 - i)
  NEXT

END SUB

SUB dft(xx_r(), xx_i(), x_r(), x_i(), N)
  FOR i = 0 TO N - 1
    xx_r(i) = 0
    xx_i(i) = 0
    FOR j = 0 TO N - 1
      xx_r(i) = xx_r(i) + x_r(j) * COS(2 * PI * i * j / N) + x_i(j) * SIN(2 * PI * i * j / N)
      xx_i(i) = xx_i(i) - x_r(j) * SIN(2 * PI * i * j / N) + x_i(j) * COS(2 * PI * i * j / N)
    NEXT
  NEXT
END SUB