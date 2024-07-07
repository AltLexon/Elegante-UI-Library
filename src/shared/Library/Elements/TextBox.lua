export type TextBoxData = {
    title: string,
    default: string?,
    callback: (value: string) -> any,
}

local TextBox = {};
TextBox.__index = TextBox;

TextBox.Instance = nil :: Frame;
TextBox.Callback = function() end;

TextBox.Button = nil :: TextButton;

TextBox.Value = "" :: string;

function TextBox.new(data: TextBoxData)
    local self = setmetatable({}, TextBox);

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
    Title.Position = UDim2.fromScale(0.377, 0.5);
    Title.Size = UDim2.fromScale(0.7, 0.9);
    Title.AnchorPoint = Vector2.new(0.5, 0.5);
    Title.BackgroundTransparency = 1;
    Title.TextScaled = true;
    Title.RichText = true;
    Title.Parent = Frame;

    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = 22;
    UITextSizeConstraint.Parent = Title;

    local TextBoxFrame = Instance.new("Frame");
    TextBoxFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    TextBoxFrame.Position = UDim2.fromScale(0.868, 0.5);
    TextBoxFrame.Size = UDim2.fromScale(0.25, 0.875);
    TextBoxFrame.AnchorPoint = Vector2.new(0.5, 0.5);
    TextBoxFrame.BackgroundTransparency = 0.5;
    TextBoxFrame.BackgroundTransparency = 0.5;
    TextBoxFrame.Parent = Frame;

    local _TextBox = Instance.new("TextBox");
    _TextBox.Size = UDim2.fromScale(1, 1);
    _TextBox.BackgroundTransparency = 1;
    _TextBox.MaxVisibleGraphemes = 0;
    _TextBox.TextTransparency = 1;
    _TextBox.ZIndex = 2;
    _TextBox.Parent = TextBoxFrame;
    
    local TextBoxLabel = Instance.new("TextLabel");
    TextBoxLabel.Text = `<font weight="600" family="12187365364">{data.default or "Unknown"}</font>`;
    TextBoxLabel.TextColor3 = Color3.fromRGB(184, 184, 184);
    TextBoxLabel.Size = UDim2.fromScale(1, 1);
    TextBoxLabel.BackgroundTransparency = 1;
    TextBoxLabel.TextScaled = true;
    TextBoxLabel.RichText = true;
    TextBoxLabel.Parent = TextBoxFrame;

    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingBottom = UDim.new(0.2, 0);
    UIPadding.PaddingLeft = UDim.new(0.05, 0);
    UIPadding.PaddingRight = UDim.new(0.05, 0);
    UIPadding.PaddingTop = UDim.new(0.2, 0);
    UIPadding.Parent = TextBoxLabel;

    local buttonUICorner = UICorner:Clone();
    buttonUICorner.CornerRadius = UDim.new(0, 5);
    buttonUICorner.Parent = TextBoxFrame;

    local buttonUIStroke = UIStroke:Clone();
    buttonUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
    buttonUIStroke.Parent = TextBoxFrame;

    self.Instance = Frame;

    self.Button = _TextBox;
    self.TextBox = _TextBox;

    _TextBox:GetPropertyChangedSignal("Text"):Connect(function()
        local Text = _TextBox.Text;

        TextBoxLabel.Text = `<font weight="600" family="12187365364">{Text or ""}</font>`;

        self.Value = Text;
    end)

    _TextBox.FocusLost:Connect(function(enterPressed)
        if not enterPressed then
            return;
        end

        self.Callback(self.Value);
    end)

    self.Callback = data.callback;

    return self;
end

return TextBox;