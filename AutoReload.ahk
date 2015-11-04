#SingleInstance force
#Persistent

AutoReload()

AutoReload()
{
	global TimeStamp
	FileGetTime, TimeStamp, %A_ScriptFullPath%
	SetTimer, CheckReload, 1000
}

CheckReload()
{
	global TimeStamp
	FileGetTime, time, %A_ScriptFullPath%
	if (time > TimeStamp)
	{
		Reload
	}
}