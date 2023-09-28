--[[
By: ComoEsteban
https://v3rmillion.net/showthread.php?tid=1149189

Whatever your mouse cursor touches, it will show the path of it. You can press "C" on your keyboard 
and it will copy it to the clipboard too or "F" if you don't want it to show the path anymore. 
You also choose whether you want it to get the paths for coregui stuff as well.
]]--

getgenv().settings = {
   ["IgnoreCoreGui"] = false,
   ["ToggleKeyBind"] = "F",
   ["ClipboardKeyBind"] = "C"
}

loadstring(game:HttpGet("https://raw.githubusercontent.com/Poll0none/Tools/main/GuiPathFinder-loadstring.lua"))()
