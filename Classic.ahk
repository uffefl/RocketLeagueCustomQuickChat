#include Gamepads.ahk
#include Tray.ahk
#include Splash.ahk

InitInput()

InitInput()
{
	global InputStates := GetStates()

	UpdateInput(True)
	SetTimer, UpdateInput, 5
}

UpdateInput(initial = False)
{
	global ScriptName
	global InputStates
	global NativeButtons
	count := 0
	states := GetStates()
	message := ""
	changes := []
	for controller, state in states
	{
		prev := InputStates[controller]
		state["Last"] := prev["Last"]
		if (state["Name"] = "" and prev["Name"] <> "")
		{
			message := message . "Controller " . controller . " (" . prev["Name"] . ") disconnected. "
		}
		if (state["Name"] <> "" and prev["Name"] = "")
		{
			message := message . "Controller " . controller . " (" . state["Name"] . ") connected. "
		}
		if (state["Name"] = "")
		{
			Continue
		}
		count := count + 1
		for i, button in NativeButtons
		{
			if (state[button] = True and prev[button] = False)
			{
				changes.Insert({ Controller: controller, Button: button, Event: "D" })
			}
			if (state[button] = False and prev[button] = True)
			{
				changes.Insert({ Controller: controller, Button: button, Event: "U" })
			}
		}
	}

	for i, change in changes
	{
		state := states[change["Controller"]]
		native := ""
		alias := ""
		for j, button in NativeButtons
		{
			if (button <> change["Button"] and state[button] = True)
			{
				native := native . button . "+"
				alias := alias . ToAlias(button) . "+"
			}
		}
		if (state["Last"] = native . change["Button"] . "D" and change["Event"] = "U")
		{
			extra := native . change["Button"]
			aliasExtra := alias . ToAlias(change["Button"])
		}
		native := native . change["Button"] . change["Event"]
		Splash(native . "`n`n" . alias, "Controller " . change["Controller"])
		state["Last"] := native
		if (extra <> "")
		{
			Splash(extra . "`n`n" . aliasExtra, "Controller " . change["Controller"])
			state["Last"] := extra
		}
	}

	InputStates := states
	if (initial)
	{
		message := "Script initializing. "
	}
	if (message <> "")
	{
		message := message . "There is currently " . count . " controller"
		if (count <> 1)
		{
			message := message . "s"
		}
		message := message . " connected..."
		Tray(message)
	}
}

GetStates()
{
	states := []
	Loop, 16
	{
		states.Insert(GetState(A_Index))
	}
	return states
}

GetState(controller)
{
	global NativeButtons
	state := { Controller: controller, Name: "" }
	some := ""
	GetKeyState, some, %controller%JoyX
	if (some = "")
	{
		return state
	}
	state["Name"] := GetKeyState(controller . "JoyName")
	for i, button in NativeButtons
	{
		state[button] := GetKeyState(controller . button)
	}
	return state
}