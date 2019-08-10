#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance

#HotkeyInterval 1000 ;prevents warning popup from appearing when scrolling extremely quickly
#MaxHotkeysPerInterval 500

Speed := 6 ;set default scrolling behavior

Gui()
{
Global
Gui, font, s10, verdana
Gui, Add, Text, ,Scrolling set to %Speed% lines
Gui, Show, Center, Msgbox
Sleep, 400
Gui, Destroy
return
}

>^Up::
Speed += 1
Gui()
return
>^Down::
Speed -= 1
Gui()
return

#1:: ;hotkeys for controlling mouse scrolling speed
Speed := 1
Gui()
return
#2::
Speed := 2
Gui()
return
#3::
Speed := 3
Gui()
return
#4::
Speed := 4
Gui()
#5::
Speed := 5
Gui()
return
#6::
Speed := 6
Gui()
return
#7::
Speed := 7
Gui()
return
#8::
Speed := 8
Gui()
return
#9::
Speed := 9
Gui()
return
#0::
Speed := 10
Gui()
return

WheelUp::
Click, WheelUp, %Speed%
return

WheelDown::
Click, WheelDown, %Speed%
return
