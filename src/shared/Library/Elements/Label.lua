local RunService = game:GetService("RunService")
export type LabelData = {
    text: string,
}

local Label = {};
Label.__index = Label;

Label.Instance = nil :: Frame;

Label.Label = nil :: TextLabel;
Label.Connections = {} :: {RBXScriptConnection} | {};

function Label.new(data: LabelData)
    local self = setmetatable({}, Label);

    local Frame = Instance.new("Frame");
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
    Frame.Size = UDim2.new(0.98, 0, 0, 50);

    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 8);
    UICorner.Parent = Frame;
    
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(72, 72, 72);
    UIStroke.Parent = Frame;

    local TextLabel = Instance.new("TextLabel");
    TextLabel.Text = `<font weight="400" family="12187365364">{data.text or ""}</font>`;
    TextLabel.TextColor3 = Color3.fromRGB(211, 211, 211);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Position = UDim2.fromScale(0.51, 0.5)
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Size = UDim2.fromScale(0.965, 0.9);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextScaled = true;
    TextLabel.RichText = true;
    TextLabel.Parent = Frame;

    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = 22;
    UITextSizeConstraint.Parent = TextLabel;

    self.Instance = Frame;

    self.Label = TextLabel;

    return self;
end

function Label:Set(text: string)
    self.Label.Text = `<font weight="400" family="12187365364">{text or ""}</font>`;
end

function Label:AddLoop(callback: (deltaTime: number) -> any)
    local connection = RunService.RenderStepped:Connect(function(deltaTime)
        local value = callback(deltaTime);

        self:Set(tostring(value));
    end)

    table.insert(self.Connections, connection);

    return self;
end

function Label:DestroyConnections()
    for _, v: RBXScriptConnection in self.Connections do
        v:Disconnect();
    end

    self.Connections = {};
end

return Label;