#SingleInstance force
#Persistent

GamepadsInit()

; Native gamepad inputs to listen to (AutoHotkey names)
Native({ Buttons: ["Joy1", "Joy2", "Joy3", "Joy4", "Joy5", "Joy6", "Joy7", "Joy8", "Joy9", "Joy10"], Sticks: [{X:"JoyX",Y:"JoyY"},{X:"JoyU",Y:"JoyV"}], Dpads: ["JoyPov"], Triggers: ["JoyZ","JoyR"]})

; Mappings from popular controllers to native inputs
Gamepad("Xbox 360 Controller", { "A": "Joy1", "B": "Joy2", "X": "Joy3", "Y": "Joy4", "LB": "Joy5", "RB": "Joy6", "Back": "Joy7", "Start": "Joy8", "LS": "Joy9", "RS": "Joy10", "Up": "JoyPovUp", "Down": "JoyPovDown", "Left": "JoyPovLeft", "Right": "JoyPovRight" })
Gamepad("Xbox One Controller", { "A": "Joy1", "B": "Joy2", "X": "Joy3", "Y": "Joy4", "LB": "Joy5", "RB": "Joy6", "View": "Joy7", "Menu": "Joy8", "LS": "Joy9", "RS": "Joy10", "Up": "JoyPovUp", "Down": "JoyPovDown", "Left": "JoyPovLeft", "Right": "JoyPovRight" })
Gamepad("DualShock 3 Controller", { "Cross": "Joy1", "Circle": "Joy2", "Square": "Joy3", "Triangle": "Joy4", "L1": "Joy5", "R1": "Joy6", "Select": "Joy7", "Start": "Joy8", "L3": "Joy9", "R3": "Joy10", "Up": "JoyPovUp", "Down": "JoyPovDown", "Left": "JoyPovLeft", "Right": "JoyPovRight" })
Gamepad("DualShock 4 Controller", { "Cross": "Joy1", "Circle": "Joy2", "Square": "Joy3", "Triangle": "Joy4", "L1": "Joy5", "R1": "Joy6", "Share": "Joy7", "Options": "Joy8", "L3": "Joy9", "R3": "Joy10", "Up": "JoyPovUp", "Down": "JoyPovDown", "Left": "JoyPovLeft", "Right": "JoyPovRight" })

DefaultGamepad := "Xbox One Controller"

GamepadsInit()
{
	global NativeMap := Object()
	global AliasMap := Object()
}

Native(def)
{
	global NativeButtons := def["Buttons"]
	global NativeSticks := def["Sticks"]
	global NativeDpads := def["Dpads"]
	global NativeTriggers := def["Triggers"]
}

Gamepad(gamepadType, def)
{
	global NativeMap
	global AliasMap
	AliasMap[gamepadType] := Object()
	for alias, native in def
	{
		NativeMap[alias] := native
		AliasMap[gamepadType][native] := alias
	}
}

ToNative(alias)
{
	global NativeMap
	return NativeMap[alias]
}

ToAlias(native)
{
	global AliasMap
	return AliasMap[DefaultGamepad][native]
}