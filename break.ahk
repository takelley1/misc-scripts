
; >>>>>>>>>> SCRIPT MUST BE RUN AS ADMINISTRATOR <<<<<<<<<<

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn   ;Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance

;every x min disable mouse and keyboard and force a x minute break
Loop,
	{
	minutesWait := 25 ;set time to wait before break (in minutes)
	minutesWait := minutesWait*1000*60 ;convert to miliseconds
	Sleep, minutesWait
	
	blockinput, on
	Send {RWin down} ;minimize all windows and mute audio
	Send {d}
	Send {RWin up}
	Soundget, CurrentVol
	CurrentVolDown := CurrentVol/2
	Send {Volume_Down %CurrentVolDown%}

	minutesBreak := 1 ;set duration of break here (in minutes)
	
	Gui, font, s20, Verdana
	Gui, Add, Text, ,Break for %minutesBreak% minute(s)
	Gui, +AlwaysOnTop
	Gui, Show, Center, Msgbox
	
	minutesBreak := minutesBreak*1000*60
	Sleep, minutesBreak
	
	Send {RWin down}
	Send {d}
	Send {RWin up}
	CurrentVolUp := CurrentVol/2
	Send {Volume_Up %CurrentVolUp%}
	Gui, Destroy
	blockinput, off
	}

^!Delete:: ExitApp
