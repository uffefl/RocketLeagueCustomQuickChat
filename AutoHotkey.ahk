; Rocket League Custom Quick Chats
;
; This file contains a small AutoHotkey (www.autohotkey.com) script that
; enables additional "quick chat" functionality while playing Rocket
; League.
;
; Look towards the bottom of this file for the actual texts that are
; output. Add new things by copy/pasting existing lines, remove those you
; don't like by deleting lines (or putting a semi-colon in front of
; them). Customize the buttons bound by looking at the very last part
; with the Mapping[...] lines. It should be fairly self-explanatory.
;
; If you want this file to always run when you start AutoHotkey, you can
; put it in My Documents\AutoHotkey.ahk. The script will stay running
; with an H-icon in the system tray; right click that to stop or force a
; reload. (However this script reloads itself when it detects it has
; been modified, so reloading manually shouldn't be necessary.)

#SingleInstance force
#Persistent

SetTimer,UPDATEDSCRIPT,1000

SetTimer, Watch, 5
return

UPDATEDSCRIPT:
	FileGetAttrib,attribs,%A_ScriptFullPath%
	IfInString,attribs,A
	{
		FileSetAttrib,-A,%A_ScriptFullPath%
		SplashTextOn,,,Updated script,
		Sleep,500
		Reload
	}
	Return

Watch:
if (WinActive("ahk_exe RocketLeague.exe"))
{
	WatchPOV()
	WatchLB()
	WatchRB()
	if (PovTime < LBTime or PovTime < RBTime)
		return
	Trigger := LBHeld . RBHeld . PovHeld
	if (Mapping[Trigger])
	{
		SayRandom(Mapping[Trigger], Team[Trigger])
		PovTime := RBTime - 1
	}
}

WatchPOV()
{
	global PovHeld, PovTime
	GetKeyState, POV, JoyPOV
	if POV < 0
		Held := ""
	else if POV between 4501 and 13500 ; 45 to 135 degrees: Right
		Held := "Right"
	else if POV between 13501 and 22500 ; 135 to 225 degrees: Down
		Held := "Down"
	else if POV between 22501 and 31500 ; 225 to 315 degrees: Left
		Held := "Left"
	else
		Held := "Up"
	if (Held <> PovHeld)
	{
		PovHeld := Held
		PovTime := A_TickCount
	}
}

WatchLB()
{
	global LBHeld, LBTime
	if GetKeyState("Joy5")
		Held := "LB+"
	else
		Held := ""
	if (Held <> LBHeld)
	{
		LBHeld := Held
		LBTime := A_TickCount
	}
}

WatchRB()
{
	global RBHeld, RBTime
	if GetKeyState("Joy6")
		Held := "RB+"
	else
		Held := ""
	if (Held <> RBHeld)
	{
		RBHeld := Held
		RBTime := A_TickCount
	}
}

Say(s, t = False)
{
	ch := t ? "y" : "t"
	SendInput, %ch%
	Sleep, 200
	count := 0
	batch := 20
	Loop
	{
		if (s=="")
		{
			SendInput, {Enter}
			return
		}
		i := RegExMatch(s, " ", "", batch)
		if (i<1)
		{
			i := batch
		}
		sub := RegExReplace(SubStr(s, 1, i), "([!#+^{}])", "{$1}")
		s := SubStr(s, i+1)
		count := count+i
		SendInput, %sub%
		if (count>100)
		{
			SendInput, {Enter}
			count := 0
			Sleep, 200
			SendInput, %ch%
			Sleep, 200
		}
		else
		{
			Sleep, 100
		}
	}
}

SayRandom(a, t = False)
{
	Random, r, a._MinIndex(), a._MaxIndex()
	Say(a[r], t)
}

; Text list definitions
;
; You can add or modify directly in the existing text lists below here,
; by simply copy/pasting. Or you can create a new list by following the
; same pattern. (But then you do need to visit the last section and make
; sure the list is bound to some buttons!)

; [Team] Teamwork compliment! (LB+RB+Up)
TeamworkCompliment := Object()
TeamworkCompliment.Insert("Nice team work! Add me if you want! SteamID: <put steam-id here>")

; GG (LB+RB+Right)
GoodGame := Object()
GoodGame.Insert("gg")
GoodGame.Insert("GG")
GoodGame.Insert("Gg")
GoodGame.Insert("Good game!")

; Weird (LB+RB+Left)
Weird := Object()
Weird.Insert("")

; Retort (LB+RB+Down)
Retort := Object()
Retort.Insert("Ball chasers do not get to complain!")
Retort.Insert("I, too, like to invent excuses and disregard my own shortcomings!")
Retort.Insert("You don't have to be right to voice your opinion. But it helps!")
Retort.Insert("Are you chasing the ball? Or just driving away from your mistakes?")
Retort.Insert("Do you like cheese too?")
Retort.Insert("Is that red or white whine?")
Retort.Insert("Complain is: a top-level Rocket League team. Complain is not: something you're allowed to do.")
Retort.Insert("Congratulations! You're wrong AND an asshole.")
Retort.Insert("I will not argue with an idiot. You will just drag me down to your level and beat me with experience.")
Retort.Insert("If I agreed with you we'd both be wrong.")
Retort.Insert("You'd be better off remaining silent and thought a fool, than to speak and remove all doubt.")
Retort.Insert("Your clear conscience is probably a symptom of poor memory.")
Retort.Insert("Evolution must favor stupid people. It made SO many.")
Retort.Insert("Remember to laugh at your problems... everybody else does.")
Retort.Insert("He who smiles in a crisis has found someone to blame.")
Retort.Insert("Always take life with a grain of salt... plus a slice of lemon... and a shot of tequila.")
Retort.Insert("You're never too old to learn something stupid.")
Retort.Insert("Jesus loves you, but everyone else thinks you're an asshole.")
Retort.Insert("You clearly don't suffer from insanity. You seem to be enjoying every minute of it!")
Retort.Insert("Experience is what you get when you didn't get what you wanted.")
Retort.Insert("Well aren't you a waste of two billion years of evolution.")
Retort.Insert("The right to be heard does not automatically include the right to be taken seriously.")
Retort.Insert("The probability of someone watching you is proportional to the stupidity of your actions.")
Retort.Insert("Impotence: Nature's way of saying ""No hard feelings"".")
Retort.Insert("To err is human. To blame it on somebody else shows management potential.")
Retort.Insert("See, the problem is that you've got a brain and a penis, and only enough blood to run one at a time.")
Retort.Insert("100,000 sperm and you were the fastest?")
Retort.Insert("For every action, there is a corresponding over-reaction.")
Retort.Insert("Who lit the fuse on your tampon?")
Retort.Insert("Wise people think all they say. Fools say all they think.")
Retort.Insert("It's so simple to be wise. Just think of something stupid to say and then don't say it.")
Retort.Insert("Anyone who has never made a mistake has never tried anything new.")
Retort.Insert("Failure is not falling down; it is not getting up again.")
Retort.Insert("Thanks for giving us the opportunity to learn from your mistakes!")
Retort.Insert("You are depriving some poor village of its idiot.")
Retort.Insert("Discretion is being able to raise your eyebrow instead of your voice.")
Retort.Insert("Be careful of your thoughts. They may become words at any moment.")
Retort.Insert("Your gene pool could use a little chlorine.")
Retort.Insert("Don't hate me because I'm such a handsome man. Hate me because your boyfriend thinks so.")
Retort.Insert("Everyone has the right to be stupid, but you are abusing the privilege!")
Retort.Insert("Insanity is doing the same thing over and over again, expecting different results.")
Retort.Insert("Think of how stupid the average person is. Then realize that half of them are stupider than that. And then there's you...")
Retort.Insert("If you're going to ride my ass at least pull my hair and make me scream!")
Retort.Insert("Genius! Why have nobody thought of that before?")
Retort.Insert("I'm old enough to be your father, and wise enough that I wasn't.")
Retort.Insert("Yawn... Say something original.")
Retort.Insert("Most people who shit talk in games are bad players and don't know what they are doing.")
Retort.Insert("Pot, meet kettle. Thine color is black.")
Retort.Insert("Why do you see the speck that is in your brother's eye, but do not notice the log that is in your own?")
Retort.Insert("Stop fucking swearing!")

; Back to the Future quotes (currently unbound)
BackToTheFuture := Object()
BackToTheFuture.Insert("Time circuit's on. Flux capacitor, fluxing. Engine running. All right.")
BackToTheFuture.Insert("If my calculations are correct, when this baby hits 88 miles per hour... you're gonna see some serious shit.")
BackToTheFuture.Insert("Where we're going, we don't need roads.")
BackToTheFuture.Insert("If you put your mind to it, you can accomplish anything.")
BackToTheFuture.Insert("I'm your density.")
BackToTheFuture.Insert("Silence, Earthling. My name is Darth Vader. I am an extraterrestrial from the planet Vulcan!")
BackToTheFuture.Insert("Why don't you make like a tree and get outta here?")
BackToTheFuture.Insert("I guess you guys aren't ready for that yet. But your kids are gonna love it.")
BackToTheFuture.Insert("Great Scott!")
BackToTheFuture.Insert("Whoa! Rock 'n' Roll.")
BackToTheFuture.Insert("This is heavy.")

; Random insults (currently unbound)
RandomInsults := Object()
RandomInsults.Insert("Oh, pish posh! How about we play the game?")
RandomInsults.Insert("You are a sad strange little man, and you have my pity.")
RandomInsults.Insert("It looks to me like the best part of you ran down the crack of your momma's ass and ended up as a brown stain on the mattress!")
RandomInsults.Insert("I fart in your general direction! Your mother was a hamster and your father smelt of elderberries!")
RandomInsults.Insert("You dirt-eating piece of slime, you scum-sucking pig, you son of a motherless goat!")
RandomInsults.Insert("What you just said is one of the most insanely idiotic things I have ever heard. Everyone in this game is now dumber for having listened to it. May God have mercy on your soul.")

; Good luck, have fun (RB+Up)
GoodLuck := Object()
GoodLuck.Insert("gl hf")
GoodLuck.Insert("glhf")
GoodLuck.Insert("GLHF")
GoodLuck.Insert("GL HF")
GoodLuck.Insert("Good luck, have fun!")
GoodLuck.Insert("Good luck, and have fun!")

; I know that was lucky! Sorry/not-sorry! (RB+Left)
Lucky := Object()
Lucky.Insert("I know that was lucky! Sorry/not-sorry!")
Lucky.Insert("Sorry/not-sorry!")
Lucky.Insert("That was totally intended!")
Lucky.Insert("I love it when a plan comes together!")
Lucky.Insert("Luck had nothing to do with it!")
Lucky.Insert("I should play the lottery...")
Lucky.Insert("I meant to do that!")
Lucky.Insert("Intentional!")
Lucky.Insert("Yes, that was the plan all along...")
Lucky.Insert("Exactly as planned.")
Lucky.Insert("That was unexpected!")
Lucky.Insert("Totally expected that!")
Lucky.Insert("Yes. Now for my next trick...")
Lucky.Insert("Magic!")
Lucky.Insert("My next trick also involves magic!")
Lucky.Insert("Luck is a valid strategy!")
Lucky.Insert("Rolling the dice!")
Lucky.Insert("Shit yeah!")
Lucky.Insert("Fuck yeah!")
Lucky.Insert("As was foretold...")
Lucky.Insert("As I had foreseen it...")
Lucky.Insert("Legendary luck!")

; LOL! (RB+Right)
Funny := Object()
Funny.Insert("LOL!")
Funny.Insert("hahahahaha")
Funny.Insert("omfg!")
Funny.Insert("That's funny!")
Funny.Insert("lol")
Funny.Insert("lol!")
Funny.Insert("lololol")
Funny.Insert("bwahaha")
Funny.Insert("Great Scott!")
Funny.Insert("rofl")
Funny.Insert("LMFAO!")
Funny.Insert("lmfao")
Funny.Insert("wtf lol!")
Funny.Insert("lol wut")
Funny.Insert("HAH!")
Funny.Insert("lmao")
Funny.Insert("LMAO!")
Funny.Insert("that's hilarious!")

; Curses (RB+Down)
Curses := Object()
Curses.Insert("Curses!")
Curses.Insert("Noes!")
Curses.Insert("Oh noes...")
Curses.Insert("Fuck!")
Curses.Insert("Damn!")
Curses.Insert("Dammit!")
Curses.Insert("Shit!")
Curses.Insert("Dang!")
Curses.Insert("Darn!")
Curses.Insert("Fuck me!")
Curses.Insert("ffs")
Curses.Insert("for fucks sake")
Curses.Insert("FFS!")
Curses.Insert("For fucks sake!")
Curses.Insert("oh ffs!")
Curses.Insert("Oh, for fucks sake!")
Curses.Insert("wtf argh!")
Curses.Insert("Fuuuck!")
Curses.Insert("Tits!")
Curses.Insert("Crap!")
Curses.Insert("ARGH!")
Curses.Insert("AAAAAAAAaah!")
Curses.Insert("But for fucks sake!")
Curses.Insert("#@$%*!")
Curses.Insert("%*#$*@")
Curses.Insert("@$г*&%!!")
Curses.Insert("з!@#гд$%&")
Curses.Insert("з@д% my $#!&г")
Curses.Insert("$H!T")
Curses.Insert("F*ck me!")
Curses.Insert("for f*cks sake")
Curses.Insert("For f*cks sake!")
Curses.Insert("Oh, for f*cks sake!")
Curses.Insert("#@% argh!")
Curses.Insert("F***ck!")
Curses.Insert("cr@p!")
Curses.Insert("@&г#!")
Curses.Insert("@@@@@@#!")
Curses.Insert("But for f*cks sake!")
Curses.Insert("""What The Fuck Is This Shit"" - Dr. Seuss")
Curses.Insert("well @!*% the &#!$ and his *@%!!...")
Curses.Insert("Balls!")
Curses.Insert("Bloody hell!")
Curses.Insert("Sod it!")
Curses.Insert("Fucking balls to it!")
Curses.Insert("Sod this!")
Curses.Insert("Fucking ballache!")
Curses.Insert("Bloody fucking shit!")
Curses.Insert("Shitting ballbreaker!")
Curses.Insert("Bloody fucking hell!")
Curses.Insert("Fucking balls!")
Curses.Insert("Cunting fuck!")
Curses.Insert("Cock!")
Curses.Insert("Bollocks!")
Curses.Insert("Bollocks to that!")
Curses.Insert("Cocking shit!")
Curses.Insert("Arse!")
Curses.Insert("Piss!")
Curses.Insert("F*&#!$N HELL!")
Curses.Insert("F*#!")
Curses.Insert("#$@&%*!")

; Mapping

Mapping := Object()
Team := Object()

Mapping["LB+RB+Up"] := TeamworkCompliment
Team["LB+RB+Up"] := True
Mapping["LB+RB+Left"] := Weird
Mapping["LB+RB+Right"] := GoodGame
Mapping["LB+RB+Down"] := Retort

Mapping["RB+Up"] := GoodLuck
Mapping["RB+Left"] := Lucky
Mapping["RB+Right"] := Funny
Mapping["RB+Down"] := Curses
