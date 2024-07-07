export type ToggleData = {
    title: string,
    default: boolean?,
    callback: (state: boolean) -> any,
}

local Toggle = {};
Toggle.__index = Toggle;

Toggle.Instance = nil :: Frame;
Toggle.Callback = function() end;

Toggle.Button = nil :: TextButton;
Toggle.Icon = nil :: ImageLabel;

Toggle.State = false;

function Toggle.new(data: ToggleData)
    local self = setmetatable({}, Toggle);

    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
    Frame.Size = UDim2.new(0.98, 0, 0, 50);

    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 8);
    UICorner.Parent = Frame;
    
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(72, 72, 72);
    UIStroke.Parent = Frame;

    local Title = Instance.new("TextLabel");
    Title.Text = `<font weight="400" family="12187365364">{data.title or "Unknown"}</font>`;
    Title.TextColor3 = Color3.fromRGB(211, 211, 211);
    Title.TextXAlignment = Enum.TextXAlignment.Left;
    Title.Position = UDim2.fromScale(0.447, 0.5);
    Title.Size = UDim2.fromScale(0.84, 0.9);
    Title.AnchorPoint = Vector2.new(0.5, 0.5);
    Title.BackgroundTransparency = 1;
    Title.TextScaled = true;
    Title.RichText = true;
    Title.Parent = Frame;

    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = 22;
    UITextSizeConstraint.Parent = Title;

    local Button = Instance.new("TextButton");
    Button.Position = UDim2.fromScale(0.942, 0.5);
    Button.Size = UDim2.fromScale(0.1, 0.875);
    Button.AnchorPoint = Vector2.new(0.5, 0.5);
    Button.BackgroundTransparency = 0.7;
    Button.Text = "";
    Button.Parent = Frame;

    local buttonUICorner = UICorner:Clone();
    buttonUICorner.CornerRadius = UDim.new(0, 5);
    buttonUICorner.Parent = Button;

    local buttonUIStroke = UIStroke:Clone();
    buttonUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    buttonUIStroke.Parent = Button;

    UIStroke:Clone().Parent = Button;

    local Image = "rbxassetid://3926305904";

    local Icon = Instance.new("ImageLabel");
    Icon.Position = UDim2.fromScale(0.5, 0.5);
    Icon.Size = UDim2.fromScale(0.6, 0.6);
    Icon.AnchorPoint = Vector2.new(0.5, 0.5);
    Icon.BackgroundTransparency = 1;
    Icon.Image = Image;
    Icon.Parent = Button;

    self.Instance = Frame;

    self.Button = Button;
    self.Icon = Icon;

    Button.Activated:Connect(function()
        self.State = not self.State;
        self:Set();
    end)

    if data.default == true or data.default == false then
        self.State = data.default;
        self:Set(true);
    end

    self:Set(true);
    self:SetCallback(data.callback);

    return self;
end

function Toggle:SetCallback(callback: (toggle: boolean) -> any)
    if typeof(callback) == 'function' then
        self.Callback = callback;
    end
end

function Toggle:Set(isInit: boolean?)
    local toggle = self.State;

    local ImageOffset_True = Vector2.new(312, 4);
    local ImageOffset_False = Vector2.new(924, 724);

    local ImageSize_True = Vector2.new(24, 24);
    local ImageSize_False = Vector2.new(36, 36);

    local UIStroke = self.Button:FindFirstChildOfClass("UIStroke")

    self.Button.BackgroundColor3 = if not toggle then Color3.new(1, 0, 0) else Color3.new(0, 1, 0);
    UIStroke.Color = if not toggle then Color3.new(1, 0, 0) else Color3.new(0, 1, 0);
    self.Icon.ImageColor3 = if not toggle then Color3.new(1, 0, 0) else Color3.new(0, 1, 0);
    self.Icon.ImageRectOffset = if not toggle then ImageOffset_False else ImageOffset_True;
    self.Icon.ImageRectSize = if not toggle then ImageSize_False else ImageSize_True;

    if isInit == nil then
        self.Callback(self.State);
    end
end

return Toggle;