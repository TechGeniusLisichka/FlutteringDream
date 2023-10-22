#NoEnv
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

; ......................Надписи на кнопках......................
setEnglish() {
  SendMessage, 0x50,, 0x4090409,, A
  }

setRussian() {
  SendMessage, 0x50,, 0x4190419,, A
  }

Gui, 3: +LastFound +AlwaysOnTop -Caption +ToolWindow

Gui, 3: Add, Button, greps_igo x0 y0 w100 h30, Лечу
Gui, 3: Add, Button, greps_gps x0 y35 w100 h30, Поставлю метку
Gui, 3: Add, Button, greps_yes x0 y70 w100 h30, Да
Gui, 3: Add, Button, greps_no x0 y105 w100 h30, Нет
Gui, 3: Add, Button, greps_babochka x0 y140 w100 h30, Бабочка
Gui, 3: Add, Button, greps_fact x0 y175 w100 h30, По факту
Gui, 3: Add, Button, greps_not_tp x0 y210 w100 h30, Не телепортируем
Gui, 3: Add, Button, greps_proofs x0 y245 w100 h30, При наличии док-в
Gui, 3: Add, Button, greps_narush_net x0 y280 w100 h32, Нет нар.пишите жб
Gui, 3: Add, Button, greps_ne_razglas x0 y315 w100 h32, Не разглашаем

Gui, 3: Add, Button, greps_gg x110 y0 w100 h32, Приятной игры
Gui, 3: Add, Button, greps_tech_forum x110 y35 w100 h32, Тех. раздел
Gui, 3: Add, Button, greps_podrobnee x110 y70 w100 h32, Опишите подробнее
Gui, 3: Add, Button, greps_we_not_fix_swim_car x110 y105 w100 h30, Утопленная машина
Gui, 3: Add, Button, greps_mech x110 y140 w100 h30, Вызовите механика
Gui, 3: Add, Button, greps_relog x110 y175 w100 h30, Перезайдите
Gui, 3: Add, Button, greps_problem_solved x110 y210 w100 h30, Проблема решена
Gui, 3: Add, Button, greps_nakazan x110 y245 w100 h30, Игрок наказан
Gui, 3: Add, Button, greps_ne_dvigaetsa x110 y280 w100 h32, Персонаж не двигается
Gui, 3: Add, Button, greps_report_closed x110 y315 w100 h32, Репорт CLOSED

Gui, 3: Add, Button, greps_utid x220 y0 w100 h32, Уточните ID
Gui, 3: Add, Button, greps_medic x220 y35 w100 h32, Вызовите EMS
Gui, 3: Add, Button, greps_obzhalovanie x220 y70 w100 h32, Обжалование
Gui, 3: Add, Button, greps_offtop x220 y105 w100 h30, Не оффтопьте
Gui, 3: Add, Button, greps_off_news x220 y140 w100 h30, Офиц.новости
Gui, 3: Add, Button, greps_vip_uval x220 y175 w100 h30, Вип увал
Gui, 3: Add, Button, greps_mind_self x220 y210 w100 h30, Узнайте сами
Gui, 3: Add, Button, greps_police_pomehaIC x220 y245 w100 h30, Полицию
Gui, 3: Add, Button, greps_na_usmotrenie x220 y280 w100 h32, На усмотр
Gui, 3: Add, Button, greps_preduprezden x220 y315 w100 h32, Игрок предупрежден

Gui, 3: Add, Button, greps_tex_pochta x330 y0 w100 h32, 3дняБан
Gui, 3: Add, Button, greps_isk_v_sud x330 y35 w100 h32, Иск в суд
Gui, 3: Add, Button, greps_dve_mashini x330 y70 w100 h32, 2ая машина
Gui, 3: Add, Button, greps_proverim x330 y105 w100 h32, Проверим
Gui, 3: Add, Button, greps_slezhu x330 y140 w100 h32, Слежу
Gui, 3: Add, Button, greps_ne_zapret x330 y175 w100 h32, Не запрещено
Gui, 3: Add, Button, greps_ic_moment x330 y210 w100 h32, IC момент
Gui, 3: Add, Button, greps_otvet_up x330 y245 w100 h32, Ответ выше
Gui, 3: Add, Button, greps_pisat_ss x330 y280 w100 h32, Напишите СС
Gui, 3: Add, Button, greps_peredam x330 y315 w100 h32, Передам

Gui, 3: Add, Button, greps_ne_snimaem x440 y0 w100 h32, Не снимаем SYS
Gui, 3: Add, Button, greps_prosite_gos x440 y35 w100 h32, Просите сотрудников
Gui, 3: Add, Button, greps_ls_admin x440 y70 w100 h32, В личку админу
Gui, 3: Add, Button, greps_ochered_zhalob x440 y105 w100 h32, Рассмотр. ЖБ
Gui, 3: Add, Button, greps_gde_nrp x440 y140 w100 h32, Где НРП?
Gui, 3: Add, Button, greps_vnimatelno x440 y175 w100 h32, Внимательней
Gui, 3: Add, Button, greps_ne_chinim x440 y210 w100 h32, Не чиним
Gui, 3: Add, Button, greps_bodikamera x440 y245 w100 h32, Бодикамера
Gui, 3: Add, Button, greps_vpn x440 y280 w100 h32, VPN
Gui, 3: Add, Button, greps_kd_tir x440 y315 w100 h32, КД Тир

Gui, 3: Add, Button, greps_demorgan x550 y0 w100 h32, Деморган схавал нелегал
Gui, 3: Add, Button, greps_kd_orga x550 y35 w100 h32, КД Орга
Gui, 3: Add, Button, greps_nal_kazik x550 y70 w100 h32, Нал Казик
Gui, 3: Add, Button, greps_moped x550 y105 w100 h32, Арендуйте новый
Gui, 3: Add, Button, greps_small_rank x550 y140 w100 h32, Мелкий ранг
Gui, 3: Add, Button, greps_bag_nika x550 y175 w100 h32, Баг ника рестарт
Gui, 3: Add, Button, greps_smena_nika x550 y210 w100 h32, Имя_Фамилия
Gui, 3: Add, Button, greps_27pp x550 y245 w100 h32, 2.7 ПП
Gui, 3: Add, Button, greps_cheat x550 y280 w100 h32, Читер
Gui, 3: Add, Button, greps_soznanie x550 y315 w100 h32, Потеряйте сознание

Gui, 3: Add, Button, greps_podarki x660 y0 w100 h32, F10-Подарки
Gui, 3: Add, Button, greps_sudimost x660 y35 w100 h32, Снять судимости
Gui, 3: Add, Button, greps_wait x660 y70 w100 h32, Ожидайте
Gui, 3: Add, Button, greps_minikarta x660 y105 w100 h32, Нет миникарты
Gui, 3: Add, Button, greps_evakuator x660 y140 w100 h32, Эвакуируйте
Gui, 3: Add, Button, greps_strelka_vniz x660 y175 w100 h32, Стрелочка вниз
Gui, 3: Add, Button, greps_vremya_ft x660 y210 w100 h32, М-Личное дело
Gui, 3: Add, Button, greps_gde_kupit x660 y245 w100 h32, Где купить
Gui, 3: Add, Button, greps_kvest x660 y280 w100 h32, Время ивента
Gui, 3: Add, Button, greps_kurator x660 y315 w100 h32, У куратора

Gui, 3: Color, black

Loop
{
  PixelGetColor, color1, 670, 15
  PixelGetColor, color2, 741, 27
  PixelGetColor, color3, 822, 46

  if (color1 = 0x555555 and color2 = 0xF6F6F6 and color3 = 0x555555)
  {
    Gui, 3: Show, w761 h350 x989 y15 NoActivate, binder_btns
  }
  Else
  {
    Sleep, 300
    Gui, 3: Hide
  }
}
Return

; ...................... Содержимое кнопок ......................

      reps_yes:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Да.{enter}","Да.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      
      reps_no:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Нет.{enter}","Нет.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      
      reps_babochka:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Скорее всего, вы не успели доставить бабочку за 10 минут. Если вы считаете, что успели за указанное ранее время - напишите в тех раздел на форуме.{enter}","Скорее всего, вы не успели доставить бабочку за 10 минут. Если вы считаете, что успели за указанное ранее время - напишите в тех раздел на форуме.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      
      reps_fact:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Пишите по факту нарушения.{enter}","Пишите по факту нарушения.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      
      reps_not_tp:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Не телепортируем.{enter}","Не телепортируем.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      
      reps_proofs:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["При наличии доказательств нарушения Вы можете оставить жалобу на игрока, на форуме нашего проекта forum.gta5rp.com – Сервер №14 Del Perro – Жалобы – Жалобы на игроков. Приятной игры.{enter}","При наличии доказательств нарушения Вы можете оставить жалобу на игрока, на форуме нашего проекта forum.gta5rp.com – Сервер №14 Del Perro – Жалобы – Жалобы на игроков. Приятной игры.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 600
          setEnglish()
        }
      Return
      reps_we_not_fix_swim_car:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Переместила ваш автомобиль на сушу, теперь вам надо вызвать механика, дабы починить авто. Рем комплект тут не поможет.{enter}","Переместила авто, вызовите механика для починки вашего ТС. Если механики не будут отвечать - эвакуируйте авто, либо ожидайте, когда все же ответят.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 600
          setEnglish()
        }
      Return
      reps_mind_self:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Администрация не сообщает такого рода информацию, узнайте это самостоятельно.{enter}","Узнайте данную информацию самостоятельно или у игроков.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_tech_forum:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["В такой ситуации оформите тему в Техническом разделе на форуме. forum.gta5rp.com - Регистрируетесь - Технический Раздел - Del Perro | Технический раздел.{enter}","В такой ситуации напишите тему в техническом разделе на форуме, forum.gta5rp.com.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 700
          setEnglish()
        }
      Return
      
      reps_podrobnee:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Опишите ваш вопрос/проблему подробнее.{enter}","Опишите ваш вопрос/проблему подробнее.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_gg:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Приятной игры и хорошего настроения.{enter}","Приятной игры на сервере Del Perro.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_relog:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Релогнитесь на сервер, нажав F1 - сервер Del Perro.{enter}","Релогнитесь на сервер, нажав F1 - сервер Del Perro.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_problem_solved:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Видимо Ваша проблема уже решена. Приятной игры и хорошего настроения на сервере Del Perro.{enter}","Видимо Ваша проблема уже решена. Приятной игры и хорошего настроения на сервере Del Perro.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_nakazan:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Игрок наказан согласно правилам проекта. Приятной игры.{enter}","Игрок наказан, спасибо за помощь. Приятной игры.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_ne_dvigaetsa:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Нажмите F1 два раза, либо F1 потом F2, либо Alt+F1.{enter}","Нажмите F1 два раза, либо F1 потом F2, либо Alt+F1.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_narush_net:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Во время наблюдений за игроком нарушений не заметила. При наличии доказательств нарушения Вы можете оставить жалобу на игрока, на форуме нашего проекта forum.gta5rp.com – Сервер №14 Del Perro – Жалобы – Жалобы на игроков.{enter}","Во время наблюдений за игроком нарушений не заметила. При наличии доказательств нарушения Вы можете оставить жалобу на игрока, на форуме нашего проекта forum.gta5rp.com – Сервер №14 Del Perro – Жалобы – Жалобы на игроков.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 800
          setEnglish()
        }
      Return
      reps_ne_razglas:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Не разглашаем.{enter}","Не разглашаем.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_obzhalovanie:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Если вы не согласны с полученным наказанием, можете оформить обжалование на форуме.{enter}","Если вы не согласны с выданным вам наказанием, можете оформить обжалование на форуме.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      
      reps_gps:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Сейчас поставлю метку.{enter}","Сейчас дам вам метку.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      
      reps_mech:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Вызовите автомеханика.{enter}","Вызовите механика.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      
      reps_utid:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Уточните ID.{enter}","Уточните ID игрока.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      
      reps_medic:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Вызовите медика.{enter}","Вызовите сотрудника EMS.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      
      reps_offtop:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Прекратите оффтоп.{enter}","Не оффтопьте в репорт.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_off_news:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Следите за оф.новостями проекта.{enter}","Следите за официальными новостями проекта.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_vip_uval:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["M-Меню фракции. Через поиск находите себя, затем нажимаете на перечеркнутый кружочек. (Если есть VIP){enter}","M-Меню фракции. Через поиск находите себя, затем нажимаете на перечеркнутый кружочек. (Если есть VIP){enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_police_pomehaIC:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Увы, это IC момент. Вызовите полицию, дабы решить проблему.{enter}","Увы, это IC момент. Вызовите полицию, дабы решить проблему.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_na_usmotrenie:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Наказание выдается на усмотрение администрации.{enter}","Наказание выдается на усмотрение администрации.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_tex_pochta:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Обратитесь в нашу поддержку по ссылке https://gta5rp.com/support. Отвечать нужно будет на то же письмо которое придет.{enter}","В такой ситуации вам необходимо обратиться в нашу поддержку по ссылке https://gta5rp.com/support. Отвечать нужно будет на то же письмо которое придет.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          SendInput, % links[var]
        }
      Return

      reps_isk_v_sud:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Если вы считаете, что сотрудник нарушает закон, Вы можете обратиться с исковым заявлением в суд. Иск можно заполнить на форуме нашего сервера, forume.gta5rp.com - Сервер №14 Del Perro - Гос.организации - Government - Судебная власть.{enter}","Если вы считаете, что сотрудник нарушает закон, Вы можете обратиться с исковым заявлением в суд. Иск можно заполнить на форуме нашего сервера, forume.gta5rp.com - Сервер №14 Del Perro - Гос.организации - Government - Судебная власть.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 700
          setEnglish()
        }
      Return
      reps_dve_mashini:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Откройте телефон - Авто - Настройки - Нажмите на нужное авто стрелочку вверх и поднимите его, после чего нажмите сохранить. Если у вас парковка, вам необходимо продать место и купить новое.{enter}","Откройте телефон - Авто - Настройки - Нажмите на нужное авто стрелочку вверх и поднимите его, после чего нажмите сохранить. Если у вас парковка, вам необходимо продать место и купить новое.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_proverim:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Проверим, спасибо.{enter}","Спасибо, проверим.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_slezhu:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Слежу за ситуацией.{enter}","Наблюдаю за ситуацией.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_ne_zapret:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Не запрещено.{enter}","Не запрещено.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_ic_moment:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Это IC момент.{enter}","IC момент.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()


        }
      Return
      reps_otvet_up:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Ответ выше.{enter}","Ответ был дан выше.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_pisat_ss:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Обратитесь к старшему составу/лидеру/куратору фракции.{enter}","Обратитесь к старшему составу, лидеру или куратору фракции.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_ne_snimaem:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Не снимаем системное наказание.{enter}","Системные наказания не амнистируются.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_prosite_gos:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Попросите об этом сотрудников.{enter}","Попросите гос. сотрудников помочь.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_ls_admin:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Обратитесь к администратору в личные сообщения в дискорд.{enter}","Напишите администратору в личные сообщения в дискорд.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_ochered_zhalob:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Жалобы/обжалования рассматриваются в порядке очереди, ожидайте.{enter}","Жалобы/обжалования рассматриваются в порядке очереди, ожидайте.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_gde_nrp:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["В чем НРП?{enter}","В чем НРП поведение?{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_vnimatelno:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Смотрите внимательней.{enter}","Ищите внимательней.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_ne_chinim:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Не чиним авто, вызовите механика или воспользуйтесь рем. комплектом.{enter}","Не ремонтируем авто, вызовите механика или воспользуйтесь рем. комплектом.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_bodikamera:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Бодикамера лишь предмет в игре для того, чтобы Ваши откаты, записанные на сторонние программы могли использоваться в различных РП процессах, дабы привязать  Ваш ООС откат к IC.{enter}","Бодикамера лишь предмет в игре для того, чтобы Ваши откаты, записанные на сторонние программы могли использоваться в различных РП процессах, дабы привязать  Ваш ООС откат к IC.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 900
          setEnglish()
        }
      Return
      reps_vpn:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Воспользуйтесь VPN.{enter}","Включите VPN.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_demorgan:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["При попадании в деморган весь нелегал изымается и возвращен не будет.{enter}","При попадании в деморган весь нелегал изымается и возвращен не будет.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_kd_orga:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["КД на вступление в следующую организацию отсчитывается с момента вступления в предыдущую, и составляет 2 часа.{enter}","КД на вступление в следующую организацию отсчитывается с момента вступления в предыдущую, и составляет 2 часа.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_nal_kazik:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Если крутили физическое колесо удачи - заберите деньги в окне JackPot. Оно находится в казино, справа от входа, спускаясь по ступенькам. Если в телефоне - деньги начислились Вам справа внизу.{enter}","Если крутили физическое колесо удачи - заберите деньги в окне JackPot. Оно находится в казино, справа от входа, спускаясь по ступенькам. Если в телефоне - деньги начислились Вам справа внизу.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 800
          setEnglish()
        }
      Return
      reps_moped:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Арендуйте новый.{enter}","Арендуйте новый.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_small_rank:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Ваш ранг не позволяет.{enter}","Ваш ранг не позволяет.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_bag_nika:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Если Вы сменили ник - меню фракции/организации могло забагаться. Дождитесь рестарта.{enter}","Если Вы сменили ник - меню фракции/организации могло забагаться. Дождитесь рестарта.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_smena_nika:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Необходимо писать через нижнее подчеркивание. Вот так: Имя_Фамилия{enter}","Необходимо писать через нижнее подчеркивание. Пример: Имя_Фамилия{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_27pp:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Ваш ник не подходит под рамки РП и нарушает пункт 2.7 правил проекта.{enter}","Ваш ник нарушает пункт 2.7 правил проекта.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_cheat:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Почему Вы так решили?{enter}","Почему так считаете?{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_podarki:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["F10-Подарки.{enter}","F10-Подарки.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_sudimost:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Судимости можно снять на черном рынке, начав новую жизнь за 150 000, или же пройти юридическую реабилитацию, обратившись к сотрудникам правительства.{enter}","Судимости можно снять на черном рынке, начав новую жизнь за 150 000, или же пройти юридическую реабилитацию, обратившись к сотрудникам правительства.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 700
          setEnglish()
        }
      Return
      reps_wait:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Ожидайте.{enter}","Ожидайте.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_minikarta:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Если у вас пропала миникарта, отключите фикс миникарты для мониторов 21:9 в F10-Шестеренка-Интерфейс, после чего полностью перезайдите в игру.{enter}","Если у вас нет миникарты, отключите фикс миникарты для мониторов 21:9 в F10-Шестеренка-Интерфейс, после чего полностью перезайдите в игру.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 700
          setEnglish()
        }
      Return
      reps_gde_kupit:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Купить металоискатель можно в Secret Shop'е. Лопату в рыболовном магазине.{enter}","Купить металоискатель можно в Secret Shop'е. Лопату в рыболовном магазине.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_kvest:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Задания и экзамены будут доступны до 07:00 МСК 16 октября. Купить призы у директора можно будет до 07:00 МСК 30 октября.{enter}","Задания и экзамены будут доступны до 07:00 МСК 16 октября. Купить призы у директора можно будет до 07:00 МСК 30 октября.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_report_closed:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Репорт закрывается автоматически после ответа администратора.{enter}","Репорт закрывается автоматически после ответа администратора.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_preduprezden:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Игрок предупрежден.{enter}","Игрок предупрежден.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_peredam:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Передам.{enter}","Передам.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_kd_tir:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["КД на тренировку в обычном тире - 90 минут, в армейском - 60.{enter}","КД на тренировку в обычном тире - 90 минут, в армейском - 60.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_soznanie:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Потеряйте сознание.{enter}","Потеряйте сознание.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_evakuator:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Эвакуируйте авто.{enter}","Эвакуируйте авто.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_strelka_vniz:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Стрелочка вниз.{enter}","Стрелочка вниз.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_vremya_ft:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["М-Личное дело.{enter}","М-Личное дело.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return
      reps_kurator:
        WinActivate, "ahk_exe ragemp_v.exe"
        MouseClick, left, -689, 315
      
        links := ["Уточните у куратора фракции.{enter}","Уточните у куратора фракции.{enter}"]
        {
          Random,var , 1,2
          sleep 100
          setRussian()
          SendInput, % links[var]
          sleep 500
          setEnglish()
        }
      Return