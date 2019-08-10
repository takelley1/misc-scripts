#NoEnv ;Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ;Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ;Ensures a consistent starting directory.
#SingleInstance

#h:: ;hibernate pc with WIN-h
DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 1)
return

#s:: ;sleep pc with WIN-s
DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
return
