--[[
By: HTDBarsi
https://v3rmillion.net/showthread.php?tid=1213511

After executing this script, immediately click back into roblox, and dont click out of it till it prints "Done!" in the console.
Then the code will be copied to clipboard. Go to an AI website and type: 

convert these luau instructions into readable luau code and simplify it please
```lua
<code here>
```
]]--

local p = game:GetService("Players").LocalPlayer.PlayerGui.LocalScript -- path to the script
wait(2)
setclipboard(loadstring(game:HttpGet("https://raw.githubusercontent.com/Poll0none/Tools/main/ModuleScriptDecompiler-loadstring.lua"))()(p,true))
print("Done!")
