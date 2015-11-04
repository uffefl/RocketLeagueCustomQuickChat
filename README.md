# Rocket League Custom Quick Chats

This project contains a small [AutoHotkey](www.autohotkey.com) script that enables additional "quick chat" functionality while playing Rocket League.

Requirements:

* Download and install [AutoHotkey](http://ahkscript.org/download/ahk-install.exe)

* Put the `AutoHotkey.ahk` file somewhere you can find it again. For example in the root of `My Documents`.

* Run the script by double-clicking it.

Look towards the bottom of the `AutoHotkey.ahk` file for the actual texts that are output. Add new things by copy/pasting existing lines, remove those you don't like by deleting lines (or putting a semi-colon in front of them). Customize the buttons bound by looking at the very last part with the `Mapping[...]` lines. It should be fairly self-explanatory.

If you want this file to always run when you start AutoHotkey, you can put it in `My Documents\AutoHotkey.ahk`. The script will stay running with an H-icon in the system tray; right click  that to stop or force a reload. (However this script reloads itself when it detects it has been modified, so reloading manually shouldn't be necessary.)

Here's how it works:

* You run the AutoHotkey script.

* It will then listen to your controllers LB, RB and D-PAD actions. (PS4 controllers: LB=L1 and RB=R1.)

* Only when Rocket League is active it will then try to fire off a custom chat when you either "press and hold RB and a direction on the D-PAD" or when you "press and hold both LB and RB and then a direction on the D-PAD".

* That gives 8 possible binds. Each can be configured to either be team channel or public. I've put my often used ones on RB+Direction (those I want to be able to fire off at a moments notice) and the more seldomly used ones on LB+RB+Direction (like gg which I only use after the match is over). It'd be very easy to inlude LB+Direction for another 4 binds, but I haven't found a use for that yet.

* It's easy to change which buttons it listens to. My configuration assumes that the scoreboard has been moved from RB, since that interferes with normal chat operations, but if you don't want to move it I suggest using another button than RB.

* For each of the 8 bindings there's a section in the bottom of the script with the actual texts used. They're easy to modify and extend. Some, like "gl hf" or "gg", always use mostly the same text, while others pick randomly from a long list.

* When you edit the script it will automatically reload itself when you save it.

Here's how it doesn't work:

* It just simulates keypresses to use the normal chat, so you still can't talk to PS4 players.

* It assumes you're playing, and not using the menus. If you're using the menus, or in the post-game scoreboard screen, I guess weird shit can happen.

* It has manual timings for delay after pressing T or Y before typing in, since the chat box doesn't pop instantly. This works flawlessly on my machine, but I guess it might need tweaking; especially if you've got less than 60 fps.

* If you play using keyboard/mouse it will probably not be very useful.

* It probably only works with one controller connected to your system. I will eventually get around to adding support for any number of controllers, but I haven't gotten there yet.

* It doesn't prevent the controller buttons from passing through to the game at all; so when I press "RB+Up" to fire off my "gl hf" emote the "Up" still registers in Rocket League and opens the in-game quick chat on the team commands menu. This is mostly a feature (and I don't think anything can be done about it, other than not use the D-PAD) since the first quick chat I send in a game is usually either "[Team] I got it!", "[Team] Defending!" or "[Team] Take the shot!" so it works out pretty well.
