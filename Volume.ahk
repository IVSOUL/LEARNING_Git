#NoEnv
#Persistent
#SingleInstance

~WheelUp::
if (existclass("ahk_class Shell_TrayWnd")=1)
	Send,{LWin Down}{Ctrl Down}{Left}{Ctrl Up}{LWin Up}
else
{
	MouseGetPos,, var, id
	WinGetClass, class, ahk_id %id%
	If (var < 45 and InStr(class,"Chrome_WidgetWin"))
	{
		IfWinNotActive ahk_id %id%
		WinActivate ahk_id %id%
		Send ^{PGUP}
	}
	else if (ypos < 15 and InStr(class,"Progman"))
	{
		IfWinNotActive ahk_id %id%
		WinActivate ahk_id %id%
		Send, {Volume_Up}
	}
}
return

~WheelDown::
if (existclass("ahk_class Shell_TrayWnd")=1)
	Send,{LWin Down}{Ctrl Down}{Right}{Ctrl Up}{LWin Up}
else
{
	MouseGetPos,, var, id
	WinGetClass, class, ahk_id %id%
	If (var < 45 and InStr(class,"Chrome_WidgetWin"))
	{
		IfWinNotActive ahk_id %id%
		WinActivate ahk_id %id%
		Send ^{PGDN}
	}
	else if (ypos < 15 and InStr(class,"Progman"))
	{
		IfWinNotActive ahk_id %id%
		WinActivate ahk_id %id%
		Send, {Volume_Up}
	}
}
return

~MButton::
if (existclass("ahk_class Shell_TrayWnd")=1)
	Send,{Volume_Mute}
return

Existclass(class)
{
	MouseGetPos,,,win
	WinGet,winid,id,%class%
	if win = %winid%
	Return,1
	Else
	return,0
}