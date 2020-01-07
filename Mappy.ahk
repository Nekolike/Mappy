#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; I love every single one of you beautiful people. You are amazing. Have a great 2020. 
; If life seems rough at some point, just keep this in mind. No matter what other people say or do. You are awesome.
; If you need a good read about loving and living with yourself, read this: https://www.reddit.com/r/getdisciplined/comments/1q96b5/i_just_dont_care_about_myself/cdah4af/?context=3
; We all go through tough times. The important thing is to stay strong and keep going. And if you can't manage that on your own,
; remember that there are alot of people out there who can and want to help you. Contact a friend, a loved one or a random person on the internet.
; Everyone needs a little help from time to time and there's no shame in getting help. 
; If you can't / don't want to tell anybody else about things, contact me at Discord @Neko#1524 or via reddit @ u/Nekolike
;
;
; All things aside, just enjoy life, the game and obviously my tool!

; Variables
;--------------------------------
;--------------------------------
CustomColor := "EEAA99"
GUINameMappy := "Mappy"
GUINameConfig := "Config"
IsLocked := false
STierOpen := false
ATierOpen := false
BTierOpen := false
GUIMappyOpen := true
GUIConfigOpen := false
RegionOpen := false
CategoriesExist := false
MapsAddedCategory1 := false
MapsAddedCategory2 := false
MapsAddedCategory3 := false
MapsAddedCategory4 := false
MapsAddedCategory5 := false
AmountOfRegions = 8
RegionRowHeight = 38
CategoryRowHeight = 42
controlName := ""

; Academy missing since it's coded into the DDLstring at start
Maps := ["Acid Caverns", "Alleyways", "Ancient City", "Arachnid Nest", "Arcade", "Arena", "Arid Lake", "Armoury", "Arsenal", "Ashen Wood", "Atoll", "Barrows", "Basilica", "Bazaar", "Beach", "Belfry", "Bog", "Bone Crypt", "Burial Chambers", "Cage", "Caldera", "Canyon", "Carcass", "Castle Ruins", "Cells", "Cemetery", "Channel", "Chateau", "City Square", "Colonnade", "Colosseum", "Conservatory", "Coral Ruins", "Core", "Courthouse", "Courtyard", "Coves", "Crater", "Crimson Temple", "Crystal Ore", "Cursed Crypt", "Dark Forest", "Defiled Cathedral", "Desert", "Desert Spring", "Dig", "Dunes", "Dungeon", "Estuary", "Excavation", "Factory", "Fields", "Flooded Mine", "Fungal Hollow", "Gardens", "Geode", "Ghetto", "Glacier", "Graveyard", "Grotto", "Haunted Mansion", "Iceberg", "Infested Valley", "Ivory Temple", "Jungle Valley", "Laboratory", "Lair", "Lava Chamber", "Lava Lake", "Leyline", "Lighthouse", "Lookout", "Malformation", "Marshes", "Mausoleum", "Maze", "Mesa", "Mineral Pools", "Moon Temple", "Mud Geyser", "Museum", "Necropolis", "Orchard", "Overgrown Ruin", "Overgrown Shrine", "Palace", "Park", "Pen", "Peninsula", "Phantasmagoria", "Pier", "Pit", "Plateau", "Plaza", "Port", "Precinct", "Primordial Pool", "Promenade", "Racecourse", "Ramparts", "Reef", "Relic Chambers", "Residence", "Scriptorium", "Sepulchre", "Shipyard", "Shore", "Shrine", "Siege", "Spider Forest", "Spider Lair", "Strand", "Sulphur Vents", "Summit", "Sunken City", "Temple", "Terrace", "Thicket", "Tower", "Toxic Sewer", "Tropical Island", "Underground River", "Underground Sea", "Vaal Pyramid", "Vaal Temple", "Vault", "Villa", "Volcano", "Waste Pool", "Wasteland", "Waterways", "Wharf"]
Regions := ["Glennach Cairns", "Haewark Hamlet", "Lex Ejoris", "Lex Proxima", "Lira Arthain", "New Vastir", "Tirn's End", "Valdo's Rest"]

; GUI Layout
;--------------------------------
;--------------------------------
Gui, %GUINameMappy%:New, +LastFound -SysMenu +AlwaysOnTop
Gui, %GUINameMappy%:Color, %CustomColor%
WinSet, TransColor, %CustomColor% 150

; Menu
Gui, Add, Button, x10 y10 gLock, Lock Menu
Gui, Add, Button, x+5 gHideMaps, Hide Maps
Gui, Add, Button, x+5 gShowMaps, Show Maps
Gui, Add, Button, x+5 gRegion, Show Region
Gui, Add, Button, x+5 vButtonConfig gConfig, Config
Gui, Add, Button, x+5 gReset, Reload Script
;Gui, Add, Button, x+5 gMinimize, Minimize

; Regions
Gui, Add, Button, hidden x10 gRegionSelect, Glennach Cairns
Gui, Add, Button, hidden x+5 gRegionSelect, Haewark Hamlet
Gui, Add, Button, hidden x+5 gRegionSelect, Lex Ejoris
Gui, Add, Button, hidden x+5 gRegionSelect, Lex Proxima
Gui, Add, Button, hidden x+5 gRegionSelect, Lira Arthain
Gui, Add, Button, hidden x+5 gRegionSelect, New Vastir
Gui, Add, Button, hidden x+5 gRegionSelect, Tirn's End
Gui, Add, Button, hidden x+5 gRegionSelect, Valdo's Rest

; Startup GUI
Gui, %GUINameMappy%:Show, NoActivate AutoSize
;WinActivate, Path of Exile

Return

; Labels
;--------------------------------
;--------------------------------

; Showing & Hiding Region-buttons
Region:
CategoryCount := 0
if(RegionOpen = false)
{
    Loop % AmountOfRegions
    {
        GuiControl, Show, % Regions[A_Index]
    }
    GuiControl, Text, Show Region, Hide Region
    RegionOpen := true
}
else
{
    Loop % AmountOfRegions{
        GuiControl, Hide, % Regions[A_Index]
    }
    GuiControl, Text, Hide Region, Show Region
    RegionOpen := false
}
Gui, %GUINameMappy%:Show, AutoSize
Return

; Sends Region to Path of Exile 
RegionSelect:
GuiControlGet, var,, % A_GuiControl
WinActivate, Path of Exile
Send ^f
Send % var
Return

; Reload Mappy to reset Categories etc.
Reset:
Reload
Return

; Create Config GUI
Config:
Gui, %GUINameConfig%: new, +AlwaysOnTop
Gui, %GUINameConfig%:Add, Text, x10 y10, Amount of categories:
Gui, %GUINameConfig%:Add, Edit, vAmountOfCategories
Gui, %GUINameConfig%:Add, UpDown, Range1-5, 3
Gui, %GUINameConfig%:Add, Button, x+5 vButtonSaveAmount gSaveAmount, Save amount
Gui, %GUINameConfig%:Add, Button, Disabled x+5 vButtonAddCategory gAddCategory, Add Category
Gui, %GUINameConfig%:Add, Button, Disabled x+5 vButtonSaveCategories gSaveCategories, Save Categories
Gui, %GUINameConfig%:Show,, %GUINameConfig%
GuiControl, %GUINameMappy%:Disable, ButtonConfig
Return

; Updates Config with amount of categories selected
SaveAmount:
GuiControlGet, AmountOfCategories

DDLString := "Academy|"
Loop, % Maps.MaxIndex()
    DDLString .= "|" Maps[A_Index]

CategoryCount := 0
MapCount := 0
Loop %AmountOfCategories%{
    CategoryCount += 1
    MapCount += 1
    Gui, %GUINameConfig%:Add, Text, x10, Category:
    Gui, %GUINameConfig%:Add, Edit, vCategory%CategoryCount%
    Gui, %GUINameConfig%:Add, ComboBox, hidden x+5 vCombo%CategoryCount%, %DDLString%
    Gui, %GUINameConfig%:Add, Button, hidden x+5 vButton%MapCount% gGetButtonPressed, Add
}

Gui, %GUINameConfig%:Show, AutoSize
GuiControl, Disable, ButtonSaveAmount
GuiControl, Disable, AmountOfCategories
GuiControl, Enable, ButtonAddCategory
GuiControl, Enable, ButtonSaveCategories
Return

NewButtonPositionX(x,y,z)
{
    return x + y + z
}

AddCategory:
CategoryCount += 1
MapCount += 1
AmountOfCategories += 1
Gui, %GUINameConfig%:Add, Text, x10, Category:
Gui, %GUINameConfig%:Add, Edit, vCategory%CategoryCount%
Gui, %GUINameConfig%:Add, ComboBox, hidden x+5 vCombo%CategoryCount%, %DDLString%
Gui, %GUINameConfig%:Add, Button, hidden x+5 vButton%MapCount% gGetButtonPressed, Add
Gui, %GUINameConfig%:Show, AutoSize
Return

SaveCategories:
CategoryCount := 0
MapCount := 0
Loop % AmountOfCategories{
        CategoryCount += 1
        MapCount += 1
        GuiControl, Show, Combo%CategoryCount%
        GuiControl, Show, Button%MapCount%
        GuiControlGet, Category%CategoryCount%
        Gui, %GUINameMappy%:Add, Button, x10 section vButton%CategoryCount% gShowHideMaps, % Category%CategoryCount%
        GuiControl, Disable, Category%CategoryCount%
    }
    CategoriesExist := true
    CategoryCount := 0
    MapCount := 0
    Gui, %GUINameMappy%:Show, AutoSize
    GuiControl, Disable, ButtonSaveAmount
    GuiControl, Disable, ButtonSaveCategories
    GuiControl, Disable, ButtonAddCategory
    Loop % AmountOfCategories 
    {
        GuiControl, Disable, ButtonAddCategory
    }
Return

ShowHideMaps:
Return

; GetButtonPressed is the first function to be called when "Add Map" is being clicked to find out which button was pressed
; Next, it goes to AddMap to retrieve the input from the Combobox and actually add the map to the Mappy-GUI
GetButtonPressed(CtrlHwnd:=0)
{
    global controlName
    GuiControlGet, controlName, Name, %CtrlHwnd%
    gosub AddMap
}

GetPosition:
GuiControlGet, Button1, %GUINameMappy%:Pos, % Category1
MsgBox, X is %Button1X%. Y is %Button1Y%
NextButtonX := NewButtonPositionX(Button1X, Button1W, 5)
; NextButtonX := NewButtonPositionX(%Button1X%, %Button1W%, 5)
; MsgBox, %NextButtonX% für neuen button
NextButtonY = %Button1Y%
Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vfinally, %Combo1%
Gui, %GUINameMappy%:Show, AutoSize
Return

AddMap:
Gui, Submit, NoHide
MapCount += 1
if(controlName = "Button1")
    {
        if(MapsAddedCategory1 = false)
        {
            GuiControlGet, Button1, %GUINameMappy%:Pos, % Category1
            NextButtonX := NewButtonPositionX(Button1X, Button1W, 5)
            NextButtonY = %Button1Y%
            Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vMap%MapCount% gCallMap, %Combo1%
            MapsAddedCategory1 := true
            PreviousMap1 := % Combo1

        }
        else
        {
            GuiControlGet, Button2, %GUINameMappy%:Pos, % PreviousMap1
            NextButtonX := NewButtonPositionX(Button2X, Button2W, 5)
            NextButtonY = %Button2Y%
            Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vMap%MapCount% gCallMap, %Combo1%
            PreviousMap1 := % Combo1
        }
        
        Gui, %GUINameMappy%:Show, AutoSize
    }
else if(controlName = "Button2")
    {

        if(MapsAddedCategory2 = false)
        {
            GuiControlGet, Button1, %GUINameMappy%:Pos, % Category2
            NextButtonX := NewButtonPositionX(Button1X, Button1W, 5)
            NextButtonY = %Button1Y%
            Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vMap%MapCount% gCallMap, %Combo2%
            MapsAddedCategory2 := true
            PreviousMap2 := % Combo2

        }
        else
        {
            GuiControlGet, Button2, %GUINameMappy%:Pos, % PreviousMap2
            NextButtonX := NewButtonPositionX(Button2X, Button2W, 5)
            NextButtonY = %Button2Y%
            Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vMap%MapCount% gCallMap, %Combo2%
            PreviousMap2 := % Combo2
        }
        
        Gui, %GUINameMappy%:Show, AutoSize
    }
else if(controlName = "Button3")
    {
        if(MapsAddedCategory3 = false)
        {
            GuiControlGet, Button1, %GUINameMappy%:Pos, % Category3
            NextButtonX := NewButtonPositionX(Button1X, Button1W, 5)
            NextButtonY = %Button1Y%
            Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vMap%MapCount% gCallMap, %Combo3%
            MapsAddedCategory3 := true
            PreviousMap3 := % Combo3

        }
        else
        {
            GuiControlGet, Button2, %GUINameMappy%:Pos, % PreviousMap3
            NextButtonX := NewButtonPositionX(Button2X, Button2W, 5)
            NextButtonY = %Button2Y%
            Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vMap%MapCount% gCallMap, %Combo3%
            PreviousMap3 := % Combo3
        }
        
        Gui, %GUINameMappy%:Show, AutoSize
    }
else if(controlName = "Button4")
    {
        if(MapsAddedCategory4 = false)
        {
            GuiControlGet, Button1, %GUINameMappy%:Pos, % Category4
            NextButtonX := NewButtonPositionX(Button1X, Button1W, 5)
            NextButtonY = %Button1Y%
            Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vMap%MapCount% gCallMap, %Combo4%
            MapsAddedCategory4 := true
            PreviousMap4 := % Combo4

        }
        else
        {
            GuiControlGet, Button2, %GUINameMappy%:Pos, % PreviousMap4
            NextButtonX := NewButtonPositionX(Button2X, Button2W, 5)
            NextButtonY = %Button2Y%
            Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vMap%MapCount% gCallMap, %Combo4%
            PreviousMap4 := % Combo4
        }

        Gui, %GUINameMappy%:Show, AutoSize
    }
else if(controlName = "Button5")
    {
        if(MapsAddedCategory5 = false)
        {
            GuiControlGet, Button1, %GUINameMappy%:Pos, % Category5
            NextButtonX := NewButtonPositionX(Button1X, Button1W, 5)
            NextButtonY = %Button1Y%
            Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vMap%MapCount% gCallMap, %Combo5%
            MapsAddedCategory5 := true
            PreviousMap5 := % Combo5

        }
        else
        {
            GuiControlGet, Button2, %GUINameMappy%:Pos, % PreviousMap5
            NextButtonX := NewButtonPositionX(Button2X, Button2W, 5)
            NextButtonY = %Button2Y%
            Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vMap%MapCount% gCallMap, %Combo5%
            PreviousMap5 := % Combo5
        }

        Gui, %GUINameMappy%:Show, AutoSize
    }
Return

CallMap:
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

; Label to lock / unlock the Mappy-window
Lock:
if (IsLocked = false)
{
    Gui, %GUINameMappy%:-Caption
    GuiControl, Text, Lock, Unlock
    IsLocked := true
}
else
{
    Gui, %GUINameMappy%:+Caption
    GuiControl, Text, Unlock, Lock Menu
    IsLocked := false
}
WinActivate, Path of Exile
Gui, %GUINameMappy%:Show, AutoSize
Return


HideMaps:
WinActivate, Path of Exile
Return

ShowMaps:
WinActivate, Path of Exile
Return


;Minimize:
;Gui, Hide
;Return