#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SetKeyDelay, 1
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

;These are the global variables that you will need to change.  All should be self explanitory.
global NormalCallSign := "3-H-12"
;global GangCallsign := "3-G-13"
global AdamCallsign := "3-A-13"
global TomCallsign := "TOM-10"
global MaryCallsign := "MARY-10"
global MRCallsign := "5-P-13"
global BadgeNumber := "24410"

; opens the mini MDC. If your ctrl button gets stuck or you cannot press the windows key, remove this.
; Causes some issues on some keyboards. No known fix for now.
NumpadAdd::
	sleep, 150
	send, {LCtrl down}{M down}
	sleep, 50
	send, {LCtrl Up}{M up}
	sleep 150
	send, {F7}
	sleep 50
	send, {F7}
return

;Insert Key allows you to quickly run the trace rp
^NumPad3::
	send, t/melow opens up the laptop, and loads MDC's database, entering in a number and mashing enter on the enter key{enter}
	sleep, 200
	send, t/dolow The laptop would chirp, indicating the entered number is valid.{enter}
	sleep 1000

    Gui, Destroy
    Gui, Add, DropdownList, w300 vRespondType, Positive Trace||Negative Trace
    Gui, Add, Button, Default x80 gTraceConfirm w80, Ok
    Gui, Show,, Respond ID
    return

    TraceConfirm:
		Gui,Submit
		sleep, 200
		if (RespondType="Positive Trace") {
			send, t/dolow The laptop would chirp, and start passively showing the location of the trace{enter}
		} else if (RespondType="Negative Trace") {
			send, t/dolow The laptop would make a chirp, and a pop-up box would appear on the screen showing an error{enter}
		}
    return
return

;Numpad3 allows you to quickly run the reload trace rp
^NumPad9::
	send, t/trace{space}
	sleep 500
	send, t/melow hits refresh on the tab open in the MDC{enter}
return

;Insert Key allows you to quick respond to an ID
^Ins::
    Gui, Destroy
    Gui, Add, Text,, Enter Respond ID:
    Gui, Add, Edit, w300 vRespondId,
    Gui, Add, DropdownList, w300 vRespondType, Respond To Call||Check GPS
    Gui, Add, Button, Default x80 gRespondConfirm w80, Ok
    ;Gui, Add, Button, Default x+0 gRespondCancel w80, Cancel
    Gui, Show,, Respond ID
    return

    RespondConfirm:
		Gui,Submit
        if (RespondId!=""){
            if (RespondType="Check GPS") {
                send, t/setcall %RespondId%{enter}
            } else if (RespondType="Respond To Call") {
                send, t/resp %RespondId%{enter}
            }
        } else {
            MsgBox,, ERROR, The respond ID is empty. Must enter a value.
        }
    return
return

^F9::
	Gui, Destroy
	Gui, Add, Text,, Enter Item Type:
	Gui, Add, Edit, w300 vItemId,
	Gui, Add, DropdownList, w300 vNewOld, New Print Check||Already Checking
	Gui, Add, Button, Default x80 gItemConfirm w80, Ok
	Gui, Show,, Item ID
	return

	ItemConfirm:
		Gui, Submit
		if (ItemId!="") {
			if (NewOld="New Print Check") {
				send, t/melow pulls out his container of Aluminum powder, and Zephyr brushs, opening the container{enter}
				sleep 3000
				send, t/melow dips the brush in the powder, and lightly coats the %ItemId% with the brush{enter}
			} else {
				send, t/melow dips the Zephyr brush into the tin of powder again, and recoats the brush{enter}
				sleep 3000
				send, t/melow light coats the %ItemId% with the brush{enter}
			}
			sleep 3000
			send, t/melow grabs a second brush and wipes away any excess powder from the %ItemId%{enter}
			sleep 3000
			send, t/melow grabs some tape and places it over the location of some possible fingerprints, pressing down firmly{enter}
			sleep 3000
			send, t/melow transfer the tape to a lift plate, and secures it in place{enter}
		} else {
			MsgBox,, ERROR, The Item ID is empty. Must enter a value.
		}
	return
return

^F10::
	Gui, Destroy
	Gui, Add, Text,, Enter Vehicle Type:
	Gui, Add, Edit, w300 vVehicleType,
	Gui, Add, Button, Default x80 gVehicleConfirm w80, Ok
	Gui, Show,, Vehicle ID
	return

	VehicleConfirm:
		Gui, Submit
		if (VehicleType!=""){
			send, t/melow pulls out his container of Aluminum powder, and Zephyr brushs, opening the container{enter}
			sleep 3000
			send, t/melow dips the brush in the powder, and lightly coats the %VehicleType%'s steering wheel with the brush{enter}
			sleep 3000
			send, t/melow grabs a second brush and wipes away any excess powder from the %VehicleType%'s steering wheel{enter}
			sleep 3000
			send, t/melow grabs some tape and places it over the location of some possible fingerprints, pressing down firmly{enter}
			sleep 3000
			send, t/melow transfer the tape to a lift plate, and secures it in place{enter}
		} else {
			MsgBox,, Error, The Vehicle ID is empty. Must enter a value.
		}
	return
return

;self explanitory
F9::
	send, t/vr 1{enter}
return

;self explanitory
F10::
	send, t/setcall -1{enter}
return

;sets mouse button 4 to send p so you can use the phone button for TAC
XButton1::p

;kill switch
F12::ExitApp

;change this button to whatever you want to open your menu.  I found that F3 is the best, due to its position and not being used by the game.
F3::

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, FullMenu, Add, Park Cruiser, ParkCruiser

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Menu, FullMenu, Add, Cuff, PDCuff
;Menu, FullMenu, Add, Uncuff, PDUncuff
;Menu, FullMenu, Add, Initial BLS, PDInitialBLS
;Menu, FullMenu, Add, Pursuit Force, LethalPursuit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Menu, TrafficStopMenu, Add, Citation: Issue, PDIssueCitationHandler
;Menu, TrafficStopMenu, Add, Citation: Hand , PDHandCitation
;Menu, TrafficStopMenu, Add, Citation: No Driver , PDNoDriverCitation
;Menu, TrafficStopMenu, Add, Citation: No Bike Driver , PDNoBikeDriverCitation
;Menu, TrafficStopMenu, Add, License Suspension/Demerit,PDIssueSuspensionDemerit
;Menu, FullMenu, Add, Traffic Stop, :TrafficStopMenu

;Menu, FelonyStopMenu, Add, Step 1: Toss keys from ignition, FelonyStop1
;Menu, FelonyStopMenu, Add, Step 2: Open vehicle door slowly, FelonyStop2
;Menu, FelonyStopMenu, Add, Step 3: Step out, FelonyStop3
;Menu, FelonyStopMenu, Add, Step 4: Full 360, FelonyStop4
;Menu, FelonyStopMenu, Add, Step 5: Walk backwards, FelonyStop5
;Menu, FullMenu, Add, Felony Stop, :FelonyStopMenu

;Menu, InmateProcessingMenu, Add, Mugshot, PDMugshot
;Menu, InmateProcessingMenu, Add, On Scene Mugshot, PDOnSceneMugshot
;Menu, InmateProcessingMenu, Add, Fingerprints, PDFingerprints
;Menu, InmateProcessingMenu, Add, Release form, PDReleaseForm
;Menu, RPMenu, Add, Inmate Processing, :InmateProcessingMenu

Menu, TowMenu, Add, Tow Vehicle, TowVehicle
Menu, TowMenu, Add, Untow Vehicle, UnTowVehicle
;Menu, RPMenu, Add, Towing, :TowMenu

;Menu, FullMenu, Add, Traffic Stop/Processing Procedure, :RPMenu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Menu, LifeSupportMenu, Add, Grab BLS Kit, PDGrabBLS
;Menu, LifeSupportMenu, Add, Initial BLS, PDInitialBLS
;Menu, FullMenu, Add, Life Support, :LifeSupportMenu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Menu, DeceasedMenu, Add, Grab Body Bag, PDGrabBodyBag
;Menu, DeceasedMenu, Add, Load Into Body Bag, PDLoadIntoBodyBag
;Menu, FullMenu, Add, Deceased, :DeceasedMenu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Menu, SceneMenu, Add, Grab Barriers, PDGrabBarriers
;Menu, SceneMenu, Add, Gather All Barriers, PDGatherBarriers
;Menu, SceneMenu, Add, Store Barriers, PDStoreBarriers
;Menu, FullMenu, Add, Scene Management, :SceneMenu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, FullMenu, Add, Scout, SpawnUnmarkedScout
Menu, FullMenu, Add, STX, SpawnBuffalo

Menu, VehicleMenu, Add, Kamacho, SpawnKamacho
Menu, VehicleMenu, Add, Drafter, SpawnDrafter
Menu, VehicleMenu, Add, Flatbed, SpawnFlatbed
Menu, VehicleMenu, Add, Crown Vic, SpawnVic

; Other Scouts
Menu, ScoutMenu, Add, K9 Scout, SpawnScoutK9
Menu, VehicleMenu, Add, Livery Scouts, :ScoutMenu

; TED Vehicles
Menu, TEDMenu, Add, Traffic Scout, SpawnScoutTED
Menu, TEDMenu, Add, Motorcycle, SpawnMotorcycle
Menu, TEDMenu, Add, Traffic Alamo, SpawnAlamoTED
Menu, VehicleMenu, Add, TED Vehicles, :TEDMenu

; Other Vehicles
Menu, OtherVehiclesMenu, Add, Interceptor, SpawnInterceptor
;Menu, OtherVehiclesMenu, Add, Gang Alamo, SpawnAlamoGU
Menu, OtherVehiclesMenu, Add, Alamo, SpawnAlamo
;Menu, OtherVehiclesMenu, Add, Gang Caracara, SpawnCaracaraGU
Menu, VehicleMenu, Add, Other Vehicles, :OtherVehiclesMenu

Menu, FullMenu, Add, Police Vehicles, :VehicleMenu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, DRadioMenu, Add, 10-15 to DOC, DRadio
Menu, DRadioMenu, Add, PD to DOC, DRadioPDtoDOC
Menu, DRadioMenu, Add, DB Investigation, DRadioDB
;Menu, DRadioMenu, Add, 10-15 to DOC HVT, DRadioHVT
;Menu, DRadioMenu, Add, PD to MD, DRadioPDtoMD
;Menu, DRadioMenu, Add, Injured 10-15, DRadioMDPris
Menu, FullMenu, Add, Departmental Radio, :DRadioMenu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, UnitMenu, Add, Rename to %NormalCallSign%, NormalUnit
;Menu, UnitMenu, Add, Rename to %GangCallsign%, LincolnUnit
Menu, UnitMenu, Add, Rename to %AdamCallsign%, AdamUnit
Menu, UnitMenu, Add, Join Another Unit, JoinOtherUnit
Menu, UnitMenu, Add, Rename to %TomCallsign%, TOMUnit
Menu, UnitMenu, Add, Rename to %MaryCallsign%, RenameMaryCallsign
Menu, UnitMenu, Add, Rename to %MRCallsign%, MRUnit
Menu, FullMenu, Add, Change Unit, :UnitMenu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, SubMenu0, Add, type, MenuHandler
Menu, SubMenu0, Add, sitchair3, MenuHandler
Menu, SubMenu0, Add, finger, MenuHandler
Menu, SubMenu0, Add, wave, MenuHandler
Menu, SubMenu0, Add, prone, MenuHandler
Menu, SubMenu0, Add, crawl, MenuHandler
Menu, SubMenu0, Add, airplane, MenuHandler
Menu, SubMenu0, Add, celebrate, MenuHandler
Menu, SubMenu0, Add, shakeoff, MenuHandler

Menu, FullMenuAnim, Add, Favorites, :SubMenu0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, WatchMenu, Add, Start Watch, StartWatch
Menu, WatchMenu, Add, End Watch, EndWatch
Menu, FullMenu, Add, Start/End Watch, :WatchMenu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Menu, SubMenu1.1, Add, DJ, MenuHandler
Menu, SubMenu1.1, Add, Airsynth, MenuHandler
Menu, SubMenu1.1, Add, Airguitar, MenuHandler
Menu, SubMenu1.1, Add, Guitar, MenuHandler
Menu, SubMenu1.1, Add, Guitar2, MenuHandler
Menu, SubMenu1.1, Add, PlayPiano, MenuHandler
Menu, SubMenu1.1, Add, PlayBass, MenuHandler
Menu, SubMenu1, Add, Instruments, :SubMenu1.1

Menu, SubMenu1.2, Add, Bobbing, MenuHandler
Menu, SubMenu1.2, Add, Bobbing2, MenuHandler
Menu, SubMenu1, Add, Bobbing, :SubMenu1.2

Menu, SubMenu1.3, Add, Clown, MenuHandler
Menu, SubMenu1.3, Add, Clown2, MenuHandler
Menu, SubMenu1.3, Add, Clown3, MenuHandler
Menu, SubMenu1.3, Add, Clown4, MenuHandler
Menu, SubMenu1.3, Add, Clown5, MenuHandler
Menu, SubMenu1, Add, Clown, :SubMenu1.3

Menu, SubMenu1.4, Add, Dance, MenuHandler
Menu, SubMenu1.4, Add, Dance2, MenuHandler
Menu, SubMenu1.4, Add, Dance3, MenuHandler
Menu, SubMenu1.4, Add, Dance4, MenuHandler
Menu, SubMenu1.4, Add, Dance5, MenuHandler
Menu, SubMenu1.4, Add, Dance6, MenuHandler
Menu, SubMenu1.4, Add, Dance7, MenuHandler
Menu, SubMenu1.4, Add, Dance8, MenuHandler
Menu, SubMenu1.4, Add, Dance9, MenuHandler
Menu, SubMenu1.4, Add, Dance10, MenuHandler
Menu, SubMenu1.4, Add, Dance11, MenuHandler
Menu, SubMenu1.4, Add, Dance12, MenuHandler
Menu, SubMenu1.4, Add, Dance13, MenuHandler
Menu, SubMenu1.4, Add, Dance14, MenuHandler
Menu, SubMenu1, Add, Dances, :SubMenu1.4

Menu, SubMenu1.5, Add, DanceCheer, MenuHandler
Menu, SubMenu1.5, Add, DanceCheer2, MenuHandler
Menu, SubMenu1.5, Add, DanceCheer3, MenuHandler
Menu, SubMenu1, Add, Dance Cheer, :SubMenu1.5

Menu, SubMenu1.6, Add, DanceF, MenuHandler
Menu, SubMenu1.6, Add, DanceF2, MenuHandler
Menu, SubMenu1.6, Add, DanceF3, MenuHandler
Menu, SubMenu1.6, Add, DanceF4, MenuHandler
Menu, SubMenu1.6, Add, DanceF5, MenuHandler
Menu, SubMenu1.6, Add, DanceF6, MenuHandler
Menu, SubMenu1.6, Add, DanceF7, MenuHandler
Menu, SubMenu1.6, Add, DanceF8, MenuHandler
Menu, SubMenu1.6, Add, DanceF9, MenuHandler
Menu, SubMenu1.6, Add, DanceF10, MenuHandler
Menu, SubMenu1.6, Add, DanceF11, MenuHandler
Menu, SubMenu1.6, Add, DanceF12, MenuHandler
Menu, SubMenu1.6, Add, DanceF13, MenuHandler
Menu, SubMenu1.6, Add, DanceF14, MenuHandler
Menu, SubMenu1.6, Add, DanceF15, MenuHandler
Menu, SubMenu1.6, Add, DanceF16, MenuHandler
Menu, SubMenu1.6, Add, DanceF17, MenuHandler
Menu, SubMenu1.6, Add, DanceF18, MenuHandler
Menu, SubMenu1, Add, Dance Female, :SubMenu1.6

Menu, SubMenu1.7, Add, DanceM, MenuHandler
Menu, SubMenu1.7, Add, DanceM2, MenuHandler
Menu, SubMenu1.7, Add, DanceM3, MenuHandler
Menu, SubMenu1.7, Add, DanceM4, MenuHandler
Menu, SubMenu1.7, Add, DanceM5, MenuHandler
Menu, SubMenu1.7, Add, DanceM6, MenuHandler
Menu, SubMenu1.7, Add, DanceM7, MenuHandler
Menu, SubMenu1.7, Add, DanceM8, MenuHandler
Menu, SubMenu1.7, Add, DanceM9, MenuHandler
Menu, SubMenu1.7, Add, DanceM10, MenuHandler
Menu, SubMenu1.7, Add, DanceM11, MenuHandler
Menu, SubMenu1.7, Add, DanceM12, MenuHandler
Menu, SubMenu1, Add, Dance Male, :SubMenu1.7

Menu, SubMenu1.8, Add, DanceShy, MenuHandler
Menu, SubMenu1.8, Add, DanceShy2, MenuHandler
Menu, SubMenu1, Add, Dance Shy, :SubMenu1.8

Menu, SubMenu1.9, Add, DanceSide, MenuHandler
Menu, SubMenu1.9, Add, DanceSide2, MenuHandler
Menu, SubMenu1.9, Add, DanceSide3, MenuHandler
Menu, SubMenu1, Add, Dance Side, :SubMenu1.9

Menu, SubMenu1.10, Add, DanceSilly, MenuHandler
Menu, SubMenu1.10, Add, DanceSilly2, MenuHandler
Menu, SubMenu1.10, Add, DanceSilly3, MenuHandler
Menu, SubMenu1.10, Add, DanceSilly4, MenuHandler
Menu, SubMenu1.10, Add, DanceSilly5, MenuHandler
Menu, SubMenu1.10, Add, DanceSilly6, MenuHandler
Menu, SubMenu1.10, Add, DanceSilly7, MenuHandler
Menu, SubMenu1.10, Add, DanceSilly8, MenuHandler
Menu, SubMenu1.10, Add, DanceSilly9, MenuHandler
Menu, SubMenu1, Add, Dance Silly, :SubMenu1.10

Menu, SubMenu1.11, Add, DanceSlow, MenuHandler
Menu, SubMenu1.11, Add, DanceSlow2, MenuHandler
Menu, SubMenu1.11, Add, DanceSlow3, MenuHandler
Menu, SubMenu1.11, Add, DanceSlow4, MenuHandler
Menu, SubMenu1, Add, Dance Slow, :SubMenu1.11

Menu, SubMenu1.12, Add, DanceUpper, MenuHandler
Menu, SubMenu1.12, Add, DanceUpper2, MenuHandler
Menu, SubMenu1, Add, Dance Upper, :SubMenu1.12

Menu, SubMenu1.13, Add, FishDance, MenuHandler
Menu, SubMenu1.13, Add, FishDance2, MenuHandler
Menu, SubMenu1.13, Add, FishDance3, MenuHandler
Menu, SubMenu1, Add, Dance Fish, :SubMenu1.13

Menu, SubMenu1.14, Add, JazzHands, MenuHandler
Menu, SubMenu1.14, Add, JazzHands2, MenuHandler
Menu, SubMenu1, Add, Jazz Hands, :SubMenu1.14

Menu, SubMenu1.15, Add, LapDance, MenuHandler
Menu, SubMenu1.15, Add, LapDance2, MenuHandler
Menu, SubMenu1.15, Add, LapDance3, MenuHandler
Menu, SubMenu1.15, Add, LapDance4, MenuHandler
Menu, SubMenu1, Add, Lap Dance, :SubMenu1.15

Menu, SubMenu1.16, Add, SalsaRoll, MenuHandler
Menu, SubMenu1.16, Add, SalsaRoll2, MenuHandler
Menu, SubMenu1, Add, Salsa Roll, :SubMenu1.16

Menu, SubMenu1.17, Add, Twerk, MenuHandler
Menu, SubMenu1.17, Add, Twerk2, MenuHandler
Menu, SubMenu1, Add, Twerk, :SubMenu1.17

Menu, SubMenu1.18, Add, UncleDisco, MenuHandler
Menu, SubMenu1.18, Add, UncleDisco2, MenuHandler
Menu, SubMenu1, Add, Uncle Disco, :SubMenu1.18

Menu, SubMenu1.19, Add, Woogie, MenuHandler
Menu, SubMenu1.19, Add, Woogie2, MenuHandler
Menu, SubMenu1, Add, Woogie, :SubMenu1.19

Menu, SubMenu1.20, Add, AirHump, MenuHandler
Menu, SubMenu1.20, Add, Curtsy, MenuHandler
Menu, SubMenu1.20, Add, PodiumDance, MenuHandler
Menu, SubMenu1, Add, Other, :SubMenu1.20

Menu, FullMenuAnim, Add, Dances, :SubMenu1

Menu, SubMenu2.1, Add, Cop, MenuHandler
Menu, SubMenu2.1, Add, Cop2, MenuHandler
Menu, SubMenu2.1, Add, Cop3, MenuHandler
Menu, SubMenu2.1, Add, Cop4, MenuHandler
Menu, SubMenu2.1, Add, Cop5, MenuHandler
Menu, SubMenu2, Add, Cop, :SubMenu2.1

Menu, SubMenu2.2, Add, CrossArms, MenuHandler
Menu, SubMenu2.2, Add, CrossArms2, MenuHandler
Menu, SubMenu2.2, Add, CrossArms3, MenuHandler
Menu, SubMenu2.2, Add, CrossArms4, MenuHandler
Menu, SubMenu2.2, Add, CrossArms5, MenuHandler
Menu, SubMenu2.2, Add, CrossArms6, MenuHandler
Menu, SubMenu2.2, Add, CrossArmsSide, MenuHandler
Menu, SubMenu2, Add, Cross Arms, :SubMenu2.2

Menu, SubMenu2.3, Add, Fit, MenuHandler
Menu, SubMenu2.3, Add, Fit2, MenuHandler
Menu, SubMenu2, Add, Fit, :SubMenu2.3

Menu, SubMenu2.4, Add, FoldArms, MenuHandler
Menu, SubMenu2.4, Add, FoldArms2, MenuHandler
Menu, SubMenu2.4, Add, FoldArms3, MenuHandler
Menu, SubMenu2.4, Add, FoldArms4, MenuHandler
Menu, SubMenu2.4, Add, FoldArms5, MenuHandler
Menu, SubMenu2, Add, Fold Arms, :SubMenu2.4

Menu, SubMenu2.5, Add, Gang, MenuHandler
Menu, SubMenu2.5, Add, Gang2, MenuHandler
Menu, SubMenu2, Add, Gang, :SubMenu2.5

Menu, SubMenu2.6, Add, Idle, MenuHandler
Menu, SubMenu2.6, Add, Idle2, MenuHandler
Menu, SubMenu2.6, Add, Idle3, MenuHandler
Menu, SubMenu2.6, Add, Idle4, MenuHandler
Menu, SubMenu2.6, Add, Idle5, MenuHandler
Menu, SubMenu2.6, Add, Idle6, MenuHandler
Menu, SubMenu2.6, Add, Idle7, MenuHandler
Menu, SubMenu2.6, Add, Idle8, MenuHandler
Menu, SubMenu2.6, Add, Idle9, MenuHandler
Menu, SubMenu2.6, Add, Idle10, MenuHandler
Menu, SubMenu2.6, Add, Idle11, MenuHandler
Menu, SubMenu2.6, Add, Idle12, MenuHandler
Menu, SubMenu2.6, Add, IdleDrunk, MenuHandler
Menu, SubMenu2.6, Add, IdleDrunk2, MenuHandler
Menu, SubMenu2.6, Add, IdleDrunk3, MenuHandler
Menu, SubMenu2, Add, Idle, :SubMenu2.6

Menu, SubMenu2.7, Add, Impatient, MenuHandler
Menu, SubMenu2.7, Add, Impatient2, MenuHandler
Menu, SubMenu2, Add, Impatient, :SubMenu2.7

Menu, SubMenu2.8.1, Add, Lean, MenuHandler
Menu, SubMenu2.8.1, Add, Lean2, MenuHandler
Menu, SubMenu2.8.1, Add, Lean3, MenuHandler
Menu, SubMenu2.8.1, Add, Lean4, MenuHandler
Menu, SubMenu2.8.1, Add, Lean5, MenuHandler
Menu, SubMenu2.8.1, Add, Lean6, MenuHandler
Menu, SubMenu2.8.1, Add, Lean7, MenuHandler
Menu, SubMenu2.8.1, Add, Lean8, MenuHandler
Menu, SubMenu2.8.1, Add, Lean9, MenuHandler
Menu, SubMenu2.8.1, Add, Lean10, MenuHandler
Menu, SubMenu2.8, Add, Lean, :SubMenu2.8.1

Menu, SubMenu2.8.2, Add, LeanBar, MenuHandler
Menu, SubMenu2.8.2, Add, LeanBar2, MenuHandler
Menu, SubMenu2.8.2, Add, LeanBar3, MenuHandler
Menu, SubMenu2.8, Add, Lean Bar, :SubMenu2.8.2

Menu, SubMenu2.8.3, Add, LeanHigh, MenuHandler
Menu, SubMenu2.8.3, Add, LeanHigh2, MenuHandler
Menu, SubMenu2.8, Add, Lean High, :SubMenu2.8.3

Menu, SubMenu2.8.4, Add, LeanRail, MenuHandler
Menu, SubMenu2.8.4, Add, LeanRail2, MenuHandler
Menu, SubMenu2.8.4, Add, LeanRail3, MenuHandler
Menu, SubMenu2.8, Add, Lean Rail, :SubMenu2.8.4

Menu, SubMenu2.8.5, Add, LeanSide, MenuHandler
Menu, SubMenu2.8.5, Add, LeanSide2, MenuHandler
Menu, SubMenu2.8.5, Add, LeanSide3, MenuHandler
Menu, SubMenu2.8.5, Add, LeanSide4, MenuHandler
Menu, SubMenu2.8.5, Add, LeanSide5, MenuHandler
Menu, SubMenu2.8.5, Add, LeanSide6, MenuHandler
Menu, SubMenu2.8, Add, Lean Side, :SubMenu2.8.5

Menu, SubMenu2.8.6, Add, LeanTable, MenuHandler
Menu, SubMenu2.8.6, Add, LeanTable2, MenuHandler
Menu, SubMenu2.8, Add, Lean table, :SubMenu2.8.6

Menu, SubMenu2.8.7, Add, LeanFlirt, MenuHandler
Menu, SubMenu2.8.7, Add, LeanSleepy, MenuHandler
Menu, SubMenu2.8.7, Add, LeanStretch, MenuHandler
Menu, SubMenu2.8, Add, Other, :SubMenu2.8.7
Menu, SubMenu2, Add, Lean, :SubMenu2.8

Menu, SubMenu2.9, Add, Listen, MenuHandler
Menu, SubMenu2.9, Add, Listen2, MenuHandler
Menu, SubMenu2.9, Add, Listen3, MenuHandler
Menu, SubMenu2.9, Add, Listen4, MenuHandler
Menu, SubMenu2.9, Add, Listen5, MenuHandler
Menu, SubMenu2, Add, Listen, :SubMenu2.9

Menu, SubMenu2.10, Add, NosePick, MenuHandler
Menu, SubMenu2.10, Add, NosePick2, MenuHandler
Menu, SubMenu2, Add, Nose Pick, :SubMenu2.10

Menu, SubMenu2.11, Add, Sexy, MenuHandler
Menu, SubMenu2.11, Add, Sexy2, MenuHandler
Menu, SubMenu2.11, Add, Sexy3, MenuHandler
Menu, SubMenu2, Add, Sexy, :SubMenu2.11

Menu, SubMenu2.11.1, Add, Shy, MenuHandler
Menu, SubMenu2.11.1, Add, Shy2, MenuHandler
Menu, SubMenu2.11.1, Add, Shy3, MenuHandler
Menu, SubMenu2, Add, Shy, :SubMenu2.11.1

Menu, SubMenu2.12, Add, Smoke, MenuHandler
Menu, SubMenu2.12, Add, SmokeFlick, MenuHandler
Menu, SubMenu2.12, Add, SmokeFlick2, MenuHandler
Menu, SubMenu2, Add, Smoke, :SubMenu2.12

Menu, SubMenu2.13, Add, StandStraight, MenuHandler
Menu, SubMenu2.13, Add, StandStraight2, MenuHandler
Menu, SubMenu2.13, Add, StandStraight3, MenuHandler
Menu, SubMenu2.13, Add, StandStraight4, MenuHandler
Menu, SubMenu2, Add, Stand Straight, :SubMenu2.13

Menu, SubMenu2.14, Add, Statue2, MenuHandler
Menu, SubMenu2.14, Add, Statue3, MenuHandler
Menu, SubMenu2, Add, Statue, :SubMenu2.14

Menu, SubMenu2.15, Add, Superhero, MenuHandler
Menu, SubMenu2.15, Add, Superhero2, MenuHandler
Menu, SubMenu2.15, Add, Spiderman, MenuHandler
Menu, SubMenu2, Add, Superhero, :SubMenu2.15

Menu, SubMenu2.16, Add, T, MenuHandler
Menu, SubMenu2.16, Add, T2, MenuHandler
Menu, SubMenu2, Add, T-Poses, :SubMenu2.16

Menu, SubMenu2.17, Add, Think, MenuHandler
Menu, SubMenu2.17, Add, Think2, MenuHandler
Menu, SubMenu2.17, Add, Think3, MenuHandler
Menu, SubMenu2.17, Add, Think4, MenuHandler
Menu, SubMenu2.17, Add, Think5, MenuHandler
Menu, SubMenu2, Add, Think, :SubMenu2.17

Menu, SubMenu2.18, Add, Twitchy, MenuHandler
Menu, SubMenu2.18, Add, Twitchy2, MenuHandler
Menu, SubMenu2.18, Add, Twitchy3, MenuHandler
Menu, SubMenu2.18, Add, Twitchy4, MenuHandler
Menu, SubMenu2, Add, Twitchy, :SubMenu2.18

Menu, SubMenu2.19, Add, Wait, MenuHandler
Menu, SubMenu2.19, Add, Wait2, MenuHandler
Menu, SubMenu2.19, Add, Wait3, MenuHandler
Menu, SubMenu2.19, Add, Wait4, MenuHandler
Menu, SubMenu2.19, Add, Wait5, MenuHandler
Menu, SubMenu2.19, Add, Wait6, MenuHandler
Menu, SubMenu2.19, Add, Wait7, MenuHandler
Menu, SubMenu2.19, Add, Wait8, MenuHandler
Menu, SubMenu2.19, Add, Wait9, MenuHandler
Menu, SubMenu2.19, Add, Wait10, MenuHandler
Menu, SubMenu2.19, Add, Wait11, MenuHandler
Menu, SubMenu2.19, Add, Wait12, MenuHandler
Menu, SubMenu2.19, Add, Wait13, MenuHandler
Menu, SubMenu2.19, Add, Wait14, MenuHandler
Menu, SubMenu2.19, Add, Wait15, MenuHandler
Menu, SubMenu2.19, Add, Wait16, MenuHandler
Menu, SubMenu2, Add, Wait, :SubMenu2.19

Menu, SubMenu2.20, Add, Watch, MenuHandler
Menu, SubMenu2.20, Add, Watch2, MenuHandler
Menu, SubMenu2.20, Add, WatchStrip, MenuHandler
Menu, SubMenu2, Add, Watch, :SubMenu2.20

Menu, SubMenu2.21, Add, AirPlane, MenuHandler
Menu, SubMenu2.21, Add, Bark, MenuHandler
Menu, SubMenu2.21, Add, BarTender, MenuHandler
Menu, SubMenu2.21, Add, CheckOut, MenuHandler
Menu, SubMenu2.21, Add, FallAsleep, MenuHandler
Menu, SubMenu2.21, Add, Fidget, MenuHandler
Menu, SubMenu2.21, Add, Hooker, MenuHandler
Menu, SubMenu2.21, Add, Ledge, MenuHandler
Menu, SubMenu2.21, Add, LookAround, MenuHandler
Menu, SubMenu2.21, Add, Metal, MenuHandler
Menu, SubMenu2.21, Add, Namaste, MenuHandler
Menu, SubMenu2.21, Add, Pee, MenuHandler
Menu, SubMenu2.21, Add, Peek, MenuHandler
Menu, SubMenu2.21, Add, Reaching, MenuHandler
Menu, SubMenu2.21, Add, StickUp, MenuHandler
Menu, SubMenu2.21, Add, Stumble, MenuHandler
Menu, SubMenu2.21, Add, Stunned, MenuHandler
Menu, SubMenu2.21, Add, Threaten, MenuHandler
Menu, SubMenu2.21, Add, Warming, MenuHandler
Menu, SubMenu2.21, Add, WashFace, MenuHandler
Menu, SubMenu2.21, Add, Wasted, MenuHandler
Menu, SubMenu2, Add, Other, :SubMenu2.21
Menu, FullMenuAnim, Add, Stances, :SubMenu2

Menu, SubMenu3.1.1, Add, Sit, MenuHandler
Menu, SubMenu3.1.1, Add, Sit2, MenuHandler
Menu, SubMenu3.1.1, Add, Sit3, MenuHandler
Menu, SubMenu3.1.1, Add, Sit4, MenuHandler
Menu, SubMenu3.1.1, Add, Sit5, MenuHandler
Menu, SubMenu3.1.1, Add, Sit6, MenuHandler
Menu, SubMenu3.1.1, Add, Sit7, MenuHandler
Menu, SubMenu3.1.1, Add, Sit8, MenuHandler
Menu, SubMenu3.1.1, Add, Sit9, MenuHandler
Menu, SubMenu3.1.1, Add, Sit10, MenuHandler
Menu, SubMenu3.1.1, Add, Sit11, MenuHandler
Menu, SubMenu3.1.1, Add, Sit12, MenuHandler
Menu, SubMenu3.1.1, Add, SitDrunk, MenuHandler
Menu, SubMenu3.1.1, Add, SitFloor, MenuHandler
Menu, SubMenu3.1.1, Add, SitFloor2, MenuHandler
Menu, SubMenu3.1.1, Add, SitGround, MenuHandler
Menu, SubMenu3.1.1, Add, SitSad, MenuHandler
Menu, SubMenu3.1.1, Add, SitScared, MenuHandler
Menu, SubMenu3.1.1, Add, SitScared2, MenuHandler
Menu, SubMenu3.1.1, Add, SitScared3, MenuHandler
Menu, SubMenu3.1, Add, Sit, :SubMenu3.1.1
Menu, SubMenu3.1, Add, Meditate, MenuHandler
Menu, SubMenu3.1, Add, Meditate2, MenuHandler
Menu, SubMenu3.1, Add, Meditate3, MenuHandler
Menu, SubMenu3.1, Add, Praise, MenuHandler
Menu, SubMenu3.1, Add, Praise2, MenuHandler
Menu, SubMenu3, Add, Sit on ground, :SubMenu3.1

Menu, SubMenu3.2.1, Add, Bench, MenuHandler
Menu, SubMenu3.2.1, Add, Bench2, MenuHandler
Menu, SubMenu3.2.1, Add, Bench3, MenuHandler
Menu, SubMenu3.2.1, Add, BenchSmoke, MenuHandler
Menu, SubMenu3.2.1, Add, TalkOnBench, MenuHandler
Menu, SubMenu3.2, Add, Bench, :SubMenu3.2.1
Menu, SubMenu3.2, Add, Praise2, MenuHandler
Menu, SubMenu3.2, Add, PimpSit, MenuHandler
Menu, SubMenu3.2, Add, SitBonnet, MenuHandler

Menu, SubMenu3.2.2, Add, SitChair, MenuHandler
Menu, SubMenu3.2.2, Add, SitChair2, MenuHandler
Menu, SubMenu3.2.2, Add, SitChair3, MenuHandler
Menu, SubMenu3.2.2, Add, SitChair4, MenuHandler
Menu, SubMenu3.2.2, Add, SitChair5, MenuHandler
Menu, SubMenu3.2.2, Add, SitChair6, MenuHandler
Menu, SubMenu3.2.2, Add, SitChairSide, MenuHandler
Menu, SubMenu3.2, Add, Chair, :SubMenu3.2.2

Menu, SubMenu3.2, Add, SitLean, MenuHandler
Menu, SubMenu3.2, Add, SitStairs, MenuHandler
Menu, SubMenu3.2, Add, SitWorried, MenuHandler
Menu, SubMenu3, Add, Sit on object, :SubMenu3.2

Menu, SubMenu3.3, Add, Crouch, MenuHandler
Menu, SubMenu3.3, Add, Crouch2, MenuHandler
Menu, SubMenu3, Add, Crouch, :SubMenu3.3

Menu, SubMenu3.4, Add, Kneel, MenuHandler
Menu, SubMenu3.4, Add, Kneel2, MenuHandler
Menu, SubMenu3.4, Add, Kneel3, MenuHandler
Menu, SubMenu3.4, Add, Medic, MenuHandler
Menu, SubMenu3, Add, Kneel, :SubMenu3.4

Menu, FullMenuAnim, Add, Sit/Crouch/Kneel, :SubMenu3

Menu, SubMenu4.1, Add, CloudGaze, MenuHandler
Menu, SubMenu4.1, Add, CloudGaze2, MenuHandler
Menu, SubMenu4, Add, Cloud Gaze, :SubMenu4.1

Menu, SubMenu4.2, Add, Down, MenuHandler
Menu, SubMenu4.2, Add, Down2, MenuHandler
Menu, SubMenu4.2, Add, Down3, MenuHandler
Menu, SubMenu4.2, Add, Down4, MenuHandler
Menu, SubMenu4.2, Add, Down5, MenuHandler
Menu, SubMenu4, Add, Down, :SubMenu4.2

Menu, SubMenu4.3, Add, PassOut, MenuHandler
Menu, SubMenu4.3, Add, PassOut2, MenuHandler
Menu, SubMenu4.3, Add, PassOut3, MenuHandler
Menu, SubMenu4.3, Add, PassOut4, MenuHandler
Menu, SubMenu4.3, Add, PassOut5, MenuHandler
Menu, SubMenu4, Add, Pass out, :SubMenu4.3

Menu, SubMenu4.4, Add, Slumped, MenuHandler
Menu, SubMenu4.4, Add, Slumped2, MenuHandler
Menu, SubMenu4, Add, Slumped, :SubMenu4.4

Menu, SubMenu4.5, Add, SunBathe, MenuHandler
Menu, SubMenu4.5, Add, SunBathe2, MenuHandler
Menu, SubMenu4.5, Add, SunBathe3, MenuHandler
Menu, SubMenu4, Add, Sun bathing, :SubMenu4.5

Menu, SubMenu4.6, Add, Chill, MenuHandler
Menu, SubMenu4.6, Add, LayDown, MenuHandler
Menu, SubMenu4.6, Add, LayingInPain, MenuHandler
Menu, SubMenu4.6, Add, Prone, MenuHandler
Menu, SubMenu4.6, Add, Sleep, MenuHandler
Menu, SubMenu4, Add, Other, :SubMenu4.6
Menu, FullMenuAnim, Add, Laydown, :SubMenu4

Menu, SubMenu5.1.1, Add, Arrest, MenuHandler
Menu, SubMenu5.1.1, Add, HandsUp, MenuHandler
Menu, SubMenu5.1, Add, Standing, :SubMenu5.1.1

Menu, SubMenu5.1.2, Add, Down2, MenuHandler
Menu, SubMenu5.1.2, Add, Down3, MenuHandler
Menu, SubMenu5.1.2, Add, Down5, MenuHandler
Menu, SubMenu5.1, Add, On knees, :SubMenu5.1.2
Menu, SubMenu5, Add, Allow detain/arrest, :SubMenu5.1

Menu, SubMenu5.2, Add, Surrender, MenuHandler
Menu, SubMenu5.2, Add, HandsUp2, MenuHandler
Menu, SubMenu5, Add, Surrender, :SubMenu5.2

Menu, SubMenu5.3, Add, Cower, MenuHandler
Menu, SubMenu5.3, Add, Down4, MenuHandler
Menu, SubMenu5.3, Add, Hostage, MenuHandler

Menu, SubMenu5.3.1, Add, Frightened, MenuHandler
Menu, SubMenu5.3.1, Add, Frightened2, MenuHandler
Menu, SubMenu5.3.1, Add, Frightened3, MenuHandler
Menu, SubMenu5.3.1, Add, Frightened4, MenuHandler
Menu, SubMenu5.3, Add, Frightened, :SubMenu5.3.1
Menu, SubMenu5, Add, Scared, :SubMenu5.3
Menu, SubMenu5, Add, UnCuff, MenuHandler
Menu, FullMenuAnim, Add, Hostage/Detaining, :SubMenu5

Menu, SubMenu6, Add, Adjust, MenuHandler
Menu, SubMenu6, Add, AdjustTie, MenuHandler
Menu, SubMenu6, Add, DustOff, MenuHandler
Menu, SubMenu6, Add, ShakeOff, MenuHandler

Menu, SubMenu6.1, Add, TryClothes, MenuHandler
Menu, SubMenu6.1, Add, TryClothes2, MenuHandler
Menu, SubMenu6.1, Add, TryClothes3, MenuHandler
Menu, SubMenu6, Add, Try Clothes, :SubMenu6.1
Menu, FullMenuAnim, Add, Clothing, :SubMenu6

Menu, SubMenu7, Add, Angry, MenuHandler

Menu, SubMenu7.1, Add, Argue, MenuHandler
Menu, SubMenu7.1, Add, Argue2, MenuHandler
Menu, SubMenu7, Add, Argue, :SubMenu7.1

Menu, SubMenu7.2, Add, Depressed, MenuHandler
Menu, SubMenu7.2, Add, Depressed2, MenuHandler
Menu, SubMenu7, Add, Depressed, :SubMenu7.2

Menu, SubMenu7, Add, Distressed, MenuHandler

Menu, SubMenu7.3, Add, FacePalm, MenuHandler
Menu, SubMenu7.3, Add, FacePalm2, MenuHandler
Menu, SubMenu7.3, Add, FacePalm3, MenuHandler
Menu, SubMenu7.3, Add, FacePalm4, MenuHandler
Menu, SubMenu7.3, Add, Palm, MenuHandler
Menu, SubMenu7, Add, Face palming, :SubMenu7.3

Menu, SubMenu7.4, Add, Frightened, MenuHandler
Menu, SubMenu7.4, Add, Frightened2, MenuHandler
Menu, SubMenu7.4, Add, Frightened3, MenuHandler
Menu, SubMenu7.4, Add, Frightened4, MenuHandler
Menu, SubMenu7, Add, Frightened, :SubMenu7.4

Menu, SubMenu7.5, Add, Nervous, MenuHandler
Menu, SubMenu7.5, Add, Nervous2, MenuHandler
Menu, SubMenu7.5, Add, Nervous3, MenuHandler
Menu, SubMenu7, Add, Nervous, :SubMenu7.5

Menu, SubMenu7.6, Add, Scared, MenuHandler
Menu, SubMenu7.6, Add, Scared2, MenuHandler
Menu, SubMenu7.6, Add, Scared3, MenuHandler
Menu, SubMenu7.6, Add, SitScared, MenuHandler
Menu, SubMenu7.6, Add, SitScared2, MenuHandler
Menu, SubMenu7.6, Add, SitScared3, MenuHandler
Menu, SubMenu7, Add, Scared, :SubMenu7.6

Menu, SubMenu7.7, Add, Shy, MenuHandler
Menu, SubMenu7.7, Add, Shy2, MenuHandler
Menu, SubMenu7.7, Add, Shy3, MenuHandler
Menu, SubMenu7, Add, Shy, :SubMenu7.7

Menu, SubMenu7.8, Add, Worried, MenuHandler
Menu, SubMenu7.8, Add, SitWorried, MenuHandler
Menu, SubMenu7, Add, Worried, :SubMenu7.8
Menu, FullMenuAnim, Add, Emotions, :SubMenu7

Menu, SubMenu8, Add, Beast, MenuHandler

Menu, SubMenu8.1, Add, Boxing, MenuHandler
Menu, SubMenu8.1, Add, Boxing2, MenuHandler
Menu, SubMenu8, Add, Boxing, :SubMenu8.1

Menu, SubMenu8.2, Add, BringItOn, MenuHandler
Menu, SubMenu8.2, Add, FightMe, MenuHandler
Menu, SubMenu8.2, Add, FightMe2, MenuHandler
Menu, SubMenu8.2, Add, KnuckleCrunch, MenuHandler
Menu, SubMenu8.2, Add, KnuckleCrunch2, MenuHandler
Menu, SubMenu8, Add, Challenge someone, :SubMenu8.2

Menu, SubMenu8.3, Add, Headbutt, MenuHandler
Menu, SubMenu8.3, Add, Punching, MenuHandler
Menu, SubMenu8.3, Add, Slap, MenuHandler
Menu, SubMenu8, Add, Attacks, :SubMenu8.3

Menu, FullMenuAnim, Add, Fight, :SubMenu8

Menu, SubMenu9.1, Add, Bark, MenuHandler
Menu, SubMenu9.1, Add, Bird, MenuHandler
Menu, SubMenu9.1, Add, Rabbit, MenuHandler
Menu, SubMenu9, Add, Animals, :SubMenu9.1

Menu, SubMenu9.2, Add, Freakout, MenuHandler
Menu, SubMenu9.2, Add, Freakout2, MenuHandler
Menu, SubMenu9, Add, Freakout, :SubMenu9.2

Menu, SubMenu9, Add, GrabCrotch, MenuHandler

Menu, SubMenu9.3, Add, Loco, MenuHandler
Menu, SubMenu9.3, Add, Loco2, MenuHandler
Menu, SubMenu9, Add, Loco, :SubMenu9.3

Menu, SubMenu9.4, Add, LOL, MenuHandler
Menu, SubMenu9.4, Add, LOL2, MenuHandler
Menu, SubMenu9, Add, LOL, :SubMenu9.4

Menu, SubMenu9.5, Add, MindControl, MenuHandler
Menu, SubMenu9.5, Add, MindControl2, MenuHandler
Menu, SubMenu9, Add, Mind control, :SubMenu9.5

Menu, SubMenu9, Add, PickButt, MenuHandler
Menu, SubMenu9, Add, Wank, MenuHandler

Menu, FullMenuAnim, Add, Goofy, :SubMenu9

Menu, SubMenu10.1, Add, Bow, MenuHandler
Menu, SubMenu10.1, Add, Bow2, MenuHandler
Menu, SubMenu10, Add, Bow, :SubMenu10.1

Menu, SubMenu10.2, Add, BroLove, MenuHandler
Menu, SubMenu10.2, Add, BroLove2, MenuHandler
Menu, SubMenu10, Add, Bro love, :SubMenu10.2

Menu, SubMenu10.3, Add, Damn, MenuHandler
Menu, SubMenu10.3, Add, Damn2, MenuHandler
Menu, SubMenu10.3, Add, Damn3, MenuHandler
Menu, SubMenu10, Add, Damn, :SubMenu10.3

Menu, SubMenu10.4, Add, Handshake, MenuHandler
Menu, SubMenu10.4, Add, Handshake2, MenuHandler
Menu, SubMenu10, Add, Handshakes, :SubMenu10.4

Menu, SubMenu10.5, Add, Hug, MenuHandler
Menu, SubMenu10.5, Add, Hug2, MenuHandler
Menu, SubMenu10.5, Add, Hug3, MenuHandler
Menu, SubMenu10, Add, Hugs, :SubMenu10.5

Menu, SubMenu10.6, Add, Knock, MenuHandler
Menu, SubMenu10.6, Add, Knock2, MenuHandler
Menu, SubMenu10, Add, Knocking, :SubMenu10.6

Menu, SubMenu10.7, Add, MindBlown, MenuHandler
Menu, SubMenu10.7, Add, MindBlown2, MenuHandler
Menu, SubMenu10, Add, Mind blown, :SubMenu10.7

Menu, SubMenu10.8, Add, No, MenuHandler
Menu, SubMenu10.8, Add, No2, MenuHandler
Menu, SubMenu10.8, Add, NoWay, MenuHandler
Menu, SubMenu10.8, Add, NoWay2, MenuHandler
Menu, SubMenu10.8, Add, NoWay3, MenuHandler
Menu, SubMenu10, Add, No, :SubMenu10.8

Menu, SubMenu10.9, Add, Ok, MenuHandler
Menu, SubMenu10.9, Add, Ok2, MenuHandler
Menu, SubMenu10.9, Add, Yeah, MenuHandler
Menu, SubMenu10, Add, Ok, :SubMenu10.9

Menu, SubMenu10.10, Add, Photo, MenuHandler
Menu, SubMenu10.10, Add, Photo2, MenuHandler
Menu, SubMenu10, Add, Photo, :SubMenu10.10

Menu, SubMenu10.11, Add, Point, MenuHandler
Menu, SubMenu10.11, Add, PointDown, MenuHandler
Menu, SubMenu10.11, Add, PointRight, MenuHandler
Menu, SubMenu10, Add, Pointing, :SubMenu10.11

Menu, SubMenu10.12, Add, Salute, MenuHandler
Menu, SubMenu10.12, Add, Salute2, MenuHandler
Menu, SubMenu10.12, Add, Salute3, MenuHandler
Menu, SubMenu10.12, Add, Salute4, MenuHandler
Menu, SubMenu10, Add, Salute, :SubMenu10.12

Menu, SubMenu10.13, Add, Shrug, MenuHandler
Menu, SubMenu10.13, Add, Shrug2, MenuHandler
Menu, SubMenu10, Add, Shrug, :SubMenu10.13

Menu, SubMenu10.14, Add, Smell, MenuHandler
Menu, SubMenu10.14, Add, Stink, MenuHandler
Menu, SubMenu10.14, Add, Stink2, MenuHandler
Menu, SubMenu10, Add, Smell/Stink, :SubMenu10.14

Menu, SubMenu10.15, Add, ThumbsDown, MenuHandler
Menu, SubMenu10.15, Add, ThumbsDown2, MenuHandler
Menu, SubMenu10, Add, Thumbs down, :SubMenu10.15

Menu, SubMenu10.16, Add, ThumbsUp, MenuHandler
Menu, SubMenu10.16, Add, ThumbsUp2, MenuHandler
Menu, SubMenu10.16, Add, ThumbsUp3, MenuHandler
Menu, SubMenu10.16, Add, ThumbsUp4, MenuHandler
Menu, SubMenu10.16, Add, ThumbsUp5, MenuHandler
Menu, SubMenu10.16, Add, ThumbsUp6, MenuHandler
Menu, SubMenu10, Add, Thumbs up, :SubMenu10.16

Menu, SubMenu10.17, Add, Wave, MenuHandler
Menu, SubMenu10.17, Add, Wave2, MenuHandler
Menu, SubMenu10.17, Add, Wave3, MenuHandler
Menu, SubMenu10.17, Add, Wave4, MenuHandler
Menu, SubMenu10.17, Add, Wave5, MenuHandler
Menu, SubMenu10.17, Add, Wave6, MenuHandler
Menu, SubMenu10.17, Add, Wave7, MenuHandler
Menu, SubMenu10.17, Add, Wave8, MenuHandler
Menu, SubMenu10.17, Add, Wave9, MenuHandler
Menu, SubMenu10.17, Add, Wave10, MenuHandler
Menu, SubMenu10.17, Add, Wave11, MenuHandler
Menu, SubMenu10.17, Add, Wave12, MenuHandler
Menu, SubMenu10.17, Add, Wave13, MenuHandler
Menu, SubMenu10.17, Add, Wave14, MenuHandler
Menu, SubMenu10, Add, Wave, :SubMenu10.17

Menu, SubMenu10.18, Add, What, MenuHandler
Menu, SubMenu10.18, Add, What2, MenuHandler
Menu, SubMenu10, Add, What, :SubMenu10.18

Menu, SubMenu10.19, Add, Whistle, MenuHandler
Menu, SubMenu10.19, Add, Whistle2, MenuHandler
Menu, SubMenu10.19, Add, Taxi, MenuHandler
Menu, SubMenu10, Add, Whistles, :SubMenu10.19

Menu, SubMenu10.20, Add, BlowKiss, MenuHandler
Menu, SubMenu10.20, Add, Boi, MenuHandler
Menu, SubMenu10.20, Add, ComeHere, MenuHandler
Menu, SubMenu10.20, Add, Greeting, MenuHandler
Menu, SubMenu10.20, Add, Inspect, MenuHandler
Menu, SubMenu10.20, Add, KeyFob, MenuHandler
Menu, SubMenu10.20, Add, Lift, MenuHandler
Menu, SubMenu10.20, Add, Me, MenuHandler
Menu, SubMenu10.20, Add, Petting, MenuHandler
Menu, SubMenu10.20, Add, PickUp, MenuHandler
Menu, SubMenu10.20, Add, PullOver, MenuHandler
Menu, SubMenu10.20, Add, ThankYou, MenuHandler
Menu, SubMenu10.20, Add, WashFace, MenuHandler
Menu, SubMenu10, Add, Other, :SubMenu10.20

Menu, FullMenuAnim, Add, Interaction, :SubMenu10

Menu, SubMenu11.1, Add, CashRain, MenuHandler
Menu, SubMenu11.1, Add, CashRain2, MenuHandler
Menu, SubMenu11, Add, Cash rain, :SubMenu11.1

Menu, SubMenu11.2, Add, FingerKiss, MenuHandler
Menu, SubMenu11.2, Add, FingerKiss2, MenuHandler
Menu, SubMenu11, Add, Finger kiss, :SubMenu11.2

Menu, SubMenu11.3, Add, Lapdance, MenuHandler
Menu, SubMenu11.3, Add, Lapdance2, MenuHandler
Menu, SubMenu11.3, Add, Lapdance3, MenuHandler
Menu, SubMenu11.3, Add, Lapdance4, MenuHandler
Menu, SubMenu11, Add, Lapdance, :SubMenu11.3

Menu, SubMenu11.4, Add, Twerk, MenuHandler
Menu, SubMenu11.4, Add, Twerk2, MenuHandler
Menu, SubMenu11, Add, Twerk, :SubMenu11.4

Menu, SubMenu11, Add, Hooker, MenuHandler
Menu, SubMenu11, Add, WatchStrip, MenuHandler

Menu, FullMenuAnim, Add, Stripclub, :SubMenu11

Menu, SubMenu12.1, Add, Cheer, MenuHandler
Menu, SubMenu12.1, Add, Cheer2, MenuHandler
Menu, SubMenu12.1, Add, Cheer3, MenuHandler
Menu, SubMenu12.1, Add, DanceCheer, MenuHandler
Menu, SubMenu12.1, Add, DanceCheer2, MenuHandler
Menu, SubMenu12.1, Add, DanceCheer3, MenuHandler
Menu, SubMenu12.1, Add, RallyCheer, MenuHandler
Menu, SubMenu12, Add, (Dance) Cheer, :SubMenu12.1

Menu, SubMenu12.2, Add, Slide, MenuHandler
Menu, SubMenu12.2, Add, Slide2, MenuHandler
Menu, SubMenu12.2, Add, Slide3, MenuHandler
Menu, SubMenu12, Add, Slide, :SubMenu12.2

Menu, SubMenu12.3, Add, SlowClap, MenuHandler
Menu, SubMenu12.3, Add, ClapAngry, MenuHandler
Menu, SubMenu12, Add, Clapping, :SubMenu12.3

Menu, SubMenu12, Add, Celebrate, MenuHandler
Menu, SubMenu12, Add, Countdown, MenuHandler

Menu, FullMenuAnim, Add, Cheer/Celebrate, :SubMenu12

Menu, SubMenu13.1, Add, Chicken, MenuHandler
Menu, SubMenu13.1, Add, Chicken2, MenuHandler
Menu, SubMenu13, Add, Chicken, :SubMenu13.1


Menu, SubMenu13.2, Add, ChinBrush, MenuHandler
Menu, SubMenu13.2, Add, ChinBrush2, MenuHandler
Menu, SubMenu13, Add, Chin brush, :SubMenu13.2

Menu, SubMenu13, Add, ComeAtMeBro, MenuHandler

Menu, SubMenu13.3, Add, CryBaby, MenuHandler
Menu, SubMenu13.3, Add, CryBaby2, MenuHandler
Menu, SubMenu13, Add, Cry baby, :SubMenu13.3

Menu, SubMenu13.4, Add, CutThroat, MenuHandler
Menu, SubMenu13.4, Add, CutThroat2, MenuHandler
Menu, SubMenu13, Add, Cut Throat, :SubMenu13.4

Menu, SubMenu13.5, Add, Dock, MenuHandler
Menu, SubMenu13.5, Add, Dock2, MenuHandler
Menu, SubMenu13, Add, Dock, :SubMenu13.5

Menu, SubMenu13.6, Add, Finger, MenuHandler
Menu, SubMenu13.6, Add, Finger2, MenuHandler
Menu, SubMenu13, Add, Finger, :SubMenu13.6

Menu, SubMenu13.7, Add, FlipOff, MenuHandler
Menu, SubMenu13.7, Add, FlipOff2, MenuHandler
Menu, SubMenu13.7, Add, FlipOff3, MenuHandler
Menu, SubMenu13.7, Add, FlipOff4, MenuHandler
Menu, SubMenu13, Add, Flip off, :SubMenu13.7

Menu, SubMenu13, Add, ScrewYou, MenuHandler

Menu, SubMenu13.8, Add, Shush, MenuHandler
Menu, SubMenu13.8, Add, Shush2, MenuHandler
Menu, SubMenu13, Add, Shush, :SubMenu13.8

Menu, SubMenu13.9, Add, SlowClap2, MenuHandler
Menu, SubMenu13.9, Add, SlowClap3, MenuHandler
Menu, SubMenu13, Add, Slow clap, :SubMenu13.9

Menu, SubMenu13.10, Add, ThumbOnEars, MenuHandler
Menu, SubMenu13.10, Add, ThumbOnEars2, MenuHandler
Menu, SubMenu13, Add, Thumbs on ears, :SubMenu13.10

Menu, SubMenu13.11, Add, ThumbsDown, MenuHandler
Menu, SubMenu13.11, Add, ThumbsDown2, MenuHandler
Menu, SubMenu13, Add, Thumbs down, :SubMenu13.11

Menu, SubMenu13, Add, Wank, MenuHandler

Menu, FullMenuAnim, Add, Mocking, :SubMenu13

Menu, SubMenu14.1, Add, Photo, MenuHandler
Menu, SubMenu14.1, Add, Photo2, MenuHandler
Menu, SubMenu14, Add, Make photo's, :SubMenu14.1

Menu, SubMenu14, Add, Radio, MenuHandler

Menu, SubMenu14.2, Add, Computer, MenuHandler
Menu, SubMenu14.2, Add, Type, MenuHandler
Menu, SubMenu14.2, Add, Type2, MenuHandler
Menu, SubMenu14.2, Add, Type3, MenuHandler
Menu, SubMenu14.2, Add, Type4, MenuHandler
Menu, SubMenu14, Add, Type, :SubMenu14.2

Menu, FullMenuAnim, Add, Work, :SubMenu14

Menu, SubMenu15.1, Add, CPR, MenuHandler
Menu, SubMenu15.1, Add, CPR2, MenuHandler
Menu, SubMenu15, Add, CPR, :SubMenu15.1

Menu, SubMenu15.2, Add, FallOver, MenuHandler
Menu, SubMenu15.2, Add, FallOver2, MenuHandler
Menu, SubMenu15.2, Add, FallOver3, MenuHandler
Menu, SubMenu15.2, Add, FallOver4, MenuHandler
Menu, SubMenu15.2, Add, FallOver5, MenuHandler
Menu, SubMenu15, Add, Falling over, :SubMenu15.2

Menu, SubMenu15, Add, Inspect, MenuHandler
Menu, SubMenu15, Add, Medic, MenuHandler

Menu, SubMenu15.3, Add, PassOut, MenuHandler
Menu, SubMenu15.3, Add, PassOut2, MenuHandler
Menu, SubMenu15.3, Add, PassOut3, MenuHandler
Menu, SubMenu15.3, Add, PassOut4, MenuHandler
Menu, SubMenu15.3, Add, PassOut5, MenuHandler
Menu, SubMenu15, Add, Passing out, :SubMenu15.3

Menu, SubMenu15.4, Add, Crawl, MenuHandler
Menu, SubMenu15.4, Add, LayingPain, MenuHandler
Menu, SubMenu15.4, Add, Shot, MenuHandler
Menu, SubMenu15, Add, Pain on ground, :SubMenu15.4

Menu, SubMenu15.5, Add, Slumped, MenuHandler
Menu, SubMenu15.5, Add, Slumped2, MenuHandler
Menu, SubMenu15, Add, Slumped, :SubMenu15.5

Menu, FullMenuAnim, Add, Medical/Injuries, :SubMenu15

Menu, SubMenu16, Add, Drink, MenuHandler
Menu, SubMenu16, Add, Eat, MenuHandler

Menu, FullMenuAnim, Add, Food/Drink, :SubMenu16

Menu, SubMenu17.1, Add, Flip, MenuHandler
Menu, SubMenu17.1, Add, Flip2, MenuHandler
Menu, SubMenu15, Add, Flip, :SubMenu17.1

Menu, SubMenu17.2, Add, Jog, MenuHandler
Menu, SubMenu17.2, Add, Jog2, MenuHandler
Menu, SubMenu17.2, Add, Jog3, MenuHandler
Menu, SubMenu17.2, Add, Jog4, MenuHandler
Menu, SubMenu17, Add, Jogging, :SubMenu17.2

Menu, SubMenu17.3, Add, Karate, MenuHandler
Menu, SubMenu17.3, Add, Karate2, MenuHandler
Menu, SubMenu17, Add, Karate, :SubMenu17.3

Menu, SubMenu17.4, Add, Push, MenuHandler
Menu, SubMenu17.4, Add, Push2, MenuHandler
Menu, SubMenu17, Add, Push, :SubMenu17.4

Menu, SubMenu17.5, Add, SitUp, MenuHandler
Menu, SubMenu17.5, Add, SitUps, MenuHandler
Menu, SubMenu17.5, Add, SitUps2, MenuHandler
Menu, SubMenu17, Add, Sit ups, :SubMenu17.5

Menu, SubMenu17.6, Add, Stretch, MenuHandler
Menu, SubMenu17.6, Add, Stretch2, MenuHandler
Menu, SubMenu17.6, Add, Stretch3, MenuHandler
Menu, SubMenu17.6, Add, Stretch4, MenuHandler
Menu, SubMenu17.6, Add, Stretch5, MenuHandler
Menu, SubMenu17, Add, Stretching, :SubMenu17.6

Menu, SubMenu17.7, Add, Yoga, MenuHandler
Menu, SubMenu17.7, Add, Yoga2, MenuHandler
Menu, SubMenu17.7, Add, Yoga3, MenuHandler
Menu, SubMenu17.7, Add, Yoga4, MenuHandler
Menu, SubMenu17.7, Add, Yoga5, MenuHandler
Menu, SubMenu17, Add, Yoga, :SubMenu17.7

Menu, SubMenu17.8, Add, GolfSwing, MenuHandler
Menu, SubMenu17.8, Add, Hiking, MenuHandler
Menu, SubMenu17.8, Add, JumpingJacks, MenuHandler
Menu, SubMenu17.8, Add, OutOfBreath, MenuHandler
Menu, SubMenu17.8, Add, PressUps, MenuHandler
Menu, SubMenu17.8, Add, PushUp, MenuHandler
Menu, SubMenu17.8, Add, Pull, MenuHandler
Menu, SubMenu17.8, Add, PullUp, MenuHandler
Menu, SubMenu17.8, Add, Punching, MenuHandler
Menu, SubMenu17.8, Add, Slugger, MenuHandler
Menu, SubMenu17, Add, Other, :SubMenu17.8

Menu, FullMenuAnim, Add, Sports/Tricks, :SubMenu17

Menu, SubMenu18, Add, Inspect, MenuHandler
Menu, SubMenu18, Add, KeyFob, MenuHandler

Menu, SubMenu18.1, Add, Mechanic, MenuHandler
Menu, SubMenu18.1, Add, Mechanic2, MenuHandler
Menu, SubMenu18.1, Add, Mechanic3, MenuHandler
Menu, SubMenu18.1, Add, Mechanic4, MenuHandler
Menu, SubMenu18.1, Add, Mechanic5, MenuHandler
Menu, SubMenu18, Add, Mechanic, :SubMenu18.1

Menu, FullMenuAnim, Add, Mechanic, :SubMenu18

Menu, SubMenu19, Add, BlowKiss, MenuHandler

Menu, SubMenu19.1, Add, Dock, MenuHandler
Menu, SubMenu19.1, Add, Dock2, MenuHandler
Menu, SubMenu19, Add, Dock, :SubMenu19.1

Menu, SubMenu19.2, Add, Finger, MenuHandler
Menu, SubMenu19.2, Add, Finger2, MenuHandler
Menu, SubMenu19, Add, Finger, :SubMenu19.2

Menu, SubMenu19.3, Add, FingerKiss, MenuHandler
Menu, SubMenu19.3, Add, FingerKiss2, MenuHandler
Menu, SubMenu19, Add, Finger kiss, :SubMenu19.3


Menu, SubMenu19.4, Add, FlipOff, MenuHandler
Menu, SubMenu19.4, Add, FlipOff2, MenuHandler
Menu, SubMenu19.4, Add, FlipOff3, MenuHandler
Menu, SubMenu19.4, Add, FlipOff4, MenuHandler
Menu, SubMenu19, Add, Flipping off, :SubMenu19.4

Menu, SubMenu19.5, Add, Gang, MenuHandler
Menu, SubMenu19.5, Add, Gang2, MenuHandler
Menu, SubMenu19, Add, Gang, :SubMenu19.5

Menu, SubMenu19.6, Add, Loco, MenuHandler
Menu, SubMenu19.6, Add, Loco2, MenuHandler
Menu, SubMenu19, Add, Loco, :SubMenu19.6

Menu, SubMenu19, Add, Me, MenuHandler
Menu, SubMenu19, Add, Metal, MenuHandler
Menu, SubMenu19, Add, Rock, MenuHandler

Menu, SubMenu19.7, Add, MindBlown, MenuHandler
Menu, SubMenu19.7, Add, MindBlown2, MenuHandler
Menu, SubMenu19, Add, Mind Blown, :SubMenu19.7

Menu, SubMenu19.8, Add, Peace, MenuHandler
Menu, SubMenu19.8, Add, Peace2, MenuHandler
Menu, SubMenu19.8, Add, Peace3, MenuHandler
Menu, SubMenu19.8, Add, Peace4, MenuHandler
Menu, SubMenu19, Add, Peace, :SubMenu19.8

Menu, SubMenu19.9, Add, Shush, MenuHandler
Menu, SubMenu19.9, Add, Shush2, MenuHandler
Menu, SubMenu19, Add, Shush, :SubMenu19.9

Menu, SubMenu19.10, Add, V, MenuHandler
Menu, SubMenu19.10, Add, V2, MenuHandler
Menu, SubMenu19, Add, V, :SubMenu19.10

Menu, FullMenuAnim, Add, Gestures/signs, :SubMenu19

Menu, FullMenu, Add, Animations, :FullMenuAnim

Menu, FullMenu, Add, Exit application, ExitApplication

CoordMode, Menu, Screen
Menu, FullMenu, Show, % A_ScreenWidth/2, % A_ScreenHeight/2
return

;Handler for animations
MenuHandler:
	send, t/anim %A_ThisMenuItem%{enter}
return

;Vehicle spawn handlers
SpawnAlamo:
	send, t/fspawn policealamo{enter}
return

SpawnBuffalo:
	send, t/fspawn policebuffalo2{enter}
return

SpawnMotorcycle:
    send, t/fspawn policeb{enter}
return

SpawnDrafter:
	send, t/fspawn policedrafter 4{enter}
return

SpawnKamacho:
	send, t/fspawn policekamacho{enter}
return

SpawnVic:
	send, t/fspawn police4{enter}
return

SpawnInterceptor:
	send, t/fspawn police3 4{enter}
return

SpawnScout:
	send, t/fspawn policescout{enter}
return

SpawnVan:
	send, t/fspawn policet{enter}
return

SpawnFlatbed:
	send, t/fspawn flatbed{enter}
return

SpawnScoutTED:
	send, t/fspawn policescout 4{enter}
return

SpawnScoutGU:
	send, t/fspawn policescout 5{enter}
return

SpawnCaracaraGU:
	send, t/fspawn policecaracara 5{enter}
return

SpawnUnmarkedScout:
	send, t/fspawn policescout2{enter}
return

SpawnAlamoGU:
	send, t/fspawn policealamo 5{enter}
return

SpawnAlamoTED:
	send, t/fspawn policealamo 4{enter}
return

SpawnScoutK9:
	send, t/fspawn policescout 7{enter}
return

ParkCruiser:
	send, t/parkcruiser{enter}
	sleep 600
	send, t {up}{enter}
return

;Normal GO Unit
NormalUnit:
	send, t/renameunit %NormalCallSign%{enter}
	sleep 500
	send, t/rlow %BadgeNumber% show me renaming unit to %NormalCallSign%{enter}
return

;Unit name handlers
LincolnUnit:
	send, t/renameunit %GangCallsign%{enter}
	Sleep 500
	send, t/rlow %BadgeNumber% show me renaming unit to %GangCallsign%{enter}
return

AdamUnit:
	send, t/renameunit %AdamCallsign%{enter}
	Sleep 500
	send, t/rlow %BadgeNumber% show me renaming unit to %AdamCallsign%{enter}
return

MRUnit:
	send, t/renameunit %MRCallsign%{enter}
	Sleep 500
	send, t/rlow %BadgeNumber% show me renaming unit to %MRCallsign%{enter}
return

TOMUnit:
	send, t/renameunit %TomCallsign%{enter}
	Sleep 500
	send, t/rlow %BadgeNumber% show me renaming unit to %TomCallsign%{enter}
return

; Disbands or Leaves current unit, radios the joining of a new and sets the joinunit
JoinOtherUnit:
    Gui, Destroy
    Gui, Add, Text,, Enter Unit Number:
    Gui, Add, Edit, w300 vUnitNumber,
    Gui, Add, DropdownList, w300 vUnitLeaveType, Select...||Disband Your Unit|Leave Current Unit
    Gui, Add, Button, Default x80 gUnitConfirm w80, Ok
	Gui, Add, Button, Default x+0 gUnitCancel w80, Cancel
    Gui, Show,, Join Another Unit
    return

    UnitConfirm:
		Gui,Submit
        if (UnitNumber!=""){
            if (UnitLeaveType="Disband Your Unit") {
                send, t/disbandunit{enter}
            } else if (UnitLeaveType="Leave Current Unit") {
                send, t/leaveunit{enter}
            } else {
                MsgBox,, ERROR, You must select a removal unit type!
            }
            Sleep 350
            send, t/rlow %BadgeNumber% show me disbanding unit, and resuming under %UnitNumber%{enter}
            Sleep 350
            send, t/joinunit %UnitNumber%{enter}
        } else {
            MsgBox,, ERROR, You must enter in a unit number to use this!
        }
    return

    UnitCancel:
        Gui, Destroy
    return
return

RenameMaryCallsign:
	send, t/renameunit %MaryCallsign% {enter}
	Sleep 500
	send, t/rlow %BadgeNumber% show me renaming unit to %MaryCallsign%{enter}
return

;Traffic stop handlers
PDHandCitation:
	send, t/melow Holds out a citation for the driver{enter}
return

;Traffic Citation on empty Vehicle
PDNoDriverCitation:
    send, t/melow Places the citation under the vehicles windscreen wiper{enter}
return

PDNoBikeDriverCitation:
    send, t/melow Places the citation under the bikes seat, securing it with tape{enter}
return

PDIssueSuspensionDemerit:
    Gui, Destroy
	Gui, Add, Text,, Enter Player ID:
	Gui, Add, Edit, w300 vPlayerID
	Gui, Add, Text,, Demerit?:
    Gui, Add, DropdownList, w300 vDemeritSuspend, Select...||No|Yes
	Gui, Add, Text,, Type of License:
	Gui, Add, DropdownList, w300 vLicenseType, Select...||Driver|Driver and Trucker
	Gui, Add, Button, Default x80 gSuspensionOk w80, Ok
    Gui, Add, Button, Default x+0 gSuspensionCancel w80, Cancel
	Gui, Show,, Issue Citation RPly
	return

    SuspensionOk:
        Gui,Submit
            if (PlayerID="") {
                MsgBox,, ERROR, You must enter a player ID in order to issue a suspension!
            }
            else if (LicenseType!="Select..." and DemeritSuspend!="Select...") {
                if (DemeritSuspend="Yes") {
                    send, t/warndriver %PlayerID%{enter}
                    sleep 550
                    send, t/melow adds a demerit to the individual's driver's license{enter}
                    sleep 550
                }

                send, t/suspend %PlayerID% driver 1{enter}
                sleep 550
                send, t/melow issues a 24 hour suspension on the individual's driver's license{enter}

                if (LicenseType="Driver and Trucker") {
                    send, t/suspend %PlayerID% trucker 1{enter}
                    sleep 550
                    send, t/melow issues a 24 hour suspension on the individual's trucker's license{enter}
                    sleep 550
                }
            } else {
                MsgBox,, ERROR, You must select a License Type and Demerit Suspend Type!
            }
    return

    SuspensionCancel:
        Gui, Destroy
    return

return

PDIssueCitationHandler:
	Gui, Destroy
	Gui, Add, Text,, Enter Player ID:
	Gui, Add, Edit, w300 vPlayerID,
	Gui, Add, Text,, Citation Type:
	Gui, Add, DropdownList, w300 vCitationType, Select...||VC01 - Speeding 1st Degree|VC02 - Speeding 2nd Degree|VC03 - Speeding 3rd Degree|VC04 - Illegal Parking|VC05 - Improper Traffic Maneuvers|VC06 - Following or Impeding Emergency Response|VC07 - Operating a Vehicle Without a License on Your Person|VC08 - Negligent Operation of a Road or Marine Vehicle|VC09 - Blocking Intersection|VC10 - Unroadworthy Vehicle|VC11 - Failure to Pay a Toll|VC12 - Operating an Unregistered Vehicle|VC13 - Disruptive Impeding or Blocking Travel
	Gui, Add, Text,, General Citations:
	Gui, Add, DropdownList, w300 vGeneralCitationType, Select...||GC01 - Loitering|GC02 - Traffic Endangerment|GC03 - Disorderly Conduct|GC04 - Face Concealment|GC05 - Misuse of Government Public Safety Radio Frequencies or Hotlines|GC06 - Possession of Cannabis
	Gui, Add, Text,, Demerit?
	Gui, Add, DropdownList, w300 vDemeritSuspend, Select...||No|Yes|Demerit and Suspension
	Gui, Add, Text,, Type of License:
	Gui, Add, DropdownList, w300 vLicenseType, Select...||Driver|Driver and Trucker
	Gui, Add, Button, Default x80 gCitationOk w80, Ok
    Gui, Add, Button, Default x+0 gCitationCancel w80, Cancel
	Gui, Show,, Issue Citation RPly
	return

    CitationCancel:
        Gui, Cancel
    return

	CitationOk:
		Gui,Submit

		if ((DemeritSuspend="No" or DemeritSuspend="Select...") and CitationType!="Select...") {
			sleep 150
			send, t/melow logs into the MDC and adds a "%CitationType%" to the individual's record{enter}
			sleep 350
			send, t/melow prints out the citation and grabs it from the printer{enter}
		} else if (DemeritSuspend="Yes" and CitationType!="Select...") {
			if (PlayerID!=""){
				sleep 150
				send, t/melow logs into the MDC and adds a "%CitationType%" to the individual's record{enter}
				sleep 350
				send, t/warndriver %PlayerID%{enter}
				sleep 500
				send, t/melow adds a demerit to the individual's driver's license{enter}
				sleep 350
				send, t/melow prints out the citation and grabs it from the printer{enter}
			} else {
				MsgBox,, ERROR, You must enter a player ID in order to issue a demerit!
			}
		} else if (DemeritSuspend="Demerit and Suspension" and CitationType!="Select...") {
			if (LicenseType="Driver" or LicenseType="Driver and Trucker") and (PlayerID!=""){
				sleep 150
				send, t/melow logs into the MDC and adds a "%CitationType%" to the individual's record{enter}
				sleep 350
				send, t/warndriver %PlayerID%{enter}
				sleep 500
				send, t/melow adds a demerit to the individual's driver's license{enter}
				sleep 500
				if (LicenseType="Driver"){
					send, t/suspend %PlayerID% driver 1{enter}
					sleep 500
					send, t/melow issues a 24 hour suspension on the individual's driver's license{enter}
					sleep 500
					send, t/melow prints out the citation and grabs it from the printer{enter}
				} else if (LicenseType="Driver and Trucker"){
					send, t/suspend %PlayerID% driver 1{enter}
					sleep 550
					send, t/suspend %PlayerID% trucker 1{enter}
					sleep 550
					send, t/melow issues a 24 hour suspension on both the individual's driver's and trucker's license{enter}
					sleep 500
					send, t/melow prints out the citation and grabs it from the printer{enter}
				}
			} else if (PlayerID="") {
				MsgBox,, ERROR, You must enter a player ID in order to issue a suspension!
			} else {
				MsgBox,, ERROR, You must select a license type in order to issue a suspension!
			}
		} else if (GeneralCitationType!="Select...") {
		    sleep 150
		    send, t/melow logs into the MDC and adds a "%GeneralCitationType%" citation to the individual's record{enter}
		    sleep 850
		    send, t/melow prints out the citation and grabs it from the printer{enter}
		} else {
			MsgBox,, ERROR, You must select a citation type!
		}
	return

return

; RPs the towing of a vehicle
TowVehicle:
	Send, t/melow opens the control panel, pulls down a lever, and lowers the ramp{enter}
	Sleep, 3000
	Send, t/melow deploys the winch cables and securely attaches the cables to the tow hook of the vehicle{enter}
	Sleep, 3000
	Send, t/melow pulls another lever on the control panel and starts the winch{enter}
	Sleep, 3000
	Send, t/melow secures the vehicle by its tires to the flatbed and lifts the ramp{enter}
Return

; RPs the untow deployment of the vehicle
UnTowVehicle:
    Send, t/melow opens the control panel, pulls down a lever, and lowers the ramp{enter}
    Sleep, 3000
	Send, t/melow unsecures the straps on the vehicles, and checks that the car in neutral{enter}
	Sleep, 3000
	Send, t/melow pulls another lever on the control panel and starts the winch, letting the vehicle slowly roll back onto the ground{enter}
    Sleep, 3000
    send, t/melow Raises the ramp to the standard position{enter}
return

;Interdepartmental radio handlers
DRadio:
	InputBox, NumberInput, Unit, How many 10-15s?, , 250, 125
	if ErrorLevel{
		MsgBox,, ERROR, Cancel was pressed!
	}
	else if (NumberInput!=""){
		InputBox, MinInput, Unit, Estimated Time of Arrival, , 250, 125
		if ErrorLevel{
			MsgBox,, ERROR, Cancel was pressed!
		}
		else if (MinInput!="") {
			Send, t/deplow PD to DOC, en route with %NumberInput% x 10-15. ETA %MinInput% minutes. Are you able to receive?{enter}
		}
		else {
			MsgBox,, ERROR, You must input the ETA!
		}
	}
	else {
		MsgBox,, ERROR, You must input the number of 10-15s!
	}
Return

DRadioHVT:
	InputBox, NumberInput, Unit, How many 10-15s?, , 250, 125
	if ErrorLevel{
		MsgBox,, ERROR, Cancel was pressed!
	}
	else if (NumberInput!=""){
		InputBox, MinInput, Unit, Estimated Time of Arrival, , 250, 125
		if ErrorLevel{
			MsgBox,, ERROR, Cancel was pressed!
		}
		else if (MinInput!=""){
			Send, t/deplow PD to DOC, en route with %NumberInput% x 10-15 HVT through the gates. ETA %MinInput% minutes. Are you able to receive?{enter}
		}
		else {
			MsgBox,, ERROR, You must input the ETA!
		}
	}
	else {
		MsgBox,, ERROR, You must input the number of 10-15s!
	}
Return

DRadioDB:
	send, t/deplow PD to SD, be advised, a DB unit will be entering your jurisdiction in a marked cruiser for investigative purposes.{enter}
	sleep 500
return

DRadioMDPris:
	send, t/backup FOR MD{enter}
	Sleep 2000
	InputBox, NumberInput, Unit, How many injured 10-15s?, , 250, 125
	if ErrorLevel{
		MsgBox,, ERROR, Cancel was pressed!
	}
	else if (NumberInput!=""){
		InputBox, BackupNumber, Unit, Backup number?, , 250, 125
		if ErrorLevel{
			MsgBox,, ERROR, Cancel was pressed!
		}
		else if (BackupNumber!=""){
			Send, t/deplow PD to MD, %NumberInput% x injured 10-15 at %BackupNumber%. Are you able to assist?{enter}
		}
		else {
			MsgBox,, ERROR, You must input the backup number!
		}
	}
	else {
		MsgBox,, ERROR, You must input the number of injured 10-15s!
	}
return

DRadioPDtoDOC:
	send, t/deplow PD to DOC, how copy?{enter}
return

DRadioPDtoMD:
	send, t/deplow PD to MD, how copy?{enter}
return

;Scene management handlers
PDGrabBarriers:
	send, t/me grabs the necessary barriers from the trunk of the cruiser, placing them under my arms{enter}
return

PDGatherBarriers:
	send, t/me gathers all the blockades one by one and places them under my arms{enter}
	Sleep 250
	send, t/RemoveAllBlockades{enter}
return

PDStoreBarriers:
	send, t/me places the barriers in the trunk of the cruiser{enter}
return

PDGrabBLS:
	send, t/me grabs a BLS kit from the trunk of the cruiser{enter}
return

PDInitialBLS:
	send, t/anim medic{enter}
	Sleep 250
	send, t/me sets the BLS kit on the groud and begins looking over their injuries{enter}
	Sleep 500
	send, t/do what would I see?{enter}
return

PDGrabBodyBag:
	send, t/melow grabs a body bag from the trunk of the cruiser{enter}
return

PDLoadIntoBodyBag:
	send, t/melow sets the body bag next to the body and unzips it{enter}
	Sleep 650
	send, t/melow rolls the body over into the body bag, ensuring the head, arms, and feet are all clear of the zipper.{enter}
	Sleep 950
	send, t/melow zips up the body bag{enter}
return

;Prisoner processing and arrest handlers
PDCuff:
	send, t/melow grabs a pair of cuffs from my duty belt and attempts to put them around their wrists{enter}
return

PDUncuff:
	send, t/melow takes the handcuff key from my duty belt and attempts to uncuff them{enter}
return

PDReleaseForm:
	send, t/melow takes a pen out from their breast pocket and flips through the prisoner transfer forms{enter}
	Sleep 650
	send, t/melow finds a blank prisoner transfer form and signs it{enter}
return

PDMugshot:
	send, t/melow takes a mugshot of the individual and uploads it to the PD database{enter}
	Sleep 1200
	send, t/dolow the upload would be successful{enter}
return

PDOnSceneMugshot:
	send, {F7}
	Sleep 500
	send, {F8}
	Sleep 350
	send, {F7}
	Sleep 500
	send, t/record{enter}
	Sleep 250
	send, t/melow takes a mugshot of the individual and uploads it to the PD database{enter}
	Sleep 1200
	send, t/dolow the upload would be successful{enter}
	Sleep 500
	send, t/record{enter}
return

PDFingerprints:
	send, t/collectprints
	KeyWait, Enter, d
	{
		Sleep 500
		send, t/melow takes each of the fingers from their left hand and slowly rolls them over the scanner{enter}
		Sleep 2250
		send, t/melow checks the clarity of the fingerprints on the MDC before submitting{enter}
		Sleep 2150
		send, t/melow submits the left hand fingerprints in the MDC{enter}
		Sleep 1750
		send, t/dolow the prints would be clear enough to be accepted by the database{enter}
		Sleep 1750
		send, t/dolow the MDC would prompt to scan the right hand fingerprints{enter}
		Sleep 1550
		send, t/melow takes each of the fingers from their right hand and slowly rolls them over the scanner{enter}
		Sleep 1755
		send, t/melow checks the clarity of the fingerprints on the MDC before submitting{enter}
		Sleep 2550
		send, t/melow submits the right hand fingerprints in the MDC{enter}
		Sleep 1650
		send, t/dolow the prints would be clear enough to be accepted by the database{enter}
		Sleep 1150
		send, t/melow uploads the prints to the database{enter}
		Sleep 750
		send, t/dolow the upload would be successful{enter}
	}
return

;Start and end watch handlers
StartWatch:
	send, t/melow grabs a body cam from the locker, securing it to his chest and turns it on {enter}
	Sleep 500
	send, t/dolow the light would start blinking green {enter}
	Sleep 500
	send, t/time {enter}
	Sleep 750
	send, t/createunit %NormalCallSign% {enter}
	Sleep 750
	send, t/rlow %BadgeNumber% show me start of watch under %NormalCallSign% {enter}
    sleep 500
return

EndWatch:
	send, t/rlow %BadgeNumber% disbanding unit and ending watch{enter}
	Sleep 750
	send, t/disbandunit{enter}
	Sleep 750
	send, t/leaveunit{enter}
    sleep 500
    send, t/dolow the light of the body cam would be blinking red{enter}
    sleep 500
    send, t/melow takes off the body cam, and secures it back in the locker{enter}
    sleep 500
    send, t/melow takes of his duty uniform and places it into the laundry shoot and puts on his civilian clothing{enter}
	sleep 500
return

; Felony stop megaphone steps
FelonyStop1:
	Send, t/m Driver, take your keys out of the ignition and toss them out of the window.{enter}
Return

FelonyStop2:
	Send, t/m Driver, place both hands outside of the window. Reach down and open the door with your right hand.{enter}
Return

FelonyStop3:
	Send, t/m Driver, exit the vehicle slowly. No sudden movements and keep your hands in the air. Face away from us at all times.{enter}
Return

FelonyStop4:
	Send, t/m Grab your shirt by the neck, lift it high, and turn around a full 360 so we can see your waistline.{enter}
Return

FelonyStop5:
	Send, t/m Walk backwards towards my voice until you are told to stop.{enter}
Return

;Pursuit megaphone
LethalPursuit:
	Send, t/m LSPD, STOP THE VEHICLE NOW OR FORCE MAY BE USED{enter}
Return

ExitApplication:
ExitApp
return

return
