export type ButtonData = {
    title: string,
    callback: (state: boolean) -> any,
}

local Button = {};
Button.__index = Button;

Button.Instance = nil :: Frame | nil;
Button.Callback = function() end;

Button.Button = nil :: TextButton | nil;
Button.Icon = nil :: ImageLabel | nil;

function Button.new(data: ButtonData)
    local self = setmetatable({}, Button);

    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
    Frame.Size = UDim2.new(0.98, 0, 0, 50);

    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 8);
    UICorner.Parent = Frame;
    
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(72, 72, 72);
    UIStroke.Parent = Frame;

    local TextButton = Instance.new("TextButton");
    TextButton.Text = `<font weight="400" family="12187365364">{data.title or "Unknown"}</font>`;
    TextButton.TextColor3 = Color3.fromRGB(211, 211, 211);
    TextButton.TextXAlignment = Enum.TextXAlignment.Left;
    TextButton.Size = UDim2.fromScale(1, 1);
    TextButton.BackgroundTransparency = 1;
    TextButton.TextScaled = true;
    TextButton.RichText = true;
    TextButton.Parent = Frame;

    local buttonUIPadding = Instance.new("UIPadding");
    buttonUIPadding.PaddingLeft = UDim.new(0.03, 0);
    buttonUIPadding.PaddingRight = UDim.new(0.1, 0);
    buttonUIPadding.Parent = TextButton;

    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = 22;
    UITextSizeConstraint.Parent = TextButton;

    UIStroke:Clone().Parent = TextButton;

    local Image = "rbxassetid://12974400533";

    local Icon = Instance.new("ImageLabel");
    Icon.Position = UDim2.fromScale(0.95, 0.5);
    Icon.Size = UDim2.fromScale(0.06, 0.6);
    Icon.AnchorPoint = Vector2.new(0.5, 0.5);
    Icon.BackgroundTransparency = 1;
    Icon.Image = Image;
    Icon.Parent = Frame;

    self.Instance = Frame;

    self.Button = TextButton;
    self.Icon = Icon;

    TextButton.Activated:Connect(function()
        self.Callback();
    end)

    self:SetCallback(data.callback);

    return self;
end

function Button:SetCallback(callback: (Button: boolean) -> any)
    if typeof(callback) == 'function' then
        self.Callback = callback;
    end
end

return Button;