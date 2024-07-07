local Components = script.Parent.Parent.Components;
local Elements = script.Parent;

local ListButton = require(Components.ListButton);

local TextBox = require(Elements.TextBox);
local Toggle = require(Elements.Toggle);
local Button = require(Elements.Button);
local Label = require(Elements.Label);

export type TabData = {
    name: string,
    icon: number?,
};

export type ToggleData = {
    title: string,
    default: boolean?,
    callback: (state: boolean) -> any,
}

export type ButtonData = {
    title: string,
    callback: (state: boolean) -> any,
}

export type TextBoxData = {
    title: string,
    default: string?,
    callback: (value: string) -> any,
}

export type LabelData = {
    text: string,
}

local Tab = {};
Tab.__index = Tab;

Tab.List = nil :: ScrollingFrame;
Tab.Instance = nil :: Frame;
Tab.Button = nil :: Frame;

function Tab.new(data: TabData)
    local self = setmetatable({}, Tab);

    local Frame = Instance.new("CanvasGroup");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.Name = data.name;
    Frame.GroupTransparency = 1;
    Frame.Visible = false;

    local Title = Instance.new("TextLabel");
    Title.Text = `<font weight="600" family="12187365364">{tostring(data.name)}</font>`;
    Title.TextXAlignment = Enum.TextXAlignment.Left;
    Title.TextColor3 = Color3.new(1, 1, 1);
    Title.Position = UDim2.fromScale(0.503, 0.1);
    Title.Size = UDim2.fromScale(0.908, 0.085);
    Title.FontFace.Weight = Enum.FontWeight.Bold;
    Title.AnchorPoint = Vector2.new(0.5, 0.5);
    Title.BackgroundTransparency = 1;
    Title.TextScaled = true;
    Title.RichText = true;
    Title.Parent = Frame;

    local List = Instance.new("ScrollingFrame");
    List.ScrollBarImageColor3 = Color3.fromRGB(72, 72, 72);
    List.Position = UDim2.fromScale(0.512, 0.577);
    List.Size = UDim2.fromScale(0.926, 0.786);
    List.CanvasSize = UDim2.fromScale(0,0);
    List.AnchorPoint = Vector2.new(0.5, 0.5);
    List.BackgroundTransparency = 1;
    List.ScrollBarThickness = 1;
    List.BorderSizePixel = 0;
    List.Parent = Frame;

    local Separator = Instance.new("Frame");
    Separator.Size = UDim2.fromScale(0, 0);
    Separator.Parent = List;

    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout.Padding = UDim.new(0, 10);
    UIListLayout.Parent = List;

    self.Button = ListButton.Create(data.name, data.icon);
    self.Instance = Frame;
    self.List = List;

    return self;
end

function Tab:SetParent(list: ScrollingFrame, menu: Instance)
    self.Instance.Parent = menu;
    self.Button.Parent = list;

    list.CanvasSize += UDim2.fromOffset(0, 43);
end


local offset = 61;
function Tab:CreateToggle(info: ToggleData)
    local newToggle = Toggle.new(info);
    newToggle.Instance.Parent = self.List;

    self.List.CanvasSize += UDim2.fromOffset(0, offset);

    return newToggle;
end

function Tab:CreateButton(info: ButtonData)
    local newButton = Button.new(info);
    newButton.Instance.Parent = self.List;

    self.List.CanvasSize += UDim2.fromOffset(0, offset);

    return newButton;
end

function Tab:CreateTextBox(info: TextBoxData)
    local newTextBox = TextBox.new(info);
    newTextBox.Instance.Parent = self.List;

    self.List.CanvasSize += UDim2.fromOffset(0, offset);

    return newTextBox;
end

function Tab:CreateLabel(info: LabelData)
    local newLabel = Label.new(info);
    newLabel.Instance.Parent = self.List;

    self.List.CanvasSize += UDim2.fromOffset(0, offset);

    return newLabel;
end

return Tab;