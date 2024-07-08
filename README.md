# Elegante UI Library

## 📜 Module
```lua
local LibraryModule = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AltLexon/Elegante-UI-Library/master/run.lua"))();
```

## 📦 Example
```lua
local Players = game:GetService("Players");

local LocalPlayer = Players.LocalPlayer;

-- Get Library Module
local LibraryModule = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AltLexon/Elegante-UI-Library/master/run.lua"))();
local Library = LibraryModule.new();

-- Create a new Window
--[[
local Window = Library:CreateWindow({
    name: string,
    color: Color3?,
    corner: number?,
    cornerColor: Color3?,

    size: UDim2?,
    position: UDim2?,

    windowTransparency: number?,
})]]

local Window = Library:CreateWindow({
    name = "Elegante UI Library",
})

-- Window Toggle
Window:Show();
Window:Hide();

-- Create a new Tab
-- Window:CreateTab(name: string, icon: number?)

local MainTab = Window:CreateTab("Main", 14187686429);
local Settings = Window:CreateTab("Settings", 11293977610);

--[[
MainTab:CreateToggle({
    title: string,
    default: boolean?,
    callback: (state: boolean) -> any
});
]]

MainTab:CreateToggle({
    title = "Auto Print",
    callback = function(state)
        while state == true do
            print("Auto Print Enabled");
        end
    end
})

--[[
MainTab:CreateButton({
    title: string,
    callback: (state: boolean) -> any,
})
]]

MainTab:CreateButton({
    title = "Print",
    callback = function(state)
        print("Hello World!")
    end
})

--[[
MainTab:CreateTextBox({
    title: string,
    default: string?,
    callback: (value: string) -> any,
})
]]

MainTab:CreateTextBox({
    title = "Print Input",
    default = "Insert a text",
    callback = function(value)
        print("Input:", value);
    end
})

--[[
MainTab:CreateLabel({
    text: string,
})
]]

MainTab:CreateLabel({
    text = "Welcome, " .. LocalPlayer.DisplayName
})
```

## 📃 Documentation
* Library
    * Show()
    * Hide()
    * CreateWindow
        * Destroy()
        * ChangeTab(**tabName**)
        * CreateTab(**name, icon**)
            * CreateTextBox(**{title, default?, callback}**)
            * CreateToggle(**{title, default?, callback}**)
            * CreateButton(**{title, callback}**)
            * CreateLabel(**{text}**)
<br>
<br>
#### Made by **[@altlexon](https://www.roblox.com/users/2836896939/profile)**