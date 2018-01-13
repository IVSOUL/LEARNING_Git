Git Push pull disk verifGit Git Pull
modifiy and revert contents of listed bash.
~WheelUp::
MouseGetPos,, yPos,win
WinGetClass, class, ahk_id %win%
WinGet, winid, ID, ahk_class Shell_TrayWnd
if win = %winid%
	Send, {LWin Down}{Ctrl Down}{Left}{Ctrl Up}{LWin Up}
else if (yPos < 45 and InStr(class,"Chrome_WidgetWin"))
{
	IfWinNotActive ahk_id %win%
	WinActivate ahk_id %win%
	Send ^{PGUP}
}
return

~WheelDown::
MouseGetPos,, yPos,win
WinGetClass, class, ahk_id %win%
WinGet, winid, ID, ahk_class Shell_TrayWnd
if win = %winid%
	Send, {LWin Down}{Ctrl Down}{Right}{Ctrl Up}{LWin Up}
else if (yPos < 45 and InStr(class,"Chrome_WidgetWin"))
{
	IfWinNotActive ahk_id %win%
	WinActivate ahk_id %win%
	Send ^{PGDN}
}
return

~MButton::
MouseGetPos,, yPos,win
WinGet, winid, ID, ahk_class Shell_TrayWnd
if win = %winid%
	Send, {Volume_Mute}
return

~RButton::
MouseGetPos,, yPos,win
WinGetClass, class, ahk_id %win%
if (yPos < 45 and InStr(class,"Chrome_WidgetWin"))
	Send, {MButton}
return