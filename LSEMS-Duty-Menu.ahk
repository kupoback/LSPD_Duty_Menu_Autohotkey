#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SetKeyDelay, 1
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

;These are the global variables that you will need to change.  All should be self explanitory.
global NormalCallSign := "00"
global Rank := "EMR"
global Surname := "Onassis"

;Insert Key allows you to quick respond to an ID
^Ins::
    Gui, Destroy
    Gui, Add, Text,, Enter Respond ID:
    Gui, Add, Edit, w300 vRespondId,
    Gui, Add, Button, Default x80 gRespondConfirm w80, Ok
    ;Gui, Add, Button, Default x+0 gRespondCancel w80, Cancel
    Gui, Show,, Respond ID
    return

    RespondConfirm:
		Gui,Submit
        if (RespondId!=""){
            send, t/resp %RespondId%{enter}
        } else {
            return
        }
    return
return

;self explanitory
F10::
	send, t/setcall -1{enter}
return

;kill switch
F12::ExitApp

;change this button to whatever you want to open your menu.  I found that F3 is the best, due to its position and not being used by the game.
F3::

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, FullMenu, Add, Park Cruiser, ParkAmbulance

Menu, StartMenu, Add, Start Solo Watch, StartWatch
;Menu, StartMenu, Add, Start Other Watch, StartWatchElse
Menu, FullMenu, Add, Start Menu, :StartMenu

Menu, EndMenu, Add, End Solo Watch, EndWatch
;Menu, EndMenu, Add, End Other Watch, EndWatchElse
Menu, FullMenu, Add, End Menu, :EndMenu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, FullMenu, Add, Exit application, ExitApplication

CoordMode, Menu, Screen
Menu, FullMenu, Show, % A_ScreenWidth/2, % A_ScreenHeight/2
return

ParkAmbulance:
	send, t/delambulance{enter}
return

;Start watch under someone else
StartWatchElse:
	StartWatchRP()
	;Gui, Destroy
    ;Gui, Add, Text,, Enter Unit Name:
    ;Gui, Add, Edit, w300 vUnitName,
    ;Gui, Add, Button, Default x80 gUnitConfirm w80, Ok
    ;Gui, Add, Button, Default x+0 gUnitCancel w80, Cancel
    ;Gui, Show,, Unit Name
    ;return

    ;UnitConfirm:
	;	Gui,Submit
    ;    if (UnitName!=""){
    ;        StartWatchRP()
	;		send, t/joinunit %UnitName%{enter}
	;		sleep 500
	;		send, t/rlow %Rank% %Surname% is start service under %UnitName%{enter}
	;		sleep 500
    ;    } else {
    ;        MsgBox,, ERROR, The respond ID is empty. Must enter a value.
    ;    }
    ;return
return

;Start watch handler
StartWatch:
	StartWatchRP()
	;send, t/createunit %NormalCallSign% {enter}
	;Sleep 750
	;send, t/rlow %Rank% %Surname% is form %NormalCallSign% and 10-8 from Pillbox{enter}
    ;sleep 500
return

;End watch handler
EndWatchElse:
	;send, t/rlow %Rank% %Surname% is disband %NormalCallSign% and 10-9 end service.{enter}
	;sleep 500
	EndWatchRP()
return

;End watch handler
EndWatch:
	;send, t/rlow %Rank% %Surname% is disband %NormalCallSign% and 10-9 end service.{enter}
	;sleep 500
	EndWatchRP()
return

StartWatchRP()
{
	send, t/melow takes off her clothes, folding them neatly and places it into the locker, grabbing her uniform{enter}
	sleep 500
	send, t/melow puts on her uniform, and puts on her gloves{enter}
	sleep 500
	send, t/melow grabs a body cam from the locker, securing it to her chest and turns it on{enter}
	Sleep 500
	send, t/time {enter}
	Sleep 750
}

EndWatchRP()
{
	send, t/disbandunit{enter}
	sleep 500
	send, t/leaveunit{enter}
	sleep 500
	send, t/melow takes off her uniform, putting on her normal clothing{enter}
	sleep 500
	send, t/melow takes off her on-duty bodycam placing it in her locker and takes out her civilian bodycam attaching it, turning it on{enter}
	sleep 500
	send, t/time{enter}
	sleep 500
}

ExitApplication:
	ExitApp
return

return
