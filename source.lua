-- Библиотека для создания пользовательского интерфейса

local Lib = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game.Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Lib"
ScreenGui.Parent = game.CoreGui

local mainframe
local tabs = {}
local buttons = {}
local toggles = {}
local sliders = {}

function Lib:CreateWindow(name)
    if not mainframe then
        mainframe = Instance.new("Frame")
        mainframe.Name = "MainFrame"
        mainframe.Size = UDim2.new(0, 600, 0, 400)
        mainframe.Position = UDim2.new(0.5, -300, 0.5, -200)
        mainframe.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
        mainframe.BorderSizePixel = 0
        mainframe.Parent = ScreenGui

        local tablist = Instance.new("ScrollingFrame")
        tablist.Name = "TabList"
        tablist.Size = UDim2.new(0, 200, 0, 350)
        tablist.Position = UDim2.new(0, 0, 0, 50)
        tablist.BackgroundColor3 = Color3.new(0.45, 0.45, 0.45)
        tablist.BorderSizePixel = 0
        tablist.Parent = mainframe

        local functionslist = Instance.new("ScrollingFrame")
        functionslist.Name = "FunctionsList"
        functionslist.Size = UDim2.new(0, 400, 0, 350)
        functionslist.Position = UDim2.new(0, 200, 0, 50)
        functionslist.BackgroundColor3 = Color3.new(0.45, 0.45, 0.45)
        functionslist.BorderSizePixel = 0
        functionslist.Parent = mainframe

        local tabframe = Instance.new("Frame")
        tabframe.Name = "TabFrame"
        tabframe.Size = UDim2.new(1, 0, 0, 50)
        tabframe.BackgroundColor3 = Color3.new(0.45, 0.45, 0.45)
        tabframe.BorderSizePixel = 0
        tabframe.Parent = mainframe

        local close = Instance.new("ImageButton")
        close.Name = "CloseButton"
        close.Image = "rbxassetid://385868188"
        close.Size = UDim2.new(0, 50, 0, 50)
        close.BackgroundTransparency = 1
        close.ImageTransparency = 1
        close.Position = UDim2.new(1, -50, 0, 0)
        close.Parent = tabframe

        local closeoverlay = Instance.new("TextLabel")
        closeoverlay.Text = "X"
        closeoverlay.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeoverlay.Size = UDim2.new(0, 50, 0, 50)
        closeoverlay.BackgroundTransparency = 1
        closeoverlay.TextSize = 40
        closeoverlay.Position = UDim2.new(0, 0, 0, 0)
        closeoverlay.Parent = close

        local minimize = Instance.new("ImageButton")
        minimize.Name = "MinimizeButton"
        minimize.Image = "rbxassetid://385868188"
        minimize.Size = UDim2.new(0, 50, 0, 50)
        minimize.BackgroundTransparency = 1
        minimize.ImageTransparency = 1
        minimize.Position = UDim2.new(1, -100, 0, 0)
        minimize.Parent = tabframe

        local minimizeoverlay = Instance.new("TextLabel")
        minimizeoverlay.Text = "-"
        minimizeoverlay.TextColor3 = Color3.fromRGB(255, 255, 255)
        minimizeoverlay.Size = UDim2.new(0, 50, 0, 50)
        minimizeoverlay.BackgroundTransparency = 1
        minimizeoverlay.TextSize = 40
        minimizeoverlay.Position = UDim2.new(0, 0, 0, 0)
        minimizeoverlay.Parent = minimize

        local windowname = Instance.new("TextLabel")
        windowname.Text = name
        windowname.Size = UDim2.new(0, 150, 0, 50)
        windowname.Position = UDim2.new(0, 12, 0, 0)
        windowname.Font = Enum.Font.GothamBold
        windowname.TextSize = 30
        windowname.TextXAlignment = Enum.TextXAlignment.Left
        windowname.TextColor3 = Color3.fromRGB(255, 255, 255)
        windowname.BackgroundTransparency = 1
        windowname.Parent = tabframe

        close.MouseButton1Click:Connect(function()
            for _, tabContent in pairs(tabs) do
                for _, element in pairs(tabContent:GetChildren()) do
                    if element:IsA("TextButton") then
                        element.TextTransparency = 1
                        element.BackgroundTransparency = 1
                    end
                end
            end

            for _, tabButton in pairs(tablist:GetChildren()) do
                if tabButton:IsA("TextButton") then
                    tabButton.TextTransparency = 1
                    tabButton.BackgroundTransparency = 1
                end
            end

            windowname.Visible = false
            closeoverlay.Visible = false
            minimizeoverlay.Visible = false

            tablist:Destroy()
            functionslist:Destroy()

            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tweenSize = TweenService:Create(mainframe, tweenInfo, {
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0.5, 0, 0.5, 0)
            })
            tweenSize:Play()
            tweenSize.Completed:Wait()

            ScreenGui:Destroy()
        end)

        minimize.MouseButton1Click:Connect(function()
            if minimizeoverlay.Text == "-" then
                mainframe.BackgroundTransparency = 1
                functionslist.Visible = false
                tablist.Visible = false
                minimizeoverlay.Text = "+"

                for _, button in ipairs(buttons) do
                    button.Visible = false
                end

                for _, toggle in ipairs(toggles) do
                    toggle.Visible = false
                end

                for _, slider in ipairs(sliders) do
                    slider.Visible = false
                end
            else
                mainframe.BackgroundTransparency = 0
                functionslist.Visible = true
                tablist.Visible = true
                minimizeoverlay.Text = "-"

                for _, button in ipairs(buttons) do
                    button.Visible = true
                end

                for _, toggle in ipairs(toggles) do
                    toggle.Visible = true
                end

                for _, slider in ipairs(sliders) do
                    slider.Visible = true
                end
            end
        end)
    end
end

function Lib:MakeTab(tabName)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName
    tabButton.Size = UDim2.new(0, 200, 0, 50)
    tabButton.BackgroundColor3 = Color3.new(0.45, 0.45, 0.45)
    tabButton.BorderSizePixel = 0
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 24
    tabButton.Parent = mainframe:FindFirstChild("TabList")

    local listLayout = mainframe:FindFirstChild("TabList"):FindFirstChildOfClass("UIListLayout")
    if not listLayout then
        listLayout = Instance.new("UIListLayout")
        listLayout.Parent = mainframe:FindFirstChild("TabList")
        listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, 5)
    end

    local tabContent = Instance.new("Frame")
    tabContent.Name = tabName .. "Content"
    tabContent.Size = UDim2.new(1, 0, 1, -50)
    tabContent.Position = UDim2.new(0, 0, 0, 50)
    tabContent.BackgroundTransparency = 1
    tabContent.Parent = mainframe

    tabs[tabName] = tabContent

    tabButton.MouseButton1Click:Connect(function()
        for _, content in pairs(tabs) do
            content.Visible = false
        end
        tabContent.Visible = true
    end)

    return tabContent
end

function Lib:CreateButton(tab, buttonName, callback)
    local button = Instance.new("TextButton")
    button.Name = buttonName
    button.Size = UDim2.new(0, 200, 0, 50)
    button.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
    button.BorderSizePixel = 0
    button.Text = buttonName
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 24
    button.Parent = mainframe:FindFirstChild("FunctionsList")

    table.insert(buttons, button)

    button.MouseButton1Click:Connect(callback)
end

function Lib:AddToggle(tab, toggleName, defaultState, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = toggleName .. "Frame"
    toggleFrame.Size = UDim2.new(0, 200, 0, 50)
    toggleFrame.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = mainframe:FindFirstChild("FunctionsList")

    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Name = toggleName .. "Label"
    toggleLabel.Size = UDim2.new(1, -50, 1, 0)
    toggleLabel.Position = UDim2.new(0, 50, 0, 0)
    toggleLabel.BackgroundColor3 = Color3.new(1, 1, 1)
    toggleLabel.BorderSizePixel = 0
    toggleLabel.Text = toggleName
    toggleLabel.TextColor3 = Color3.new(0, 0, 0)
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextSize = 18
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.Parent = toggleFrame

    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = toggleName .. "Toggle"
    toggleButton.Size = UDim2.new(0, 30, 0, 30)
    toggleButton.Position = UDim2.new(0, 10, 0, 10)
    toggleButton.AutoButtonColor = false
    toggleButton.BackgroundColor3 = defaultState and Color3.new(0.1, 0.8, 0.1) or Color3.new(0.8, 0.1, 0.1)
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = ""
    toggleButton.Parent = toggleFrame

    local toggleState = defaultState
    toggles[toggleName] = toggleButton

    toggleButton.MouseButton1Click:Connect(function()
        toggleState = not toggleState
        toggleButton.BackgroundColor3 = toggleState and Color3.new(0.1, 0.8, 0.1) or Color3.new(0.8, 0.1, 0.1)
        callback(toggleState)
    end)

    return toggleFrame
end

function Lib:AddSlider(settings)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = settings.Name .. "Frame"
    sliderFrame.Size = UDim2.new(0, 200, 0, 50)
    sliderFrame.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Position = UDim2.new(0, 0, 1, -100)
    sliderFrame.Parent = mainframe

    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Name = settings.Name .. "Label"
    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
    sliderLabel.Position = UDim2.new(0, 0, 0, 0)
    sliderLabel.BackgroundColor3 = Color3.new(1, 1, 1)
    sliderLabel.BorderSizePixel = 0
    sliderLabel.Text = settings.Name
    sliderLabel.TextColor3 = Color3.new(0, 0, 0)
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.TextSize = 18
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.Parent = sliderFrame

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = settings.Name .. "ValueLabel"
    valueLabel.Size = UDim2.new(0, 40, 0, 20)
    valueLabel.Position = UDim2.new(1, -40, 0, 0)
    valueLabel.BackgroundColor3 = Color3.new(1, 1, 1)
    valueLabel.BorderSizePixel = 0
    valueLabel.Text = tostring(settings.Default) .. settings.ValueName
    valueLabel.TextColor3 = Color3.new(0, 0, 0)
    valueLabel.Font = Enum.Font.Gotham
    valueLabel.TextSize = 18
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = sliderFrame

    local sliderButton = Instance.new("TextButton")
    sliderButton.Name = settings.Name .. "Slider"
    sliderButton.Size = UDim2.new(1, 0, 0, 30)
    sliderButton.Position = UDim2.new(0, 0, 1, -30)
    sliderButton.AutoButtonColor = false
    sliderButton.BackgroundColor3 = Color3.new(0.75, 0.75, 0.75)
    sliderButton.BorderSizePixel = 0
    sliderButton.Text = ""
    sliderButton.Parent = sliderFrame

    local sliderValue = Instance.new("Frame")
    sliderValue.Name = settings.Name .. "SliderValue"
    sliderValue.Size = UDim2.new((settings.Default - settings.Min) / (settings.Max - settings.Min), 0, 1, 0)
    sliderValue.BackgroundColor3 = Color3.new(1, 1, 1)
    sliderValue.BorderSizePixel = 0
    sliderValue.Parent = sliderButton

    sliders[settings.Name] = sliderFrame

    local dragging = false
    local function updateValue(posX)
        local absPosX = math.clamp(posX - sliderButton.AbsolutePosition.X, 0, sliderButton.AbsoluteSize.X)
        local value = settings.Min + ((absPosX / sliderButton.AbsoluteSize.X) * (settings.Max - settings.Min))
        value = math.floor(value + 0.5)
        value = math.clamp(value, settings.Min, settings.Max)
        valueLabel.Text = tostring(value) .. settings.ValueName
        sliderValue.Size = UDim2.new((value - settings.Min) / (settings.Max - settings.Min), 0, 1, 0)
        settings.Callback(value)
    end

    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
        updateValue(UserInputService:GetMouseLocation().X)
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateValue(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return sliderFrame
end

return Lib
