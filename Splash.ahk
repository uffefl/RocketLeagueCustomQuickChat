SplashInit()

SplashInit()
{
	global SplashTitle := A_ScriptName
	SplashTitle := RegExReplace(SplashTitle, "\.[^\.]+$", "")
	SplashTitle := RegExReplace(SplashTitle, "(\p{Ll})(\p{Lu})", "$1 $2")
	SplashTitle := RegExReplace(SplashTitle, "[^\p{L}\p{N}]+", " ")
	SplashTitle := RegExReplace(SplashTitle, ".*", "$t0")
}

SplashUpdate()
{
	
}

Splash(message, title = "")
{
	global SplashTitle
	if (title = "")
	{
		title := SplashTitle
	}
	SplashImage, Off
	SplashImage, , B1, , %message%, %title%,
	SetTimer, SplashOff, -2500
}

SplashOff()
{
	SplashImage, Off
}