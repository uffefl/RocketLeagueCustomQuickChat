#include AutoReload.ahk
#include Gamepads.ahk

global TrayTitle := "Rocket League Custom Quick Chat"

InitInput()
AutoReload()

#include XInput\XInput.ahk

InitInput()
{
	global InputCount := 0
	global InputCaps := [ "", "", "", "" ]
	XInput_Init()
	UpdateInput(True)
	SetTimer, UpdateInput, 5
}

UpdateInput(initial = False)
{
	global InputCount := 0
	global InputCaps
	check := [ XInput_GetCapabilities(0, 0), XInput_GetCapabilities(1, 0), XInput_GetCapabilities(2, 0), XInput_GetCapabilities(3, 0) ]
	s := ""
	Loop, 4
	{
		was := InputCaps[A_Index]["Type"] . "/" . InputCaps[A_Index]["SubType"]
		type := check[A_Index]["Type"] . "/" . check[A_Index]["SubType"]
		if (type <> "/")
		{
			InputCount := InputCount + 1
			if (was <> type)
			{
				s := s . "Controller " . A_Index . " (" . type . ") connected. "
			}
		}
		else
		{
			if (was <> type)
			{
				s := s . "Controller " . A_Index . " (" . was . ") disconnected. "
			}
		}
		
	}
	InputCaps := check
	if (initial)
	{
		s := "Script initializing. "
	}
	if (s <> "")
	{
		s := s . "There is currently " . InputCount . " controller"
		if (InputCount <> 1)
		{
			s := s . "s"
		}
		s := s . " connected..."
		TrayTip, %TrayTitle%, %s%, , 16
	}
}