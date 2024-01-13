#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SetKeyDelay, 1
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

;These are the global variables that you will need to change.  All should be self explanitory.
global CallSign := "EMR-1"
global Rank := "EMR"
global Surname := "Onassis"

;self explanitory
F10::
	send, t/setcall -1{enter}
return

^Ins::
	send, t/anim medic{enter}
	sleep 500
	send, t/melow sets down her ALS bag, and begins to look over the patient{enter}
	sleep 500
	send, t/dolow What injuries would I see on the individual?{enter}
return



; Responding to a call
^Numpad1::
 	Gui, Destroy
	Gui, Add, Text,, Call Type:
    Gui, Add, DropdownList, w300 vCallType, PD||||SD
	Gui, Add, Text,, 10-70?:
    Gui, Add, DropdownList, w300 vAsBackup, No||Yes
    Gui, Add, Button, Default x80 gRespConfirm w80, Ok
    Gui, Add, Button, x+0 gGuiClose w80, Cancel
    Gui, Show,, Responding to Call
    return

	setCallType := ""
	backupCall := ""

	RespConfirm:
		Gui,Submit
		if (CallType="") {
			setCallType := "last"
		} else {
			setCallType := "last " . CallType
		}

		if (AsBackup="Yes") {
			backupCall := " as 10-70"
		}
		
		send, t/rlow %CallSign% Code 3 to %setCallType% call%backupCall%{enter}
    return
return

; Code 6 at scene
^Numpad2::
	Gui, Destroy
	Gui, Add, Text,, Call Type:
    Gui, Add, DropdownList, w300 vCallType, PD||||SD
    Gui, Add, Button, Default x80 gCodeConfirm w80, Ok
    Gui, Add, Button, x+0 gGuiClose w80, Cancel
    Gui, Show,, Code 6 Scene
    return

	setCallType := ""

	CodeConfirm:
		Gui,Submit
		if (CallType="") {
			setCallType := "last"
		} else {
			setCallType := "last " . CallType
		}
			
		send, t/rlow %CallSign% is Code 6 at %setCallType% call{enter}
    return
return

; Response to Pillbox\Paleto
^Numpad3::
 	Gui, Destroy
    Gui, Add, Text,, Number of Patients:
    Gui, Add, Edit, w300 vPatientCount,
	Gui, Add, Text,, Location Type:
    Gui, Add, DropdownList, w300 vLocationType, Pillbox||Paleto
	Gui, Add, Text,, Patient Type:
    Gui, Add, DropdownList, w300 vPatientType, 10-16||10-15
	Gui, Add, Text,, Code Type:
    Gui, Add, DropdownList, w300 vCodeType, Code 2||Code 3
	Gui, Add, Text,, Call Type:
    Gui, Add, DropdownList, w300 vCallType, PD||||SD
    Gui, Add, Button, Default x80 gPatientConfirm w80, Ok
    Gui, Add, Button, x+0 gGuiClose w80, Cancel
    Gui, Show,, Response to Hospital
    return

	setCallType := ""

	PatientConfirm:
		Gui,Submit
		if (PatientCount!=""){
			if (CallType="") {
				setCallType := "last"
			} else {
				setCallType := "last " . CallType
			}
			
			send, t/rlow %CallSign% %CodeType% to %LocationType% with %PatientCount%x %PatientType% from %setCallType% call{enter}
		} else {
			return
		}
    return
return

; 10-99 Call
^Numpad4::
 	Gui, Destroy
	Gui, Add, Text,, Location Type:
    Gui, Add, Edit, w300 vRespLocation,
	Gui, Add, Text,, Status:
    Gui, Add, DropdownList, w300 vStatus, 10-8||10-9
	Gui, Add, Text,, Static/Roaming:
    Gui, Add, DropdownList, w300 vMobility, Static||Roaming
	Gui, Add, Text,, Call Type:
    Gui, Add, DropdownList, w300 vRespCallType, PD||||SD
    Gui, Add, Button, Default x80 gResponseConfirm w80, Ok
    Gui, Add, Button, x+0 gGuiClose w80, Cancel
    Gui, Show,, 10-99 Call
    return

	setCallType := ""
	setMobility := "to"

	ResponseConfirm:
		Gui,Submit
		if(RespLocation!=""){
			if (RespCallType="") {
				setCallType := "last"
			} else {
				setCallType := "last " . RespCallType
			}
			
			if(Mobility="Roaming"){
				setMobility := "roaming"
			} else {
				setMobility := "to"
			}

			send, t/rlow %CallSign% show %setCallType% call is 10-99, is %Status% %setMobility% %RespLocation%{enter}
		}
    return
return

;Sidewalk Patient
^Numpad5::
	Gui, Destroy
	Gui, Add, Text,, Location Type:
    Gui, Add, Edit, w300 vLocation,
    Gui, Add, Button, Default x80 gSidewalkConfirm w80, Ok
    Gui, Add, Button, x+0 gGuiClose w80, Cancel
	Gui, Show,, Sidewalk Patient
	return

	SidewalkConfirm:
		Gui,Submit
		if(Location!=""){
			send, t/rlow %CallSign% is 10-9 with sidewalk patient at %Location%{enter}
		}
	return
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
	;send, t/createunit %CallSign% {enter}
	;Sleep 750
	;send, t/rlow %Rank% %Surname% is form %CallSign% and 10-8 from Pillbox{enter}
    ;sleep 500
return

;End watch handler
EndWatchElse:
	;send, t/rlow %Rank% %Surname% is disband %CallSign% and 10-9 end service.{enter}
	;sleep 500
	EndWatchRP()
return

;End watch handler
EndWatch:
	;send, t/rlow %Rank% %Surname% is disband %CallSign% and 10-9 end service.{enter}
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

; Closes the GUI
GuiClose:
    Gui, Destroy
return

ExitApplication:
	ExitApp
return

return
