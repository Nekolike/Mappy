# Mappy

Download here: [Mappy](https://github.com/Nekolike/Mappy/releases/tag/v1.0)

Mappy is an ahk (autohotkey) script to ease your inventory searches. It allows you to save all the things you search for in your stash or at vendors every day. It simply replaces typing with clicking on buttons.

![Image of Mappy](images/Mappy.PNG)

# Video showcase

I recorded a showcase/tutorial to guide through the tool. You can check the video out here: [Youtube - Mappy](https://www.youtube.com/watch?v=d_Me_jUMZgk)

# Updates

Check the Changelog.txt for a full list of updates. This place only contains informations about the current progress I'd like to share

**Update 19.01.2020**

Version 1.0 is out. Removing is here, saving & loading is here. I am happy with the result and hope people can find use in the tool. I also recorded and uploaded a new version to show Mappy in its 1.0 state. Hope everyone is having a wonderful weekend :)


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

Using the overlay is fairly simple. Starting Mappy for the first time will pop up a window with one line of buttons and a "+" button below. (I will call this process Method 1)
- Clicking that + button will add a new category. Categories are like folders, they contain all your keywords. 
- Keywords are the words you'd type in your input field in Path of Exile. 
- Having your first category added allows you to add keywords to that category (Via a "+" button again. The one on the right to your category). With your first category & keyword done, Mappy can go to work. 
- Clicking on your keyword will send the text to Path of Exile (Your stash or vendor menu needs to be open). 
- Repeat this process of adding categories & keywords until you have everything set up. You can now use Mappy everyday instead of typing anything in your stash anymore!
- If you don't need a category or keyword anymore, either hit the "-" button to remove the last item or right-click on a button to remove it

Method 2 (Creating a new overlay via the config-gui. Allows for saving the overlay as a new file)
- Click on "New Overlay" to open a new window which guides you through the process of adding categories & keywords
- Choose the amount of categories you want and same it
- Name your categories and hit "Save Categories"
- You can now add keywords to your categories (The field contains a drop-down-list with all maps if these are what you'd like to add)
- Done with your categories & keywords? You can either choose "Save Overlay" to overwrite your current one or choose "Save As New Overlay" to create a new file (filename must end with ".ini")

Loading Overlays
- You can also load overlays (either from yourself or other people if they share their .ini.
- Simply select "Load Overlay" and select the file you'd like to load. Done


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

