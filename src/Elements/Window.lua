local Flipper = require(script.Parent.Parent.Packages.Flipper);

local Tab = require(script.Parent.Tab);

export type WindowData = {
    name: string,
    color: Color3?,
    corner: number?,
    cornerColor: Color3?,

    size: UDim2?,
    position: UDim2?,

    windowTransparency: number?,
}

local Window = {};
Window.__index = Window;

Window.Instance = nil :: Frame | nil;

Window.Tabs = nil :: ScrollingFrame | nil;
Window.SelectedTab = {
    Name = "",
    Canvas = nil :: CanvasGroup | nil,
}
Window.TabsMotors = {};

Window.Menu = nil :: Frame | nil;

Window.Close = nil :: TextButton | nil;
Window.Minimize = nil :: TextButton | nil;

Window.Transparency = 0;

function Window.new(data: WindowData)
    local self = setmetatable({}, Window);

    self.Transparency = data.windowTransparency or 0;

    local Frame = Instance.new("CanvasGroup");
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.BackgroundColor3 = data.color or Color3.fromRGB(0, 0, 0);
    Frame.Position = data.position or UDim2.fromScale(0.5, 0.5) + UDim2.fromOffset(0, 200);
    Frame.Size = data.size or UDim2.fromScale(0.4, 0.5);

    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, data.corner or 8);
    UICorner.Parent = Frame;

    local UIGradient = Instance.new("UIGradient");
    UIGradient.Rotation = 45;
    UIGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0.15),
        NumberSequenceKeypoint.new(1, 0)
    })
    UIGradient.Parent = Frame;

    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = data.cornerColor or Color3.fromRGB(95, 95, 95);
    UIStroke.Parent = Frame;

    local Pattern = Instance.new("ImageLabel");
    Pattern.Size = UDim2.fromScale(1, 1);
    Pattern.BackgroundTransparency = 1;
    Pattern.Image = "rbxassetid://2151782136";
    Pattern.ScaleType = Enum.ScaleType.Tile;
    Pattern.TileSize = UDim2.fromOffset(30, 50);
    Pattern.ImageTransparency = 0.95;
    Pattern.ZIndex = 1000;
    Pattern.Parent = Frame;

    local Top = Instance.new("Frame");
    Top.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Top.Size = UDim2.fromScale(1, 0.1);
    Top.BackgroundTransparency = 0.25;
    Top.Parent = Frame;

    local Title = Instance.new("TextLabel");
    Title.TextColor3 = Color3.fromRGB(165, 165, 165);
    Title.TextXAlignment = Enum.TextXAlignment.Left;
    Title.Position = UDim2.fromScale(0.025, 0);
    Title.Size = UDim2.fromScale(0.25, 1);
    Title.Text = `<font family="12187365364">{tostring(data.name)}</font>`;
    Title.BackgroundTransparency = 1;
    Title.TextScaled = true;
    Title.RichText = true;
    Title.Parent = Top;

    local Close = Instance.new("TextButton");
    Close.Position = UDim2.fromScale(1, 0);
    Close.Size = UDim2.fromScale(0.07, 1);
    Close.AnchorPoint = Vector2.new(1, 0);
    Close.BackgroundTransparency = 1;
    Close.Text = "";
    Close.Parent = Top;

    local CloseImage = Instance.new("ImageLabel");
    CloseImage.ImageColor3 = Color3.fromRGB(165, 165, 165);
    CloseImage.Position = UDim2.fromScale(0.5, 0.5);
    CloseImage.Size = UDim2.fromScale(0.5, 0.5);
    CloseImage.AnchorPoint = Vector2.new(0.5, 0.5);
    CloseImage.ScaleType = Enum.ScaleType.Fit
    CloseImage.Image = "rbxassetid://11293981586";
    CloseImage.BackgroundTransparency = 1;
    CloseImage.Parent = Close;

    local Minimize = Instance.new("TextButton");
    Minimize.Position = UDim2.fromScale(0.93, 0);
    Minimize.Size = UDim2.fromScale(0.07, 1);
    Minimize.AnchorPoint = Vector2.new(1, 0);
    Minimize.BackgroundTransparency = 1;
    Minimize.Text = "";
    Minimize.Parent = Top;

    local MinimizeImage = Instance.new("ImageLabel");
    MinimizeImage.ImageColor3 = Color3.fromRGB(165, 165, 165);
    MinimizeImage.Position = UDim2.fromScale(0.5, 0.5);
    MinimizeImage.Size = UDim2.fromScale(0.5, 0.5);
    MinimizeImage.AnchorPoint = Vector2.new(0.5, 0.5);
    MinimizeImage.ScaleType = Enum.ScaleType.Fit
    MinimizeImage.Image = "rbxassetid://11293980042";
    MinimizeImage.BackgroundTransparency = 1;
    MinimizeImage.Parent = Minimize;

    local UITextSizeConstraint = Instance.new("UITextSizeConstraint");
    UITextSizeConstraint.MaxTextSize = 20;
    UITextSizeConstraint.Parent = Title;

    UICorner:Clone().Parent = Top;
    UIStroke:Clone().Parent = Top;

    local Tabs = Instance.new("Frame");
    Tabs.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Tabs.Position = UDim2.fromScale(0.143, 0.547);
    Tabs.Size = UDim2.fromScale(0.265, 0.854);
    Tabs.AnchorPoint = Vector2.new(0.5, 0.5);
    Tabs.BackgroundTransparency = 0.25;
    Tabs.Parent = Frame;

    UIStroke:Clone().Parent = Tabs;
    UICorner:Clone().Parent = Tabs;

    local TabsList = Instance.new("ScrollingFrame");
    TabsList.ScrollBarImageColor3 = Color3.fromRGB(72, 72, 72);
    TabsList.Position = UDim2.fromScale(0.5, 0.5);
    TabsList.AnchorPoint = Vector2.new(0.5, 0.5);
    TabsList.CanvasSize = UDim2.fromScale(0, 0);
    TabsList.Size = UDim2.fromScale(0.9, 0.9);
    TabsList.BackgroundTransparency = 1;
    TabsList.ScrollBarThickness = 1;
    TabsList.BorderSizePixel = 0;
    TabsList.Parent = Tabs;

    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.Padding = UDim.new(0, 3);
    UIListLayout.Parent = TabsList;

    local Menu = Instance.new("Frame");
    Menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Menu.Position = UDim2.fromScale(0.64, 0.547);
    Menu.Size = UDim2.fromScale(0.691, 0.854);
    Menu.AnchorPoint = Vector2.new(0.5, 0.5);
    Menu.BackgroundTransparency = 0.25;
    Menu.Parent = Frame;

    UIStroke:Clone().Parent = Menu;
    UICorner:Clone().Parent = Menu;

    local Motor = Flipper.SingleMotor.new(165);
    Motor:onStep(function(x)
        CloseImage.ImageColor3 = Color3.fromRGB(x, 165, 165);
    end)

    local Motor2 = Flipper.SingleMotor.new(165);
    Motor2:onStep(function(x)
        MinimizeImage.ImageColor3 = Color3.fromRGB(x, x, x);
    end)

    Close.MouseEnter:Connect(function()
        Motor:setGoal(Flipper.Spring.new(255));
    end)

    Close.MouseLeave:Connect(function()
        Motor:setGoal(Flipper.Spring.new(165));
    end)

    MinimizeImage.MouseEnter:Connect(function()
        Motor2:setGoal(Flipper.Spring.new(255));
    end)

    MinimizeImage.MouseLeave:Connect(function()
        Motor2:setGoal(Flipper.Spring.new(165));
    end)

    self.Close = Close;
    self.Minimize = Minimize;

    self.Instance = Frame;
    self.Menu = Menu;
    self.Tabs = TabsList;

    -- Draggable UI --
    --[[do
        local dragging
        local dragInput
        local dragStart
        local startPos

        local function update(input)
            local delta = input.Position - dragStart
            self.Instance.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        self.Instance.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = self.Instance.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)

        self.Instance.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging and self.Instance and self.Instance.Parent ~= nil then
                update(input)
            end
        end)
    end]]

    return self;
end

function Window:CreateTab(name: string, icon: number?)
    local newTab = Tab.new({
        name = name,
        icon = icon,
    });

    newTab.Button.Activated:Connect(function()
        self:ChangeTab(name);
    end)

    newTab:SetParent(self.Tabs, self.Menu);

    return newTab;
end

function Window:SetParent(instance: Instance)
    self.Instance.Parent = instance;
end

function Window:Destroy(screenGui: ScreenGui)
    if screenGui then
        screenGui:Destroy();
    end
end

function Window:ChangeTab(name: string)
    assert(typeof(name) == 'string', "Name is not a string. | Type: " .. typeof(name));
    if name == self.SelectedTab.Name then
        return;
    end

    for i, v in self.TabsMotors do
        v:stop();
        v:destroy();
        self.TabsMotors[i] = nil;
    end

    local Canvas = self.SelectedTab.Canvas;
    local Name = self.SelectedTab.Name;
    
    if Name ~= "" or Canvas ~= nil then
        local oldCanvas: CanvasGroup = Canvas;
        local Motor = Flipper.SingleMotor.new(oldCanvas.GroupTransparency);
        
        self.TabsMotors[Name] = Motor;

        Motor:onStep(function(x)
            oldCanvas.GroupTransparency = x;
        end)

        Motor:setGoal(Flipper.Spring.new(1));

        task.spawn(function()
            repeat
                task.wait()
            until oldCanvas.GroupTransparency > 0.5;
    
            oldCanvas.Visible = false;
        end)
    end

    local found = false;
    for _, v in self.Menu:GetChildren() do
        if v:IsA("CanvasGroup") and v.Name == name then
            Canvas = v;
            Name = name;
            found = true;
            break;
        end
    end
    
    if not found then
        warn(`Couldn't find the tab canvas. | Tab: {name}`);
    end

    self.SelectedTab = {
        Name = name,
        Canvas = Canvas,
    }
    Canvas.Visible = true;

    local Motor = Flipper.SingleMotor.new(Canvas.GroupTransparency);
        
    self.TabsMotors[Name] = Motor;

    Motor:onStep(function(x)
        Canvas.GroupTransparency = x;
    end)

    Motor:setGoal(Flipper.Spring.new(0));
end

return Window;