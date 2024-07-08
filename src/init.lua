local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players");

local Flipper = require(script.Packages.Flipper);

export type Window = {
    name: string,
    color: Color3?,
    corner: number?,
    cornerColor: Color3?,

    size: UDim2?,
    position: UDim2?,

    windowTransparency: number,
}

local Elements = script.Elements;

local Window = require(Elements.Window);

export type Library = {
    Screen: ScreenGui,
    Window: any,
    WindowMotor: any,
    WindowState: "Invisible" | "Visible",
    ToggleKey: Enum.KeyCode,
    Connection: RBXScriptConnection,

    new: () -> Library,
    CreateWindow: (self: Library, data: any) -> any,
    Show: (self: Library) -> nil,
    Hide: (self: Library) -> nil,
}

local Library = {};
Library.__index = Library;

Library.Screen = nil;
Library.Window = nil;

Library.WindowMotor = nil;

Library.WindowState = "Invisible" :: "Visible" | "Invisible";
Library.ToggleKey = Enum.KeyCode.RightControl :: Enum.KeyCode;

Library.Connection = nil :: RBXScriptConnection | nil;

function Library.new()
    local self = setmetatable({}, Library);

    self.Screen = Instance.new("ScreenGui");
    self.Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

    self.Screen.Name = "AltLexon's UI";

    self.Connection = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent or self.Screen == nil then
            return;
        end


        if input.KeyCode == self.ToggleKey then
            local Function = if self.WindowState == "Invisible" then "Show" else "Hide";

            self[Function](self);
        end
    end)

    return self;
end

function Library:CreateWindow(data: Window)
    local newWindow = Window.new(data);
    newWindow:SetParent(self.Screen :: any);

    self.Window = newWindow;

    self.Window.Minimize.Activated:Connect(function()
        self:Hide();
    end)

    self.Window.Close.Activated:Connect(function()
        self:Hide();
        self.Screen = nil;

        task.delay(1, function()
            self.Window:Destroy(self.Screen :: any);
            self.Connection:Disconnect();
        end)
    end)

    return newWindow;
end

function Library:Show()
    if not self.Screen or self.WindowState == "Visible" then
        return;
    end

    if self.WindowMotor then
        self.WindowMotor:destroy();
    end

    self.WindowState = "Visible";

    self.Screen.Parent = Players.LocalPlayer.PlayerGui;

    local WindowInstance = self.Window.Instance :: CanvasGroup;
    local WindowMotor = Flipper.GroupMotor.new({1, 0.6});
    WindowMotor:onStep(function(x: {[number]: number})
        WindowInstance.GroupTransparency = x[1];
        WindowInstance:FindFirstChildOfClass("UIStroke").Transparency = x[1];
        WindowInstance.Position = UDim2.fromScale(WindowInstance.Position.X.Scale, x[2]);
    end)

    WindowMotor:setGoal({
        Flipper.Spring.new(self.Window.Transparency, {frequency = 2}),
        Flipper.Spring.new(0.5, {frequency = 1.5})
    })

    self.WindowMotor = WindowMotor;
end

function Library:Hide()
    if not self.Screen or self.WindowState == "Invisible" then
        return;
    end

    if self.WindowMotor then
        self.WindowMotor:destroy();
    end

    self.WindowState = "Invisible";

    local WindowInstance = self.Window.Instance :: CanvasGroup;
    local WindowMotor = Flipper.GroupMotor.new({self.Window.Transparency, 0.5});
    WindowMotor:onStep(function(x: {[number]: number})
        WindowInstance.GroupTransparency = x[1];
        WindowInstance:FindFirstChildOfClass("UIStroke").Transparency = x[1];
        WindowInstance.Position = UDim2.fromScale(WindowInstance.Position.X.Scale, x[2]);
    end)

    WindowMotor:setGoal({
        Flipper.Spring.new(1, {frequency = 4}),
        Flipper.Spring.new(0.6, {frequency = 3.5})
    })

    task.delay(1, function()
        if self.WindowState ~= 'Invisible' or self.Screen == nil then
            return;
        end

        self.Screen.Parent = nil;
        self.WindowMotor = WindowMotor;
    end)
end

return Library;