local TweenService = game:GetService("TweenService")
local localplayer = game.Players.LocalPlayer

local Lib = {}
if game.CoreGui:FindFirstChild("Lib") then
    game.CoreGui:FindFirstChild("Lib"):Destroy()
end

if localplayer.PlayerGui:FindFirstChild("Lib") then
    localplayer.PlayerGui:FindFirstChild("Lib"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "Lib"

local mainframe
local tablist
local tabs = {}
local buttons = {}
local toggles = {}
local sliders = {} -- New table to hold sliders

function Lib:CreateWindow(name)
    if not mainframe then
        mainframe = Instance.new("Frame", ScreenGui)
        mainframe.Size = UDim2.new(0, 600, 0, 400)
        mainframe.Position = UDim2.new(0.5, -300, 0.5, -200)
        mainframe.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
        mainframe.BorderSizePixel = 0

        local functionslist = Instance.new("ScrollingFrame", mainframe)
        functionslist.Size = UDim2.new(0, 600, 0, 350)
        functionslist.Position = UDim2.new(0.5, -300, 0.5, -150)
        functionslist.BackgroundColor3 = Color3.new(0.5, 0.5, 0.5)
        functionslist.BorderSizePixel = 0

        tablist = Instance.new("ScrollingFrame", mainframe)
        tablist.Size = UDim2.new(0, 200, 0, 350)
        tablist.Position = UDim2.new(0.5, -300, 0.5, -150)
        tablist.BackgroundColor3 = Color3.new(0.45, 0.45, 0.45)
        tablist.BorderSizePixel = 0

        local tabframe = Instance.new("Frame", mainframe)
        tabframe.Size = UDim2.new(1, 0, 0, 50)
        tabframe.Position = UDim2.new(0, 0, 0, 0)
        tabframe.BackgroundColor3 = Color3.new(0.45, 0.45, 0.45)
        tabframe.BorderSizePixel = 0

        local close = Instance.new("ImageButton", tabframe)
        close.Image = "rbxassetid://385868188"
        close.Size = UDim2.new(0, 50, 0, 50)
        close.BackgroundTransparency = 1
        close.ImageTransparency = 1
        close.Position = UDim2.new(0, 550, 0, 0)

        local closeoverlay = Instance.new("TextLabel", close)
        closeoverlay.Text = "X"
        closeoverlay.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeoverlay.Size = UDim2.new(0, 50, 0, 50)
        closeoverlay.BackgroundTransparency = 1
        closeoverlay.TextSize = 40
        closeoverlay.Position = UDim2.new(0, 0, 0, 0)

        local minimize = Instance.new("ImageButton", tabframe)
        minimize.Image = "rbxassetid://385868188"
        minimize.Size = UDim2.new(0, 50, 0, 50)
        minimize.BackgroundTransparency = 1
        minimize.ImageTransparency = 1
        minimize.Position = UDim2.new(0, 490, 0, 0)

        local minimizeoverlay = Instance.new("TextLabel", minimize)
        minimizeoverlay.Text = "-"
        minimizeoverlay.TextColor3 = Color3.fromRGB(255, 255, 255)
        minimizeoverlay.Size = UDim2.new(0, 50, 0, 50)
        minimizeoverlay.BackgroundTransparency = 1
        minimizeoverlay.TextSize = 40
        minimizeoverlay.Position = UDim2.new(0, 0, 0, 0)

        local windowname = Instance.new("TextLabel", tabframe)
        windowname.Text = name
        windowname.Size = UDim2.new(0, 150, 0, 50)
        windowname.Position = UDim2.new(0, 12, 0, 0)
        windowname.Font = Enum.Font.GothamBold
        windowname.TextSize = 30
        windowname.TextXAlignment = Enum.TextXAlignment.Left
        windowname.TextColor3 = Color3.fromRGB(255, 255, 255)
        windowname.BackgroundTransparency = 1

        local Player = game.Players.LocalPlayer
        local Mouse = Player:GetMouse()
        function AddDrag(frame1, frame2)
            frame1.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                    local inpPos = inp.Position
                    repeat
                        game:GetService("RunService").RenderStepped:Wait()
                        frame2:TweenPosition(UDim2.new(0, Mouse.X - frame1.AbsoluteSize.X/2, 0, Mouse.Y - frame1.AbsoluteSize.Y + 15), 'Out', 'Linear', 0.08, true)
                    until inp.UserInputState == Enum.UserInputState.End
                end
            end)
        end
        AddDrag(tabframe, mainframe)

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
            if functionslist then
                functionslist:Destroy()
            end

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

    return tablist
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
    tabButton.Parent = tablist

    local listLayout = tablist:FindFirstChildOfClass("UIListLayout")
    if not listLayout then
        listLayout = Instance.new("UIListLayout")
        listLayout.Parent = tablist
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
    tabContent.Visible = false

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
    button.BackgroundColor3 = Color3.new(0.45, 0.45, 0.45)
    button.BorderSizePixel = 0
    button.Text = buttonName
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 24
    button.Parent = tab

    button.MouseButton1Click:Connect(function()
        callback()
    end)

    table.insert(buttons, button)

    local listLayout = tab:FindFirstChildOfClass("UIListLayout")
    if not listLayout then
        listLayout = Instance.new("UIListLayout")
        listLayout.Parent = tab
        listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, 2.5)
    end

    return button
end

function Lib:AddSlider(tabContent, SliderConfig)
    SliderConfig.Name = SliderConfig.Name or "Slider"
    SliderConfig.Min = SliderConfig.Min or 0
    SliderConfig.Max = SliderConfig.Max or 100
    SliderConfig.Increment = SliderConfig.Increment or 1
    SliderConfig.Default = SliderConfig.Default or 50
    SliderConfig.Callback = SliderConfig.Callback or function() end
    SliderConfig.ValueName = SliderConfig.ValueName or ""
    SliderConfig.Color = SliderConfig.Color or Color3.fromRGB(9, 149, 98)

    local Slider = {Value = SliderConfig.Default, Save = SliderConfig.Save}
    local Dragging = false

    local SliderDrag = Instance.new("Frame")
    SliderDrag.Name = "SliderDrag"
    SliderDrag.Parent = tabContent
    SliderDrag.Size = UDim2.new(0, 0, 1, 0)
    SliderDrag.BackgroundColor3 = SliderConfig.Color
    SliderDrag.BackgroundTransparency = 0.3
    SliderDrag.ClipsDescendants = true

    local SliderValueLabel = Instance.new("TextLabel")
    SliderValueLabel.Name = "ValueLabel"
    SliderValueLabel.Parent = SliderDrag
    SliderValueLabel.Size = UDim2.new(1, -12, 0, 14)
    SliderValueLabel.Position = UDim2.new(0, 12, 0, 6)
    SliderValueLabel.Font = Enum.Font.GothamBold
    SliderValueLabel.Text = tostring(SliderConfig.Default) .. " " .. SliderConfig.ValueName
    SliderValueLabel.TextColor3 = Color3.new(1, 1, 1)
    SliderValueLabel.BackgroundTransparency = 1
    SliderValueLabel.TextTransparency = 0

    local SliderBar = Instance.new("Frame")
    SliderBar.Name = "SliderBar"
    SliderBar.Parent = tabContent
    SliderBar.Size = UDim2.new(1, -24, 0, 26)
    SliderBar.Position = UDim2.new(0, 12, 0, 30)
    SliderBar.BackgroundColor3 = SliderConfig.Color
    SliderBar.BorderSizePixel = 0

    local SliderStroke = Instance.new("Frame")
    SliderStroke.Name = "Stroke"
    SliderStroke.Parent = SliderBar
    SliderStroke.BackgroundColor3 = SliderConfig.Color
    SliderStroke.BorderSizePixel = 0
    SliderStroke.Size = UDim2.new(1, 0, 1, 0)

    local SliderText = Instance.new("TextLabel")
    SliderText.Name = "ValueText"
    SliderText.Parent = SliderBar
    SliderText.Size = UDim2.new(1, -12, 0, 14)
    SliderText.Position = UDim2.new(0, 12, 0, 6)
    SliderText.Font = Enum.Font.GothamBold
    SliderText.Text = tostring(SliderConfig.Default) .. " " .. SliderConfig.ValueName
    SliderText.TextColor3 = Color3.new(1, 1, 1)
    SliderText.BackgroundTransparency = 1
    SliderText.TextTransparency = 0.8

    local SliderButton = Instance.new("TextButton")
    SliderButton.Name = "SliderButton"
    SliderButton.Parent = SliderBar
    SliderButton.Size = UDim2.new(0, 20, 0, 20)
    SliderButton.BackgroundColor3 = Color3.new(1, 1, 1)
    SliderButton.BorderSizePixel = 0
    SliderButton.Position = UDim2.new((SliderConfig.Default - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 0, 0.5, -10)
    SliderButton.Text = "."
    SliderButton.TextColor3 = Color3.new(0, 0, 0)
    SliderButton.Font = Enum.Font.GothamBold
    SliderButton.ZIndex = 2

    local function updateSlider(value)
        local percentage = (value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min)
        SliderButton.Position = UDim2.new(percentage, 0, 0.5, -10)
        SliderText.Text = tostring(math.floor(value + 0.5)) .. " " .. SliderConfig.ValueName
        SliderValueLabel.Text = tostring(math.floor(value + 0.5)) .. " " .. SliderConfig.ValueName
    end

    SliderButton.MouseButton1Down:Connect(function()
        Dragging = true
    end)

    UserInputService.InputChanged:Connect(function(input)
        if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local sizeScale = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            local newValue = SliderConfig.Min + (SliderConfig.Max - SliderConfig.Min) * sizeScale

            newValue = math.clamp(newValue, SliderConfig.Min, SliderConfig.Max)
            newValue = math.floor(newValue / SliderConfig.Increment) * SliderConfig.Increment

            updateSlider(newValue)
            SliderConfig.Callback(newValue)

            Slider.Value = newValue
        end
    end)

    SliderButton.MouseButton1Up:Connect(function()
        Dragging = false
    end)

    return Slider
end

return Lib
