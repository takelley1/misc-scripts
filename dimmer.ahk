#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir %A_ScriptDir%  Ensures a consistent starting directory.
;#NoTrayIcon    don't display the script icon in the tray 
#SingleInstance

SysGet, VirtualWidth, 78 ; get desktop size
SysGet, VirtualHeight, 79

intensity:=50 ; set default intensity
Gosub Overlay

F1::
intensity+=15
If intensity>225
   intensity:=225
GoSub Overlay
return

!^Down::
intensity+=15
If intensity>225
   intensity:=225
GoSub Overlay
return

F2::
intensity-=15
if intensity<0
  intensity:=0
GoSub Overlay
return

!^Up::
intensity-=15
if intensity<0
  intensity:=0
GoSub Overlay
return

Overlay:
Gui, 1: Default
Gui, Color, 0x000000 ; Color to black
Gui, +LastFound +AlwaysOnTop -Caption +E0x20 ; Click through GUI always on top.
Winset, AlwaysOnTop, On
Winset, Disable
WinSet, Transparent, %intensity%
Gui, Show, x0 y0 w%VirtualWidth% h%VirtualHeight%, Overlay ; Cover entire screen
return