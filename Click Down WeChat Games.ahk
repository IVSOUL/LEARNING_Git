#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

LButton::
MouseGetPos, X1, Y1
return

RButton::
MouseGetPos, X2, Y2
D := Sqrt((X2 - X1)**2 +(Y2 -Y1)**2) 
Time := D * 3.476
Click Down
Sleep, %Time%
Click Up
return

Esc::
ExitApp
return
