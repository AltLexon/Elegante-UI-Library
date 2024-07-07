local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Flipper = require(ReplicatedStorage.Packages.Flipper);

local Module = {};

function Module.Create(text: string, icon: number?)
    local Button = Instance.new("TextButton");
    Button.AnchorPoint = Vector2.new(0.5, 0.5);
    Button.Size = UDim2.new(0.99, 0, 0, 40);
    Button.BackgroundTransparency = 1;
    Button.Name = text;
    Button.Text = "";

    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 4);
    UICorner.Parent = Button;

    local Title = Instance.new("TextLabel");
    Title.Text = `<font weight="500" family="12187365364">{tostring(text)}</font>`;
    Title.TextColor3 = Color3.fromRGB(211, 211, 211);
    Title.TextXAlignment = Enum.TextXAlignment.Left;
    Title.Position = UDim2.fromScale(0.624, 0.5);
    Title.Size = UDim2.fromScale(0.631, 0.7);
    Title.AnchorPoint = Vector2.new(0.5, 0.5)
    Title.BackgroundTransparency = 1;
    Title.TextScaled = true;
    Title.RichText = true;
    Title.Parent = Button;

    if icon ~= nil and typeof(icon) == "number" then
        local Icon = Instance.new("ImageLabel");
        Icon.ImageColor3 = Color3.new(1, 1, 1);
        Icon.Position = UDim2.fromScale(0.125, 0.5);
        Icon.Size = UDim2.fromOffset(25, 25);
        Icon.AnchorPoint = Vector2.new(0.5, 0.5);
        Icon.Image = `rbxassetid://{icon}`;
        Icon.BackgroundTransparency = 1;
        Icon.Parent = Button;
    else
        Title.Position = UDim2.fromScale(0.5, 0.5);
        Title.TextXAlignment = Enum.TextXAlignment.Center;
    end

    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = 20;
    UITextSizeConstraint.Parent = Title;

    local BackgroundMotor = Flipper.SingleMotor.new(1);
    BackgroundMotor:onStep(function(x)
        Button.BackgroundTransparency = x;
    end)

    Button.MouseEnter:Connect(function()
        BackgroundMotor:setGoal(Flipper.Spring.new(0.9));
    end)

    Button.MouseLeave:Connect(function()
        BackgroundMotor:setGoal(Flipper.Spring.new(1));
    end)

    return Button;
end

return Module;