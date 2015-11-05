TrayInit()

TrayInit()
{
	global TrayTitle := A_ScriptName
	TrayTitle := RegExReplace(TrayTitle, "\.[^\.]+$", "")
	TrayTitle := RegExReplace(TrayTitle, "(\p{Ll})(\p{Lu})", "$1 $2")
	TrayTitle := RegExReplace(TrayTitle, "[^\p{L}\p{N}]+", " ")
	TrayTitle := RegExReplace(TrayTitle, ".*", "$t0")
}

Tray(message)
{
	global TrayTitle
	TrayTip, %TrayTitle%, %message%, , 16+32
}