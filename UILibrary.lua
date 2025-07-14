-- Velocity UI Library

local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

local VelocityLibrary = {}

function VelocityLibrary:CreateWindow(settings)
    local player = game.Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    screenGui.Name = settings.Name or "VelocityUI"
    screenGui.ResetOnSpawn = false

    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    -- Drag area
    local dragArea = Instance.new("Frame")
    dragArea.Size = UDim2.new(1, 0, 0, 25)
    dragArea.BackgroundTransparency = 1
    dragArea.Parent = mainFrame

    local dragging
    local dragInput
    local dragStart
    local startPos

    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
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

    dragArea.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                           startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Header
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 25)
    header.BackgroundColor3 = Color3.fromRGB(20,20,20)
    header.BorderSizePixel = 0
    header.Text = settings.Title or "Velocity UI"
    header.Font = Enum.Font.SourceSansSemibold
    header.TextSize = 16
    header.TextColor3 = Color3.fromRGB(230,230,230)
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Parent = mainFrame

    -- Left Panel
    local leftPanel = Instance.new("Frame")
    leftPanel.Size = UDim2.new(0, 120, 1, -25)
    leftPanel.Position = UDim2.new(0, 0, 0, 25)
    leftPanel.BackgroundColor3 = Color3.fromRGB(40,40,40)
    leftPanel.BorderSizePixel = 0
    leftPanel.Parent = mainFrame

    -- Right Panel
    local rightPanel = Instance.new("Frame")
    rightPanel.Size = UDim2.new(1, -120, 1, -25)
    rightPanel.Position = UDim2.new(0, 120, 0, 25)
    rightPanel.BackgroundColor3 = Color3.fromRGB(35,35,35)
    rightPanel.BorderSizePixel = 0
    rightPanel.Parent = mainFrame

    -- Tabs
    local tabs = settings.Tabs or {"Tab1"}
    local activeTab = settings.ActiveTab or tabs[1]
    local tabButtons = {}

    for i, tabName in ipairs(tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1,0,0,25)
        tabButton.Position = UDim2.new(0,0,0,(i-1)*30 + 5)
        tabButton.BackgroundTransparency = 1
        tabButton.Text = tabName
        tabButton.Font = Enum.Font.SourceSans
        tabButton.TextSize = 18
        tabButton.TextColor3 = tabName == activeTab and Color3.fromRGB(255,80,80) or Color3.fromRGB(200,200,200)
        tabButton.TextXAlignment = Enum.TextXAlignment.Center
        tabButton.Parent = leftPanel

        tabButton.MouseButton1Click:Connect(function()
            for _,btn in ipairs(tabButtons) do
                btn.TextColor3 = Color3.fromRGB(200,200,200)
            end
            tabButton.TextColor3 = Color3.fromRGB(255,80,80)
        end)

        table.insert(tabButtons, tabButton)
    end

    -- Main Button
    local mainButton = Instance.new("TextButton")
    mainButton.Size = UDim2.new(1,-40,0,30)
    mainButton.Position = UDim2.new(0,20,0,20)
    mainButton.BackgroundColor3 = Color3.fromRGB(60,60,60)
    mainButton.BorderSizePixel = 0
    mainButton.Text = settings.ButtonText or "Button"
    mainButton.Font = Enum.Font.SourceSans
    mainButton.TextSize = 18
    mainButton.TextColor3 = Color3.fromRGB(255,255,255)
    mainButton.Parent = rightPanel

    return {
        MainFrame = mainFrame,
        Tabs = tabButtons,
        Button = mainButton
    }
end

return VelocityLibrary
