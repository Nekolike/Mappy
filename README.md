# Mappy

Download here: [Mappy](https://github.com/Nekolike/Mappy/releases/tag/v1.0)

Mappy is an ahk (autohotkey) script to ease your inventory searches. It allows you to save all the things you search for in your stash or at vendors every day. It simply replaces typing with clicking on buttons.

![Image of Mappy](images/Mappy.PNG)

# Video showcase

I recorded a showcase/tutorial to guide through the tool. The version of Mappy in this video is <1.0, so it's missing some features. A new video will be uploaded in the next days. You can check the video out here: [Youtube - Mappy](https://www.youtube.com/watch?v=JkStW1uJr7A)

# Updates

Check the Changelog.txt for a full list of updates. This place only contains informations about the current progress I'd like to share

**Update 20.01.2020**

Version 1.0 is out. Removing is here, saving & loading is here. I am happy with the result and hope people can find use in the tool. Hope everyone is having a wonderful weekend :)


# What can Mappy do?

Mappy can:
- Save as many categories as you like to put keywords in
- Save all your most used keywords (I.e. Any lategame base you would search or influence-items, good maps and whatever you are typing in your stash to search for) Setting it up once will create a save-file which then gets reloaded everytime you startup the script so you never have to retype these things again)
- Remove any category or keyword you like with right-clicking on the button.
- Remove the last keyword in a category via the "-" button at the end of the category
- Remove the last category via the "-" button at the end of the categories
- Show & Hide keywords. You can either show / hide all keywords in any single category or just show / hide every keyword
- Show & Hide all 8 region names for you to search in your stash. One click on any region will show all the maps in that region (If you are at your stash with the currently tab containing maps)
- Save multiple layouts. You can create a new overlay with the "New Overlay" button and save your overlay as a new one at the end via the "Save As New Overlay". The filename needs to end with ".ini"
- Load any overlay. Click "Load Overlay" and choose a "*.ini" file to load. This works with any .ini that was created via Mappy. Allows for sharing overlays

# What can Mappy not do (yet)?
This is more a list of things that aren't working / implemented yet. Check out future versions of Mappy to see if any of these were added!

- Adding information to regions like influence or watch stones. Might be coming in the next couple of updates but it's not on my high-priority list

# How to use Mappy (Version 1.0)

I will update this section with pictures in upcoming days. Sorry for the inconvenience.

The first time you start Mappy, a fairly empty window with the title "Mappy - Version 1.00 - Config.ini" will open. You can either create your overlay via the "+" buttons at the bottom or the "New Overlay"-button. Choosing the later will open a config-window where you can select how many categories you want to add, their names and their keywords. You can either save your overlay in the "Config.ini" or create a new save file via the "Save As New Overlay"-button. (The filename must end with ".ini"!) Adding categories & keywords dynamically works with the "+" buttons. The one at the end of your categories (bottom one) will add a new category. There's also a "+" button at the end of each category to add a new keyword for that category. If you want to remove any category or keyword, right click on it. Keywords will be removed immediately, categories will open a message box to know if you really want to delete the category with all the keywords in them. Once you've set up your overlay, a press on any keyword will send the text to Path of Exile (Have your stash open in order for the button to be used as a search-word-button). A press on any category will show/hide all keywords in that category. You can also load another overlay via the "Load Overlay"-button. Done with Mappy? Minimize the window via Ctrl+Numpad0 or change the hotkey to whatever you want with the "Change Toggle-Key"-button.


# How to use Mappy (Outdated < Version 1.0)
A video on how to use Mappy can be found in the "Demo Video" section above. I have also written down the needed steps to use and set up your Mappy below:

Step 1: Startup Mappy.ahk - You will see the following window (That will be your main management window)
![Image of Mappy at startup](images/Mappy_Startup.PNG)

Step 2: Click on "Config" to set your environment up - A new window will open which looks like this
![Image of Config at startup](images/Config_Startup.PNG)

Step 3: Choose the amount of categories you want to use and save it with the "Save amount"-button

(Optional) Step 3.1: Want to add more categories? Click "Add Category" and choose a name

Step 4: Your input fields for categories will open below. Choose any name for the category you want.  (I.e. "Good Maps", "Conqueror Items", "Elder/Shaper Items", "Lategame Bases", Gems for new chars)

![Image of Category amount](images/Config_ChooseCategory.PNG)

Step 5: If you are done, click "Save Categories" to lock them in. (They can't be changed in the current version.) New options will pop up next to your categories and the categories will be put into your "Mappy"-Window

![Image of Category + Keyword options](images/Mappy_CategoriesChosen.PNG)

Step 6: You can either choose any name for your search-criteria you want or choose a map from the drop-down-list. Inputting the Map name yourself will also work. Any word will work but keep it "searchable" for your map stash, otherwise it will be a useless button. After inputting your word click "Add" to add it to the Mappy-Window.

Step 7: Once you are done with your categories and search-words, close the Config-Window or press "Save Keywords" to save your overlay. The "Mappy"-Window will shortly reload.

Step 8: Choose a place for your Mappy-Window and lock it with the "Lock Menu"-button. (You have to lock it in order for your buttons to work!) You can unlock and move it anywhere else if your place of choice doesn't please you. 

Step 9: Your Mappy is set up and you can start using it. Check out the "What can Mappy do" section to find more additional features.

![Image of Mappy done](images/Mappy_Final.PNG)

(Optional) Step 10: Done with searching for items? Hide Mappy with Ctrl+Numpad0 (Or change the hotkey via the "Change Toggle-Key" option!

