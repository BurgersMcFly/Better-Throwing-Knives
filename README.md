Powered by Powered by [Cyber Engine Tweaks](https://github.com/yamashi/CyberEngineTweaks) and [redscript](https://github.com/jac3km4/redscript), a Swift-like programming language for working with scripts used by REDengine in Cyberpunk 2077.

# Better Throwing Knives

Thrown knives reload automatically and instantly, no need to pick them up! Can also make the "reloading" animation faster and prevent V from changing to a different weapon when clicking left/right mouse button too fast.

Using both files with minimumReloadTime 0 and knifeWeaponSwapOnAttackDelay 99:

![](https://i.imgur.com/UYbsMdJ.gif)

## Mod page on Nexus Mods

https://www.nexusmods.com/cyberpunk2077/mods/6006

## Features

Redscript file makes reloading automatic and instant, no need to pick the knives up.

CET file (init.lua) makes the "reloading" animation faster and prevents V from changing to a different weapon when clicking left/right mouse button too fast. Can also open it with a text editor and edit the values yourself. I've included comments with descriptions and the default values for both reloading and changing weapons:

init.lua contents:

```lua
registerForEvent("onInit", function() 
--default minimumReloadTime = 0.9f; || lower values = faster reload
--default knifeWeaponSwapOnAttackDelay 0.4f; || higer values will prevent V from changing to a different weapon when clicking left/right mouse button too fast
```

^^^ These are the comments.

default minimumReloadTime = 0.9 

default knifeWeaponSwapOnAttackDelay 0.4

```lua
TweakDB:SetFlat("Items.Base_Knife.minimumReloadTime", 0)
TweakDB:SetFlat("Items.Base_Knife.knifeWeaponSwapOnAttackDelay", 99)
end)
```
^^^ These are the lines that change reload speed and the weapon changing behavior. If you want to edit them just change the number at the end. 0 is already the lowest you can go for minimumReloadTime, and I don't think there's a reason to go over 99 for the knifeWeaponSwapOnAttackDealy. Changes won't take effect if you're already in game. Do it before launching the game.

You can use both files at the same time or on their own.

## Installation for Redscript file

1. Download [redscript](https://www.nexusmods.com/cyberpunk2077/mods/1511).
2. Download the mod and drop its content in your game's folder. 
3. Should look like this: \Cyberpunk 2077\r6\scripts\BetterThrowingKnives.reds

## Notes

You might need [cybercmd](https://www.nexusmods.com/cyberpunk2077/mods/5176) for compatibility with redmod.

## Installation for CET file

1. Download [Cyber Engine Tweaks](https://www.nexusmods.com/cyberpunk2077/mods/107). Drop its contents in your game's folder.
2. Download my mod and drop its contents in your game's folder.
3. Should look like this: \Cyberpunk2077\bin\x64\plugins\cyber_engine_tweaks\mods\BetterThrowingKnives\init.lua

## License

[GNU GPLv3](https://choosealicense.com/licenses/gpl-3.0/)