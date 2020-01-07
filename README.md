# Mappy

Mappy is an ahk (autohotkey) script to manage your maps and/or inventory. It was made with the intend to only search for maps in your stash but after playing around for a while I noticed it also works as a search tool for (almost) everything. (I.e. looking for Bone Helmet or ilvl84 items or Conqueror items etc.)

![Image of Mappy] (images/Mappy.png)

# Demo Video

I will record a "tutorial" in the upcoming days, explaining how to navigate and use the tool, especially in its unfinished state. If you want to use it already, check out the "How to use Mappy" section or the video on reddit here: 

# What can Mappy do?

Mappy can:
- Show & Hide all 8 region names for you to search in your stash. One click on any region will show all the maps in that region
- Save up to 5 categories for you to put keywords in
- "Save" all your most used / favourite keywords (I.e. Any lategame base you would search or influence-items, good maps and whatever you are typing in your stash to search for.

# What can Mappy not do (yet)?
This is more a list of things that aren't working / implemented yet. Check out future versions of Mappy to see if any of these were added!

Mappy can't:
- Dynamically add / remove categories & keywords. Once you've set up your environment, it's done and can't be changed unless you reload the script
- Show & Hide keywords. They will always be visible in the Mappy-Window for now
- Save your complete state. This is probably the biggest minus for now. Once you close the script, all configuration will be lost. So you basically have to set up your Mappy every day. (I really hope this can get implemented easily so I can add this as fast as possible since this is probably the biggest disappointment for now)


# How to use Mappy
Quick Answer: Check out the reddit post linked above and watch the video to figure out how to use the tool. Play around with it and you will figure out how to use it after a couple of tries.

Long answer: Managing Mappy looks, feels and is just rough at this stage of the tool. So don't use it if you prefer polished tools. But if you are willing to use it, following these steps to setup your own (sowewhat working) inventory manager:

Step 1: Startup Mappy.ahk - You will see the following window (That will be your main management window)
![Image of Mappy at startup] (images/Mappy_Startup.png)

Step 2: Click on "Config" to set your environment up - A new window will open which looks like this
![Image of Config at startup] (images/Config_Startup.png)

Step 3: Choose the amount of categories (From 1 to 5) you want to use and save it with the "Save amount"-button (Anything higher or lower will result in errors/not working areas. This will get patched in later versions)

(Optional) Step 3.1: Want to add more categories? Click "Add Category" and choose a name (No more than 5 categories!)

Step 4: Your input fields for categories will open below. Choose any name for the category you want.  (I.e. "Good Maps", "Conqueror Items", "Elder/Shaper Items", "Lategame Bases")
![Image of Category amount] (images/Config_ChooseCategory.png)

Step 5: If you are done, click "Save Categories" to lock them in. (They can't be changed in the current version.) New options will pop up next to your categories and the categories will be put into your "Mappy"-Window
![Image of Category + Keyword options] (images/Mappy_CategoriesChosen.png)

Step 6: You can either choose any name for your search-criteria you want or choose a map from the drop-down-list. Inputting the Map name yourself will also work. Any word will work but keep it "searchable" for your map stash, otherwise it will be a useless button. After inputting your word click "Add" to add it to the Mappy-Window. (Very important: Don't choose any word twice. It will mess up the layout in the Mappy-Window)

Step 7: Once you are done with your categories and search-words, close the Config-Window. (It can't be accessed at any point later on, so set up your environment wisely. Will be patched in later versions)

Step 8: Choose a place for your Mappy-Window and lock it with the "Lock Menu"-button. You can unlock and move it anywhere else if your place of choice doesn't please you. 

Step 9: Your Mappy is set up and you can start using it. Check out the "What can Mappy do" section to find more additional features.
![Image of Mappy done] (images/Mappy_Final.png)

(Optional) Step 10: Done with searching for items? Hide Mappy with Ctrl+Numpad0

(Optional) Step 11: Messed anything up or forgot something very important? Click "Reload Script" in the Mappy-Window to load the script from 0 again. You will have to set up your environment again.
