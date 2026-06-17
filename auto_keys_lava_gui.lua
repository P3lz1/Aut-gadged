-- Auto Keys Lava GUI
-- Loadstring-ready Roblox Lua script.
-- Host this file as a raw .lua file, then run:
-- loadstring(game:HttpGet("RAW_FILE_URL_HERE"))()

local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("LavaAutoKeysGui")
if oldGui then
    oldGui:Destroy()
end

local enabled = false
local leftClickHeld = false

local actions = {
    { name = "E", key = Enum.KeyCode.E, enabled = false, speed = 5 },
    { name = "R", key = Enum.KeyCode.R, enabled = false, speed = 5 },
    { name = "Q", key = Enum.KeyCode.Q, enabled = false, speed = 5 },
    { name = "C", key = Enum.KeyCode.C, enabled = false, speed = 5 },
    { name = "V", key = Enum.KeyCode.V, enabled = false, speed = 5 },
    { name = "Left Click", mouse = true, enabled = false, speed = 5 },
}

local gui = Instance.new("ScreenGui")
gui.Name = "LavaAutoKeysGui"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 292, 0, 318)
frame.Position = UDim2.new(0, 30, 0, 120)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ClipsDescendants = true
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 8)
frameCorner.Parent = frame

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(255, 90, 20)
frameStroke.Thickness = 1
frameStroke.Transparency = 0.15
frameStroke.Parent = frame

local lavaLayer = Instance.new("Frame")
lavaLayer.Size = UDim2.new(1, 0, 1, 0)
lavaLayer.BackgroundTransparency = 1
lavaLayer.ClipsDescendants = true
lavaLayer.ZIndex = 1
lavaLayer.Parent = frame

local function makeLavaPiece(width, height, color, transparency, y, rotation, speed)
    local piece = Instance.new("Frame")
    piece.Size = UDim2.new(0, width, 0, height)
    piece.Position = UDim2.new(0, 292 + math.random(0, 180), 0, y)
    piece.BackgroundColor3 = color
    piece.BackgroundTransparency = transparency
    piece.BorderSizePixel = 0
    piece.Rotation = rotation
    piece.ZIndex = 1
    piece.Parent = lavaLayer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = piece

    task.spawn(function()
        while lavaLayer.Parent do
            local startX = 292 + math.random(0, 220)
            local endX = -width - math.random(60, 180)
            local nextY = y + math.random(-18, 18)

            if nextY < -20 then
                nextY = -20
            elseif nextY > 318 then
                nextY = 318
            end

            piece.Position = UDim2.new(0, startX, 0, nextY)
            piece.Rotation = rotation + math.random(-4, 4)

            local tween = TweenService:Create(
                piece,
                TweenInfo.new(speed + (math.random(0, 80) / 100), Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
                { Position = UDim2.new(0, endX, 0, nextY + math.random(-8, 8)) }
            )

            tween:Play()
            tween.Completed:Wait()
            task.wait(math.random(0, 20) / 100)
        end
    end)
end

for i = 1, 16 do
    makeLavaPiece(
        math.random(130, 250),
        math.random(16, 34),
        Color3.fromRGB(math.random(65, 120), 0, math.random(5, 20)),
        math.random(18, 38) / 100,
        math.random(8, 305),
        math.random(-12, 12),
        math.random(28, 46) / 10
    )
end

for i = 1, 12 do
    makeLavaPiece(
        math.random(115, 225),
        math.random(8, 19),
        Color3.fromRGB(255, math.random(35, 92), 0),
        math.random(12, 32) / 100,
        math.random(15, 300),
        math.random(-10, 10),
        math.random(18, 34) / 10
    )
end

for i = 1, 18 do
    makeLavaPiece(
        math.random(45, 120),
        math.random(2, 5),
        Color3.fromRGB(255, math.random(110, 185), math.random(15, 45)),
        math.random(0, 18) / 100,
        math.random(10, 305),
        math.random(-18, 18),
        math.random(12, 26) / 10
    )
end

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -36, 0, 34)
title.Position = UDim2.new(0, 12, 0, 4)
title.BackgroundTransparency = 1
title.Text = "Lava Auto Keys"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2
title.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 24, 0, 24)
closeButton.Position = UDim2.new(1, -32, 0, 8)
closeButton.BackgroundColor3 = Color3.fromRGB(135, 25, 20)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 14
closeButton.ZIndex = 2
closeButton.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

local mainToggle = Instance.new("TextButton")
mainToggle.Size = UDim2.new(1, -32, 0, 34)
mainToggle.Position = UDim2.new(0, 16, 0, 44)
mainToggle.BackgroundColor3 = Color3.fromRGB(150, 30, 25)
mainToggle.Text = "AUS"
mainToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainToggle.Font = Enum.Font.SourceSansBold
mainToggle.TextSize = 18
mainToggle.ZIndex = 2
mainToggle.Parent = frame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = mainToggle

local function pressKey(keyCode)
    VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
    task.wait()
    VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
end

local function setLeftClickHold(state)
    if leftClickHeld == state then
        return
    end

    leftClickHeld = state

    local mousePos = UserInputService:GetMouseLocation()
    VirtualInputManager:SendMouseButtonEvent(mousePos.X, mousePos.Y, 0, state, game, 0)
end

local function releaseAll()
    for _, action in ipairs(actions) do
        if action.key then
            VirtualInputManager:SendKeyEvent(false, action.key, false, game)
        end
    end

    setLeftClickHold(false)
end

local function updateMainToggle()
    if enabled then
        mainToggle.Text = "AN"
        mainToggle.BackgroundColor3 = Color3.fromRGB(30, 150, 55)
    else
        mainToggle.Text = "AUS"
        mainToggle.BackgroundColor3 = Color3.fromRGB(150, 30, 25)
        releaseAll()
    end
end

mainToggle.MouseButton1Click:Connect(function()
    enabled = not enabled
    updateMainToggle()
end)

closeButton.MouseButton1Click:Connect(function()
    enabled = false
    releaseAll()
    gui:Destroy()
end)

local function createActionRow(action, index)
    local y = 90 + ((index - 1) * 35)

    local checkbox = Instance.new("TextButton")
    checkbox.Size = UDim2.new(0, 24, 0, 24)
    checkbox.Position = UDim2.new(0, 18, 0, y)
    checkbox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    checkbox.BorderColor3 = Color3.fromRGB(255, 100, 20)
    checkbox.Text = ""
    checkbox.TextColor3 = Color3.fromRGB(255, 210, 90)
    checkbox.Font = Enum.Font.SourceSansBold
    checkbox.TextSize = 19
    checkbox.ZIndex = 2
    checkbox.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 100, 0, 24)
    label.Position = UDim2.new(0, 52, 0, y)
    label.BackgroundTransparency = 1
    label.Text = action.name
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.SourceSansBold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 2
    label.Parent = frame

    local speedBox = Instance.new("TextBox")
    speedBox.Size = UDim2.new(0, 74, 0, 24)
    speedBox.Position = UDim2.new(0, 176, 0, y)
    speedBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    speedBox.BorderColor3 = Color3.fromRGB(255, 100, 20)
    speedBox.Text = tostring(action.speed)
    speedBox.PlaceholderText = "ms"
    speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    speedBox.Font = Enum.Font.SourceSans
    speedBox.TextSize = 15
    speedBox.ClearTextOnFocus = false
    speedBox.ZIndex = 2
    speedBox.Parent = frame

    local msLabel = Instance.new("TextLabel")
    msLabel.Size = UDim2.new(0, 25, 0, 24)
    msLabel.Position = UDim2.new(0, 255, 0, y)
    msLabel.BackgroundTransparency = 1
    msLabel.Text = "ms"
    msLabel.TextColor3 = Color3.fromRGB(255, 180, 120)
    msLabel.Font = Enum.Font.SourceSansBold
    msLabel.TextSize = 14
    msLabel.ZIndex = 2
    msLabel.Parent = frame

    checkbox.MouseButton1Click:Connect(function()
        action.enabled = not action.enabled
        checkbox.Text = action.enabled and "X" or ""

        if not action.enabled and action.mouse then
            setLeftClickHold(false)
        end
    end)

    speedBox.FocusLost:Connect(function()
        local value = tonumber(speedBox.Text)

        if value and value >= 1 then
            action.speed = value
            speedBox.Text = tostring(math.floor(value))
        else
            action.speed = 5
            speedBox.Text = "5"
        end
    end)
end

for i, action in ipairs(actions) do
    createActionRow(action, i)
end

for _, action in ipairs(actions) do
    if action.key then
        task.spawn(function()
            while gui.Parent do
                if enabled and action.enabled then
                    pressKey(action.key)
                    task.wait(math.max(action.speed, 1) / 1000)
                else
                    task.wait(0.05)
                end
            end
        end)
    end
end

task.spawn(function()
    while gui.Parent do
        local clickAction = actions[6]

        if enabled and clickAction.enabled then
            setLeftClickHold(true)
            task.wait(math.max(clickAction.speed, 1) / 1000)
        else
            setLeftClickHold(false)
            task.wait(0.05)
        end
    end
end)
