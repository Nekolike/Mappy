#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; If you need some kind words, scroll to the bottom. 

CustomColor := "EEAA99" 
GUINameMappy := "Mappy"
GUINameConfig := "Config"
IsLocked := false
GUIMappyOpen := true
GUIConfigOpen := false
RegionOpen := false
MapsAddedCategory1 := false
MapsAddedCategory2 := false
MapsAddedCategory3 := false
MapsAddedCategory4 := false
MapsAddedCategory5 := false
CategoryCount = 0
MapCount = 0
AmountOfRegions = 8
SavedAmountOfCategories = 0
AmountOfCategories = 0
SavedAmountOfKeywords := []
Categories := []
Keywords := [[],[]]
controlName := ""
KeywordArrayIndex = 0
KeywordIndex = 0

ConfigFile = %A_ScriptDir%\Config.ini
ifnotexist,%ConfigFile%
{
    IniWrite, 0, %ConfigFile%, AmountOfCategories, Key1
}
IniRead, SavedAmountOfCategories, %ConfigFile%, AmountOfCategories, Key1

Loop % SavedAmountOfCategories
{
    CategoryCount += 1
    KeywordArrayIndex += 1
    KeywordIndex = 0
    IniRead, tempVar, %ConfigFile%, Categories, Key%CategoryCount%
    IniRead, temp%CategoryCount%, %ConfigFile%, AmountOfKeywordsCategory%CategoryCount%, Key1
    tempVar2 = % temp%CategoryCount%
    SavedAmountOfKeywords[A_Index] := tempVar2
    Categories[A_Index] := tempVar

    Loop % SavedAmountOfKeywords[A_Index] 
    {
        KeywordIndex += 1
        IniRead, tempKeyword, %ConfigFile%, Category%CategoryCount%, Key%KeywordIndex%
        Keywords[KeywordArrayIndex, KeywordIndex] := tempKeyword
    }
}

Maps := ["Acid Caverns", "Alleyways", "Ancient City", "Arachnid Nest", "Arcade", "Arena", "Arid Lake", "Armoury", "Arsenal", "Ashen Wood", "Atoll", "Barrows", "Basilica", "Bazaar", "Beach", "Belfry", "Bog", "Bone Crypt", "Burial Chambers", "Cage", "Caldera", "Canyon", "Carcass", "Castle Ruins", "Cells", "Cemetery", "Channel", "Chateau", "City Square", "Colonnade", "Colosseum", "Conservatory", "Coral Ruins", "Core", "Courthouse", "Courtyard", "Coves", "Crater", "Crimson Temple", "Crystal Ore", "Cursed Crypt", "Dark Forest", "Defiled Cathedral", "Desert", "Desert Spring", "Dig", "Dunes", "Dungeon", "Estuary", "Excavation", "Factory", "Fields", "Flooded Mine", "Fungal Hollow", "Gardens", "Geode", "Ghetto", "Glacier", "Graveyard", "Grotto", "Haunted Mansion", "Iceberg", "Infested Valley", "Ivory Temple", "Jungle Valley", "Laboratory", "Lair", "Lava Chamber", "Lava Lake", "Leyline", "Lighthouse", "Lookout", "Malformation", "Marshes", "Mausoleum", "Maze", "Mesa", "Mineral Pools", "Moon Temple", "Mud Geyser", "Museum", "Necropolis", "Orchard", "Overgrown Ruin", "Overgrown Shrine", "Palace", "Park", "Pen", "Peninsula", "Phantasmagoria", "Pier", "Pit", "Plateau", "Plaza", "Port", "Precinct", "Primordial Pool", "Promenade", "Racecourse", "Ramparts", "Reef", "Relic Chambers", "Residence", "Scriptorium", "Sepulchre", "Shipyard", "Shore", "Shrine", "Siege", "Spider Forest", "Spider Lair", "Strand", "Sulphur Vents", "Summit", "Sunken City", "Temple", "Terrace", "Thicket", "Tower", "Toxic Sewer", "Tropical Island", "Underground River", "Underground Sea", "Vaal Pyramid", "Vaal Temple", "Vault", "Villa", "Volcano", "Waste Pool", "Wasteland", "Waterways", "Wharf"]
Regions := ["Glennach Cairns", "Haewark Hamlet", "Lex Ejoris", "Lex Proxima", "Lira Arthain", "New Vastir", "Tirn's End", "Valdo's Rest"]
RegionButtons := ["RegionButton1", "RegionButton2", "RegionButton3", "RegionButton4", "RegionButton5", "RegionButton6", "RegionButton7", "RegionButton8"]

Gui, %GUINameMappy%:New, +LastFound -SysMenu +AlwaysOnTop
Gui, %GUINameMappy%:Color, %CustomColor%
WinSet, TransColor, %CustomColor% 150

Gui, Add, Button, x10 y10 gLock, Lock Menu
Gui, Add, Button, x+5 gHideMaps, Hide Keywords
Gui, Add, Button, x+5 gShowMaps, Show Keywords
Gui, Add, Button, x+5 gToggleRegion, Show Region
Gui, Add, Button, x+5 vButtonConfig gConfig, Create Keywords

Gui, Add, Button, hidden x10 vRegionButton1 gSearchKeyword, Glennach Cairns
Gui, Add, Button, hidden x+5 vRegionButton2 gSearchKeyword, Haewark Hamlet
Gui, Add, Button, hidden x+5 vRegionButton3 gSearchKeyword, Lex Ejoris
Gui, Add, Button, hidden x+5 vRegionButton4 gSearchKeyword, Lex Proxima
Gui, Add, Button, hidden x+5 vRegionButton5 gSearchKeyword, Lira Arthain
Gui, Add, Button, hidden x+5 vRegionButton6 gSearchKeyword, New Vastir
Gui, Add, Button, hidden x+5 vRegionButton7 gSearchKeyword, Tirn's End
Gui, Add, Button, hidden x+5 vRegionButton8 gSearchKeyword, Valdo's Rest

if(SavedAmountOfCategories != 0){
    CategoryCount := 0
    Loop % SavedAmountOfCategories{
        CategoryCount += 1
        tempKey = 0
        GuiControlGet, Category%CategoryCount%
        Gui, %GUINameMappy%:Add, Button, x10 section vButtonCategory%CategoryCount% gGetButtonCategoryPressed, % Categories[CategoryCount]
        Loop % SavedAmountOfKeywords[A_Index]{
            if(!SavedMapsAddedCategory%CategoryCount%){
                GuiControlGet, CategoryButton, %GUINameMappy%:Pos, ButtonCategory%CategoryCount%
                NextButtonX := NewButtonPositionX(CategoryButtonX, CategoryButtonW, 5)
                NextButtonY = %CategoryButtonY%
                SavedMapsAddedCategory%CategoryCount% := !SavedMapsAddedCategory%CategoryCount%
            }
            else{
                GuiControlGet, Button2, %GUINameMappy%:Pos, ButtonSavedCategory%CategoryCount%Keyword%tempKey%
                NextButtonX := NewButtonPositionX(Button2X, Button2W, 5)
                NextButtonY = %Button2Y%
                Keywords%CategoryCount% += 1
                tempKey = % Keywords%CategoryCount%
            }
            tempKey += 1
            Keywords[KeywordArrayIndex, KeywordIndex] := tempKeyword
            currentKeyword := Keywords[CategoryCount, tempKey]
            Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vButtonSavedCategory%CategoryCount%Keyword%tempKey% gSearchKeyword, %currentKeyword%
        }
        
    }
}

Gui, %GUINameMappy%:Show, NoActivate AutoSize
Return

Lock:
if (!IsLocked)
{
    Gui, %GUINameMappy%:-Caption
    GuiControl, Text, Lock, Unlock
}
else
{
    Gui, %GUINameMappy%:+Caption
    GuiControl, Text, Unlock, Lock Menu
    
}
IsLocked := !IsLocked
Gui, %GUINameMappy%:Show, AutoSize
Return


HideMaps:
CategoryCount = 0
Loop % SavedAmountOfCategories
{
    tempKey = 0
    CategoryCount += 1
    Loop % SavedAmountOfKeywords[A_Index]
        {
            tempKey += 1
            GuiControl, %GUINameMappy%:Hide, ButtonSavedCategory%CategoryCount%Keyword%tempKey%  
        }
}
Return

ShowMaps:
CategoryCount = 0
Loop % SavedAmountOfCategories
{
    tempKey = 0
    CategoryCount += 1
    Loop % SavedAmountOfKeywords[A_Index]
        {
            tempKey += 1
                GuiControl, %GUINameMappy%:Show, ButtonSavedCategory%CategoryCount%Keyword%tempKey%            
        }
}
Return

ToggleRegion:
if(RegionOpen)
{
    Loop % AmountOfRegions
    {
        GuiControl, Show, % Regions[A_Index]
    }
    GuiControl, Text, Show Region, Hide Region
}
else
{
    Loop % AmountOfRegions
    {
        GuiControl, Hide, % Regions[A_Index]
    }
    GuiControl, Text, Hide Region, Show Region
}
RegionOpen := !RegionOpen
Gui, %GUINameMappy%:Show, AutoSize
Return

Config:
Gui, %GUINameConfig%: new, +AlwaysOnTop
Gui, %GUINameConfig%:Add, Text, x10 y10, Amount of categories:
Gui, %GUINameConfig%:Add, Edit, vEditAmountOfCategories
Gui, %GUINameConfig%:Add, UpDown, Range1-5, 3
Gui, %GUINameConfig%:Add, Button, x+5 vButtonSaveAmount gSaveAmount, Save amount
Gui, %GUINameConfig%:Add, Button, Disabled x+5 vButtonAddCategory gAddCategory, Add Category
Gui, %GUINameConfig%:Add, Button, Disabled x+5 vButtonSaveCategories gSaveCategories, Save Categories
Gui, %GUINameConfig%:Show

Keywords1 = 0
Keywords2 = 0
Keywords3 = 0
Keywords4 = 0
Keywords5 = 0
Return

SaveAmount:
GuiControlGet, AmountOfCategories,, EditAmountOfCategories
if(AmountOfCategories > 5)
{
    MsgBox, 4096, Too Many Categories!,  I can only add up to 5 categories
    Return
}

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
    Gui, %GUINameConfig%:Add, Button, hidden x+5 vButtonAddKeyword%MapCount% gGetButtonPressed, Add
}

Gui, %GUINameConfig%:Show, AutoSize
GuiControl, Disable, ButtonSaveAmount
GuiControl, Disable, AmountOfCategories
GuiControl, Enable, ButtonAddCategory
GuiControl, Enable, ButtonSaveCategories
Return

AddCategory:
AmountOfCategories += 1
if(AmountOfCategories > 5)
{
    MsgBox, 4096, Too Many Categories!,  I can only add up to 5 categories
    AmountOfCategories -= 1
    Return
}
CategoryCount += 1
MapCount += 1
IniWrite, %AmountOfCategories%, %A_ScriptDir%\Config.ini, AmountOfCategories, Key1
Gui, %GUINameConfig%:Add, Text, x10, Category:
Gui, %GUINameConfig%:Add, Edit, vCategory%CategoryCount%
Gui, %GUINameConfig%:Add, ComboBox, hidden x+5 vCombo%CategoryCount%, %DDLString%
Gui, %GUINameConfig%:Add, Button, hidden x+5 vButtonAddKeyword%MapCount% gGetButtonPressed, Add
Gui, %GUINameConfig%:Show, AutoSize
Return

SaveCategories:
CategoryCount := 0
MapCount := 0

if(AmountOfCategories <= SavedAmountOfCategories)
{
    Loop % AmountOfCategories
    {
        CategoryCount += 1
        MapCount += 1
        GuiControl, Show, Combo%CategoryCount%
        GuiControl, Show, ButtonAddKeyword%MapCount%
        GuiControlGet, CategoryNumber,, Category%CategoryCount%
        IniWrite, %CategoryNumber%, %ConfigFile%, Categories, Key%CategoryCount%
        GuiControl, %GUINameMappy%:Text, ButtonCategory%CategoryCount%, % CategoryNumber
    }

    if(AmountOfCategories < SavedAmountOfCategories)
    {
        Loop % SavedAmountOfCategories - AmountOfCategories
            {
                CategoryCount += 1
                GuiControl, %GUINameMappy%:Hide, ButtonCategory%CategoryCount%, % CategoryNumber
                IniDelete, %ConfigFile%, Categories, Key%CategoryCount%
            }
    }
    
}

else if(AmountOfCategories > SavedAmountOfCategories)
{
    Loop % SavedAmountOfCategories
    {
        CategoryCount += 1
        MapCount += 1
        GuiControl, Show, Combo%CategoryCount%
        GuiControl, Show, ButtonAddKeyword%MapCount%
        GuiControlGet, CategoryNumber,, Category%CategoryCount%
        IniWrite, %CategoryNumber%, %ConfigFile%, Categories, Key%CategoryCount%
        GuiControl, %GUINameMappy%:Text, ButtonCategory%CategoryCount%, % CategoryNumber
    }

    Loop % AmountOfCategories - SavedAmountOfCategories
    {
        CategoryCount += 1
        MapCount += 1
        GuiControl, Show, Combo%CategoryCount%
        GuiControl, Show, ButtonAddKeyword%MapCount%
        GuiControlGet, CategoryNumber,, Category%CategoryCount%
        Categories[CategoryCount] := CategoryNumber
        Gui, %GUINameMappy%:Add, Button, x10 section vButtonCategory%CategoryCount% gGetButtonCategoryPressed, % Categories[CategoryCount]
        IniWrite, %CategoryNumber%, %ConfigFile%, Categories, Key%CategoryCount%
    }
}

CategoryCount = 0
tempKey = 0
Loop % SavedAmountOfCategories
{
    CategoryCount += 1
    tempKey = 0
    IniDelete, %ConfigFile%, Category%CategoryCount%
    IniDelete, %ConfigFile%, AmountOfKeywordsCategory%CategoryCount%
    Loop % SavedAmountOfKeywords[A_Index]
    {
        tempKey += 1
        GuiControl, %GUINameMappy%:Hide, ButtonCategory%CategoryCount%Keyword%tempKey%
        GuiControl, %GUINameMappy%:Hide, ButtonSavedCategory%CategoryCount%Keyword%tempKey%
    }
}

IniWrite, %AmountOfCategories%, %A_ScriptDir%\Config.ini, AmountOfCategories, Key1
GuiControl, Disable, ButtonAddCategory
GuiControl, Disable, ButtonSaveCategories
Gui, %GUINameConfig%:Add, Button, x10 vButtonSaveKeywords gSaveKeywords, Save Keywords
Gui, %GUINameConfig%:Show, AutoSize
Gui, %GUINameMappy%:Show, AutoSize
Return

SaveKeywords:
Reload
Return

AddKeyword:
Gui, Submit, NoHide


if(controlName = "ButtonAddKeyword1"){
    CategoryCount = 1
    Keywords1 += 1
    KeyValue = %Keywords1%
}
else if(controlName = "ButtonAddKeyword2"){
    CategoryCount = 2
    Keywords2 += 1
    KeyValue = %Keywords2%
}
else if(controlName = "ButtonAddKeyword3"){
    CategoryCount = 3
    Keywords3 += 1
    KeyValue = %Keywords3%
}
else if(controlName = "ButtonAddKeyword4"){
    CategoryCount = 4
    Keywords4 += 1
    KeyValue = %Keywords4%
} 
else if(controlName = "ButtonAddKeyword5"){
    CategoryCount = 5
    Keywords5 += 1
    KeyValue = %Keywords5%
}

if(!MapsAddedCategory%CategoryCount%){
    tempKey = % Keywords%CategoryCount%
    GuiControlGet, CategoryButton, %GUINameMappy%:Pos, ButtonCategory%CategoryCount%
    NextButtonX := NewButtonPositionX(CategoryButtonX, CategoryButtonW, 5)
    NextButtonY = %CategoryButtonY%
    MapsAddedCategory%CategoryCount% := !MapsAddedCategory%CategoryCount%
}
else{
    Keywords%CategoryCount% -= 1
    tempKey = % Keywords%CategoryCount%
    GuiControlGet, Button2, %GUINameMappy%:Pos, ButtonCategory%CategoryCount%Keyword%tempKey%
    NextButtonX := NewButtonPositionX(Button2X, Button2W, 5)
    NextButtonY = %Button2Y%
    Keywords%CategoryCount% += 1
    tempKey = % Keywords%CategoryCount%
}

GuiControlGet, ComboValue,, % Combo%CategoryCount%
IniWrite, %ComboValue%, %ConfigFile%, Category%CategoryCount%, Key%KeyValue%
IniWrite, %KeyValue%, %ConfigFile%, AmountOfKeywordsCategory%CategoryCount%, Key1
Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vButtonCategory%CategoryCount%Keyword%tempKey% gSearchKeyword, % Combo%CategoryCount%
Gui, %GUINameMappy%:Show, AutoSize
Return

SearchKeyword:
GuiControlGet, var,, % A_GuiControl
WinActivate, Path of Exile
Send ^f
Send % var
Return

ShowHideKeywords:
if(controlName = "ButtonCategory1"){
    CategoryCount = 1
}
else if(controlName = "ButtonCategory2"){
    CategoryCount = 2
}
else if(controlName = "ButtonCategory3"){
    CategoryCount = 3
}
else if(controlName = "ButtonCategory4"){
    CategoryCount = 4
} 
else if(controlName = "ButtonCategory5"){
    CategoryCount = 5
}

tempKey = 0
Loop % SavedAmountOfKeywords[CategoryCount]
    {
        tempKey += 1
        if(!KeywordsHidden%CategoryCount%)
        {
            GuiControl, %GUINameMappy%:Hide, ButtonSavedCategory%CategoryCount%Keyword%tempKey%
        }
        else if(KeywordsHidden%CategoryCount%)
        {
            GuiControl, %GUINameMappy%:Show, ButtonSavedCategory%CategoryCount%Keyword%tempKey%
        }
        
    }
KeywordsHidden%CategoryCount% := !KeywordsHidden%CategoryCount%
Return

ConfigGuiClose:
Reload
return
    
^Numpad0::
if (GUIMappyOpen)
    Gui, %GUINameMappy%:Hide
else
    Gui, %GUINameMappy%:Show
GUIMappyOpen := !GUIMappyOpen
Return

GetButtonPressed(CtrlHwnd:=0)
{
    global controlName
    GuiControlGet, controlName, Name, %CtrlHwnd%
    gosub AddKeyword
}

GetButtonCategoryPressed(CtrlHwnd:=0)
{
    global controlName
    GuiControlGet, controlName, Name, %CtrlHwnd%
    gosub ShowHideKeywords
}

; Searches for words (needle) in an array (haystack) (OC: jNizM -> https://www.autohotkey.com/boards/viewtopic.php?f=6&t=3514&p=109617#p109617)
HasVal(haystack, needle) {
	if !(IsObject(haystack)) || (haystack.Length() = 0)
		return 0
	for index, value in haystack
		if (value = needle)
			return index
	return 0
}

NewButtonPositionX(x,y,z)
{
    return x + y + z
}

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
;
;   ,d88b.d88b,
;   88888888888
;   `Y8888888Y'
;     `Y888Y'
;       `Y'
;
