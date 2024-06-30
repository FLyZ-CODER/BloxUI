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

function Lib:CreateSlider(tab, sliderName, minValue, maxValue, startValue, step, callback)
    step = step or 1 -- Шаг по умолчанию равен 1, если не указан

    local slider = Instance.new("Frame")
    slider.Name = sliderName
    slider.Size = UDim2.new(0, 200, 0, 50)
    slider.BackgroundColor3 = Color3.new(0.45, 0.45, 0.45)
    slider.BorderSizePixel = 0
    slider.Parent = tab

    local sliderText = Instance.new("TextLabel", slider)
    sliderText.Name = "SliderText"
    sliderText.Text = sliderName .. ": " .. tostring(startValue)
    sliderText.Size = UDim2.new(0, 200, 0, 50)
    sliderText.TextColor3 = Color3.new(1, 1, 1)
    sliderText.Font = Enum.Font.GothamBold
    sliderText.TextSize = 24
    sliderText.BackgroundTransparency = 1

    local sliderButton = Instance.new("TextButton", slider)
    sliderButton.Name = "SliderButton"
    sliderButton.Size = UDim2.new(0, 20, 0, 20)
    sliderButton.Position = UDim2.new((startValue - minValue) / (maxValue - minValue), 0, 0.5, -10)
    sliderButton.BackgroundColor3 = Color3.new(1, 1, 1)
    sliderButton.BorderSizePixel = 0
    sliderButton.ZIndex = 2

    local function updateSlider(value)
        local percentage = (value - minValue) / (maxValue - minValue)
        sliderButton.Position = UDim2.new(percentage, 0, 0.5, -10)
        sliderText.Text = sliderName .. ": " .. tostring(math.floor(value + 0.5)) -- Round to nearest integer
    end

    sliderButton.MouseButton1Down:Connect(function()
        local input = game:GetService("UserInputService")
        local conn
        conn = input.InputChanged:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseMovement then
                local mousePos = inp.Position.X
                local framePos = slider.AbsolutePosition.X
                local frameSize = slider.AbsoluteSize.X
                local relativePos = (mousePos - framePos) / frameSize
                local newValue = minValue + (maxValue - minValue) * math.clamp(relativePos, 0, 1)

                -- Округляем newValue в соответствии с шагом
                newValue = minValue + math.floor((newValue - minValue) / step) * step
                newValue = math.clamp(newValue, minValue, maxValue)

                updateSlider(newValue)
                callback(newValue)
            end
        end)

        input.InputEnded:Connect(function(inp)
            if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                conn:Disconnect()
            end
        end)
    end)

    updateSlider(startValue)
    callback(startValue)

    table.insert(sliders, slider)

    local listLayout = tab:FindFirstChildOfClass("UIListLayout")
    if not listLayout then
        listLayout = Instance.new("UIListLayout")
        listLayout.Parent = tab
        listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        listLayout.SortOrder = Enum.SortOrder.LayoutOrder
        listLayout.Padding = UDim.new(0, 2.5)
    end

    return slider
end


return Lib
