; Rocket League Custom Quick Chats
;
; This file contains a small AutoHotkey (www.autohotkey.com) script that
; enables additional "quick chat" functionality while playing Rocket
; League.
;
; Look towards the bottom of this file for the actual texts that are
; output. You should definitely customize this before using the script.
; Add new things by copy/pasting existing lines, remove those you
; don't like by deleting lines (or putting a semi-colon in front of
; them). Customize the buttons bound by looking at the very last part
; with the Mapping[...] lines. It should be fairly self-explanatory.
;
; If you want this file to always run when you start AutoHotkey, you can
; put it in My Documents\AutoHotkey.ahk. The script will stay running
; with an H-icon in the system tray; right click that to stop or force a
; reload. (However this script reloads itself when it detects it has
; been modified, so reloading manually shouldn't be necessary.)

#SingleInstance force
#Persistent

SetTimer,UPDATEDSCRIPT,1000

SetTimer, Watch, 5
return

UPDATEDSCRIPT:
	FileGetAttrib,attribs,%A_ScriptFullPath%
	IfInString,attribs,A
	{
		FileSetAttrib,-A,%A_ScriptFullPath%
		SplashTextOn,,,Updated script,
		Sleep,500
		Reload
	}
	Return

Watch:
if (WinActive("ahk_exe RocketLeague.exe"))
{
	WatchPOV()
	WatchLB()
	WatchRB()
	if (PovTime < LBTime or PovTime < RBTime)
		return
	Trigger := LBHeld . RBHeld . PovHeld
	if (Mapping[Trigger])
	{
		SayRandom(Mapping[Trigger], Team[Trigger])
		PovTime := RBTime - 1
	}
}

WatchPOV()
{
	global PovHeld, PovTime
	GetKeyState, POV, JoyPOV
	if POV < 0
		Held := ""
	else if POV between 4501 and 13500 ; 45 to 135 degrees: Right
		Held := "Right"
	else if POV between 13501 and 22500 ; 135 to 225 degrees: Down
		Held := "Down"
	else if POV between 22501 and 31500 ; 225 to 315 degrees: Left
		Held := "Left"
	else
		Held := "Up"
	if (Held <> PovHeld)
	{
		PovHeld := Held
		PovTime := A_TickCount
	}
}

WatchLB()
{
	global LBHeld, LBTime
	if GetKeyState("Joy5")
		Held := "LB+"
	else
		Held := ""
	if (Held <> LBHeld)
	{
		LBHeld := Held
		LBTime := A_TickCount
	}
}

WatchRB()
{
	global RBHeld, RBTime
	if GetKeyState("Joy6")
		Held := "RB+"
	else
		Held := ""
	if (Held <> RBHeld)
	{
		RBHeld := Held
		RBTime := A_TickCount
	}
}

Say(s, t = False)
{
	ch := t ? "y" : "t"
	SendInput, %ch%
	Sleep, 200
	count := 0
	batch := 20
	Loop
	{
		if (s=="")
		{
			SendInput, {Enter}
			return
		}
		i := RegExMatch(s, " ", "", batch)
		if (i<1)
		{
			i := batch
		}
		sub := RegExReplace(SubStr(s, 1, i), "([!#+^{}])", "{$1}")
		s := SubStr(s, i+1)
		count := count+i
		SendInput, %sub%
		if (count>100)
		{
			SendInput, {Enter}
			count := 0
			Sleep, 200
			SendInput, %ch%
			Sleep, 200
		}
		else
		{
			Sleep, 100
		}
	}
}

SayRandom(a, t = False)
{
	Random, r, a._MinIndex(), a._MaxIndex()
	Say(a[r], t)
}

; Text list definitions
;
; You can add or modify directly in the existing text lists below here,
; by simply copy/pasting. Or you can create a new list by following the
; same pattern. (But then you do need to visit the last section and make
; sure the list is bound to some buttons!)

; [Team] Teamwork compliment! (LB+RB+Up)
TeamworkCompliment := Object()
TeamworkCompliment.Insert("Nice team work! Add me if you want! SteamID: <put steam-id here>")

; GG (LB+RB+Right)
GoodGame := Object()
GoodGame.Insert("gg")

; Weird (LB+RB+Left)
Weird := Object()
Weird.Insert("Hi! I installed Rocket League Custom Quick Chat and didn't pay attention to the instructions. Now I randomly pressed a button and embarrassed myself in chat. Isn't that awkward?")

; Retort (LB+RB+Down)
Retort := Object()
Retort.Insert("Ball chasers do not get to complain!")
Retort.Insert("I, too, like to invent excuses and disregard my own shortcomings!")
Retort.Insert("You don't have to be right to voice your opinion. But it helps!")

; Good luck, have fun (RB+Up)
GoodLuck := Object()
GoodLuck.Insert("gl hf")

; I know that was lucky! Sorry/not-sorry! (RB+Left)
Lucky := Object()
Lucky.Insert("I know that was lucky! Sorry/not-sorry!")

; LOL! (RB+Right)
Funny := Object()
Funny.Insert("LOL!")

; Curses (RB+Down)
Curses := Object()
Curses.Insert("Fuck!")
Curses.Insert("Dammit!")
Curses.Insert("Shit!")

; Mapping

Mapping := Object()
Team := Object()

Mapping["LB+RB+Up"] := TeamworkCompliment
Team["LB+RB+Up"] := True
Mapping["LB+RB+Left"] := Weird
Mapping["LB+RB+Right"] := GoodGame
Mapping["LB+RB+Down"] := Retort

Mapping["RB+Up"] := GoodLuck
Mapping["RB+Left"] := Lucky
Mapping["RB+Right"] := Funny
Mapping["RB+Down"] := Curses
