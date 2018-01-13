;###################################################################################################################//
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Persistent
#SingleInstance,force
;Menu, Tray, NoStandard ;Hide Default Menu.
ProgramName:="IVSOUL@AHK Scripts"
Menu,Tray,Tip,%ProgramName% ;Show Tips When Cursor Hovering on Trayicon.
NOW = %A_YYYY%年%A_MM%月%A_DD%日 %A_Hour%:%A_Min%:%A_Sec% %A_DDDD%
Traytip,IVSOUL@WARNING,%NOW%`nQuickShortcuts Starts Now！
SetTimer, RemoveTrayTip, 2000
return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;###################################################################################################################//
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
TB_HIDEBUTTON(wParam, lParam, Msg, HWND)
{
	static WM_USER := 0x400
	static _______ := OnMessage(WM_USER + 4, "TB_HIDEBUTTON")
	
	If (lParam = 513) ;LButton Click On Trayicon.
	{
		suspend
		SoundBeep, 500, 200
	}
	If (lParam = 519) ;MButton Click On Trayicon.
	{
		Edit
		Traytip,IVSOUL@WARNING,AHK Script Edit Mode！
		SetTimer, RemoveTrayTip, 1300
		SoundBeep, 500, 500
		return
	}
}
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
~LButton & RShift::
Reload ;Reload the script by Left Button and Right Shift.
SoundBeep, 500, 500
return

~LButton & Enter::
NOW = %A_YYYY%年%A_MM%月%A_DD%日 %A_Hour%:%A_Min%:%A_Sec% %A_DDDD%
Traytip,IVSOUL@WARNING,%NOW%`nAHK Script Will Now Exit！
SetTimer, RemoveTrayTip, 2000
SoundBeep, 500, 500
Sleep 1800
ExitApp
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
~Pause::
var := !var
if var
{
	BlockInput ON
	HideShowDesktopIcon()
	;WinMinimizeAll ;Minimize All Windows.
	WinHide, ahk_class Shell_TrayWnd ;Hide Task Bar.
	;SoundBeep, 500, 500
	;NOW = %A_YYYY%年%A_MM%月%A_DD%日 %A_Hour%:%A_Min%:%A_Sec% %A_DDDD%
	;Traytip,IVSOUL@WARNING,%NOW%`nEnter Away Mode Now！
	;SetTimer, RemoveTrayTip, 1300
}
else
{
	BlockInput OFF
	HideShowDesktopIcon()
	;WinMinimizeAllUndo
	WinShow, ahk_class Shell_TrayWnd
	;SoundBeep, 500, 500
	;NOW = %A_YYYY%年%A_MM%月%A_DD%日 %A_Hour%:%A_Min%:%A_Sec% %A_DDDD%
	;Traytip,IVSOUL@WARNING,%NOW%`nAway Mode Will Now Exit！
	;SetTimer, RemoveTrayTip, 1300
}
return

HideShowDesktopIcon()
{
	ControlGet, HWND, Hwnd,, SysListView321, ahk_class Progman
	If HWND =
		ControlGet, HWND, Hwnd,, SysListView321, ahk_class WorkerW
	If DllCall("IsWindowVisible", UInt, HWND)
		WinHide, ahk_id %HWND%
	Else
		WinShow, ahk_id %HWND%
	return
}
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:*:,,Time:: ;Insert Current Date And Time.
CurrentDateTime = %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_Sec% %A_DDDD%
SendInput %CurrentDateTime%
return

:*:,,tg:: ;Time Stamp.
TAG = %A_YYYY%%A_MM%%A_DD%%A_Hour%%A_Min%%A_Sec%
SendInput %TAG%
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Switch Tasks.
~LButton & RButton::AltTab
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
!N::
FileCreateDir, %A_Desktop%\NEW %A_Now%
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
F3:: ;Hold down the Hotkey to temporarily reduce the mouse cursor's speed, which facilitates precise positioning.
SPI_GETMOUSESPEED = 0x70
SPI_SETMOUSESPEED = 0x71
;Retrieve the current speed so that it can be restored later:
DllCall("SystemParametersInfo", UInt, SPI_GETMOUSESPEED, UInt, 0, UIntP, OrigMouseSpeed, UInt, 0)
;Now set the mouse to the slower speed specified in the next-to-last parameter (the range is 1-20, 10 is default):
DllCall("SystemParametersInfo", UInt, SPI_SETMOUSESPEED, UInt, 0, Ptr, 3, UInt, 0)
KeyWait F3 ;This prevents keyboard auto-repeat from doing the DllCall repeatedly.
return

F3 up::DllCall("SystemParametersInfo", UInt, 0x71, UInt, 0, Ptr, OrigMouseSpeed, UInt, 0)  ;Restore the original speed.
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:*://PortNumber::  ;Set Remote Desktop PortNumber, Take Effect When Reboot The System.
InputBox PortNumber, PortNumber, Enter Remote Desktop PortNumber(1024-65535)：
if  PortNumber between 1024 and 65535
	gosub ChangePortNumber
else
	Traytip,IVSOUL@WARNING, Invalid Value！
return

ChangePortNumber:
RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp, PortNumber, %PortNumber%
RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp, PortNumber, %PortNumber%
Traytip,IVSOUL@WARNING, Reboot The System To Take Effect!`nPortNumber Changed Successfully!
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
!V:: ;Paste Plain Text By Alt+V.
ClipboardBak:=ClipboardAll ;Store Full Version of Clipboard.
ClipBoard := ClipBoard ;Converts to Plain Text.
SendInput, ^v
Sleep, 50
Clipboard:=ClipboardBak
Return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#PrintScreen:: ;Turn Off Monitor.
KeyWait PrintScreen
KeyWait LWin
SendMessage,0x112,0xF170,2,,Program Manager
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:://countdown:: ;CountDown.
InputBox UserInput, CountDown, 请设定计划倒计时数值（分钟）：
IfEqual, Errorlevel, 0
{
	sleep UserInput * 60000
	SoundBeep, 500, 3000
	Traytip,IVSOUL@WARNING,TIME IS UP！
}
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:://sd:: ;Count Down To Shutdown.
InputBox UserInput, Shutdown Counter, 输入计划关机剩余时间（分钟）:
Run cmd
WinWaitActive ahk_class ConsoleWindowClass
time := UserInput * 60
Send shutdown{Space} -s{Space}-t{Space}%time%{Enter}exit{Enter}
return

:://cancel::
Run cmd
WinWaitActive ahk_class ConsoleWindowClass
Send shutdown{Space} -a{Space}{Enter}exit{Enter}
return

:://sleep::
Run cmd
WinWaitActive ahk_class ConsoleWindowClass
Send shutdown{Space} -h{Enter}exit{Enter}
return

:://sdn:: ;Shutdown Now.
Shutdown, 1
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:*://dl:: ;Open Folder.
Run C:\Users\IVSOUL\Downloads
return

:*://work::
Run C:\Users\IVSOUL\OneDrive\IIIIIII\WORKSTATION\华龙网
return

:*://ahk::
Run C:\Users\IVSOUL\OneDrive\IIIIIII\MAINTENANCE\AutoHotkey Scripts
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:://g:: ;Open url By Default Browser.
Run http://www.google.com/ncr
return

!G:: ;Search Clipboard By Google.
Send ^c
Run http://www.google.com/search?q=%Clipboard%
return

!B:: ;Search Clipboard By Baidu.
Send ^c
Run http://www.baidu.com/s?wd=%Clipboard%
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#F::
if WinExist("ahk_exe Everything.exe")
	WinActivate, ahk_exe Everything.exe
else
	Run, C:\Program Files\Everything\Everything.exe
return

#N::
if WinExist("ahk_exe notepad.exe")
	WinActivate, ahk_exe notepad.exe
else
	Run, notepad.exe
return

:*://God:: ;Run God Mode.
Run shell:::{ED7BA470-8E54-465E-825C-99712043E01C}
return

:*://ctrl:: ;Control Pannel.
Run Control
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
F7::SwitchSelCase("L") ;Switch Selected Text to Lower case.
F8::SwitchSelCase("U") ;Switch Selected Text to Upper case.
F9::SwitchSelCase("T") ; Switch First Letter to Upper case.

SwitchSelCase(Mode)
{
	clipBak := ClipboardAll ; Backup Clipboard.
	Clipboard := "" ;Clear Clipboard.
  
	Send, ^c ;Copy Selected Text.
	ClipWait, 1
	selText := Clipboard
  
	if (selText != "")
	{
		Clipboard := ""
		Clipboard := Format("{:" Mode "}", selText)
		ClipWait, 1
		Send, ^v
		Sleep, 500
	}
	Clipboard := clipBak ;Restore Clipboard.
}
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Alt & 1:: ;Copy File Name.
Clipboard =
Send,^c
ClipWait
path = %Clipboard%
if path =
return

SplitPath, path, name
Clipboard = %name%
tooltip 已复制文件名至剪切板！`nFileName: "%clipboard%" Copied.
Traytip,IVSOUL@WARNING,已复制文件名至剪切板！`n%Clipboard%
SetTimer, RemoveTrayTip, 2000
SetTimer, RemoveToolTip, 2000
return

Alt & 2:: ;Copy Folder Path.
Clipboard =
Send,^c
ClipWait
path = %Clipboard%
if path =
return

SplitPath, path, , dir
Clipboard = %dir%
tooltip 已复制文件夹路径至剪切板！`nFolderPath: "%clipboard%"Copied .
Traytip,IVSOUL@WARNING,已复制文件夹路径至剪切板！`n%Clipboard%
SetTimer, RemoveTrayTip, 2000
SetTimer, RemoveToolTip, 2000
return

Alt & 3:: ;Copy File Path and Name.
Clipboard =
Send,^c
ClipWait
path = %Clipboard%
if path =
return

Clipboard = %path%
tooltip 已复制文件路径至剪切板！`nFilePath: "%clipboard%" Copied.
Traytip,IVSOUL@WARNING,已复制文件路径至剪切板！`n%Clipboard%
SetTimer, RemoveTrayTip, 2000
SetTimer, RemoveToolTip, 2000
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
^H:: ;Show or Hide Hidden Files.
ID := WinExist("A")
WinGetClass,Class, ahk_id %ID%
WClasses := "CabinetWClass ExploreWClass"
IfInString, WClasses, %Class%
	GoSub, Toggle_HiddenFiles_Display
Return

^!H:: ;Show or Hide Super Hidden Files.
ID := WinExist("A")
WinGetClass,Class, ahk_id %ID%
WClasses := "CabinetWClass ExploreWClass"
IfInString, WClasses, %Class%
	GoSub, Toggle_SuperHiddenFiles_Display
Return

^E:: ;Show or Hide File Extensions.
ID := WinExist("A")
WinGetClass,Class, ahk_id %ID%
WClasses := "CabinetWClass ExploreWClass"
IfInString, WClasses, %Class%
	GoSub, Toggle_FileExt_Display
Return

Toggle_HiddenFiles_Display:
RootKey = HKEY_CURRENT_USER
SubKey  = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced

RegRead, HiddenFiles_Status, % RootKey, % SubKey, Hidden
if HiddenFiles_Status = 2
	RegWrite, REG_DWORD, % RootKey, % SubKey, Hidden, 1
else
	RegWrite, REG_DWORD, % RootKey, % SubKey, Hidden, 2
	PostMessage, 0x111, 41504,,, ahk_id %ID%
Return

Toggle_SuperHiddenFiles_Display:
RootKey = HKEY_CURRENT_USER
SubKey  = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced

RegRead, SuperHiddenFiles_Status, % RootKey, % SubKey, ShowSuperHidden
if SuperHiddenFiles_Status = 0
	RegWrite, REG_DWORD, % RootKey, % SubKey, ShowSuperHidden, 1
else
	RegWrite, REG_DWORD, % RootKey, % SubKey, ShowSuperHidden, 0
	PostMessage, 0x111, 41504,,, ahk_id %ID%
Return

Toggle_FileExt_Display:
RootKey = HKEY_CURRENT_USER
SubKey  = Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced

RegRead, FileExt_Status, % RootKey, % SubKey, HideFileExt
if FileExt_Status = 0
	RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 1
else
	RegWrite, REG_DWORD, % RootKey, % SubKey, HideFileExt, 0
	PostMessage, 0x111, 41504,,, ahk_id %ID%
Return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
:*:@1::
Send ivsoul@163.com
return

:*:@o::
Send ivsoul@outlook.com
return

:*:@s::
Send ivsoul@sina.com
return

:*:@q::
Send 964131219@qq.com
return

:*:,,gongsi::
Send 重庆华龙网华乐健康传媒有限公司
return

:*:,,jituan::
Send 重庆华龙网集团股份有限公司
return

:*:,,dizhi::
Send 重庆市 渝北区 金开大道西段106号 10栋 移动新媒体产业大厦 9楼
return

:*:,,zhanghu::
Send 中国工商银行股份有限公司高新园支行 账号：3100022609100074624
return

:*:,,shuihao::
Send 91500000078833301T
return

:*:,,WiFi::
Send WiFi：HLW，密码：Cyy@09＊&
return
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
$CapsLock::
KeyWait, CapsLock
If (A_PriorKey="CapsLock")
SetCapsLockState, % GetKeyState("CapsLock","T") ? "Off":"On"
Return
#If, GetKeyState("CapsLock", "P")
i::Up
j::Left
k::Down
l::Right
h::Backspace
n::^z
return
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
RemoveTrayTip:
SetTimer, RemoveTrayTip, Off
TrayTip
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return
;####################################################################################################################
;####################################################################################################################