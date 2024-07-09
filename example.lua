local Players = game:GetService("Players");

local LocalPlayer = Players.LocalPlayer;

-- Get Library Module
local LibraryModule = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/AltLexon/Elegante-UI-Library/master/run.lua"))();
local Library = LibraryModule.new();

local Window = Library:CreateWindow({
    name = "Elegante UI Library",
})

local MainTab = Window:CreateTab("Main", 14187686429);
local Settings = Window:CreateTab("Settings", 11293977610);

MainTab:CreateToggle({
    title = "Auto Print",
    callback = function(state)
        while state == true do
            print("Auto Print Enabled");
            task.wait(1)
        end
    end
})

MainTab:CreateButton({
    title = "Print",
    callback = function(state)
        print("Hello World!")
    end
})

MainTab:CreateTextBox({
    title = "Print Input",
    default = "Insert a text",
    callback = function(value)
        print("Input:", value);
    end
})

MainTab:CreateLabel({
    text = "Welcome, " .. LocalPlayer.DisplayName
})

task.wait(1);

Window:Show();