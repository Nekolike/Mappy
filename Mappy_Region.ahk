#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Variables
;--------------------------------
;--------------------------------
CustomColor := "EEAA99"
GUINameMappy := "Mappy_Region"

Gui, %GUINameMappy%:New, +LastFound +SysMenu +AlwaysOnTop
Gui, %GUINameMappy%:Color, %CustomColor%
WinSet, TransColor, %CustomColor% 150

; Regions
Gui, Add, Button, x10 vRegionButton1 gRegionSelect, Glennach Cairns
Gui, Add, Button, x+5 vRegionButton2 gRegionSelect, Haewark Hamlet
Gui, Add, Button, x+5 vRegionButton3 gRegionSelect, Lex Ejoris
Gui, Add, Button, x+5 vRegionButton4 gRegionSelect, Lex Proxima
Gui, Add, Button, x+5 vRegionButton5 gRegionSelect, Lira Arthain
Gui, Add, Button, x+5 vRegionButton6 gRegionSelect, New Vastir
Gui, Add, Button, x+5 vRegionButton7 gRegionSelect, Tirn's End
Gui, Add, Button, x+5 vRegionButton8 gRegionSelect, Valdo's Rest

; Startup GUI
Gui, %GUINameMappy%:Show, NoActivate AutoSize

Return

; Sends Region to Path of Exile 
RegionSelect:
GuiControlGet, var,, % A_GuiControl
WinActivate, Path of Exile
Send ^f
Send % var
Return

; Hotkey to show / hide Mappy
^Numpad0::
if (GUIMappyOpen = true)
{
    Gui, %GUINameMappy%:Hide
    GUIMappyOpen := false
}
else
{
    Gui, %GUINameMappy%:Show
    GUIMappyOpen := true
}
Return
