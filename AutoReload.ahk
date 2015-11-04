#SingleInstance force
#Persistent

AutoReload()
{
	SetTimer, CheckReload, 1000
}

CheckReload()
{
	FileGetAttrib, attribs, %A_ScriptFullPath%
	IfInString, attribs, A
	{
		FileSetAttrib, -A, %A_ScriptFullPath%
		Reload
	}
}