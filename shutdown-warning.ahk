#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ;Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
#SingleInstance

Gui, font, s30, Verdana
Gui, Add, Text, ,Computer will shutdown in 5 Minutes!
Gui, Add, Button, Default, OK
Gui, Show, Center, Msgbox
Return

ButtonOK:
	{
	ExitApp
	}

;hotkeys
space::
	{
	Gui, Destroy
	Exitapp
	}
	
Esc::
	{
	Gui, Destroy
	Exitapp
	}

Backspace::
	{
	Gui, Destroy
	Exitapp
	}
