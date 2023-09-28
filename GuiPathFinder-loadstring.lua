local LocalPlayer = game:GetService("Players").LocalPlayer

local function RandomString()
    local chars = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","1","2","3","4","5","6","7","8","9","0"}
    local text = ""
    for letter = 1,math.random(6,16) do
        if math.random(1,2) == 1 then
            text = text..chars[math.random(1,#chars)]
        else
            text = text..string.upper(chars[math.random(1,#chars)])
        end
    end
    return text
end

local ScreenGui = Instance.new("ScreenGui")
local Label = Instance.new("TextLabel",ScreenGui)
local LabelName = RandomString()
Label.Name = LabelName
Label.Text = ""
Label.Size = UDim2.new(0, 250,0, 42)
Label.BackgroundColor3 = Color3.fromRGB(54,54,54)
Label.TextColor3 = Color3.new(255,255,255)
Label.BorderSizePixel = 0
Label.TextWrapped = true
Label.Visible = false
local ScreenGuiName = RandomString()
ScreenGui.Name = ScreenGuiName
ScreenGui.Parent = game:GetService("CoreGui")

local old = nil
old = hookmetamethod(game,"__index",function(...)
    local args = {...}
    if old(...) == LabelName or old(...) == ScreenGuiName then
        return ""
    end
    if args[1] == ScreenGui or args[1] == Label or old(...) == ScreenGui or old(...) == Label then
        if not checkcaller() then
            return nil
        end
    end
    return old(...)
end)

local enabled = true
local focused = nil

local function DetectMouse(object)
    object.MouseEnter:Connect(function()
        focused = object
    end)
end

local classes = {"TextLabel","TextButton","TextBox","Frame","ImageLabel","ImageButton","ScrollingFrame"}
for _,object in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
    if table.find(classes,object.ClassName) then
        object.MouseEnter:Connect(function()
            focused = object
        end)
    end
end
for _,object in pairs(game:GetService("CoreGui"):GetDescendants()) do
    if table.find(classes,object.ClassName) and object ~= Label then
        object.MouseEnter:Connect(function()
            focused = object
        end)
    end
end

game:GetService("CoreGui").DescendantAdded:Connect(function(object)
    if table.find(classes,object.ClassName) then
        object.MouseEnter:Connect(function()
            focused = object
        end)
    end
end)

game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui").DescendantAdded:Connect(function(object)
    if table.find(classes,object.ClassName) then
        object.MouseEnter:Connect(function()
            focused = object
        end)
    end
end)

local mouse = LocalPlayer:GetMouse()

local function SetInfo(ObjectPath)
    local ObjectPath = focused:GetFullName()
    local Service = string.split(ObjectPath,".")[1]
    local text = 'game:GetService("<SERVICE>").'
    ObjectPath = string.gsub(ObjectPath,Service..".","")
    text = string.gsub(string.gsub(text,"<SERVICE>",Service)..ObjectPath,LocalPlayer.Name,"LocalPlayer")
    for _,split in pairs(string.split(text,".")) do
        if string.find(split," ") then
            text = string.gsub(text,"."..split,'["'..split..'"]')
        end
    end
    Label.Position = UDim2.new(0,mouse.X - (Label.Size.X.Offset / 2),0,mouse.Y - (Label.Size.Y.Offset / 2) + 2)
    Label.Visible = true
    Label.Text = text
end

mouse.Move:Connect(function()
    if focused and enabled then
        if not settings.IgnoreCoreGui then
            SetInfo(focused:GetFullName())
        elseif not focused:FindFirstAncestorWhichIsA("CoreGui") then
            SetInfo(focused:GetFullName())
        end
    end
end)

mouse.KeyDown:Connect(function(key)
    if key == string.lower(settings.ClipboardKeyBind) then
        setclipboard(Label.Text)
    elseif key == string.lower(settings.ToggleKeyBind) then
        if enabled then
            enabled = false
            Label.Visible = false
        else
            enabled = true
            Label.Visible = true
        end
    end
end)
