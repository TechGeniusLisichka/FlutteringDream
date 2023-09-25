
#Persistent
#NoTrayIcon
#SingleInstance Off
DetectHiddenWindows on
SetTitleMatchMode, 3
SetControlDelay -1

if not A_IsAdmin{
try {
Run *RunAs "%A_ScriptFullPath%"
ExitApp
}
catch e {
MsgBox, 48, Application, Please run as administrator!
ExitApp
}
}
;---Собирает дату из Интернета, используя сайт, предоставляющий время в формате txt (в режиме онлайн, чтобы избежать подмены/изменения даты на ПК)--;
Try
{
WinHttp := ComObjCreate("WinHttp.WinHttpRequest.5.1")
WinHttp.Open("GET", "https://worldtimeapi.org/api/timezone/Europe/Moscow.txt", false)
WinHttp.Send()
WinHttp.WaitForResponse()
Response := WinHttp.ResponseText
}
catch
{
	MsgBox, 16, Application, Не удалось получить время. Пожалуйста, проверьте подключение к Интернету и повторите попытку. Нажимайте "Ok" до тех пор, пока приложение не запустится.
	Reload
}
Match := RegExMatch(Response, "([0-9]{4}).([0-9]{2}).([0-9]{2})", Replace)
Finaldate := RegExReplace(Replace, "-")
Date := Finaldate
;получите RAW-ссылку на файл "version" в вашем репо. Он будет работать как наш автоматический апдейтер
;(когда %Fileversion% не будет равен версии, записанной в вашем github-файле, он предложит обновиться).FileVersion = 1
FileVersion = 2
try{
	getver := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	getver.Open("GET", "https://raw.githubusercontent.com/TechGeniusLisichka/FlutteringDream/main/main/version")
	getver.Send()
	getver.WaitForResponse()
	urlversion := Trim(getver.ResponseText, "`n")
	If (FileVersion != urlversion)
	{
		;Получите RAW-ссылку "patch" в вашем репо. Она будет использоваться как всплывающая ссылка на патч при каждом новом обновлении.
		patch := ComObjCreate("WinHttp.WinHttpRequest.5.1")
		patch.Open("GET", "https://raw.githubusercontent.com/TechGeniusLisichka/FlutteringDream/main/main/patch")
		patch.Send()
		patch.WaitForResponse()
		patchnotes := Trim(patch.ResponseText, "`n")
		MsgBox, 8244, Application Update,  Доступна новая версия!`n`nОбновитесь сейчас?`n`nПатчноты: `n%patchnotes%`n`n`nТекущая версия: v%FileVersion% | Последняя версия: v%urlversion%
		IfMsgBox, Yes
		{
; Загрузите последнюю версию вашего файла в репозиторий, получите ссылку RAW и вставьте ее ниже.
; Загрузка будет происходить автоматически при нажатии пользователем кнопки "Ok" в поле "Вы хотите загрузить?".
Run, https://github.com/TechGeniusLisichka/FlutteringDream/raw/main/admin.exe
		}
		IfMsgBox, No
		{
			Sleep, 500
			Goto, LicenseCheck
		}
}
Else
{
	goto, LicenseCheck
}
} catch e{
	MsgBox, 16, Application, Произошла ошибка при получении текущей версии файла.`nОшибка: %message%`nАвтообновление может не работать до тех пор, пока эта проблема не будет решена.`nНажмите "Ok", чтобы проигнорировать это сообщение и продолжить работу со сценарием.
	Sleep, 500
	goto, LicenseCheck
}
Return
;------------start of scripts------------;
RunApplication:
MsgBox, Срок действия%expfinal% | Текущая дата:%currentdate%
#NoEnv
#Include libraries/JSON.ahk
#SingleInstance force
#Include settings/triggers.ahk
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

::sk+::
    SendInput,prison  90 6.6 правил проекта{left 22}
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

ExitApp

Expired:
MsgBox, Expiration:%expfinal% | Current Date:%currentdate%
Clipboard := keyencrypted
ExitApp

Notreg:
MsgBox, Вы еще не зарегистрированы. Нажмите OK и отправьте лицензию разработчику.
Clipboard := keyencrypted
ExitApp

;------------end of scripts------------;

LicenseCheck:
key = -19j2
try{
   PCdata = %A_username%%A_is64bitos%%A_Language%%A_computername%%A_desktop%
   PCdata = %PCdata%%A_WinDir%%A_OSType%%A_Temp%
   keyencrypted1 := Crypt.Encrypt.StrEncrypt(PCdata,key,, 1)
   keyencrypted := Crypt.Encrypt.StrEncrypt(keyencrypted1,key,, 1)
	;%keyencrypted% <- это переменная, которую должен передать вам ваш пользователь, чтобы вы могли вставить его в файл "users" в вашем репо.
	;Вы можете скопировать ее в буфер обмена или вставить в gui, на ваше усмотрение
   getver := ComObjCreate("WinHttp.WinHttpRequest.5.1")
   ;получите RAW-ссылку на файл "users" в вашем репо. Он будет служить основной базой данных для лицензий пользователей и сроков их действия.
	;Формат для размещения лицензий будет таким: "Имя (необязательно, просто для справки) - лицензионный ключ, который вам дадут ГГГГ/ММ/ДД (дата истечения срока действия)".
	;Пример:
	;JollyJoe - 22jd1-20fawf9f29af09fuofhoa2ufhoau 2023/12/12
	;Вышеприведенное означает: Срок действия лицензии Jollyjoe истекает 12 декабря 2023 года (приложение будет автоматически деактивировано)
	getver.Open("GET", "https://raw.githubusercontent.com/TechGeniusLisichka/FlutteringDream/main/main/users") ;примеры здесь
	getver.Send()
   getver.WaitForResponse()
   dbkey := getver.ResponseText
   pos := InStr(dbkey, keyencrypted) ;проверяет, найден ли %keyencrypted% (1) или нет (0) в %dbkey%
   If (pos > 0) ;теперь проверяется срок действия, если он еще действителен
   {
   expiration := RegExMatch(dbkey, "([0-9]{4}).([0-9]{2}).([0-9]{2})", expiration1, pos)
   exp := RegExReplace(expiration1, "/", "")
   FormatTime, expfinal, %exp%, yyyyMMdd
   Formattime, currentdate, %Date%, yyyyMMdd
		If(expfinal > currentdate || expfinal = currentdate) ;если срок действия не истек
		{
			Gosub, RunApplication
		}
		Else If(expfinal < currentdate) ;если срок действия истек
		{
			Gosub, Expired
		}
		else if (expfinal = "") ;если срок действия истек
	    {
			Gosub, Expired
	    }
	}
	Else if (pos = 0) ;если срок действия истек
	{
		Gosub, Notreg
	}
	Else if (pos = "") ;если срок действия истек
	{
		Gosub, Notreg
	}
return
} catch e {

	MsgBox, 16, Application, Произошла ошибка. Пожалуйста, перезапустите приложение.
	ExitApp
}
Return

;------------------ functions------------------;
/*
Класс Crypt
	В настоящее время содержит два класса и различные методы для шифрования и хеширования
Классы:
	Crypt.Encrypt - класс шифрования
	Crypt.Hash - класс хэширования
=====================================================================
Methods:
=====================================================================
Crypt.Encrypt.FileEncrypt(pFileIn,pFileOut,password,CryptAlg = 1, HashAlg = 1)
	Шифрует файл
Параметры:
	pFileIn - путь к файлу, который необходимо зашифровать
	pFileOut - путь к сохранению зашифрованного файла
	password - нет, это просто пароль...
	(опционально) CryptAlg - идентификатор алгоритма шифрования, подробнее см. ниже
	(необязательно) HashAlg - идентификатор алгоритма хэширования, подробнее см. ниже.
Return:
	при успехе, - количество байт, записанных в pFileOut
	при неудаче, - ""
--------
Crypt.Encrypt.FileDecrypt(pFileIn,pFileOut,password,CryptAlg = 1, HashAlg = 1)
	Расшифровывает файл, параметры идентичны FileEncrypt, за исключением:
	pFileIn - путь к зашифрованному файлу, который необходимо расшифровать
	pFileOut - путь для сохранения расшифрованного файла.
=====================================================================
Crypt.Encrypt.StrEncrypt(string,password,CryptAlg = 1, HashAlg = 1)
	Шифрует строку
Parameters:
	string - UTF-строка, означает любую строку, используемую в AHK_L Unicode
	password - нет, это просто пароль...
	(необязательно) CryptAlg - идентификатор алгоритма шифрования, подробнее см. ниже
	(необязательно) HashAlg - идентификатор алгоритма хэширования, подробнее см. ниже.
Return:
	при успехе - HASH-представление зашифрованного буфера, которое легко передается.
				Получить реальный зашифрованный буфер из HASH можно с помощью функции HashToByte()
	при неудаче - ""
--------
Crypt.Encrypt.StrDecrypt(EncryptedHash,password,CryptAlg = 1, HashAlg = 1)
	Расшифровывает строку, параметры идентичны StrEncrypt, за исключением:
	EncryptedHash - хэш-строка, возвращаемая функцией StrEncrypt().
=====================================================================
Crypt.Hash.FileHash(pFile,HashAlg = 1,pwd = "",hmac_alg = 1)
--------
	Получает HASH файла
Parameters:
	pFile - путь к файлу, хэш которого будет вычислен
	(необязательно) HashAlg - идентификатор алгоритма хэширования, подробнее см. ниже
	(необязательно) pwd - пароль, если он присутствует - алгоритм хеширования будет использовать HMAC для вычисления хеша
	(необязательно) hmac_alg - идентификатор алгоритма шифрования HMAC-ключа, будет использоваться при наличии параметра pwd
Return:
	при успехе, - HASH целевого файла, вычисленный по выбранному алгоритму
	при неудаче, - ""
--------
Crypt.Hash.StrHash(string,HashAlg = 1,pwd = "",hmac_alg = 1)
	Получает HASH строки. HASH будет вычислен для ANSI-представления переданной строки.
Parameters:
	string - строка UTF
	остальные параметры те же, что и для FileHash
=====================================================================
FileEncryptToStr(pFileIn,password,CryptAlg = 1, HashAlg = 1)
--------
	Шифрует файл и возвращает его хэш.
Parameters:
pFileIn - путь к файлу, который будет зашифрован
	password - нет, это просто пароль...
	(необязательно) CryptAlg - идентификатор алгоритма шифрования, подробнее см. ниже
	(необязательно) HashAlg - идентификатор алгоритма хэширования, подробнее см. ниже.
Return:
	при успехе - HASH целевого файла, вычисленный по выбранному алгоритму
	при неудаче - ""
=====================================================================
StrDecryptToFile(EncryptedHash,pFileOut,password,CryptAlg = 1, HashAlg = 1)
	Расшифровывает EncryptedHash в файл и возвращает количество байт, записанных в файл
Parameters:
	EncryptedHash - хэш ранее зашифрованных данных
	pFileOut - путь к файлу назначения, в который будут записаны расшифрованные данные
	password - не может быть, это просто пароль...
	(опционально) CryptAlg - идентификатор алгоритма шифрования, подробнее см. ниже
	(необязательно) HashAlg - идентификатор алгоритма хэширования, подробнее см. ниже.
Return:
	при успехе - количество байт, записанных в файл назначения
	при неудаче - ""
=====================================================================
Crypt.Encrypt  содержит следующие поля
Crypt.Encrypt.StrEncoding - кодировка строки, передаваемой в Crypt.Encrypt.StrEncrypt()
Crypt.Encrypt.PassEncoding - кодировка пароля для каждого из методов Crypt.Encrypt

То же самое справедливо и для класса Crypt.Hash

Доступные на данный момент алгоритмы HASH и Encryption
HashAlg IDs:
1 - MD5
2 - MD2
3 - SHA
4 - SHA_256	;Vista+ only
5 - SHA_384	;Vista+ only
6 - SHA_512	;Vista+ only
--------
Идентификаторы CryptAlg и hmac_alg:
1 - RC4
2 - RC2
3 - 3DES
4 - 3DES_112
5 - AES_128 ;not supported for win 2000
6 - AES_192 ;not supported for win 2000
7 - AES_256 ;not supported for win 2000
=====================================================================

*/

class Crypt
{
	class Encrypt
	{
		static StrEncoding := "UTF-16"
		static PassEncoding := "UTF-16"

		StrDecryptToFile(EncryptedHash,pFileOut,password,CryptAlg = 1, HashAlg = 1)
		{
			if !EncryptedHash
				return ""
			if !len := b64Decode( EncryptedHash, encr_Buf )
				return ""
			temp_file := "crypt.temp"
			f := FileOpen(temp_file,"w","CP0")
			if !IsObject(f)
				return ""
			if !f.RawWrite(encr_Buf,len)
				return ""
			f.close()
			bytes := this._Encrypt( p, pp, password, 0, temp_file, pFileOut, CryptAlg, HashAlg )
			FileDelete,% temp_file
			return bytes
		}

		FileEncryptToStr(pFileIn,password,CryptAlg = 1, HashAlg = 1)
		{
			temp_file := "crypt.temp"
			if !this._Encrypt( p, pp, password, 1, pFileIn, temp_file, CryptAlg, HashAlg )
				return ""
			f := FileOpen(temp_file,"r","CP0")
			if !IsObject(f)
			{
				FileDelete,% temp_file
				return ""
			}
			f.Pos := 0
			fLen := f.Length
			VarSetCapacity(tembBuf,fLen,0)
			if !f.RawRead(tembBuf,fLen)
			{
				Free(tembBuf)
				return ""
			}
			f.Close()
			FileDelete,% temp_file
			return b64Encode( tembBuf, fLen )
		}

		FileEncrypt(pFileIn,pFileOut,password,CryptAlg = 1, HashAlg = 1)
		{
			return this._Encrypt( p, pp, password, 1, pFileIn, pFileOut, CryptAlg, HashAlg )
		}

		FileDecrypt(pFileIn,pFileOut,password,CryptAlg = 1, HashAlg = 1)
		{
			return this._Encrypt( p, pp, password, 0, pFileIn, pFileOut, CryptAlg, HashAlg )
		}

		StrEncrypt(string,password,CryptAlg = 1, HashAlg = 1)
		{
			len := StrPutVar(string, str_buf,100,this.StrEncoding)
			if this._Encrypt(str_buf,len, password, 1,0,0,CryptAlg,HashAlg)
				return b64Encode( str_buf, len )
			else
				return ""
		}

		StrDecrypt(EncryptedHash,password,CryptAlg = 1, HashAlg = 1)
		{
			if !EncryptedHash
				return ""
			if !len := b64Decode( EncryptedHash, encr_Buf )
				return 0
			if sLen := this._Encrypt(encr_Buf,len, password, 0,0,0,CryptAlg,HashAlg)
			{
				if ( this.StrEncoding = "utf-16" || this.StrEncoding = "cp1200" )
					sLen /= 2
				return strget(&encr_Buf,sLen,this.StrEncoding)
			}
			else
				return ""
		}

		_Encrypt(ByRef encr_Buf,ByRef Buf_Len, password, mode, pFileIn=0, pFileOut=0, CryptAlg = 1,HashAlg = 1)	;mode - 1 encrypt, 0 - decrypt
		{
			c := CryptConst
			;password hashing algorithms
			CUR_PWD_HASH_ALG := HashAlg == 1 || HashAlg = "MD5" ?c.CALG_MD5
												:HashAlg==2 || HashAlg = "MD2" 	?c.CALG_MD2
												:HashAlg==3 || HashAlg = "SHA"	?c.CALG_SHA
												:HashAlg==4 || HashAlg = "SHA256" ?c.CALG_SHA_256	;Vista+ only
												:HashAlg==5 || HashAlg = "SHA384" ?c.CALG_SHA_384	;Vista+ only
												:HashAlg==6 || HashAlg = "SHA512" ?c.CALG_SHA_512	;Vista+ only
												:0
			;encryption algorithms
			CUR_ENC_ALG 	:= CryptAlg==1 || CryptAlg = "RC4" 			? ( c.CALG_RC4, KEY_LENGHT:=0x80 )
											:CryptAlg==2 || CryptAlg = "RC2" 		? ( c.CALG_RC2, KEY_LENGHT:=0x80 )
											:CryptAlg==3 || CryptAlg = "3DES" 		? ( c.CALG_3DES, KEY_LENGHT:=0xC0 )
											:CryptAlg==4 || CryptAlg = "3DES112" ? ( c.CALG_3DES_112, KEY_LENGHT:=0x80 )
											:CryptAlg==5 || CryptAlg = "AES128" 	? ( c.CALG_AES_128, KEY_LENGHT:=0x80 ) ;not supported for win 2000
											:CryptAlg==6 || CryptAlg = "AES192" 	? ( c.CALG_AES_192, KEY_LENGHT:=0xC0 )	;not supported for win 2000
											:CryptAlg==7 || CryptAlg = "AES256" 	? ( c.CALG_AES_256, KEY_LENGHT:=0x100 )	;not supported for win 2000
											:0
			KEY_LENGHT <<= 16
			if (CUR_PWD_HASH_ALG = 0 || CUR_ENC_ALG = 0)
				return 0

			if !dllCall("Advapi32\CryptAcquireContextW","Ptr*",hCryptProv,"Uint",0,"Uint",0,"Uint",c.PROV_RSA_AES,"UInt",c.CRYPT_VERIFYCONTEXT)
					{foo := "CryptAcquireContextW", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}
			if !dllCall("Advapi32\CryptCreateHash","Ptr",hCryptProv,"Uint",CUR_PWD_HASH_ALG,"Uint",0,"Uint",0,"Ptr*",hHash )
					{foo := "CryptCreateHash", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}
			;hashing password
			passLen := StrPutVar(password, passBuf,0,this.PassEncoding)
			if !dllCall("Advapi32\CryptHashData","Ptr",hHash,"Ptr",&passBuf,"Uint",passLen,"Uint",0 )
					{foo := "CryptHashData", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}
			;getting encryption key from password
			if !dllCall("Advapi32\CryptDeriveKey","Ptr",hCryptProv,"Uint",CUR_ENC_ALG,"Ptr",hHash,"Uint",KEY_LENGHT,"Ptr*",hKey )
					{foo := "CryptDeriveKey", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}
			;~ SetKeySalt(hKey,hCryptProv)
			if !dllCall("Advapi32\CryptGetKeyParam","Ptr",hKey,"Uint",c.KP_BLOCKLEN,"Uint*",BlockLen,"Uint*",dwCount := 4,"Uint",0)
					{foo := "CryptGetKeyParam", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}
			BlockLen /= 8
			if (mode == 1)							;Encrypting
			{
				if (pFileIn && pFileOut)			;encrypting file
				{
					ReadBufSize := 10240 - mod(10240,BlockLen==0?1:BlockLen )	;10KB
					pfin := FileOpen(pFileIn,"r","CP0")
					pfout := FileOpen(pFileOut,"w","CP0")
					if !IsObject(pfin)
						{foo := "File Opening " . pFileIn
						GoTO FINITA_LA_COMEDIA
						}
					if !IsObject(pfout)
						{foo := "File Opening " . pFileOut
						GoTO FINITA_LA_COMEDIA
						}
					pfin.Pos := 0
					VarSetCapacity(ReadBuf,ReadBufSize+BlockLen,0)
					isFinal := 0
					hModule := DllCall("LoadLibrary", "Str", "Advapi32.dll","UPtr")
					CryptEnc := DllCall("GetProcAddress", "Ptr", hModule, "AStr", "CryptEncrypt","UPtr")
					while !pfin.AtEOF
					{
						BytesRead := pfin.RawRead(ReadBuf, ReadBufSize)
						if pfin.AtEOF
							isFinal := 1
						if !dllCall(CryptEnc
								,"Ptr",hKey	;key
								,"Ptr",0	;hash
								,"Uint",isFinal	;final
								,"Uint",0	;dwFlags
								,"Ptr",&ReadBuf	;pbdata
								,"Uint*",BytesRead	;dwsize
								,"Uint",ReadBufSize+BlockLen )	;dwbuf
						{foo := "CryptEncrypt", err := GetLastError(), err2 := ErrorLevel
						GoTO FINITA_LA_COMEDIA
						}
						pfout.RawWrite(ReadBuf,BytesRead)
						Buf_Len += BytesRead
					}
					DllCall("FreeLibrary", "Ptr", hModule)
					pfin.Close()
					pfout.Close()
				}
				else
				{
					if !dllCall("Advapi32\CryptEncrypt"
								,"Ptr",hKey	;key
								,"Ptr",0	;hash
								,"Uint",1	;final
								,"Uint",0	;dwFlags
								,"Ptr",&encr_Buf	;pbdata
								,"Uint*",Buf_Len	;dwsize
								,"Uint",Buf_Len + BlockLen )	;dwbuf
					{foo := "CryptEncrypt", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}
				}
			}
			else if (mode == 0)								;decrypting
			{
				if (pFileIn && pFileOut)					;decrypting file
				{
					ReadBufSize := 10240 - mod(10240,BlockLen==0?1:BlockLen )	;10KB
					pfin := FileOpen(pFileIn,"r","CP0")
					pfout := FileOpen(pFileOut,"w","CP0")
					if !IsObject(pfin)
						{foo := "File Opening " . pFileIn
						GoTO FINITA_LA_COMEDIA
						}
					if !IsObject(pfout)
						{foo := "File Opening " . pFileOut
						GoTO FINITA_LA_COMEDIA
						}
					pfin.Pos := 0
					VarSetCapacity(ReadBuf,ReadBufSize+BlockLen,0)
					isFinal := 0
					hModule := DllCall("LoadLibrary", "Str", "Advapi32.dll","UPtr")
					CryptDec := DllCall("GetProcAddress", "Ptr", hModule, "AStr", "CryptDecrypt","UPtr")
					while !pfin.AtEOF
					{
						BytesRead := pfin.RawRead(ReadBuf, ReadBufSize)
						if pfin.AtEOF
							isFinal := 1
						if !dllCall(CryptDec
								,"Ptr",hKey	;key
								,"Ptr",0	;hash
								,"Uint",isFinal	;final
								,"Uint",0	;dwFlags
								,"Ptr",&ReadBuf	;pbdata
								,"Uint*",BytesRead )	;dwsize
						{foo := "CryptDecrypt", err := GetLastError(), err2 := ErrorLevel
						GoTO FINITA_LA_COMEDIA
						}
						pfout.RawWrite(ReadBuf,BytesRead)
						Buf_Len += BytesRead
					}
					DllCall("FreeLibrary", "Ptr", hModule)
					pfin.Close()
					pfout.Close()

				}
				else if !dllCall("Advapi32\CryptDecrypt"
								,"Ptr",hKey	;key
								,"Ptr",0	;hash
								,"Uint",1	;final
								,"Uint",0	;dwFlags
								,"Ptr",&encr_Buf	;pbdata
								,"Uint*",Buf_Len )	;dwsize
					{foo := "CryptDecrypt", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_LA_COMEDIA
					}
			}
FINITA_LA_COMEDIA:
			dllCall("Advapi32\CryptDestroyKey","Ptr",hKey )
			dllCall("Advapi32\CryptDestroyHash","Ptr",hHash)
			dllCall("Advapi32\CryptReleaseContext","Ptr",hCryptProv,"UInt",0)
			if (A_ThisLabel = "FINITA_LA_COMEDIA")
			{
				if (A_IsCompiled = 1)
					return ""
				else
					msgbox % foo " call failed with:`nErrorLevel: " err2 "`nLastError: " err "`n" ErrorFormat(err)
				return ""
			}
			return Buf_Len
		}
	}

	class Hash
	{
		static StrEncoding := "CP0"
		static PassEncoding := "UTF-16"

		FileHash(pFile,HashAlg = 1,pwd = "",hmac_alg = 1)
		{
			return this._CalcHash(p,pp,pFile,HashAlg,pwd,hmac_alg)
		}

		StrHash(string,HashAlg = 1,pwd = "",hmac_alg = 1)		;strType 1 for ASC, 0 for UTF
		{
			buf_len := StrPutVar(string, buf,0,this.StrEncoding)
			return this._CalcHash(buf,buf_len,0,HashAlg,pwd,hmac_alg)
		}

		_CalcHash(ByRef bBuffer,BufferLen,pFile,HashAlg = 1,pwd = "",hmac_alg = 1)
		{
			c := CryptConst
			;password hashing algorithms
			HASH_ALG := HashAlg==1?c.CALG_MD5
						:HashAlg==2?c.CALG_MD2
						:HashAlg==3?c.CALG_SHA
						:HashAlg==4?c.CALG_SHA_256	;Vista+ only
						:HashAlg==5?c.CALG_SHA_384	;Vista+ only
						:HashAlg==6?c.CALG_SHA_512	;Vista+ only
						:0
			;encryption algorithms
			HMAC_KEY_ALG 	:= hmac_alg==1?c.CALG_RC4
								:hmac_alg==2?c.CALG_RC2
								:hmac_alg==3?c.CALG_3DES
								:hmac_alg==4?c.CALG_3DES_112
								:hmac_alg==5?c.CALG_AES_128 ;not supported for win 2000
								:hmac_alg==6?c.CALG_AES_192	;not supported for win 2000
								:hmac_alg==7?c.CALG_AES_256	;not supported for win 2000
								:0
			KEY_LENGHT 		:= hmac_alg==1?0x80
								:hmac_alg==2?0x80
								:hmac_alg==3?0xC0
								:hmac_alg==4?0x80
								:hmac_alg==5?0x80
								:hmac_alg==6?0xC0
								:hmac_alg==7?0x100
								:0
			KEY_LENGHT <<= 16
			if (!HASH_ALG || !HMAC_KEY_ALG)
				return 0
			if !dllCall("Advapi32\CryptAcquireContextW","Ptr*",hCryptProv,"Uint",0,"Uint",0,"Uint",c.PROV_RSA_AES,"UInt",c.CRYPT_VERIFYCONTEXT )
				{foo := "CryptAcquireContextW", err := GetLastError(), err2 := ErrorLevel
				GoTO FINITA_DA_COMEDIA
				}
			if !dllCall("Advapi32\CryptCreateHash","Ptr",hCryptProv,"Uint",HASH_ALG,"Uint",0,"Uint",0,"Ptr*",hHash )
				{foo := "CryptCreateHash1", err := GetLastError(), err2 := ErrorLevel
				GoTO FINITA_DA_COMEDIA
				}

			if (pwd != "")			;going HMAC
			{
				passLen := StrPutVar(pwd, passBuf,0,this.PassEncoding)
				if !dllCall("Advapi32\CryptHashData","Ptr",hHash,"Ptr",&passBuf,"Uint",passLen,"Uint",0 )
					{foo := "CryptHashData Pwd", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_DA_COMEDIA
					}
				;getting encryption key from password
				if !dllCall("Advapi32\CryptDeriveKey","Ptr",hCryptProv,"Uint",HMAC_KEY_ALG,"Ptr",hHash,"Uint",KEY_LENGHT,"Ptr*",hKey )
					{foo := "CryptDeriveKey Pwd", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_DA_COMEDIA
					}
				dllCall("Advapi32\CryptDestroyHash","Ptr",hHash)
				if !dllCall("Advapi32\CryptCreateHash","Ptr",hCryptProv,"Uint",c.CALG_HMAC,"Ptr",hKey,"Uint",0,"Ptr*",hHash )
					{foo := "CryptCreateHash2", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_DA_COMEDIA
					}
				VarSetCapacity(HmacInfoStruct,4*A_PtrSize + 4,0)
				NumPut(HASH_ALG,HmacInfoStruct,0,"UInt")
				if !dllCall("Advapi32\CryptSetHashParam","Ptr",hHash,"Uint",c.HP_HMAC_INFO,"Ptr",&HmacInfoStruct,"Uint",0)
					{foo := "CryptSetHashParam", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_DA_COMEDIA
					}
			}

			if pFile
			{
				f := FileOpen(pFile,"r","CP0")
				BUFF_SIZE := 1024 * 1024 ; 1 MB
				if !IsObject(f)
					{foo := "File Opening"
					GoTO FINITA_DA_COMEDIA
					}
				if !hModule := DllCall( "GetModuleHandleW", "str", "Advapi32.dll", "UPtr" )
					hModule := DllCall( "LoadLibraryW", "str", "Advapi32.dll", "UPtr" )
				hCryptHashData := DllCall("GetProcAddress", "Ptr", hModule, "AStr", "CryptHashData", "UPtr")
				VarSetCapacity(read_buf,BUFF_SIZE,0)
				f.Pos := 0
				While (cbCount := f.RawRead(read_buf, BUFF_SIZE))
				{
					if (cbCount = 0)
						break
					if !dllCall(hCryptHashData
								,"Ptr",hHash
								,"Ptr",&read_buf
								,"Uint",cbCount
								,"Uint",0 )
						{foo := "CryptHashData", err := GetLastError(), err2 := ErrorLevel
						GoTO FINITA_DA_COMEDIA
						}
				}
				f.Close()
			}
			else
			{
				if !dllCall("Advapi32\CryptHashData"
							,"Ptr",hHash
							,"Ptr",&bBuffer
							,"Uint",BufferLen
							,"Uint",0 )
					{foo := "CryptHashData", err := GetLastError(), err2 := ErrorLevel
					GoTO FINITA_DA_COMEDIA
					}
			}
			if !dllCall("Advapi32\CryptGetHashParam","Ptr",hHash,"Uint",c.HP_HASHSIZE,"Uint*",HashLen,"Uint*",HashLenSize := 4,"UInt",0 )
				{foo := "CryptGetHashParam HP_HASHSIZE", err := GetLastError(), err2 := ErrorLevel
				GoTO FINITA_DA_COMEDIA
				}
			VarSetCapacity(pbHash,HashLen,0)
			if !dllCall("Advapi32\CryptGetHashParam","Ptr",hHash,"Uint",c.HP_HASHVAL,"Ptr",&pbHash,"Uint*",HashLen,"UInt",0 )
				{foo := "CryptGetHashParam HP_HASHVAL", err := GetLastError(), err2 := ErrorLevel
				GoTO FINITA_DA_COMEDIA
				}
			hashval := b2a_hex( pbHash, HashLen )

		FINITA_DA_COMEDIA:
			DllCall("FreeLibrary", "Ptr", hModule)
			dllCall("Advapi32\CryptDestroyHash","Ptr",hHash)
			dllCall("Advapi32\CryptDestroyKey","Ptr",hKey )
			dllCall("Advapi32\CryptReleaseContext","Ptr",hCryptProv,"UInt",0)
			if (A_ThisLabel = "FINITA_LA_COMEDIA")
			{
				if (A_IsCompiled = 1)
					return ""
				else
					msgbox % foo " call failed with:`nErrorLevel: " err2 "`nLastError: " err "`n" ErrorFormat(err)
				return 0
			}
			return hashval
		}
	}
}

;returns positive hex value of last error
GetLastError()
{
	return ToHex(A_LastError < 0 ? A_LastError & 0xFFFFFFFF : A_LastError)
}

;converting decimal to hex value
ToHex(num)
{
	if num is not integer
		return num
	oldFmt := A_FormatInteger
	SetFormat, integer, hex
	num := num + 0
	SetFormat, integer,% oldFmt
	return num
}

;And this function returns error description based on error number passed. ;
;Error number is one returned by GetLastError() or from A_LastError
ErrorFormat(error_id)
{
	VarSetCapacity(msg,1000,0)
	if !len := DllCall("FormatMessageW"
				,"UInt",FORMAT_MESSAGE_FROM_SYSTEM := 0x00001000 | FORMAT_MESSAGE_IGNORE_INSERTS := 0x00000200		;dwflags
				,"Ptr",0		;lpSource
				,"UInt",error_id	;dwMessageId
				,"UInt",0			;dwLanguageId
				,"Ptr",&msg			;lpBuffer
				,"UInt",500)			;nSize
		return
	return 	strget(&msg,len)
}

StrPutVar(string, ByRef var, addBufLen = 0,encoding="UTF-16")
{
	; Ensure capacity.
	; StrPut returns char count, but VarSetCapacity needs bytes.
	tlen := ((encoding="utf-16"||encoding="cp1200") ? 2 : 1)
	str_len := StrPut(string, encoding) * tlen
    VarSetCapacity( var, str_len + addBufLen,0 )
    ; Copy or convert the string.
	StrPut( string, &var, encoding )
    return str_len - tlen
}

SetKeySalt(hKey,hProv)
{
	KP_SALT_EX := 10
	SALT := "89ABF9C1005EDD40"
	;~ len := HashToByte(SALT,pb)
	VarSetCapacity(st,2*A_PtrSize,0)
	NumPut(len,st,0,"UInt")
	NumPut(&pb,st,A_PtrSize,"UPtr")
	if !dllCall("Advapi32\CryptSetKeyParam"
				,"Ptr",hKey
				,"Uint",KP_SALT_EX
				,"Ptr",&st
				,"Uint",0)
		msgbox % ErrorFormat(GetLastError())
}

GetKeySalt(hKey)
{
	KP_IV := 1       ; Initialization vector
	KP_SALT := 2       ; Salt value
	if !dllCall("Advapi32\CryptGetKeyParam"
				,"Ptr",hKey
				,"Uint",KP_SALT
				,"Uint",0
				,"Uint*",dwCount
				,"Uint",0)
	msgbox % "Fail to get SALT length."
	msgbox % "SALT length.`n" dwCount
	VarSetCapacity(pb,dwCount,0)
	if !dllCall("Advapi32\CryptGetKeyParam"
				,"Ptr",hKey
				,"Uint",KP_SALT
				,"Ptr",&pb
				,"Uint*",dwCount
				,"Uint",0)
	msgbox % "Fail to get SALT"
	;~ msgbox % ByteToHash(pb,dwCount) "`n" dwCount
}

class CryptConst
{
static ALG_CLASS_ANY := (0)
static ALG_CLASS_SIGNATURE := (1 << 13)
static ALG_CLASS_MSG_ENCRYPT := (2 << 13)
static ALG_CLASS_DATA_ENCRYPT := (3 << 13)
static ALG_CLASS_HASH := (4 << 13)
static ALG_CLASS_KEY_EXCHANGE := (5 << 13)
static ALG_CLASS_ALL := (7 << 13)
static ALG_TYPE_ANY := (0)
static ALG_TYPE_DSS := (1 << 9)
static ALG_TYPE_RSA := (2 << 9)
static ALG_TYPE_BLOCK := (3 << 9)
static ALG_TYPE_STREAM := (4 << 9)
static ALG_TYPE_DH := (5 << 9)
static ALG_TYPE_SECURECHANNEL := (6 << 9)
static ALG_SID_ANY := (0)
static ALG_SID_RSA_ANY := 0
static ALG_SID_RSA_PKCS := 1
static ALG_SID_RSA_MSATWORK := 2
static ALG_SID_RSA_ENTRUST := 3
static ALG_SID_RSA_PGP := 4
static ALG_SID_DSS_ANY := 0
static ALG_SID_DSS_PKCS := 1
static ALG_SID_DSS_DMS := 2
static ALG_SID_ECDSA := 3
static ALG_SID_DES := 1
static ALG_SID_3DES := 3
static ALG_SID_DESX := 4
static ALG_SID_IDEA := 5
static ALG_SID_CAST := 6
static ALG_SID_SAFERSK64 := 7
static ALG_SID_SAFERSK128 := 8
static ALG_SID_3DES_112 := 9
static ALG_SID_CYLINK_MEK := 12
static ALG_SID_RC5 := 13
static ALG_SID_AES_128 := 14
static ALG_SID_AES_192 := 15
static ALG_SID_AES_256 := 16
static ALG_SID_AES := 17
static ALG_SID_SKIPJACK := 10
static ALG_SID_TEK := 11
static CRYPT_MODE_CBCI := 6       ; ANSI CBC Interleaved
static CRYPT_MODE_CFBP := 7       ; ANSI CFB Pipelined
static CRYPT_MODE_OFBP := 8       ; ANSI OFB Pipelined
static CRYPT_MODE_CBCOFM := 9       ; ANSI CBC + OF Masking
static CRYPT_MODE_CBCOFMI := 10      ; ANSI CBC + OFM Interleaved
static ALG_SID_RC2 := 2
static ALG_SID_RC4 := 1
static ALG_SID_SEAL := 2
static ALG_SID_DH_SANDF := 1
static ALG_SID_DH_EPHEM := 2
static ALG_SID_AGREED_KEY_ANY := 3
static ALG_SID_KEA := 4
static ALG_SID_ECDH := 5
static ALG_SID_MD2 := 1
static ALG_SID_MD4 := 2
static ALG_SID_MD5 := 3
static ALG_SID_SHA := 4
static ALG_SID_SHA1 := 4
static ALG_SID_MAC := 5
static ALG_SID_RIPEMD := 6
static ALG_SID_RIPEMD160 := 7
static ALG_SID_SSL3SHAMD5 := 8
static ALG_SID_HMAC := 9
static ALG_SID_TLS1PRF := 10
static ALG_SID_HASH_REPLACE_OWF := 11
static ALG_SID_SHA_256 := 12
static ALG_SID_SHA_384 := 13
static ALG_SID_SHA_512 := 14
static ALG_SID_SSL3_MASTER := 1
static ALG_SID_SCHANNEL_MASTER_HASH := 2
static ALG_SID_SCHANNEL_MAC_KEY := 3
static ALG_SID_PCT1_MASTER := 4
static ALG_SID_SSL2_MASTER := 5
static ALG_SID_TLS1_MASTER := 6
static ALG_SID_SCHANNEL_ENC_KEY := 7
static ALG_SID_ECMQV := 1
static ALG_SID_EXAMPLE := 80
static CALG_MD2 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_MD2)
static CALG_MD4 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_MD4)
static CALG_MD5 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_MD5)
static CALG_SHA := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_SHA)
static CALG_SHA1 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_SHA1)
static CALG_MAC := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_MAC)
static CALG_RSA_SIGN := (CryptConst.ALG_CLASS_SIGNATURE | CryptConst.ALG_TYPE_RSA | CryptConst.ALG_SID_RSA_ANY)
static CALG_DSS_SIGN := (CryptConst.ALG_CLASS_SIGNATURE | CryptConst.ALG_TYPE_DSS | CryptConst.ALG_SID_DSS_ANY)
static CALG_NO_SIGN := (CryptConst.ALG_CLASS_SIGNATURE | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_ANY)
static CALG_RSA_KEYX := (CryptConst.ALG_CLASS_KEY_EXCHANGE|CryptConst.ALG_TYPE_RSA|CryptConst.ALG_SID_RSA_ANY)
static CALG_DES := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_DES)
static CALG_3DES_112 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_3DES_112)
static CALG_3DES := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_3DES)
static CALG_DESX := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_DESX)
static CALG_RC2 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_RC2)
static CALG_RC4 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_STREAM|CryptConst.ALG_SID_RC4)
static CALG_SEAL := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_STREAM|CryptConst.ALG_SID_SEA)
static CALG_DH_SF := (CryptConst.ALG_CLASS_KEY_EXCHANGE|CryptConst.ALG_TYPE_DH|CryptConst.ALG_SID_DH_SANDF)
static CALG_DH_EPHEM := (CryptConst.ALG_CLASS_KEY_EXCHANGE|CryptConst.ALG_TYPE_DH|CryptConst.ALG_SID_DH_EPHEM)
static CALG_AGREEDKEY_ANY := (CryptConst.ALG_CLASS_KEY_EXCHANGE|CryptConst.ALG_TYPE_DH|CryptConst.ALG_SID_AGREED_KEY_ANY)
static CALG_KEA_KEYX := (CryptConst.ALG_CLASS_KEY_EXCHANGE|CryptConst.ALG_TYPE_DH|CryptConst.ALG_SID_KEA)
static CALG_HUGHES_MD5 := (CryptConst.ALG_CLASS_KEY_EXCHANGE|CryptConst.ALG_TYPE_ANY|CryptConst.ALG_SID_MD5)
static CALG_SKIPJACK := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_SKIPJACK)
static CALG_TEK := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_TEK)
static CALG_CYLINK_MEK := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_CYLINK_MEK)
static CALG_SSL3_SHAMD5 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_SSL3SHAMD5)
static CALG_SSL3_MASTER := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_SSL3_MASTER)
static CALG_SCHANNEL_MASTER_HASH := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_SCHANNEL_MASTER_HASH)
static CALG_SCHANNEL_MAC_KEY := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_SCHANNEL_MAC_KEY)
static CALG_SCHANNEL_ENC_KEY := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_SCHANNEL_ENC_KEY)
static CALG_PCT1_MASTER := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_PCT1_MASTER)
static CALG_SSL2_MASTER := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_SSL2_MASTER)
static CALG_TLS1_MASTER := (CryptConst.ALG_CLASS_MSG_ENCRYPT|CryptConst.ALG_TYPE_SECURECHANNEL|CryptConst.ALG_SID_TLS1_MASTER)
static CALG_RC5 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_RC5)
static CALG_HMAC := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_HMAC)
static CALG_TLS1PRF := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_TLS1PRF)
static CALG_HASH_REPLACE_OWF := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_HASH_REPLACE_OWF)
static CALG_AES_128 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_AES_128)
static CALG_AES_192 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_AES_192)
static CALG_AES_256 := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_AES_256)
static CALG_AES := (CryptConst.ALG_CLASS_DATA_ENCRYPT|CryptConst.ALG_TYPE_BLOCK|CryptConst.ALG_SID_AES)
static CALG_SHA_256 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_SHA_256)
static CALG_SHA_384 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_SHA_384)
static CALG_SHA_512 := (CryptConst.ALG_CLASS_HASH | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_SHA_512)
static CALG_ECDH := (CryptConst.ALG_CLASS_KEY_EXCHANGE | CryptConst.ALG_TYPE_DH | CryptConst.ALG_SID_ECDH)
static CALG_ECMQV := (CryptConst.ALG_CLASS_KEY_EXCHANGE | CryptConst.ALG_TYPE_ANY | CryptConst.ALG_SID_ECMQV)
static CALG_ECDSA := (CryptConst.ALG_CLASS_SIGNATURE | CryptConst.ALG_TYPE_DSS | CryptConst.ALG_SID_ECDSA)
static CRYPT_VERIFYCONTEXT := 0xF0000000
static CRYPT_NEWKEYSET := 0x00000008
static CRYPT_DELETEKEYSET := 0x00000010
static CRYPT_MACHINE_KEYSET := 0x00000020
static CRYPT_SILENT := 0x00000040
static CRYPT_DEFAULT_CONTAINER_OPTIONAL := 0x00000080
static CRYPT_EXPORTABLE := 0x00000001
static CRYPT_USER_PROTECTED := 0x00000002
static CRYPT_CREATE_SALT := 0x00000004
static CRYPT_UPDATE_KEY := 0x00000008
static CRYPT_NO_SALT := 0x00000010
static CRYPT_PREGEN := 0x00000040
static CRYPT_RECIPIENT := 0x00000010
static CRYPT_INITIATOR := 0x00000040
static CRYPT_ONLINE := 0x00000080
static CRYPT_SF := 0x00000100
static CRYPT_CREATE_IV := 0x00000200
static CRYPT_KEK := 0x00000400
static CRYPT_DATA_KEY := 0x00000800
static CRYPT_VOLATILE := 0x00001000
static CRYPT_SGCKEY := 0x00002000
static CRYPT_ARCHIVABLE := 0x00004000
static CRYPT_FORCE_KEY_PROTECTION_HIGH := 0x00008000
static RSA1024BIT_KEY := 0x04000000
static CRYPT_SERVER := 0x00000400
static KEY_LENGTH_MASK := 0xFFFF0000
static CRYPT_Y_ONLY := 0x00000001
static CRYPT_SSL2_FALLBACK := 0x00000002
static CRYPT_DESTROYKEY := 0x00000004
static CRYPT_OAEP := 0x00000040  ; used with RSA encryptions/decryptions
static CRYPT_BLOB_VER3 := 0x00000080  ; export version 3 of a blob type
static CRYPT_IPSEC_HMAC_KEY := 0x00000100  ; CryptImportKey only
static CRYPT_DECRYPT_RSA_NO_PADDING_CHECK := 0x00000020
static CRYPT_SECRETDIGEST := 0x00000001
static CRYPT_OWF_REPL_LM_HASH := 0x00000001  ; this is only for the OWF replacement CSP
static CRYPT_LITTLE_ENDIAN := 0x00000001
static CRYPT_NOHASHOID := 0x00000001
static CRYPT_TYPE2_FORMAT := 0x00000002
static CRYPT_X931_FORMAT := 0x00000004
static CRYPT_MACHINE_DEFAULT := 0x00000001
static CRYPT_USER_DEFAULT := 0x00000002
static CRYPT_DELETE_DEFAULT := 0x00000004
static SIMPLEBLOB := 0x1
static PUBLICKEYBLOB := 0x6
static PRIVATEKEYBLOB := 0x7
static PLAINTEXTKEYBLOB := 0x8
static OPAQUEKEYBLOB := 0x9
static PUBLICKEYBLOBEX := 0xA
static SYMMETRICWRAPKEYBLOB := 0xB
static KEYSTATEBLOB := 0xC
static AT_KEYEXCHANGE := 1
static AT_SIGNATURE := 2
static CRYPT_USERDATA := 1
static KP_IV := 1       ; Initialization vector
static KP_SALT := 2       ; Salt value
static KP_PADDING := 3       ; Padding values
static KP_MODE := 4       ; Mode of the cipher
static KP_MODE_BITS := 5       ; Number of bits to feedback
static KP_PERMISSIONS := 6       ; Key permissions DWORD
static KP_ALGID := 7       ; Key algorithm
static KP_BLOCKLEN := 8       ; Block size of the cipher
static KP_KEYLEN := 9       ; Length of key in bits
static KP_SALT_EX := 10      ; Length of salt in bytes
static KP_P := 11      ; DSS/Diffie-Hellman P value
static KP_G := 12      ; DSS/Diffie-Hellman G value
static KP_Q := 13      ; DSS Q value
static KP_X := 14      ; Diffie-Hellman X value
static KP_Y := 15      ; Y value
static KP_RA := 16      ; Fortezza RA value
static KP_RB := 17      ; Fortezza RB value
static KP_INFO := 18      ; for putting information into an RSA envelope
static KP_EFFECTIVE_KEYLEN := 19      ; setting and getting RC2 effective key length
static KP_SCHANNEL_ALG := 20      ; for setting the Secure Channel algorithms
static KP_CLIENT_RANDOM := 21      ; for setting the Secure Channel client random data
static KP_SERVER_RANDOM := 22      ; for setting the Secure Channel server random data
static KP_RP := 23
static KP_PRECOMP_MD5 := 24
static KP_PRECOMP_SHA := 25
static KP_CERTIFICATE := 26      ; for setting Secure Channel certificate data (PCT1)
static KP_CLEAR_KEY := 27      ; for setting Secure Channel clear key data (PCT1)
static KP_PUB_EX_LEN := 28
static KP_PUB_EX_VAL := 29
static KP_KEYVAL := 30
static KP_ADMIN_PIN := 31
static KP_KEYEXCHANGE_PIN := 32
static KP_SIGNATURE_PIN := 33
static KP_PREHASH := 34
static KP_ROUNDS := 35
static KP_OAEP_PARAMS := 36      ; for setting OAEP params on RSA keys
static KP_CMS_KEY_INFO := 37
static KP_CMS_DH_KEY_INFO := 38
static KP_PUB_PARAMS := 39      ; for setting public parameters
static KP_VERIFY_PARAMS := 40      ; for verifying DSA and DH parameters
static KP_HIGHEST_VERSION := 41      ; for TLS protocol version setting
static KP_GET_USE_COUNT := 42      ; for use with PP_CRYPT_COUNT_KEY_USE contexts
static KP_PIN_ID := 43
static KP_PIN_INFO := 44
static HP_ALGID := 0x0001  ; Hash algorithm
static HP_HASHVAL := 0x0002  ; Hash value
static HP_HASHSIZE := 0x0004  ; Hash value size
static HP_HMAC_INFO := 0x0005  ; information for creating an HMAC
static HP_TLS1PRF_LABEL := 0x0006  ; label for TLS1 PRF
static HP_TLS1PRF_SEED := 0x0007  ; seed for TLS1 PRF
static PROV_RSA_FULL := 1
static PROV_RSA_SIG := 2
static PROV_DSS := 3
static PROV_FORTEZZA := 4
static PROV_MS_EXCHANGE := 5
static PROV_SSL := 6
static PROV_RSA_SCHANNEL := 12
static PROV_DSS_DH := 13
static PROV_EC_ECDSA_SIG := 14
static PROV_EC_ECNRA_SIG := 15
static PROV_EC_ECDSA_FULL := 16
static PROV_EC_ECNRA_FULL := 17
static PROV_DH_SCHANNEL := 18
static PROV_SPYRUS_LYNKS := 20
static PROV_RNG := 21
static PROV_INTEL_SEC := 22
static PROV_REPLACE_OWF := 23
static PROV_RSA_AES := 24
static PROV_STT_MER := 7
static PROV_STT_ACQ := 8
static PROV_STT_BRND := 9
static PROV_STT_ROOT := 10
static PROV_STT_ISS := 11
}

b64Encode( ByRef buf, bufLen )
{
	DllCall( "crypt32\CryptBinaryToStringA", "ptr", &buf, "UInt", bufLen, "Uint", 1 | 0x40000000, "Ptr", 0, "UInt*", outLen )
	VarSetCapacity( outBuf, outLen, 0 )
	DllCall( "crypt32\CryptBinaryToStringA", "ptr", &buf, "UInt", bufLen, "Uint", 1 | 0x40000000, "Ptr", &outBuf, "UInt*", outLen )
	return strget( &outBuf, outLen, "CP0" )
}

b64Decode( b64str, ByRef outBuf )
{
   static CryptStringToBinary := "crypt32\CryptStringToBinary" (A_IsUnicode ? "W" : "A")

   DllCall( CryptStringToBinary, "ptr", &b64str, "UInt", 0, "Uint", 1, "Ptr", 0, "UInt*", outLen, "ptr", 0, "ptr", 0 )
   VarSetCapacity( outBuf, outLen, 0 )
   DllCall( CryptStringToBinary, "ptr", &b64str, "UInt", 0, "Uint", 1, "Ptr", &outBuf, "UInt*", outLen, "ptr", 0, "ptr", 0 )

   return outLen
}

b2a_hex( ByRef pbData, dwLen )
{
	if (dwLen < 1)
		return 0
	if pbData is integer
		ptr := pbData
	else
		ptr := &pbData
	SetFormat,integer,Hex
	loop,%dwLen%
	{
		num := numget(ptr+0,A_index-1,"UChar")
		hash .= substr((num >> 4),0) . substr((num & 0xf),0)
	}
	SetFormat,integer,D
	StringLower,hash,hash
	return hash
}

a2b_hex( sHash,ByRef ByteBuf )
{
	if (sHash == "" || RegExMatch(sHash,"[^\dABCDEFabcdef]") || mod(StrLen(sHash),2))
		return 0
	BufLen := StrLen(sHash)/2
	VarSetCapacity(ByteBuf,BufLen,0)
	loop,%BufLen%
	{
		num1 := (p := "0x" . SubStr(sHash,(A_Index-1)*2+1,1)) << 4
		num2 := "0x" . SubStr(sHash,(A_Index-1)*2+2,1)
		num := num1 | num2
		NumPut(num,ByteBuf,A_Index-1,"UChar")
	}
	return BufLen
}

Free(byRef var)
{
  VarSetCapacity(var,0)
  return
}

MinClick(title, xcord, ycord, nwidth, nheight, button:="left")
{
SetControlDelay, -1
SysGet, SM_CYSIZE, 31
SysGet, SM_CYEDGE, 46
SysGet, SM_CXEDGE, 45
SysGet, SM_CXSIZE, 30
titleHeight := SM_CYSIZE + SM_CYEDGE
titleWidth := SM_CXEDGE + SM_CXSIZE

Buttony = %ycord%
Buttonx = %xcord%

WinGetPos,,,width,height, %title%
	if (height = nheight && width = nwidth)
		{
			Y := Buttony
			X := Buttonx
		}
	  else
		{
			Y := Buttony - titleHeight
			X := Buttonx - titleWidth
		}
	ControlClick, X%X% Y%Y%, %title%,, %button%
}
return

ControlFromPoint(X, Y, WinTitle="", WinText="", ByRef cX="", ByRef cY="", ExcludeTitle="", ExcludeText="")
{
    static EnumChildFindPointProc=0
    if !EnumChildFindPointProc
        EnumChildFindPointProc := RegisterCallback("EnumChildFindPoint","Fast")

    if !(target_window := WinExist(WinTitle, WinText, ExcludeTitle, ExcludeText))
        return false

    VarSetCapacity(rect, 16)
    DllCall("GetWindowRect","uint",target_window,"uint",&rect)
    VarSetCapacity(pah, 36, 0)
    NumPut(X + NumGet(rect,0,"int"), pah,0,"int")
    NumPut(Y + NumGet(rect,4,"int"), pah,4,"int")
    DllCall("EnumChildWindows","uint",target_window,"uint",EnumChildFindPointProc,"uint",&pah)
    control_window := NumGet(pah,24) ? NumGet(pah,24) : target_window
    DllCall("ScreenToClient","uint",control_window,"uint",&pah)
    cX:=NumGet(pah,0,"int"), cY:=NumGet(pah,4,"int")
    return control_window
}

; Ported from AutoHotkey::script2.cpp::EnumChildFindPoint()
EnumChildFindPoint(aWnd, lParam)
{
    if !DllCall("IsWindowVisible","uint",aWnd)
        return true
    VarSetCapacity(rect, 16)
    if !DllCall("GetWindowRect","uint",aWnd,"uint",&rect)
        return true
    pt_x:=NumGet(lParam+0,0,"int"), pt_y:=NumGet(lParam+0,4,"int")
    rect_left:=NumGet(rect,0,"int"), rect_right:=NumGet(rect,8,"int")
    rect_top:=NumGet(rect,4,"int"), rect_bottom:=NumGet(rect,12,"int")
    if (pt_x >= rect_left && pt_x <= rect_right && pt_y >= rect_top && pt_y <= rect_bottom)
    {
        center_x := rect_left + (rect_right - rect_left) / 2
        center_y := rect_top + (rect_bottom - rect_top) / 2
        distance := Sqrt((pt_x-center_x)**2 + (pt_y-center_y)**2)
        update_it := !NumGet(lParam+24)
        if (!update_it)
        {
            rect_found_left:=NumGet(lParam+8,0,"int"), rect_found_right:=NumGet(lParam+8,8,"int")
            rect_found_top:=NumGet(lParam+8,4,"int"), rect_found_bottom:=NumGet(lParam+8,12,"int")
            if (rect_left >= rect_found_left && rect_right <= rect_found_right
                && rect_top >= rect_found_top && rect_bottom <= rect_found_bottom)
                update_it := true
            else if (distance < NumGet(lParam+28,0,"double")
                && (rect_found_left < rect_left || rect_found_right > rect_right
                 || rect_found_top < rect_top || rect_found_bottom > rect_bottom))
                 update_it := true
        }
        if (update_it)
        {
            NumPut(aWnd, lParam+24)
            DllCall("RtlMoveMemory","uint",lParam+8,"uint",&rect,"uint",16)
            NumPut(distance, lParam+28, 0, "double")
        }
    }
    return true
}

CreateMask()
{
    Gui, 99:New
}

Mask(Window)
{
        Gui, 99: +LastFound -Caption +ToolWindow
        SetWinDelay, 10
        WinGetPos, xe, ye, we, he, %Window%
        xtrim := xe+5
        ytrim := ye
        wtrim := we-10
        htrim := he-5
        Loop
        {
            If WinActive(clientname)
            {
                  Gui, 99:Show, x%xtrim% y%ytrim% w%wtrim% h%htrim%, Mask
                  WinSet, Transparent, 1, Mask
                  ;WinMove, Mask,, %xtrim%, %ytrim%
                  Sleep, 1000
            }
            Else
            {
               Gui, 99:Hide
            }
         }
}

MaskOff()
{
    Gui, 99:Destroy
}

hk(f=0) {  ; By FeiYue
  static allkeys, ExcludeKeys:="LButton,RButton"
  if !allkeys
  {
    s:="||NumpadEnter|Home|End|PgUp|PgDn|Left|Right|Up|Down|Del|Ins|"
    Loop, 254
      k:=GetKeyName(Format("VK{:02X}",A_Index))
        , s.=InStr(s, "|" k "|") ? "" : k "|"
    For k,v in {Control:"Ctrl",Escape:"Esc"}
      s:=StrReplace(s, k, v)
    allkeys:=Trim(s, "|")
  }
  ;------------------
  f:=f ? "On":"Off"
  For k,v in StrSplit(allkeys,"|")
    if v not in %ExcludeKeys%
      Hotkey, *%v%, Block_Input, %f% UseErrorLevel
  Block_Input:
  Return
}

