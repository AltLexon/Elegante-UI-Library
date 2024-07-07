local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

task.wait(0.5)

local LocalPlayer = Players.LocalPlayer;
local Character: Model = LocalPlayer.Character or ( LocalPlayer.CharacterAdded:Wait() and LocalPlayer.Character );

local Humanoid: Humanoid = Character:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart: BasePart = Character:FindFirstChild("HumanoidRootPart");

local LibraryModule = require(ReplicatedStorage.Shared.Library);

local NewLibrary = LibraryModule.new();
local Window = NewLibrary:CreateWindow({
    name = "altlexon's hub",
    color = Color3.fromRGB(20, 20, 20),

    size = UDim2.fromScale(0.4, 0.5),

    windowTransparency = 0,
});

local mainTab = Window:CreateTab("Main", 14187686429);

mainTab:CreateTextBox({
    title = "player walk speed",
    default = tostring(Humanoid.WalkSpeed),
    callback = function(value)
        Humanoid.WalkSpeed = tonumber(value);
    end
})

mainTab:CreateTextBox({
    title = "player jump power",
    default = tostring(Humanoid.JumpPower),
    callback = function(value)
        print(value)
        Humanoid.UseJumpPower = true;
        Humanoid.JumpPower = tonumber(value);
    end
})

mainTab:CreateLabel({text = ""}):AddLoop(function()
    return `humanoid state: {Humanoid:GetState().Name:lower()}`
end);

mainTab:CreateLabel({text = ""}):AddLoop(function()
    local velocity = HumanoidRootPart.AssemblyLinearVelocity;

    return string.format("velocity: %.3f, %.3f, %.3f", velocity.X, velocity.Y, velocity.Z)
end);

mainTab:CreateButton({
    title = "teleport to start.",
    callback = function()
        Character:MoveTo((workspace:WaitForChild("Baseplate") :: BasePart).Position + Vector3.new(0, 15.5, 0));
    end
})