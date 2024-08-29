#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SetKeyDelay, 1
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

;These are the global variables that you will need to change.  All should be self explanitory.
global CallSign := ""
global OldCallSign := ""
global Rank := "Master-EMT"
global Surname := "Onassis"
Application = GTA5.exe

;self explanitory
F10::
	send, t{sleep 10}/setcall -1{enter}
return

^Numpad9::SetCallSign()

; Medical RP
F9::
	WinActivate, ahk_exe %Application%
	send, t{sleep 10}/anim medic{enter}
	sleep 500
	send, t{sleep 10}/melow sets down her ALS bag, and begins to look over the patient{enter}
	sleep 500
	send, t{sleep 10}/dolow What injuries would I see on the individual?{enter}
return

; Responding to a call
^Numpad1::
	WinActivate, ahk_exe %Application%
 	Gui, Destroy
	Gui, Add, Text,, Call Type:
    Gui, Add, DropdownList, w300 vCallType, PD||SD||||DOC
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

		send,t{sleep 10}/rlow %CallSign% am Code 3 to %setCallType% call %backupCall%{enter}
    return
return

; Response to Pillbox\Paleto
^Numpad2::
	WinActivate, ahk_exe %Application%
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
    Gui, Add, DropdownList, w300 vCallType, PD||SD||||DOC
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

			send, t{sleep 10}/rlow %CallSign% am %CodeType% to %LocationType% with %PatientCount%x %PatientType% from %setCallType% call{enter}
		} else {
			return
		}
    return
return

; 10-99 Call
^Numpad3::
	WinActivate, ahk_exe %Application%
 	Gui, Destroy
	Gui, Add, Text,, Location Type:
    Gui, Add, Edit, w300 vRespLocation,
	Gui, Add, Text,, Status:
    Gui, Add, DropdownList, w300 vStatus, 10-9||10-8||Code 3
	Gui, Add, Text,, Static/Roaming:
    Gui, Add, DropdownList, w300 vMobility, Static||Roaming
	Gui, Add, Text,, Call Type:
    Gui, Add, DropdownList, w300 vRespCallType, PD||SD||||DOC
    Gui, Add, Button, Default x80 gResponseConfirm w80, Ok
    Gui, Add, Button, x+0 gGuiClose w80, Cancel
    Gui, Show,, 10-99 Call
    return

	setCallType := ""
	setMobility := "to"
	setRespondLocation := ""

	ResponseConfirm:
		Gui,Submit
		if (RespCallType="") {
			setCallType := "last"
		} else {
			setCallType := "last " . RespCallType
		}

		if(RespLocation!=""){
			setRespondLocation := RespLocation
		} else {
			setRespondLocation := "Pillbox"
		}

		if(Mobility="Roaming"){
			setMobility := "roaming"
		} else {
			setMobility := "to"
		}

		send, t{sleep 10}/rlow %CallSign% show %setCallType% call 10-99, am %Status% %setMobility% %setRespondLocation%{enter}
    return
return

;Sidewalk Patient
^Numpad4::
	WinActivate, ahk_exe %Application%
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
			send, t{sleep 10}/rlow %CallSign% am 10-9 with sidewalk patient at %Location%{enter}
		}
	return
return

;Code 6 on scene
^Numpad5::
	WinActivate, ahk_exe %Application%
	send, t{sleep 10}/rlow %CallSign% am Code 6
return

;kill switch
F12::ExitApp

;change this button to whatever you want to open your menu.  I found that F3 is the best, due to its position and not being used by the game.
F3::

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, FullMenu, Add, Set CallSign, SetCallSign
Menu, FullMenu, Add, Start Service, StartService
Menu, FullMenu, Add, Start 10-9 Service, StartServiceNotAvail
Menu, FullMenu, Add, Rename Unit, RenameUnit
Menu, FullMenu, Add, End Service, EndWService

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, FullMenu, Add, Exit application, ExitApplication

CoordMode, Menu, Screen
Menu, FullMenu, Show, % A_ScreenWidth/2, % A_ScreenHeight/2
return

;Start watch handler
StartService:
	StartServiceRP()
	send, t{sleep 10}/createunit %CallSign% {enter}
	Sleep 750
	send, t{sleep 10}/rlow %Rank% %Surname% am form %CallSign%, am 10-8 from Pillbox{enter}
    sleep 500
return

StartServiceNotAvail:
	StartServiceRP()
	send, t{sleep 10}/createunit %CallSign% {enter}
	Sleep 750
	send, t{sleep 10}/rlow %Rank% %Surname% am form %CallSign%, am 10-9 from Pillbox{enter}
    sleep 500
return

;End watch handler
EndWService:
	send, t{sleep 10}/rlow %Rank% %Surname% am disband %CallSign%, am 10-9 end service.{enter}
	sleep 500
	EndServiceRP()
return

RenameUnit:
	send, t{sleep 10}/rlow %OldCallSign% am rename into %CallSign%{enter}
return

StartServiceRP()
{
	send, t{sleep 10}/melow takes off her clothes, folding them neatly and places it into the locker, grabbing her uniform{enter}
	sleep 500
	send, t{sleep 10}/melow puts on her uniform, and puts on her gloves{enter}
	sleep 500
	send, t{sleep 10}/melow grabs a body cam from the locker, securing it to her chest and turns it on, setting it to record{enter}
	Sleep 500
	send, t{sleep 10}/time{enter}
	Sleep 750
}

EndServiceRP()
{
	send, t{sleep 10}/disbandunit{enter}
	sleep 500
	send, t{sleep 10}/melow takes off her uniform, putting on her normal clothing{enter}
	sleep 500
	send, t{sleep 10}/melow takes off her on-duty bodycam placing it in her locker and takes out her civilian bodycam attaching it, turning it on{enter}
	sleep 500
	send, t{sleep 10}/time{enter}
	sleep 500
	ClearCallSign()
}

SetCallSign()
{
	Gui, Destroy
	Gui, Add, Text,, Unit:
    Gui, Add, Edit, w300 vCallSign gText, %CallSign%
	Gui, Add, Button, Default x80 gCallSignConfirm w80, Ok
    Gui, Add, Button, x+0 gGuiClose w80, Cancel
    Gui, Show,, 10-99 Call
	return

	CallSignConfirm:
		Gui,Submit
		FileRead, OldCallSign, %A_ScriptDir%\md-callsign.txt

		file := FileOpen(A_ScriptDir . "\md-callsign.txt", "w")
		file.Write(CallSign)
		file.Close()

		FileRead, CallSign, %A_ScriptDir%\md-callsign.txt
	return
}

ClearCallSign()
{
	file := FileOpen(A_ScriptDir . "\md-callsign.txt", "w")
	file.Write()
	file.Close()

	OldCallSign := ""
}

Text:
    Gui, Submit, NoHide
return

; Closes the GUI
GuiClose:
    Gui, Destroy
return

ExitApplication:
	ExitApp
return

return
