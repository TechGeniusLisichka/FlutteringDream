#NoEnv
#Include libraries/JSON.ahk
#SingleInstance force
#Include settings/triggers.ahk
#Include settings/Trach.ahk
#Include settings/bind.ahk
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0

ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SendMode Input
SetWorkingDir %A_ScriptDir%
SetNumlockState, AlwaysOn
SetCapsLockState, AlwaysOff
SetScrollLockState, AlwaysOff

global AdminPassword
AdminPassword = UNDEFINED_PASSWORD
global DiscordAdmin
DiscordAdmin = UNDEFIEND_DISCORD

; INI Loading
LoadingConfigs()

; Работа только в GTA5
#IfWinActive ahk_exe GTA5.exe

CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
; ---------------------------------------------------------------------------------------------------------
; ============================================= AFC check =================================================
; ---------------------------------------------------------------------------------------------------------

; Установите время в минутах, после которого будет считаться, что вы AFK
AFKTimeLimit := 15
AFKTimer := 0


SetTimer, CheckAFK, 60000 ; Проверка каждую минуту

CheckAFK:
    ; Получаем координаты курсора мыши
   CoordMode, Mouse, Screen
   MouseGetPos, prevX, prevY
    
    ; Пауза для получения актуальных координат
   Sleep, 1000
    
    ; Проверяем если координаты мыши не изменились
    MouseGetPos, currX, currY
    
    if (currX = prevX && currY = prevY)
    {
       AFKTimer := AFKTimer + 1
        
        ; Если AFKTimer превышает AFKTimeLimit, то выполняем необходимые действия
       if (AFKTimer >= AFKTimeLimit)
       {
            ; Открытие консоли и отправление команды kickme 
           SendInput, ~
           Sleep, 300
           ClickComponent("consoleBtn")
           Sleep, 300
           SendInput, kickme{ENTER}
            SendInput, ~
            MsgBox, 0, Предупреждение, Вы были AFK в течение %AFKTimeLimit% минут. Я любезно Вас кикнул из GTA., 5
            SetTimer, CheckAFK, Off
        }
   }
    else
    {
       AFKTimer := 0
    }
    return

; ========================== Для рандомного ответа =======================

plainer(text1, text2, text3, text4, text5)
{
  randomInt = 0
  Random, randomInt, 1, 5
  SendMessage, 0x50,, 0x4190419,, A
  if(randomInt = 1)
    return text1
  else if(randomInt = 2)
    return text2
  else if(randomInt = 3)
    return text3
  else if(randomInt = 4)
    return text4
  else
    return text5
}

; ========================= Приветствие ===================================
!1::
    ClickComponent("input")
    Random, variant, 1, 3

    ; Getting time
    FormatTime, nowHours,, HH

    TimesOfDay := Добрый день

    if ( nowHours >= 0 and nowHours <= 4 ) 
    {
        TimesOfDay = Доброй ночи
    }

    if ( nowHours >= 5 and nowHours <= 11 ) 
    {
        TimesOfDay = Доброе утро
    }

    if ( nowHours >= 12 and nowHours <= 17 ) 
    {
        TimesOfDay = Добрый день
    }

    if ( nowHours >= 18 and nowHours <= 23 ) 
    {
        TimesOfDay = Добрый вечер
    }

    switch variant
    {
        case 1: SendInput, %TimesOfDay%, уважаемый игрок, уже лечу{!}
        case 2: SendInput, %TimesOfDay%, уважаемый игрок, вылетаю{!}
        case 3: SendInput, %TimesOfDay%, уважаемый игрок, телепортируюсь{!}
    }

    SendInput, {ENTER}
    ClickComponent("gotoup")
    if (State4)
    {
        CountReport("first", "Y")
    } else {
        CountReport()
    }
return

; ========================== Блок наказаний ===========================

::pg+::
    SendInput,prison  30 6.7 правил проекта{left 22}
return

::nrd+::
    SendInput,prison  20 6.2 правил проекта{left 22}
return

::nsp+::
    SendInput,mute  20 5.18 правил проекта{left 23}
return

::zap+::
    SendInput,mute  10 5.17 правил проекта{left 23}
return

::ooc+::
    SendInput,mute  20 5.3 правил проекта{left 22}
return

::dm+::
    SendInput,prison  20 6.9 правил проекта{left 22}
return

::oskr+::
    SendInput,ban  30 5.5 правил проекта{left 22}
return

::db+::
    SendInput,prison  20 6.3 правил проекта{left 22}
return

::dob+::
    SendInput,prison  40 6.20 правил проекта{left 23}
return

::amo+::
    SendInput,prison  40 6.14 правил проекта{left 23}
return

::lut+::
    SendInput,prison  40 6.19 правил проекта{left 23}
return

::cbm+::
    SendInput,prison  40 6.31 правил проекта{left 23}
return

::bg+::
    SendInput,prison  30 6.16 правил проекта{left 23}
return

::ngs+::
    SendInput, prison  40 NonRP Гос{left 13}
return

::nst+::
    SendInput, prison  40 NonRP Стяжки{left 16}
return

::rk+::
    SendInput, prison  40 6.4 правил проекта{left 22}
return

::uho+::
    SendInput, prison  100 6.23 правил проекта{left 24}
return

; =========================== Предупреждения в PM ==================

::pmnrd+::
    SendInput, pm  Не нарушайте пожалуйста пункт 6.2 правил проекта (NonRP Drive){!}{left 64}
return

::pmooc+::
    SendInput, pm  Не переходите на OOC в IC{!}{left 27}
return

::pmmic+::
    SendInput, pm  Не нарушайте правила использования микрофона{!}{left 46}
return

::pmsp+::
    SendInput, pm  Предоставьте пожалуйста видеофиксацию отыгровки SoundPad в личные сообщения Discord: %DiscordAdmin%{left 91}
return

::pmna+::
    SendInput, pm  Предоставьте пожалуйста видеофиксацию начала ситуации в личные сообщения Discord: %DiscordAdmin%{left 88}
return

; ========================== Телепорт на особняки ==================
::.о1::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1135.29, 375.56, 70.11
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о2::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1806.19, 439.39, 127.93
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о3::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -834.32, 114.14, 56.21
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о4::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc 228.25, 765.94, 204.56
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о5::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1188.68, 289.34, 70.50
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о6::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1549.18, -87.88, 55.72
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о7::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1579.00, -33.85, 56.94
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о8::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1462.32, -32.05, 55.54
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о9::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -2584.95, 1913.73, 166.90
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о10::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1516.86, 852.00, 181.20
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о11::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc 3313.22, 5175.29, 18.81
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о12::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -712.52, -1298.13, 5.01
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о13::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1274.98, 496.90, 97.04
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о14::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1025.39, 360.01, 71.31
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о15::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -882.32, 365.56, 84.64
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о16::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -877.60, 306.26, 82.09
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о17::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -701.00, 647.72, 154.53
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о18::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1040.43, 222.49, 63.27
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о19::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -997.97, 156.94, 60.83
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о20::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -951.94, 195.32, 67.43
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о21::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -903.10, 191.32, 69.17
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о22::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -969.00, 124.09, 55.95
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о23::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -837.51, -25.94, 40.20
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о24::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -883.74, 39.66, 49.47
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о25::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1732.53, 380.27, 88.98
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о26::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1863.78, 309.64, 88.94
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о27::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1874.37, 201.60, 85.13
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о28::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1344.88, 481.11, 101.58
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о29::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc 39.58, 362.50, 117.39
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.о30::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, tpc -1062.32, 426.70, 76.44
  Sleep, 300
  Sendinput, {Enter}
  Sleep, 300
  ClickComponent("consoleReport")
Return

::.fam::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, var-set flyEnableFamily 0 {enter}
  Sleep, 300
  Sendinput, var-set flyEnableFaction 0 {enter}
  Sleep, 300
  Sendinput, {Enter}
Return

::.all::
  ClickComponent("consoleBtn")
  Sleep, 300
  Sendinput, var-set flyEnableNametags 0 {enter}
  Sleep, 300
  Sendinput, {Enter}
Return

; ======================== Не трогать ========================

; Посчитать первичный реопрт
!s::
    if (State4)
    {
        CountReport("first", "Y")
    } else {
        CountReport()
    }
return


; Обновление скрипта
F8::Reload
return

; ----------
; Быстрая авторизация
; ----------
!F12::
    SendInput, t
    Sleep, 300

    SendInput, /alogin13{Enter}
    Sleep, 300

    SendInput, {~}
    Sleep, 300

    ClickComponent("consoleLogin")
    Sleep, 300

    global AdminPassword

    SendInput, %AdminPassword%
    

    SendInput, {Enter}
    Sleep, 300

    SendInput, {~}
    Sleep, 300

    SendInput, {F4}
    Sleep, 300

    SendInput, {~}
    Sleep, 300

    ClickComponent("input")
    Sleep, 300
    
    SendInput, hp
    Sleep, 300

    SendInput, {Enter}
return

; REOF
!y::
    SendInput, ~
    Sleep, 300
    ClickComponent("consoleBtn")
    Sleep, 300
    SendInput, reof {ENTER}
    SendInput, ~
return

;; All windows use
#IfWinActive

; GUI Helper
!F9::

    State2:=!State2

    Gui Destroy

    If State2
    {

        FileRead, JsonFields, keys.json
        FieldKeys := JSON.Load(JsonFields)
        
        CustomColor3 = c333333

        Gui +LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20

        Gui, Color, black
        Gui, Font, s10
        Gui, Font, cWhite
        Gui, Font, w1000

        GUI, ADD,TEXT, cRed, Бинды клавиш:
        
        px := 10
        py := 10

        for each, fieldText in FieldKeys {

            py += 25

            if ( fieldText == "" ) {
                py = 10
                px += 360
            }

            addy = y%py%
            addx = x%px%

            GUI, ADD, TEXT, %addx% %addy% cWhite, % fieldText
        }
        
        WinSet, TransColor, %CustomColor3% 210

        ScreenData := GettingScreenResolution()
        winY := ScreenData[2] - 478

        Gui, Show, % "x" 0 " y" winY " w1600 h450 NoActivate", window.

    }

return

; GUI Помощник для консольных команд
!F10::

    State3:=!State3

    Gui Destroy

    If State3
    {

        FileRead, JsonFields, commands.json
        FieldCommands := JSON.Load(JsonFields)

        CustomColor3 = c333333

        Gui +LastFound +AlwaysOnTop -Caption +ToolWindow 

        Gui, Color, black
        Gui, Font, s10
        Gui, Font, cWhite
        Gui, Font, w1000

        GUI, ADD,TEXT,cRed, Введите этот текст в консоль затем пробел:

        px := 10
        py := 10

        for each, fieldText in FieldCommands {

            py += 25

            if ( fieldText == "" ) {
                py = 10
                px += 360
            }

            addy = y%py%
            addx = x%px%

            GUI, ADD, TEXT, %addx% %addy% cWhite, % fieldText
        }
        
        WinSet, TransColor, %CustomColor3% 230

        ScreenData := GettingScreenResolution()
        winY := ScreenData[2] - 378

        Gui, Show, % "x" 0 " y" winY " w1100 h350 NoActivate", window.

    }

return

; GUI Счетчик репортов
!F11::
    State4 := !State4
    
    Gui Destroy

    If State4
    {
        ShowCounters()
    }
return

; GUI Помощник для триггерных слов
!F8::

    State5:=!State5

    Gui Destroy

    If State5
    {

        FileRead, JsonFields, triggers.json
        FieldCommands := JSON.Load(JsonFields)

        CustomColor3 = c333333

        Gui +LastFound +AlwaysOnTop -Caption +ToolWindow 

        Gui, Color, black
        Gui, Font, s10
        Gui, Font, cWhite
        Gui, Font, w1000

        GUI, ADD,TEXT,cRed, Введите этот текст затем пробел:

        px := 10
        py := 10

        for each, fieldText in FieldCommands {

            py += 25

            if ( fieldText == "" ) {
                py = 10
                px += 360
            }

            addy = y%py%
            addx = x%px%

            GUI, ADD, TEXT, %addx% %addy% cWhite, % fieldText
        }
        
        WinSet, TransColor, %CustomColor3% 230

        ScreenData := GettingScreenResolution()
        winY := ScreenData[2] - 378

        Gui, Show, % "x" 0 " y" winY " w1350 h350 NoActivate", window.

    }

return
; ----------------------
; FUNCTIONS ------------
; ----------------------
ShowCounters()
{

    Gui Destroy
    
    CustomColor3 = c333333
    FindSunday := "N"

    Gui +LastFound +AlwaysOnTop -Caption +ToolWindow 

    Gui, Color, %CustomColor3%
    Gui, Font, s14
    Gui, Font, cWhite
    Gui, Font, w1000

    GUI, ADD,TEXT, cWhite, Счетчик репортов:

    DaysLater := 6
    TotalCountReports := 0

    Gui, Font, s12

    while(DaysLater >= 0)
    {
        Y_Date := A_Now
        Y_Date += -DaysLater, d
        FormatTime, FormattedDate, %Y_Date%, dd.MM.yyyy
        FormatTime, DayOfWeek, %Y_Date%, dddd

        if( DayOfWeek = "воскресенье" )
        {
            FindSunday := "Y"
        }

        if( FindSunday = "Y" )
        {
            FileReadLine, LineData, %A_ScriptDir%\counters\%FormattedDate%-first.txt, 1
            
            if ( LineData * 1 >= 100 ) {
                GUI, ADD, TEXT, c00e36a, %DayOfWeek% (%FormattedDate%): %LineData%
            } else if ( LineData * 1 >= 60 ) {
                GUI, ADD, TEXT, cf7db23, %DayOfWeek% (%FormattedDate%): %LineData%
            } else if ( LineData * 1 >= 0 ) {
                GUI, ADD, TEXT, cf72f47, %DayOfWeek% (%FormattedDate%): %LineData%
            }

            TotalCountReports += LineData * 1

            LineData := 0
        }

        --DaysLater
    }

    Gui, Font, s14
    GUI, ADD, TEXT, cWhite, Итого за неделю: %TotalCountReports%

    Gui, Font, s8
    GUI, ADD, TEXT, cWhite, Данные являются примерными

    WinSet, TransColor, c000000 210

    ScreenData := GettingScreenResolution()
    winY := ScreenData[2] - 478

    Gui, Show, % "x" 0 " y" winY " w300 h450 NoActivate", window.
}

;; Create parts array
GetPanelParts()
{

    WinGetPos, X, Y, W, H, A

    ; Array parts
    xParts := []
    yParts := []

    ; Counted parts
    xPartSize := W / 4
    yPartSize := 410 / 10

    counter := 0
    Loop, 4 {
        counter := counter + xPartSize
        xParts[A_Index, 1] := counter - xPartSize
        xParts[A_Index, 2] := counter
    }

    ResultArray := []
    ResultArray[1] := xParts

    counter := 0
    Loop, 10 {
        counter := counter + yPartSize
        yParts[A_Index, 1] := counter - yPartSize
        yParts[A_Index, 2] := counter
    }

    ResultArray[2] := yParts

    return ResultArray
}

;; Click to INPUT
ClickComponent(NameComponent, WithClick = 1)
{
    WinGetPos, X, Y, W, H, A

    ; Start Window coords
    X_Start := X
    Y_Start := Y

    ; End Window coords
    X_End := X + W
    Y_End := Y + 400

    X_Point := 0
    Y_Point := 0

    ; Click to input
    if (NameComponent = "input")
    {
        ; Input coords
        X_Point := X_Start + 160
        Y_Point := Y_Start + 332
    }

    ; Click to update
    if (NameComponent = "update")
    {
        ; Обновить координаты кнопки
        X_Point := X_End - 50
        Y_Point := Y_Start + 20
    }

    ; Click to gotoup
    if (NameComponent = "gotoup")
        {
        X_Point := X_Start + 740
        Y_Point := Y_Start + 100
        }
    
    ; Click to gps my
    if (NameComponent = "gpsmy")
        {
        X_Point := X_Start + 750
        Y_Point := Y_Start + 220
        }
    
    if (NameComponent = "console")
    {
        X_Point := X_Start + 160
        Y_Point := Y_Start + 335
    }

    if (NameComponent = "closeReport")
    {
        X_Point := X_Start + 600
        Y_Point := Y_Start + 335
    }

    if (NameComponent = "consoleReport")
    {
        X_Point := X_Start + 270
        Y_Point := Y_Start + 370
    }

    if (NameComponent = "consoleLogin")
    {
        X_Point := X_Start + 160
        Y_Point := Y_Start + 380
    }

    if (NameComponent = "consoleBtn")
    {
        X_Point := X_Start + 30
        Y_Point := Y_Start + 380
    }

    MouseMove, X_Point, Y_Point, 1

    if (WithClick = 1)
    {
        Click, X_Point, Y_Point, 1
    }
}

;; Подсчет первого репорта
CountReport(ReportType = "first", IsShowCounters = "N")
{
    FormatTime, fileDate,, dd.MM.yyyy

    IfNotExist, %A_ScriptDir%\counters
        FileCreateDir, %A_ScriptDir%\counters

    IfNotExist, %A_ScriptDir%\counters\%fileDate%-%ReportType%.txt
        FileAppend, 0, %A_ScriptDir%\counters\%fileDate%-%ReportType%.txt

    ; Чтение строки из файла счетчика
    FileReadLine, LineData, %A_ScriptDir%\counters\%fileDate%-%ReportType%.txt, 1

    Counter := LineData * 1 + 1

    FileDelete, %A_ScriptDir%\counters\%fileDate%-%ReportType%.txt
    FileAppend, %Counter%, %A_ScriptDir%\counters\%fileDate%-%ReportType%.txt
    if (IsShowCounters = "Y") 
    {
        ShowCounters()
    }
}

GettingScreenResolution() {

    result := []

    SysGet, PrimaryMonitorNumber, MonitorPrimary
    SysGet, MonitorData, Monitor, PrimaryMonitorNumber

    result.Push(MonitorDataRight)
    result.Push(MonitorDataBottom)

    Return result
}

; Загрузка конфигов
LoadingConfigs()
{
    ; Читать конфиг
    configFileName = config.ini
    configFile = % Format("{1}\{2}", A_ScriptDir, configFileName)

    IfNotExist, %configFile%
        FileAppend, % Format("[Default]`nPassword=Введите_свой_Админ_пароль`nDiscord=Введите_свой_дискорд_тэг"), %configFile%
        
    ; Получение глобальной переменной
    global AdminPassword
    global DiscordAdmin
    IniRead, DiscordAdmin, %configFileName%, Default, Discord
    IniRead, AdminPassword, %configFileName%, Default, Password
}
