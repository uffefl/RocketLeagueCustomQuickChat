#SingleInstance force
#Persistent

#include XInput\XInput.ahk

InitInput()

; Native gamepad inputs to listen to (AutoHotkey names)
Native({ Buttons: ["Joy1", "Joy2", "Joy3", "Joy4", "Joy5", "Joy6", "Joy7", "Joy8", "Joy9", "Joy10"], Sticks: [{X:"JoyX",Y:"JoyY"},{X:"JoyU",Y:"JoyV"}], Dpads: ["JoyPov"], Triggers: ["JoyZ","JoyR"]})

; Mappings from popular controllers to native inputs
Gamepad("Xbox 360 Controller", { "A": "Joy1", "B": "Joy2", "X": "Joy3", "Y": "Joy4", "LB": "Joy5", "RB": "Joy6", "Back": "Joy7", "Start": "Joy8", "LS": "Joy9", "RS": "Joy10", "Up": "JoyPovUp", "Down": "JoyPovDown", "Left": "JoyPovLeft", "Right": "JoyPovRight" })
Gamepad("Xbox One Controller", { "A": "Joy1", "B": "Joy2", "X": "Joy3", "Y": "Joy4", "LB": "Joy5", "RB": "Joy6", "View": "Joy7", "Menu": "Joy8", "LS": "Joy9", "RS": "Joy10", "Up": "JoyPovUp", "Down": "JoyPovDown", "Left": "JoyPovLeft", "Right": "JoyPovRight" })
Gamepad("DualShock 3 Controller", { "Cross": "Joy1", "Circle": "Joy2", "Square": "Joy3", "Triangle": "Joy4", "L1": "Joy5", "R1": "Joy6", "Select": "Joy7", "Start": "Joy8", "L3": "Joy9", "R3": "Joy10", "Up": "JoyPovUp", "Down": "JoyPovDown", "Left": "JoyPovLeft", "Right": "JoyPovRight" })
Gamepad("DualShock 4 Controller", { "Cross": "Joy1", "Circle": "Joy2", "Square": "Joy3", "Triangle": "Joy4", "L1": "Joy5", "R1": "Joy6", "Share": "Joy7", "Options": "Joy8", "L3": "Joy9", "R3": "Joy10", "Up": "JoyPovUp", "Down": "JoyPovDown", "Left": "JoyPovLeft", "Right": "JoyPovRight" })

Native(def)
{
	NativeButtons := def["Buttons"]
	NativeSticks := def["Sticks"]
	NativeDpads := def["Dpads"]
	NativeTriggers := def["Triggers"]
}

Aliases := Object()
Gamepad(name, def)
{
	for alias, native in def
	{
		Aliases[alias] := native
	}
}

InitInput()
{
	global InputCount := 0
	global InputCaps := [ "", "", "", "" ]
	global ScriptName := A_ScriptName
	ScriptName := RegExReplace(ScriptName, "\.[^\.]+$", "")
	ScriptName := RegExReplace(ScriptName, "(\p{Ll})(\p{Lu})", "$1 $2")
	ScriptName := RegExReplace(ScriptName, "[^\p{L}\p{N}]+", " ")
	ScriptName := RegExReplace(ScriptName, ".*", "$t0")

	XInput_Init()
	UpdateInput(True)
	SetTimer, UpdateInput, 5
}

UpdateInput(initial = False)
{
	global InputCount := 0
	global InputCaps
	global ScriptName
	check := [ XInput_GetCapabilities(0, 0), XInput_GetCapabilities(1, 0), XInput_GetCapabilities(2, 0), XInput_GetCapabilities(3, 0) ]
	message := ""
	Loop, 4
	{
		was := InputCaps[A_Index]["Type"] . "/" . InputCaps[A_Index]["SubType"]
		type := check[A_Index]["Type"] . "/" . check[A_Index]["SubType"]
		if (type <> "/")
		{
			InputCount := InputCount + 1
			if (was <> type)
			{
				message := message . "Controller " . A_Index . " (" . type . ") connected. "
			}
		}
		else
		{
			if (was <> type)
			{
				message := message . "Controller " . A_Index . " (" . was . ") disconnected. "
			}
		}
		
	}
	InputCaps := check
	if (initial)
	{
		message := "Script initializing. "
	}
	if (message <> "")
	{
		message := message . "There is currently " . InputCount . " controller"
		if (InputCount <> 1)
		{
			message := message . "message"
		}
		message := message . " connected..."
		TrayTip, %ScriptName%, %message%, , 16
	}
}