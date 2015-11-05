#include Gamepads.ahk
#include XInput\XInput.ahk

InitInput()

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