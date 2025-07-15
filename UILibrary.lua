-- Velocity Hub UI
-- Load with: loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/yourrepo/main/velocityhub.lua"))()

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Create main UI
local gui = Instance.new("ScreenGui")
gui.Name = "VelocityHubUI"
gui.Parent = player:WaitForChild("PlayerGui")

-- Detect executor name
local executorName = "Unknown"
if identifyexecutor then
    executorName = identifyexecutor() or "Unknown"
elseif getexecutorname then
    executorName = getexecutorname() or "Unknown"
elseif syn and syn.protect_gui then
    executorName = "Synapse X"
end

-- Main UI Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 500, 0, 450)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -225)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

-- UI Glow Effect
local uiGlow = Instance.new("ImageLabel")
uiGlow.Name = "UIGlow"
uiGlow.Size = UDim2.new(1, 30, 1, 30)
uiGlow.Position = UDim2.new(0, -15, 0, -15)
uiGlow.Image = "rbxassetid://4996891970"
uiGlow.ImageColor3 = Color3.fromRGB(0, 255, 0)
uiGlow.ImageTransparency = 0.8
uiGlow.ScaleType = Enum.ScaleType.Slice
uiGlow.SliceCenter = Rect.new(20, 20, 280, 280)
uiGlow.BackgroundTransparency = 1
uiGlow.Parent = mainFrame

-- UI Border
local uiBorder = Instance.new("Frame")
uiBorder.Name = "UIBorder"
uiBorder.Size = UDim2.new(1, 0, 1, 0)
uiBorder.Position = UDim2.new(0, 0, 0, 0)
uiBorder.BackgroundTransparency = 1
uiBorder.BorderSizePixel = 2
uiBorder.BorderColor3 = Color3.fromRGB(0, 255, 0)
uiBorder.Parent = mainFrame

-- Title Bar
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Velocity: Hub | Tha Bronx 3 | v1.0.0"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.Parent = titleBar

-- Executor name label with glow
local executorLabel = Instance.new("TextLabel")
executorLabel.Name = "ExecutorLabel"
executorLabel.Size = UDim2.new(1, -20, 0, 20)
executorLabel.Position = UDim2.new(0, 10, 1, 5)
executorLabel.BackgroundTransparency = 1
executorLabel.Text = "Executor: " .. executorName
executorLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
executorLabel.Font = Enum.Font.GothamBold
executorLabel.TextSize = 14
executorLabel.TextXAlignment = Enum.TextXAlignment.Left
executorLabel.Parent = titleBar

-- Mobile toggle button (only visible on mobile)
local mobileToggle = Instance.new("ImageButton")
mobileToggle.Name = "MobileToggle"
mobileToggle.Size = UDim2.new(0, 40, 0, 40)
mobileToggle.Position = UDim2.new(0, 10, 0.5, -20)
mobileToggle.Image = "rbxassetid://3926305904"
mobileToggle.ImageRectOffset = Vector2.new(964, 324)
mobileToggle.ImageRectSize = Vector2.new(36, 36)
mobileToggle.BackgroundTransparency = 1
mobileToggle.Visible = UserInputService.TouchEnabled
mobileToggle.Parent = gui

-- Tab bar (transparent background)
local tabBar = Instance.new("Frame")
tabBar.Name = "TabBar"
tabBar.Size = UDim2.new(1, 0, 0, 40)
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.BackgroundTransparency = 1
tabBar.BorderSizePixel = 0
tabBar.Parent = mainFrame

-- Create tabs
local tabs = {"Players", "Dupe", "Farms", "Combat", "Settings", "Credits"}

local tabButtons = {}
local tabContents = {}

for i, tabName in ipairs(tabs) do
    -- Tab button (transparent with just text)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName .. "Tab"
    tabButton.Size = UDim2.new(1/#tabs, -5, 1, 0)
    tabButton.Position = UDim2.new((i-1)/#tabs, 0, 0, 0)
    tabButton.BackgroundTransparency = 1
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.fromRGB(150, 150, 150)
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 14
    tabButton.AutoButtonColor = false
    tabButton.Parent = tabBar
    tabButtons[tabName] = tabButton
    
    -- Tab content frame
    local tabContent = Instance.new("Frame")
    tabContent.Name = tabName .. "Content"
    tabContent.Size = UDim2.new(1, 0, 1, -80)
    tabContent.Position = UDim2.new(0, 0, 0, 80)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.Parent = mainFrame
    tabContents[tabName] = tabContent
    
    -- Add scroll frame for content
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Name = "ScrollFrame"
    scrollFrame.Size = UDim2.new(1, 0, 1, 0)
    scrollFrame.Position = UDim2.new(0, 0, 0, 0)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.ScrollBarThickness = 5
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    scrollFrame.Parent = tabContent
    
    -- Button click event
    tabButton.MouseButton1Click:Connect(function()
        for name, content in pairs(tabContents) do
            content.Visible = (name == tabName)
        end
        for name, button in pairs(tabButtons) do
            if name == tabName then
                button.TextColor3 = Color3.fromRGB(0, 255, 0)
                local tween = TweenService:Create(button, TweenInfo.new(0.2), {TextSize = 16})
                tween:Play()
            else
                button.TextColor3 = Color3.fromRGB(150, 150, 150)
                local tween = TweenService:Create(button, TweenInfo.new(0.2), {TextSize = 14})
                tween:Play()
            end
        end
    end)
end

-- Make first tab active by default
tabButtons["Players"].TextColor3 = Color3.fromRGB(0, 255, 0)
tabContents["Players"].Visible = true

-- Draggable functionality
local dragging = false
local dragInput, dragStart, startPos

local function updateInput(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input == dragInput or input.UserInputType == Enum.UserInputType.Touch) then
        updateInput(input)
    end
end)

-- Mobile toggle functionality
mobileToggle.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    mobileToggle.ImageRectOffset = mainFrame.Visible and Vector2.new(964, 324) or Vector2.new(924, 324)
end)

-- Left Shift to toggle for PC
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.LeftShift then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

-- UI Element Creation Functions
local function createSection(parent, name, position)
    local section = Instance.new("Frame")
    section.Name = name .. "Section"
    section.Size = UDim2.new(1, -20, 0, 0)
    section.Position = UDim2.new(0, 10, 0, position)
    section.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    section.BackgroundTransparency = 0.5
    section.BorderSizePixel = 0
    section.ClipsDescendants = true
    section.Parent = parent
    
    local sectionCorner = Instance.new("UICorner")
    sectionCorner.CornerRadius = UDim.new(0, 6)
    sectionCorner.Parent = section
    
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Name = "Title"
    sectionTitle.Size = UDim2.new(1, 0, 0, 30)
    sectionTitle.Position = UDim2.new(0, 0, 0, 0)
    sectionTitle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    sectionTitle.BackgroundTransparency = 0.7
    sectionTitle.Text = "    " .. name
    sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextSize = 14
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.Parent = section
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 6)
    titleCorner.Parent = sectionTitle
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = section
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Name = "ContentLayout"
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Parent = contentFrame
    
    contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        section.Size = UDim2.new(1, -20, 0, contentLayout.AbsoluteContentSize.Y + 38)
    end)
    
    return contentFrame
end

local function createButton(parent, text, callback)
    local button = Instance.new("TextButton")
    button.Name = text .. "Button"
    button.Size = UDim2.new(0.95, 0, 0, 35)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.AutoButtonColor = false
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = parent
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = button
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    
    button.MouseButton1Down:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    end)
    
    button.MouseButton1Up:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    
    button.Activated:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and callback then
            callback()
        end
    end)
    
    return button
end

local function createToggle(parent, text, default, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = text .. "Toggle"
    toggleFrame.Size = UDim2.new(0.95, 0, 0, 30)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = parent
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 50, 0, 25)
    toggleButton.Position = UDim2.new(1, -50, 0.5, -12.5)
    toggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(70, 70, 70)
    toggleButton.AutoButtonColor = false
    toggleButton.Text = ""
    toggleButton.Parent = toggleFrame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 12)
    toggleCorner.Parent = toggleButton
    
    local toggleDot = Instance.new("Frame")
    toggleDot.Name = "ToggleDot"
    toggleDot.Size = UDim2.new(0, 21, 0, 21)
    toggleDot.Position = default and UDim2.new(1, -23, 0.5, -10.5) or UDim2.new(0, 2, 0.5, -10.5)
    toggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleDot.Parent = toggleButton
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(0, 12)
    dotCorner.Parent = toggleDot
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Name = "ToggleLabel"
    toggleLabel.Size = UDim2.new(1, -60, 1, 0)
    toggleLabel.Position = UDim2.new(0, 0, 0, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = text
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.Font = Enum.Font.Gotham
    toggleLabel.TextSize = 14
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.Parent = toggleFrame
    
    local state = default
    
    local function updateToggle()
        if state then
            TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -23, 0.5, -10.5)}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 170, 0)}):Play()
        else
            TweenService:Create(toggleDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -10.5)}):Play()
            TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
        end
        if callback then callback(state) end
    end
    
    toggleButton.Activated:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            state = not state
            updateToggle()
        end
    end)
    
    return {
        Set = function(newState)
            state = newState
            updateToggle()
        end,
        Get = function()
            return state
        end
    }
end

local function createSlider(parent, text, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = text .. "Slider"
    sliderFrame.Size = UDim2.new(0.95, 0, 0, 60)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = parent
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Name = "SliderLabel"
    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
    sliderLabel.Position = UDim2.new(0, 0, 0, 0)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = text .. ": " .. default
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.Font = Enum.Font.Gotham
    sliderLabel.TextSize = 14
    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    sliderLabel.Parent = sliderFrame
    
    local sliderTrack = Instance.new("Frame")
    sliderTrack.Name = "SliderTrack"
    sliderTrack.Size = UDim2.new(1, 0, 0, 10)
    sliderTrack.Position = UDim2.new(0, 0, 0, 30)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    sliderTrack.Parent = sliderFrame
    
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(0, 5)
    trackCorner.Parent = sliderTrack
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "SliderFill"
    sliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    sliderFill.Position = UDim2.new(0, 0, 0, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    sliderFill.Parent = sliderTrack
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 5)
    fillCorner.Parent = sliderFill
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Name = "SliderButton"
    sliderButton.Size = UDim2.new(0, 20, 0, 20)
    sliderButton.Position = UDim2.new((default - min)/(max - min), -10, 0.5, -10)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.AutoButtonColor = false
    sliderButton.Text = ""
    sliderButton.Parent = sliderTrack
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 10)
    buttonCorner.Parent = sliderButton
    
    local dragging = false
    local dragStart = nil
    local startX = nil
    
    local function updateSlider(value)
        value = math.clamp(value, min, max)
        local fillSize = (value - min)/(max - min)
        sliderFill.Size = UDim2.new(fillSize, 0, 1, 0)
        sliderButton.Position = UDim2.new(fillSize, -10, 0.5, -10)
        sliderLabel.Text = text .. ": " .. string.format("%.1f", value)
        if callback then callback(value) end
    end
    
    local function handleInput(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position.X
            startX = sliderButton.Position.X.Scale
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end
    
    sliderButton.Activated:Connect(handleInput)
    sliderTrack.Activated:Connect(handleInput)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position.X - dragStart
            local relativeDelta = delta / sliderTrack.AbsoluteSize.X
            local newValue = min + (max - min) * math.clamp(startX + relativeDelta, 0, 1)
            updateSlider(newValue)
        end
    end)
    
    return {
        Set = function(value)
            updateSlider(value)
        end,
        Get = function()
            return tonumber(string.match(sliderLabel.Text, ": (.*)"))
        end
    }
end

local function createDropdown(parent, text, options, default, callback)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Name = text .. "Dropdown"
    dropdownFrame.Size = UDim2.new(0.95, 0, 0, 35)
    dropdownFrame.BackgroundTransparency = 1
    dropdownFrame.Parent = parent
    
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Name = "DropdownButton"
    dropdownButton.Size = UDim2.new(1, 0, 0, 35)
    dropdownButton.Position = UDim2.new(0, 0, 0, 0)
    dropdownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    dropdownButton.AutoButtonColor = false
    dropdownButton.Text = text .. ": " .. (options[default] or "")
    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownButton.Font = Enum.Font.Gotham
    dropdownButton.TextSize = 14
    dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
    dropdownButton.Parent = dropdownFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 6)
    buttonCorner.Parent = dropdownButton
    
    local dropdownArrow = Instance.new("ImageLabel")
    dropdownArrow.Name = "DropdownArrow"
    dropdownArrow.Size = UDim2.new(0, 15, 0, 15)
    dropdownArrow.Position = UDim2.new(1, -20, 0.5, -7.5)
    dropdownArrow.Image = "rbxassetid://3926305904"
    dropdownArrow.ImageRectOffset = Vector2.new(564, 284)
    dropdownArrow.ImageRectSize = Vector2.new(36, 36)
    dropdownArrow.BackgroundTransparency = 1
    dropdownArrow.Parent = dropdownButton
    
    local dropdownList = Instance.new("ScrollingFrame")
    dropdownList.Name = "DropdownList"
    dropdownList.Size = UDim2.new(1, 0, 0, 0)
    dropdownList.Position = UDim2.new(0, 0, 0, 40)
    dropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    dropdownList.BorderSizePixel = 0
    dropdownList.ScrollBarThickness = 5
    dropdownList.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    dropdownList.Visible = false
    dropdownList.Parent = dropdownFrame
    
    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 6)
    listCorner.Parent = dropdownList
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Name = "ListLayout"
    listLayout.Padding = UDim.new(0, 2)
    listLayout.Parent = dropdownList
    
    for i, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = option .. "Option"
        optionButton.Size = UDim2.new(1, -10, 0, 30)
        optionButton.Position = UDim2.new(0, 5, 0, (i-1)*32)
        optionButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        optionButton.AutoButtonColor = false
        optionButton.Text = option
        optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        optionButton.Font = Enum.Font.Gotham
        optionButton.TextSize = 14
        optionButton.Parent = dropdownList
        
        local optionCorner = Instance.new("UICorner")
        optionCorner.CornerRadius = UDim.new(0, 4)
        optionCorner.Parent = optionButton
        
        optionButton.MouseEnter:Connect(function()
            optionButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)
        
        optionButton.MouseLeave:Connect(function()
            optionButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end)
        
        optionButton.MouseButton1Click:Connect(function()
            dropdownButton.Text = text .. ": " .. option
            dropdownList.Visible = false
            TweenService:Create(dropdownArrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
            if callback then callback(i, option) end
        end)
    end
    
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        dropdownList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
        dropdownList.Size = UDim2.new(1, 0, 0, math.min(listLayout.AbsoluteContentSize.Y, 150))
    end)
    
    local function toggleDropdown()
        dropdownList.Visible = not dropdownList.Visible
        if dropdownList.Visible then
            TweenService:Create(dropdownArrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
        else
            TweenService:Create(dropdownArrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
        end
    end
    
    dropdownButton.Activated:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            toggleDropdown()
        end
    end)
    
    -- Close dropdown when clicking outside
    gui.InputBegan:Connect(function(input)
        if dropdownList.Visible and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            local absolutePos = dropdownList.AbsolutePosition
            local absoluteSize = dropdownList.AbsoluteSize
            local clickPos = input.Position
            
            if not (clickPos.X >= absolutePos.X and clickPos.X <= absolutePos.X + absoluteSize.X and
                   clickPos.Y >= absolutePos.Y and clickPos.Y <= absolutePos.Y + absoluteSize.Y) then
                toggleDropdown()
            end
        end
    end)
    
    return {
        Set = function(index)
            if options[index] then
                dropdownButton.Text = text .. ": " .. options[index]
                if callback then callback(index, options[index]) end
            end
        end,
        Get = function()
            local selected = string.match(dropdownButton.Text, ": (.*)")
            for i, option in ipairs(options) do
                if option == selected then
                    return i, option
                end
            end
            return default, options[default]
        end
    }
end

local function createTextBox(parent, text, default, callback)
    local textBoxFrame = Instance.new("Frame")
    textBoxFrame.Name = text .. "TextBox"
    textBoxFrame.Size = UDim2.new(0.95, 0, 0, 70)
    textBoxFrame.BackgroundTransparency = 1
    textBoxFrame.Parent = parent
    
    local textBoxLabel = Instance.new("TextLabel")
    textBoxLabel.Name = "TextBoxLabel"
    textBoxLabel.Size = UDim2.new(1, 0, 0, 20)
    textBoxLabel.Position = UDim2.new(0, 0, 0, 0)
    textBoxLabel.BackgroundTransparency = 1
    textBoxLabel.Text = text
    textBoxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBoxLabel.Font = Enum.Font.Gotham
    textBoxLabel.TextSize = 14
    textBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
    textBoxLabel.Parent = textBoxFrame
    
    local textBox = Instance.new("TextBox")
    textBox.Name = "TextBox"
    textBox.Size = UDim2.new(1, 0, 0, 35)
    textBox.Position = UDim2.new(0, 0, 0, 25)
    textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 14
    textBox.Text = default or ""
    textBox.Parent = textBoxFrame
    
    local boxCorner = Instance.new("UICorner")
    boxCorner.CornerRadius = UDim.new(0, 6)
    boxCorner.Parent = textBox
    
    if callback then
        textBox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                callback(textBox.Text)
            end
        end)
    end
    
    return {
        Set = function(value)
            textBox.Text = tostring(value)
        end,
        Get = function()
            return textBox.Text
        end
    }
end

-- Populate Players tab (with teleports)
local playersSection1 = createSection(tabContents["Players"].ScrollFrame, "Player Options", 0)
createButton(playersSection1, "Teleport to Player", function()
    print("Teleport to Player clicked")
end)
createToggle(playersSection1, "Spectate Player", false, function(state)
    print("Spectate Player:", state)
end)
createDropdown(playersSection1, "Player List", {"Player1", "Player2", "Player3"}, 1, function(index, option)
    print("Selected player:", option)
end)
createSlider(playersSection1, "Teleport Delay", 0, 5, 1, function(value)
    print("Teleport delay set to:", value)
end)

local playersSection2 = createSection(tabContents["Players"].ScrollFrame, "Teleports", 200)
createButton(playersSection2, "Bank Tools", function()
    print("Teleporting to Bank Tools")
end)
createButton(playersSection2, "Exotic Dealer", function()
    print("Teleporting to Exotic Dealer")
end)
createButton(playersSection2, "Main Gun", function()
    print("Teleporting to Main Gun")
end)
createButton(playersSection2, "Hilltop Gun", function()
    print("Teleporting to Hilltop Gun")
end)
createButton(playersSection2, "Switch Shop", function()
    print("Teleporting to Switch Shop")
end)
createButton(playersSection2, "Bank", function()
    print("Teleporting to Bank")
end)
createButton(playersSection2, "Dealership", function()
    print("Teleporting to Dealership")
end)

-- Populate Dupe tab
local dupeSection1 = createSection(tabContents["Dupe"].ScrollFrame, "Duplication", 0)
createButton(dupeSection1, "Duplicate Items", function()
    print("Duplicating items...")
end)
createToggle(dupeSection1, "Auto Dupe", false, function(state)
    print("Auto Dupe:", state)
end)
createSlider(dupeSection1, "Dupe Speed", 1, 10, 5, function(value)
    print("Dupe speed set to:", value)
end)

local dupeSection2 = createSection(tabContents["Dupe"].ScrollFrame, "Dupe Settings", 150)
createTextBox(dupeSection2, "Item Name", "Enter item name", function(text)
    print("Item name set to:", text)
end)
createSlider(dupeSection2, "Dupe Amount", 1, 100, 10, function(value)
    print("Dupe amount set to:", value)
end)

-- Populate Farms tab
local farmsSection1 = createSection(tabContents["Farms"].ScrollFrame, "Farming Options", 0)
createToggle(farmsSection1, "Enable AutoFarm", false, function(state)
    print("AutoFarm:", state)
end)
createDropdown(farmsSection1, "Farm Location", {"Bank", "Dealership", "Construction"}, 1, function(index, option)
    print("Farm location:", option)
end)
createSlider(farmsSection1, "Farm Radius", 10, 100, 50, function(value)
    print("Farm radius:", value)
end)

local farmsSection2 = createSection(tabContents["Farms"].ScrollFrame, "Farm Settings", 150)
createTextBox(farmsSection2, "Target Item", "Enter item name", function(text)
    print("Target item set to:", text)
end)
createSlider(farmsSection2, "Farm Speed", 1, 10, 5, function(value)
    print("Farm speed set to:", value)
end)

-- Populate Combat tab
local combatSection1 = createSection(tabContents["Combat"].ScrollFrame, "Combat Options", 0)
createToggle(combatSection1, "Aimbot", false, function(state)
    print("Aimbot:", state)
end)
createToggle(combatSection1, "Silent Aim", false, function(state)
    print("Silent Aim:", state)
end)
createSlider(combatSection1, "Aimbot FOV", 1, 30, 10, function(value)
    print("Aimbot FOV:", value)
end)
createDropdown(combatSection1, "Aimbot Bone", {"Head", "Torso", "Random"}, 1, function(index, option)
    print("Aimbot bone:", option)
end)

local combatSection2 = createSection(tabContents["Combat"].ScrollFrame, "Weapon Settings", 200)
createTextBox(combatSection2, "Weapon Name", "Enter weapon name", function(text)
    print("Weapon name set to:", text)
end)
createSlider(combatSection2, "Damage Multiplier", 1, 10, 1, function(value)
    print("Damage multiplier set to:", value)
end)

-- Populate Settings tab
local settingsSection1 = createSection(tabContents["Settings"].ScrollFrame, "UI Settings", 0)
createToggle(settingsSection1, "Show Watermark", true, function(state)
    print("Watermark:", state)
end)
createSlider(settingsSection1, "UI Transparency", 0, 1, 0.15, function(value)
    mainFrame.BackgroundTransparency = value
end)
createDropdown(settingsSection1, "UI Theme", {"Green", "Blue", "Red", "Purple"}, 1, function(index, option)
    local color = Color3.fromRGB(0, 255, 0)
    if option == "Blue" then color = Color3.fromRGB(0, 150, 255)
    elseif option == "Red" then color = Color3.fromRGB(255, 50, 50)
    elseif option == "Purple" then color = Color3.fromRGB(150, 0, 255) end
    uiBorder.BorderColor3 = color
    uiGlow.ImageColor3 = color
    executorLabel.TextColor3 = color
    for _, button in pairs(tabButtons) do
        if button.TextColor3 == Color3.fromRGB(0, 255, 0) then
            button.TextColor3 = color
        end
    end
end)

local settingsSection2 = createSection(tabContents["Settings"].ScrollFrame, "Keybinds", 150)
createTextBox(settingsSection2, "Toggle UI Key", "LeftShift", function(text)
    print("Toggle UI key set to:", text)
end)
createSlider(settingsSection2, "UI Scale", 50, 150, 100, function(value)
    mainFrame.Size = UDim2.new(0, 500 * (value/100), 0, 450 * (value/100))
    mainFrame.Position = UDim2.new(0.5, -250 * (value/100), 0.5, -225 * (value/100))
end)

-- Populate Credits tab
local creditsSection = createSection(tabContents["Credits"].ScrollFrame, "Credits", 0)
local creditsLabel = Instance.new("TextLabel")
creditsLabel.Name = "CreditsLabel"
creditsLabel.Size = UDim2.new(1, -20, 0, 200)
creditsLabel.Position = UDim2.new(0, 10, 0, 10)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Text = "Velocity: Hub | Tha Bronx 3 | v1.0.0\n\nDeveloped by [Your Name]\n\nSpecial thanks to:\n- Contributors\n- Testers\n- Community"
creditsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
creditsLabel.Font = Enum.Font.Gotham
creditsLabel.TextSize = 16
creditsLabel.TextYAlignment = Enum.TextYAlignment.Top
creditsLabel.Parent = creditsSection

-- Update canvas size for all scroll frames
for _, tabContent in pairs(tabContents) do
    local scrollFrame = tabContent.ScrollFrame
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = scrollFrame
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)
end
