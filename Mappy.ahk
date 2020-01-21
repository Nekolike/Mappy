#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
#SingleInstance force

try {
    if !A_IsAdmin{
        Run *RunAs "%A_ScriptFullPath%"
    }
} catch e{
    ExitApp
}    

; If you need some kind words, scroll to the bottom. 

OnExit, SaveWindowPosition
MappyFile := "Mappy.ahk"
CurrentVersionFile := "CurrentVersion.txt"
UpdatesFile := "Updates.txt"
ChangelogFile := "Changelog.txt"
SettingsFile := "Settings.ini"
ExampleFile := "Example.ini"
VersionStart := 19
CurrentVersion = 1.04
VersionLength = 4

UrlDownloadToFile, https://raw.githubusercontent.com/Nekolike/Mappy/master/%CurrentVersionFile%, %A_ScriptDir%\%CurrentVersionFile%
FileRead, NewVersion, %A_ScriptDir%\%CurrentVersionFile%

NewVersion := SubStr(NewVersion, VersionStart, VersionLength)
GUIMappyOpen := false

if(CurrentVersion < NewVersion){
    MsgBox, 4, Update available, New version available! Want to update now?
    IfMsgBox Yes
    {
        UrlDownloadToFile, https://raw.githubusercontent.com/Nekolike/Mappy/master/%UpdatesFile%, %A_ScriptDir%\%UpdatesFile%
        FileRead, UpdatesContent, %A_ScriptDir%\%UpdatesFile%
        MsgBox, 4096, Patch notes, %UpdatesContent%
        UrlDownloadToFile, https://raw.githubusercontent.com/Nekolike/Mappy/master/%MappyFile%, %A_ScriptDir%\%MappyFile%
        UrlDownloadToFile, https://raw.githubusercontent.com/Nekolike/Mappy/master/%ChangelogFile%, %A_ScriptDir%\%ChangelogFile%
        Reload
    }     
}

CustomColor := "EEAA99"
GUINameMappy := "Mappy"
GUINameConfig := "Config"
GUINameOverlayHotkey := "OverlayHotkey"
GUINameAddKeyword := "AddKeyword"
GUINameAddCategory := "AddCategory"
Maps := ["Acid Caverns", "Alleyways", "Ancient City", "Arachnid Nest", "Arcade", "Arena", "Arid Lake", "Armoury", "Arsenal", "Ashen Wood", "Atoll", "Barrows", "Basilica", "Bazaar", "Beach", "Belfry", "Bog", "Bone Crypt", "Burial Chambers", "Cage", "Caldera", "Canyon", "Carcass", "Castle Ruins", "Cells", "Cemetery", "Channel", "Chateau", "City Square", "Colonnade", "Colosseum", "Conservatory", "Coral Ruins", "Core", "Courthouse", "Courtyard", "Coves", "Crater", "Crimson Temple", "Crystal Ore", "Cursed Crypt", "Dark Forest", "Defiled Cathedral", "Desert", "Desert Spring", "Dig", "Dunes", "Dungeon", "Estuary", "Excavation", "Factory", "Fields", "Flooded Mine", "Fungal Hollow", "Gardens", "Geode", "Ghetto", "Glacier", "Graveyard", "Grotto", "Haunted Mansion", "Iceberg", "Infested Valley", "Ivory Temple", "Jungle Valley", "Laboratory", "Lair", "Lava Chamber", "Lava Lake", "Leyline", "Lighthouse", "Lookout", "Malformation", "Marshes", "Mausoleum", "Maze", "Mesa", "Mineral Pools", "Moon Temple", "Mud Geyser", "Museum", "Necropolis", "Orchard", "Overgrown Ruin", "Overgrown Shrine", "Palace", "Park", "Pen", "Peninsula", "Phantasmagoria", "Pier", "Pit", "Plateau", "Plaza", "Port", "Precinct", "Primordial Pool", "Promenade", "Racecourse", "Ramparts", "Reef", "Relic Chambers", "Residence", "Scriptorium", "Sepulchre", "Shipyard", "Shore", "Shrine", "Siege", "Spider Forest", "Spider Lair", "Strand", "Sulphur Vents", "Summit", "Sunken City", "Temple", "Terrace", "Thicket", "Tower", "Toxic Sewer", "Tropical Island", "Underground River", "Underground Sea", "Vaal Pyramid", "Vaal Temple", "Vault", "Villa", "Volcano", "Waste Pool", "Wasteland", "Waterways", "Wharf"]
Regions := ["Glennach Cairns", "Haewark Hamlet", "Lex Ejoris", "Lex Proxima", "Lira Arthain", "New Vastir", "Tirn's End", "Valdo's Rest"]
RegionButtons := ["RegionButton1", "RegionButton2", "RegionButton3", "RegionButton4", "RegionButton5", "RegionButton6", "RegionButton7", "RegionButton8"]
IsLocked := false
GUIConfigOpen := false
RegionOpen := false
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
tempRegion := 1

ConfigFile = %A_ScriptDir%\Config.ini
ifnotexist,%ConfigFile%
{
    IniWrite, 0, %ConfigFile%, AmountOfCategories, Key1
}

ifnotexist,%SettingsFile%
{
    IniWrite, %ConfigFile%, %SettingsFile%, Settings, ConfigPath
    IniWrite, ^Numpad0, %SettingsFile%, Settings, ToggleKey
    IniWrite, 500, %SettingsFile%, Settings, MappyPositionX
    IniWrite, 500, %SettingsFile%, Settings, MappyPositionY
    IniWrite, 150, %SettingsFile%, Settings, Transparency
}
IniRead, ConfigFile, %SettingsFile%, Settings, ConfigPath
if(ConfigFile = "ERROR" | ConfigFile = "")
{
    IniWrite, %A_ScriptDir%\Config.ini, %SettingsFile%, Settings, ConfigPath
    IniRead, ConfigFile, %SettingsFile%, Settings, ConfigPath
}
SplitPath, ConfigFile, ConfigFileName

IniRead, ToggleOverlayHotkey, %SettingsFile%, Settings, ToggleKey
if(ToggleOverlayHotkey = "ERROR" || ToggleOverlayHotkey = ""){
    IniWrite, ^Numpad0, %SettingsFile%, Settings, ToggleKey
    IniRead, ToggleOverlayHotkey, %SettingsFile%, Settings, ToggleKey
}
else{
    IniRead, ToggleOverlayHotkey, %SettingsFile%, Settings, ToggleKey
}

Hotkey, %ToggleOverlayHotkey%, ToggleOverlay, On

IniRead, Transparency, %SettingsFile%, Settings, Transparency
if(Transparency = "ERROR" || Transparency = ""){
    IniWrite, 150, %SettingsFile%, Settings, Transparency
    IniRead, Transparency, %SettingsFile%, Settings, Transparency
}
else{
    IniRead, Transparency, %SettingsFile%, Settings, Transparency
}

IniRead, SavedAmountOfCategories, %ConfigFile%, AmountOfCategories, Key1

if(SavedAmountOfCategories = "ERROR" || SavedAmountOfCategories = ""){
    IniWrite, 0, %ConfigFile%, AmountOfCategories, Key1
    SavedAmountOfCategories = 0
}
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

IniRead, ExampleWasAdded, %SettingsFile%, Settings, ExampleWasAdded
ifnotexist, %ExampleFile%
{
    if(ExampleWasAdded = "" || ExampleWasAdded = "ERROR")
    {
        UrlDownloadToFile, https://raw.githubusercontent.com/Nekolike/Mappy/master/%ExampleFile%, %A_ScriptDir%\%ExampleFile%
        IniWrite, true, %SettingsFile%, Settings, ExampleWasAdded
    }
}

Gui, %GUINameMappy%:New, +LastFound -SysMenu +AlwaysOnTop, %GUINameMappy% - Version %CurrentVersion% - %ConfigFileName%
Gui, %GUINameMappy%:Color, %CustomColor%
WinSet, TransColor, %CustomColor% %Transparency%

Gui, Add, Button, x10 y10 gLock, Lock Menu
Gui, Add, Button, x+5 gHideKeywords, Hide Keywords
Gui, Add, Button, x+5 gShowKeywords, Show Keywords
Gui, Add, Button, x+5 gToggleRegion, Show Region
Gui, Add, Button, x+5 vButtonConfig gConfig, New Overlay
Gui, Add, Button, x+5 vButtonLoadConfig gLoadConfig, Load Overlay
Gui, Add, Button, x+5 vButtonHotkey gConfigHotkey, Settings

Gui, Add, Button, hidden x10 vRegionButton%tempRegion% gSearchKeyword, Glennach Cairns
Loop % AmountOfRegions - 1
{
    tempRegion += 1
    Gui, Add, Button, hidden x+5 vRegionButton%tempRegion% gSearchKeyword, % Regions[tempRegion]
}

if(SavedAmountOfCategories != 0){
    CategoryCount := 0
    Loop % SavedAmountOfCategories{
        CategoryCount += 1
        tempKey = 0
        GuiControlGet, Category%CategoryCount%
        Gui, Add, Button, x10 vButtonCategory%CategoryCount% gGetButtonCategoryPressed, % Categories[CategoryCount]
        Loop % SavedAmountOfKeywords[A_Index]{
            if(!SavedMapsAddedCategory%CategoryCount%){
                GuiControlGet, CategoryButton, %GUINameMappy%:Pos, ButtonCategory%CategoryCount%
                NextButtonX := NewButtonPosition(CategoryButtonX, CategoryButtonW, 5)
                NextButtonY = %CategoryButtonY%
                SavedMapsAddedCategory%CategoryCount% := !SavedMapsAddedCategory%CategoryCount%
            }
            else{
                GuiControlGet, Button2, %GUINameMappy%:Pos, ButtonSavedCategory%CategoryCount%Keyword%tempKey%
                NextButtonX := NewButtonPosition(Button2X, Button2W, 5)
                NextButtonY = %Button2Y%
                Keywords%CategoryCount% += 1
                tempKey = % Keywords%CategoryCount%
            }
            tempKey += 1
            Keywords[KeywordArrayIndex, KeywordIndex] := tempKeyword
            currentKeyword := Keywords[CategoryCount, tempKey]
            Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vButtonSavedCategory%CategoryCount%Keyword%tempKey% gSearchKeyword, %currentKeyword%
        }
        Gui, %GUINameMappy%:Add, Button, x+5 vButtonAddDynamicKeyword%CategoryCount% gGetButtonAddKeywordPressed, +
        Gui, %GUINameMappy%:Add, Button, x+5 vButtonRemoveDynamicKeyword%CategoryCount% gGetButtonRemoveKeywordPressed, -
    }
}

Gui, %GUINameMappy%:Add, Button, x10 vButtonAddDynamicCategoryConfig gAddDynamicCategoryConfig, +
if(SavedAmountOfCategories > 0)
{
    Gui, %GUINameMappy%:Add, Button, x+5 vButtonRemoveDynamicCategory gRemoveDynamicCategory, -
}
else
{
    Gui, %GUINameMappy%:Add, Button, hidden x+5 vButtonRemoveDynamicCategory gRemoveDynamicCategory, -
}
IniRead, MappyWindowX, %SettingsFile%, Settings, MappyPositionX
IniRead, MappyWindowY, %SettingsFile%, Settings, MappyPositionY
if(((MappyWindowX = "" || MappyWindowX = "ERROR") && (MappyWindowY = "" || MappyWindowY = "ERROR")) || (MappyWindowX < 0 || MappyWindowY < 0))
{
    IniWrite, 500, %SettingsFile%, Settings, MappyPositionX
    IniWrite, 500, %SettingsFile%, Settings, MappyPositionY
    MappyWindowX := 500
    MappyWindowY := 500
}
IniRead, IsLocked, %SettingsFile%, Settings, Locked
Gui, %GUINameMappy%:Show, x%MappyWindowX% y%MappyWindowY% NoActivate AutoSize 
if(IsLocked = "ERROR" || IsLocked = "false")
{
    IsLocked := false
    Gui, %GUINameMappy%:+Caption
    GuiControl, Text, Unlock, Lock Menu
}
else
{
    Gui, %GUINameMappy%:-Caption
    GuiControl, Text, Lock, Unlock
}
Gui, %GUINameMappy%:Show, x%MappyWindowX% y%MappyWindowY% AutoSize 
GUIMappyOpen := true
OnMessage(0x204, "WM_RBUTTONDOWN")
Return

WM_RBUTTONDOWN() {
    Gosub DeleteDynamicKeyword
}

DeleteDynamicKeyword:
GuiControlGet, var, Name, %A_GuiControl%

AmountOfNumbers := 0
Pos := 1

While Pos := RegExMatch(var, "(\d+)", Match, Pos + StrLen(Match)) {
	Variable%A_Index% := Match
    AmountOfNumbers += 1
}

tempCategoryCount = %Variable1%

if(AmountOfNumbers = 1)
{
    tempCategory := Categories[tempCategoryCount]
    MsgBox, 4, Delete Category, Do you want to delete the category %tempCategory%
    IfMsgBox, Yes
    {
        Categories.Remove(tempCategoryCount)
        Keywords.Remove(tempCategoryCount)
        SavedAmountOfCategories -= 1
        SavedAmountOfKeywords.Remove(tempCategoryCount)
        IniWrite, %SavedAmountOfCategories%, %A_ScriptDir%\Shadow%ConfigFileName%, AmountOfCategories, Key1
        currentRun = 1

        Loop % SavedAmountOfCategories
        {
            KeywordIndex = 1
            currentCategory := % Categories[A_Index]
            currentAmountOfKeywords := SavedAmountOfKeywords[currentRun]
            IniWrite, %currentCategory%, %A_ScriptDir%\Shadow%ConfigFileName%, Categories, Key%currentRun%
            IniWrite, %currentAmountOfKeywords%, %A_ScriptDir%\Shadow%ConfigFileName%, AmountOfKeywordsCategory%currentRun%, Key1
            
            Loop % SavedAmountOfKeywords[A_Index]
            {
                currentKeyword := Keywords[currentRun, KeywordIndex]
                IniWrite, "%currentKeyword%" , %A_ScriptDir%\Shadow%ConfigFileName%, Category%currentRun%, Key%KeywordIndex%
                KeywordIndex += 1
            }
            currentRun += 1
        }
        FileDelete, %ConfigFile%
        FileMove, %A_ScriptDir%\Shadow%ConfigFileName%, %ConfigFile%, 1
        Reload
    }
}

if(AmountOfNumbers = 2)
{
    tempKeywordCount = %Variable2%
    Keywords[tempCategoryCount].Remove(tempKeywordCount)
    SavedAmountOfKeywords[tempCategoryCount] -= 1

    IniWrite, %SavedAmountOfCategories%, %A_ScriptDir%\Shadow%ConfigFileName%, AmountOfCategories, Key1
    currentRun = 1

    Loop % SavedAmountOfCategories
    {
        KeywordIndex = 1
        currentCategory := % Categories[A_Index]
        currentAmountOfKeywords := SavedAmountOfKeywords[currentRun]
        IniWrite, %currentCategory%, %A_ScriptDir%\Shadow%ConfigFileName%, Categories, Key%currentRun%
        IniWrite, %currentAmountOfKeywords%, %A_ScriptDir%\Shadow%ConfigFileName%, AmountOfKeywordsCategory%currentRun%, Key1
        
        Loop % SavedAmountOfKeywords[A_Index]
        {
            currentKeyword := Keywords[currentRun, KeywordIndex]
            IniWrite, "%currentKeyword%" , %A_ScriptDir%\Shadow%ConfigFileName%, Category%currentRun%, Key%KeywordIndex%
            KeywordIndex += 1
        }
        currentRun += 1
    }
    FileDelete, %ConfigFile%
    FileMove, %A_ScriptDir%\Shadow%ConfigFileName%, %ConfigFile%, 1
    Reload
}
Return

RemoveDynamicCategory:
LastCategory = ButtonCategory%SavedAmountOfCategories%
GuiControlGet, tempCategory,, %LastCategory%
MsgBox, 4, Remove Category, Do you want to remove the last category (%tempCategory%) ? This will also delete all keywords in that category
IfMsgBox, Yes
{
    IniDelete, %ConfigFile%, Category%SavedAmountOfCategories%
    IniDelete, %ConfigFile%, AmountOfKeywordsCategory%SavedAmountOfCategories%
    IniDelete, %ConfigFile%, Categories, Key%SavedAmountOfCategories%
    SavedAmountOfCategories -= 1
    IniWrite, %SavedAmountOfCategories%, %ConfigFile%, AmountOfCategories, Key1
    Reload
}
Return

LoadConfig:
FileSelectFile, loadFile
if(loadFile = "")
{
    Return
}
IniWrite, %loadFile%, %SettingsFile%, Settings, ConfigPath
Reload
Return

Lock:
if (!IsLocked)
{
    Gui, %GUINameMappy%:-Caption
    GuiControl, Text, Lock, Unlock
    IniWrite, true, %SettingsFile%, Settings, Locked
}
else
{
    Gui, %GUINameMappy%:+Caption
    GuiControl, Text, Unlock, Lock Menu
    IniWrite, false, %SettingsFile%, Settings, Locked
}
IsLocked := !IsLocked
Gui, %GUINameMappy%:Show, AutoSize
Return

HideKeywords:
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
    GuiControl, %GUINameMappy%:Hide, ButtonAddDynamicKeyword%CategoryCount% 
    GuiControl, %GUINameMappy%:Hide, ButtonRemoveDynamicKeyword%CategoryCount% 
}
Return

ShowKeywords:
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
    GuiControl, %GUINameMappy%:Show, ButtonAddDynamicKeyword%CategoryCount%  
    GuiControl, %GUINameMappy%:Show, ButtonRemoveDynamicKeyword%CategoryCount%  
}
Gui, %GUINameMappy%:Show, AutoSize
Return

ToggleRegion:
if(!RegionOpen)
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
Gui, %GUINameConfig%: new, +AlwaysOnTop, Create Keywords
Gui, %GUINameConfig%:Add, Text, x10 y10, Amount of categories:
Gui, %GUINameConfig%:Add, Edit, vEditAmountOfCategories
Gui, %GUINameConfig%:Add, UpDown,, 1
Gui, %GUINameConfig%:Add, Button, x+5 vButtonSaveAmount gSaveAmount, Save amount
Gui, %GUINameConfig%:Add, Button, Disabled x+5 vButtonAddCategory gAddCategory, Add Category
Gui, %GUINameConfig%:Add, Button, Disabled x+5 vButtonSaveCategories gSaveCategories, Save Categories
Gui, %GUINameConfig%:Show

CategoryCount := 0
Loop % SavedAmountOfCategories
{
    CategoryCount += 1
    Keywords%CategoryCount% := 0
}
Return

ConfigHotkey:
Gui, %GUINameOverlayHotkey%: new, +AlwaysOnTop, Settings
Gui, %GUINameOverlayHotkey%:Add, Text, x10 y10, Overlay-Hotkey:
Gui, %GUINameOverlayHotkey%:Add, Hotkey, x+5 w135 vguihotkeyToggleOverlay , %ToggleOverlayHotkey%
Gui, %GUINameOverlayHotkey%:Add, Text, x10 y40, Transparency:
Gui, %GUINameOverlayHotkey%:Add, Slider, x+5 w150 vguihotkeyTransparency gTransparency Range30-255 TickInterval15, %Transparency%
Gui, %GUINameOverlayHotkey%:Add, Button, x10 y70 vButtonSaveToggleOverlayHotkey gSaveToggleOverlayHotkey, Save
Gui, %GUINameOverlayHotkey%:Show
Return

Transparency:
Gui, Submit, NoHide
WinSet, TransColor, %CustomColor% %guihotkeyTransparency%, %GUINameMappy%
Return

SaveAmount:
GuiControlGet, AmountOfCategories,, EditAmountOfCategories

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
GuiControl, Disable, EditAmountOfCategories
GuiControl, Enable, ButtonAddCategory
GuiControl, Enable, ButtonSaveCategories
Return

AddCategory:
AmountOfCategories += 1
CategoryCount += 1
MapCount += 1
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
        IniWrite, %CategoryNumber%, %A_ScriptDir%\Shadow%ConfigFileName%, Categories, Key%CategoryCount%
        GuiControl, %GUINameMappy%:Text, ButtonCategory%CategoryCount%, % CategoryNumber
    }

    if(AmountOfCategories < SavedAmountOfCategories)
    {
        Loop % SavedAmountOfCategories - AmountOfCategories
            {
                CategoryCount += 1
                GuiControl, %GUINameMappy%:Hide, ButtonCategory%CategoryCount%, % CategoryNumber
                IniDelete, %A_ScriptDir%\Shadow%ConfigFileName%, Categories, Key%CategoryCount%
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
        IniWrite, %CategoryNumber%, %A_ScriptDir%\Shadow%ConfigFileName%, Categories, Key%CategoryCount%
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
        IniWrite, %CategoryNumber%, %A_ScriptDir%\Shadow%ConfigFileName%, Categories, Key%CategoryCount%
    }
}

CategoryCount = 0
tempKey = 0
Loop % SavedAmountOfCategories
{
    CategoryCount += 1
    tempKey = 0
    IniDelete, %A_ScriptDir%\Shadow%ConfigFileName%, Category%CategoryCount%
    IniDelete, %A_ScriptDir%\Shadow%ConfigFileName%, AmountOfKeywordsCategory%CategoryCount%
    GuiControl, %GUINameMappy%:Hide, ButtonAddDynamicKeyword%CategoryCount%
    GuiControl, %GUINameMappy%:Hide, ButtonRemoveDynamicKeyword%CategoryCount%
    Loop % SavedAmountOfKeywords[A_Index]
    {
        tempKey += 1
        GuiControl, %GUINameMappy%:Hide, ButtonCategory%CategoryCount%Keyword%tempKey%
        GuiControl, %GUINameMappy%:Hide, ButtonSavedCategory%CategoryCount%Keyword%tempKey%
    }
}

CategoryCount = 0
Loop %AmountOfCategories%{
    CategoryCount += 1
    GuiControl, Disable, Category%CategoryCount%
}

IniWrite, %AmountOfCategories%, %A_ScriptDir%\Shadow%ConfigFileName%, AmountOfCategories, Key1
GuiControl, Disable, ButtonAddCategory
GuiControl, Disable, ButtonSaveCategories
GuiControl, %GUINameMappy%:Hide, ButtonAddDynamicCategoryConfig
GuiControl, %GUINameMappy%:Hide, ButtonRemoveDynamicCategory
Gui, %GUINameConfig%:Add, Button, x10 vButtonSaveKeywords gSaveKeywords, Save Overlay
Gui, %GUINameConfig%:Add, Button, x+5 vButtonSaveNewKeywords gSaveNewKeywords, Save As New Overlay
Gui, %GUINameConfig%:Show, AutoSize
Gui, %GUINameMappy%:Show, AutoSize NoActivate
Return

SaveNewKeywords:
FileSelectFile, newConfigPath, S16
If ErrorLevel{ ; "Cancel" button, close, or Escape
    FileDelete, %A_ScriptDir%\Shadow%ConfigFileName%
    Reload
    Return
}
FileDelete, %newConfigPath%
IniWrite, %newConfigPath%, %SettingsFile%, Settings, ConfigPath
FileMove, %A_ScriptDir%\Shadow%ConfigFileName%, %newConfigPath%, 1
Reload
Return

SaveKeywords:
FileDelete, %ConfigFile%
FileMove, %A_ScriptDir%\Shadow%ConfigFileName%, %ConfigFile%, 1
Reload
Return

AddKeyword:
Gui, Submit, NoHide

CategoryCount := RegExReplace(controlName, "\D")
Keywords%CategoryCount% += 1
KeyValue = % Keywords%CategoryCount%

if(!MapsAddedCategory%CategoryCount%){
    tempKey = % Keywords%CategoryCount%
    GuiControlGet, CategoryButton, %GUINameMappy%:Pos, ButtonCategory%CategoryCount%
    NextButtonX := NewButtonPosition(CategoryButtonX, CategoryButtonW, 5)
    NextButtonY = %CategoryButtonY%
    MapsAddedCategory%CategoryCount% := !MapsAddedCategory%CategoryCount%
}
else{
    Keywords%CategoryCount% -= 1
    tempKey = % Keywords%CategoryCount%
    GuiControlGet, Button2, %GUINameMappy%:Pos, ButtonCategory%CategoryCount%Keyword%tempKey%
    NextButtonX := NewButtonPosition(Button2X, Button2W, 5)
    NextButtonY = %Button2Y%
    Keywords%CategoryCount% += 1
    tempKey = % Keywords%CategoryCount%
}

GuiControlGet, ComboValue,, % Combo%CategoryCount%
IniWrite, "%ComboValue%", %A_ScriptDir%\Shadow%ConfigFileName%, Category%CategoryCount%, Key%KeyValue% 
IniWrite, %KeyValue%, %A_ScriptDir%\Shadow%ConfigFileName%, AmountOfKeywordsCategory%CategoryCount%, Key1 
Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vButtonCategory%CategoryCount%Keyword%tempKey% gSearchKeyword, % Combo%CategoryCount%
Gui, %GUINameMappy%:Show, AutoSize NoActivate
Return

SearchKeyword:
if WinExist("Path of Exile"){
    GuiControlGet, var,, % A_GuiControl
    WinActivate, Path of Exile
    Send ^f
    SendRaw % var
    Send {Enter}
}
Return

ShowHideKeywords:
CategoryCount := RegExReplace(controlName, "\D")

if(!KeywordsHidden%CategoryCount%)
{
    GuiControl, %GUINameMappy%:Hide, ButtonAddDynamicKeyword%CategoryCount%
    GuiControl, %GUINameMappy%:Hide, ButtonRemoveDynamicKeyword%CategoryCount%
}
else if(KeywordsHidden%CategoryCount%)
{
    GuiControl, %GUINameMappy%:Show, ButtonAddDynamicKeyword%CategoryCount%
    GuiControl, %GUINameMappy%:Show, ButtonRemoveDynamicKeyword%CategoryCount%
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
Gui, %GUINameMappy%:Show, AutoSize
Return

ConfigGuiClose:
FileDelete, Shadow%ConfigFileName%
Reload
Return

SaveToggleOverlayHotkey:
Gui, Submit, NoHide
if(guihotkeyToggleOverlay = "" || guihotkeyToggleOverlay = "ERROR"){
    MsgBox, Hotkey not recognized, please choose another one
    Return
}
IniWrite, %guihotkeyToggleOverlay% , %SettingsFile%, Settings, ToggleKey
Hotkey, %ToggleOverlayHotkey%, ToggleOverlay, Off
ToggleOverlayHotkey = %guihotkeyToggleOverlay%
Hotkey, %ToggleOverlayHotkey%, ToggleOverlay, On
IniWrite, %guihotkeyTransparency% , %SettingsFile%, Settings, Transparency
Gui, Destroy
Reload
Return
    
ToggleOverlay:
if (GUIMappyOpen)
    Gui, %GUINameMappy%:Hide
else
    Gui, %GUINameMappy%:Show
GUIMappyOpen := !GUIMappyOpen
Return

AddDynamicKeywordConfig:
Gui, %GUINameAddKeyword%: new, +AlwaysOnTop, Add Keyword
Gui, %GUINameAddKeyword%:Add, Text, x10 y10, New Keyword:
Gui, %GUINameAddKeyword%:Add, Edit, w150 h20 vEditNewKeyword
Gui, %GUINameAddKeyword%:Add, Button, x+5 vButtonAddNewKeyword gAddDynamicKeyword, Add new keyword
Gui, %GUINameAddKeyword%:Show
Return

AddDynamicCategoryConfig:
Gui, %GUINameAddCategory%: new, +AlwaysOnTop, Add Category
Gui, %GUINameAddCategory%:Add, Text, x10 y10, New Category:
Gui, %GUINameAddCategory%:Add, Edit, w150 h20 vEditNewCategory
Gui, %GUINameAddCategory%:Add, Button, x+5 vButtonAddNewCategory gAddDynamicCategory, Add new category
Gui, %GUINameAddCategory%:Show
Return

AddDynamicKeyword:
Gui, Submit, NoHide

CategoryCount := RegExReplace(controlName, "\D")
if(SavedAmountOfKeywords[CategoryCount] = "ERROR" || SavedAmountOfKeywords[CategoryCount] == ""){
    Keywords%CategoryCount% := 0
    SavedAmountOfKeywords[CategoryCount] := 0
}
else{
    Keywords%CategoryCount% := SavedAmountOfKeywords[CategoryCount]
}
SavedAmountOfKeywords[CategoryCount] += 1
Keywords%CategoryCount% += 1
KeyValue = % Keywords%CategoryCount%

if(!SavedMapsAddedCategory%CategoryCount%){
    tempKey = % Keywords%CategoryCount%
    GuiControlGet, CategoryButton, %GUINameMappy%:Pos, ButtonCategory%CategoryCount%
    NextButtonX := NewButtonPosition(CategoryButtonX, CategoryButtonW, 5)
    NextButtonY = %CategoryButtonY%
    SavedMapsAddedCategory%CategoryCount% := !SavedMapsAddedCategory%CategoryCount%
}
else{
    Keywords%CategoryCount% -= 1
    tempKey = % Keywords%CategoryCount%
    GuiControlGet, Button2, %GUINameMappy%:Pos, ButtonSavedCategory%CategoryCount%Keyword%tempKey%
    NextButtonX := NewButtonPosition(Button2X, Button2W, 5)
    NextButtonY = %Button2Y%
    Keywords%CategoryCount% += 1
    tempKey = % Keywords%CategoryCount%
}

GuiControlGet, NewKeyword,, %EditNewKeyword%
Keywords[CategoryCount, Keywords%CategoryCount%] := NewKeyword
IniWrite, "%NewKeyword%", %ConfigFile%, Category%CategoryCount%, Key%KeyValue%
IniWrite, %KeyValue%, %ConfigFile%, AmountOfKeywordsCategory%CategoryCount%, Key1
Gui, %GUINameMappy%:Add, Button, x%NextButtonX% y%NextButtonY% vButtonSavedCategory%CategoryCount%Keyword%tempKey% gSearchKeyword, %NewKeyword%
GuiControlGet, Button3, %GUINameMappy%:Pos, ButtonSavedCategory%CategoryCount%Keyword%tempKey%
NextButtonX := NewButtonPosition(Button3X, Button3W, 5)
NextButtonY = %Button3Y%
GuiControl, %GUINameMappy%:Move, ButtonAddDynamicKeyword%CategoryCount%, x%NextButtonX% y%NextButtonY% w20 h%Button3H%
GuiControlGet, Button3, %GUINameMappy%:Pos, ButtonAddDynamicKeyword%CategoryCount%
NextButtonX := NewButtonPosition(Button3X, Button3W, 5)
NextButtonY = %Button3Y%
GuiControl, %GUINameMappy%:Move, ButtonRemoveDynamicKeyword%CategoryCount%, x%NextButtonX% y%NextButtonY% w20 h%Button3H%
Gui, %GUINameMappy%:Show, AutoSize
Return

AddDynamicCategory:
Gui, Submit, NoHide
CategoryCount := SavedAmountOfCategories
CategoryCount += 1
GuiControlGet, NewCategory,, %EditNewCategory%
Gui, %GUINameMappy%:Add, Button, x10 vButtonCategory%CategoryCount% gGetButtonCategoryPressed, %NewCategory%
Gui, %GUINameMappy%:Add, Button, x+5 vButtonAddDynamicKeyword%CategoryCount% gGetButtonAddKeywordPressed, +
Gui, %GUINameMappy%:Add, Button, x+5 vButtonRemoveDynamicKeyword%CategoryCount% gGetButtonRemoveKeywordPressed, -
if(SavedAmountOfCategories = 0)
{
    GuiControl, %GUINameMappy%:Show, ButtonRemoveDynamicCategory
    GuiControlGet, FirstAddButton, %GUINameMappy%:Pos, ButtonAddDynamicCategoryConfig
    GuiControl, %GUINameMappy%:Move, ButtonCategory%CategoryCount%, x%FirstAddButtonX% y%FirstAddButtonY%
    NextButtonY := NewButtonPosition(FirstAddButtonY, FirstAddButtonH, 5)
    GuiControl, %GUINameMappy%:Move, ButtonAddDynamicCategoryConfig, x%FirstAddButtonX% y%NextButtonY%
    GuiControlGet, FirstAddButtonAfter, %GUINameMappy%:Pos, ButtonAddDynamicCategoryConfig
    NextButtonX := NewButtonPosition(FirstAddButtonAfterX, FirstAddButtonAfterW, 5)
    GuiControl, %GUINameMappy%:Move, ButtonRemoveDynamicCategory, x%NextButtonX% y%NextButtonY%
    GuiControlGet, FirstCategoryButton, %GUINameMappy%:Pos, ButtonCategory%CategoryCount%
    NextButtonX := NewButtonPosition(FirstCategoryButtonX, FirstCategoryButtonW, 5)
    NextButtonY = %FirstAddButtonY%
    GuiControl, %GUINameMappy%:Move, ButtonAddDynamicKeyword%CategoryCount%, x%NextButtonX% y%NextButtonY%
    GuiControlGet, AddButton, %GUINameMappy%:Pos, ButtonAddDynamicKeyword%CategoryCount%
    NextButtonX := NewButtonPosition(AddButtonX, AddButtonW, 5)
    NextButtonY = %AddButtonY%
    GuiControl, %GUINameMappy%:Move, ButtonRemoveDynamicKeyword%CategoryCount%, x%NextButtonX% y%NextButtonY%
    Gui, %GUINameMappy%:Show, AutoSize

}
else
{
    CategoryCount -= 1
    GuiControlGet, CategoryButton, %GUINameMappy%:Pos, ButtonCategory%CategoryCount%
    CategoryCount += 1
    NextButtonX = %CategoryButtonX%
    NextButtonY := NewButtonPosition(CategoryButtonY, CategoryButtonH, 5)
    GuiControl, %GUINameMappy%:Move, ButtonCategory%CategoryCount%, x%NextButtonX% y%NextButtonY% h%CategoryButtonH%
    GuiControlGet, CategoryButtonNew, %GUINameMappy%:Pos, ButtonCategory%CategoryCount%
    NextButtonX = %CategoryButtonNewX%
    NextButtonY := NewButtonPosition(CategoryButtonNewY, CategoryButtonNewH, 5)
    GuiControl, %GUINameMappy%:Move, ButtonAddDynamicCategoryConfig, x%NextButtonX% y%NextButtonY% h%CategoryButtonH%
    GuiControlGet, AddAfter, %GUINameMappy%:Pos, ButtonAddDynamicCategoryConfig
    RemovePosition := NewButtonPosition(AddAfterX, AddAfterW, 5)
    GuiControl, %GUINameMappy%:Move, ButtonRemoveDynamicCategory, x%RemovePosition% y%NextButtonY% h%CategoryButtonH%
    NextButtonX := NewButtonPosition(CategoryButtonNewX, CategoryButtonNewW, 5)
    NextButtonY = %CategoryButtonNewY%
    GuiControl, %GUINameMappy%:Move, ButtonAddDynamicKeyword%CategoryCount%, x%NextButtonX% y%NextButtonY%
    GuiControlGet, AddButton, %GUINameMappy%:Pos, ButtonAddDynamicKeyword%CategoryCount%
    NextButtonX := NewButtonPosition(AddButtonX, AddButtonW, 5)
    NextButtonY = %AddButtonY%
    GuiControl, %GUINameMappy%:Move, ButtonRemoveDynamicKeyword%CategoryCount%, x%NextButtonX% y%NextButtonY%
}
Categories[CategoryCount] := NewCategory
SavedAmountOfCategories += 1
IniWrite, %SavedAmountOfCategories%, %ConfigFile%, AmountOfCategories, Key1
IniWrite, %NewCategory%, %ConfigFile%, Categories, Key%CategoryCount%
Gui, %GUINameMappy%:Show, AutoSize
Return

RemoveDynamicKeyword:
CategoryCount := RegExReplace(controlName, "\D")
KeyToDelete := SavedAmountOfKeywords[CategoryCount]
If(KeyToDelete = "" || KeyToDelete = 0)
{
    Return
}
If(KeyToDelete = 1)
{
    IniDelete, %ConfigFile%, Category%CategoryCount%
    IniDelete, %ConfigFile%, AmountOfKeywordsCategory%CategoryCount%
    Reload
    Return
}
IniDelete, %ConfigFile%, Category%CategoryCount%, Key%KeyToDelete%
KeyToDelete -= 1
IniWrite, %KeyToDelete%, %ConfigFile%, AmountOfKeywordsCategory%CategoryCount%, Key1
Reload
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

GetButtonAddKeywordPressed(CtrlHwnd:=0)
{
    global controlName
    GuiControlGet, controlName, Name, %CtrlHwnd%
    gosub AddDynamicKeywordConfig
}

GetButtonRemoveKeywordPressed(CtrlHwnd:=0)
{
    global controlName
    GuiControlGet, controlName, Name, %CtrlHwnd%
    gosub RemoveDynamicKeyword
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

NewButtonPosition(x,y,z)
{
    return x + y + z
}

SaveWindowPosition:
if(GUIMappyOpen)
{
    WinGetPos, MappyWindowX, MappyWindowY,,, %GUINameMappy% - Version %CurrentVersion% - %ConfigFileName%
    IniWrite, %MappyWindowX%, %SettingsFile%, Settings, MappyPositionX
    IniWrite, %MappyWindowY%, %SettingsFile%, Settings, MappyPositionY
}
ExitApp

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
