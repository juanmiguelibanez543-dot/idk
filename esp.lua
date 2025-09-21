--// ESP GUI with Hitbox Controls
--// Toggle, Size (1–90), Opacity (0–1), Color (RGB)
--// Made for Delta Executor

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

---- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ESP_GUI"

-- Main frame
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 220)
Frame.Position = UDim2.new(0.05, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Active = true
Frame.Draggable = true
local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 10)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "ESP GUI"
Title.TextColor3 = Color3.fromRGB(220, 220, 220)
Title.TextStrokeTransparency = 0.7
Title.Font = Enum.Font.SourceSansSemibold
Title.TextScaled = true
local TitleCorner = Instance.new("UICorner", Title)
TitleCorner.CornerRadius = UDim.new(0, 8)

-- ESP Switch
local switch = Instance.new("TextButton", Frame)
switch.Size = UDim2.new(0.9, 0, 0, 30)
switch.Position = UDim2.new(0.05, 0, 0.18, 0)
switch.BackgroundColor3 = Color3.fromRGB(100, 40, 40)
switch.Text = ""
local switchCorner = Instance.new("UICorner", switch)
switchCorner.CornerRadius = UDim.new(1, 0)

local knob = Instance.new("Frame", switch)
knob.Size = UDim2.new(0.4, 0, 1, 0)
knob.Position = UDim2.new(0, 0, 0, 0)
knob.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
local knobCorner = Instance.new("UICorner", knob)
knobCorner.CornerRadius = UDim.new(1, 0)

local switchLabel = Instance.new("TextLabel", Frame)
switchLabel.Size = UDim2.new(1, 0, 0, 20)
switchLabel.Position = UDim2.new(0, 0, 0.05, 0)
switchLabel.BackgroundTransparency = 1
switchLabel.Text = "ESP: OFF"
switchLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
switchLabel.TextStrokeTransparency = 0.7
switchLabel.Font = Enum.Font.SourceSansSemibold
switchLabel.TextScaled = true

---- Hitbox Size Input
local boxLabel = Instance.new("TextLabel", Frame)
boxLabel.Size = UDim2.new(0.4, 0, 0, 20)
boxLabel.Position = UDim2.new(0.05, 0, 0.38, 0)
boxLabel.BackgroundTransparency = 1
boxLabel.Text = "Hitbox Size:"
boxLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
boxLabel.TextStrokeTransparency = 0.7
boxLabel.TextScaled = true
boxLabel.Font = Enum.Font.SourceSansSemibold

local hitboxInput = Instance.new("TextBox", Frame)
hitboxInput.Size = UDim2.new(0.4, 0, 0, 25)
hitboxInput.Position = UDim2.new(0.55, 0, 0.36, 0)
hitboxInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hitboxInput.Text = "4"
hitboxInput.TextColor3 = Color3.fromRGB(255, 255, 255)
hitboxInput.Font = Enum.Font.SourceSans
hitboxInput.TextScaled = true

local hitboxSize = 4

---- Hitbox Opacity Input
local opacityLabel = Instance.new("TextLabel", Frame)
opacityLabel.Size = UDim2.new(0.4, 0, 0, 20)
opacityLabel.Position = UDim2.new(0.05, 0, 0.52, 0)
opacityLabel.BackgroundTransparency = 1
opacityLabel.Text = "Opacity (0-1):"
opacityLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
opacityLabel.TextStrokeTransparency = 0.7
opacityLabel.TextScaled = true
opacityLabel.Font = Enum.Font.SourceSansSemibold

local opacityInput = Instance.new("TextBox", Frame)
opacityInput.Size = UDim2.new(0.4, 0, 0, 25)
opacityInput.Position = UDim2.new(0.55, 0, 0.5, 0)
opacityInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
opacityInput.Text = "0.6"
opacityInput.TextColor3 = Color3.fromRGB(255, 255, 255)
opacityInput.Font = Enum.Font.SourceSans
opacityInput.TextScaled = true

local hitboxOpacity = 0.6

---- Hitbox Color Inputs (R,G,B)
local colorLabel = Instance.new("TextLabel", Frame)
colorLabel.Size = UDim2.new(1, 0, 0, 20)
colorLabel.Position = UDim2.new(0.05, 0, 0.66, 0)
colorLabel.BackgroundTransparency = 1
colorLabel.Text = "Hitbox Color (RGB):"
colorLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
colorLabel.TextStrokeTransparency = 0.7
colorLabel.TextScaled = true
colorLabel.Font = Enum.Font.SourceSansSemibold

local rInput = Instance.new("TextBox", Frame)
rInput.Size = UDim2.new(0.25, 0, 0, 25)
rInput.Position = UDim2.new(0.05, 0, 0.76, 0)
rInput.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
rInput.Text = "255"
rInput.TextColor3 = Color3.fromRGB(255, 255, 255)
rInput.Font = Enum.Font.SourceSans
rInput.TextScaled = true

local gInput = Instance.new("TextBox", Frame)
gInput.Size = UDim2.new(0.25, 0, 0, 25)
gInput.Position = UDim2.new(0.375, 0, 0.76, 0)
gInput.BackgroundColor3 = Color3.fromRGB(0, 60, 0)
gInput.Text = "0"
gInput.TextColor3 = Color3.fromRGB(255, 255, 255)
gInput.Font = Enum.Font.SourceSans
gInput.TextScaled = true

local bInput = Instance.new("TextBox", Frame)
bInput.Size = UDim2.new(0.25, 0, 0, 25)
bInput.Position = UDim2.new(0.7, 0, 0.76, 0)
bInput.BackgroundColor3 = Color3.fromRGB(0, 0, 60)
bInput.Text = "0"
bInput.TextColor3 = Color3.fromRGB(255, 255, 255)
bInput.Font = Enum.Font.SourceSans
bInput.TextScaled = true

local hitboxColor = Color3.fromRGB(255,0,0)

---- ESP State
local espEnabled = false
local espObjects = {}
local guiVisible = true

-- Remove ESP
local function removeESP(player)
    if espObjects[player] then
        for _, obj in pairs(espObjects[player]) do
            if typeof(obj) == "RBXScriptConnection" then
                obj:Disconnect()
            elseif obj.Destroy then
                obj:Destroy()
            end
        end
        espObjects[player] = nil
    end
end

-- Create ESP
local function createESP(player)
    if not espEnabled or player == LocalPlayer then return end
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end

    removeESP(player)

    local hrp = player.Character.HumanoidRootPart
    local head = player.Character:FindFirstChild("Head")

    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 200, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head or hrp

    local text = Instance.new("TextLabel", billboard)
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.TextColor3 = Color3.fromRGB(255, 180, 180)
    text.TextStrokeTransparency = 0.7
    text.Font = Enum.Font.SourceSansSemibold
    text.TextScaled = true

    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = hrp
    box.AlwaysOnTop = true
    box.ZIndex = 0
    box.Color3 = hitboxColor
    box.Transparency = hitboxOpacity
    box.Size = Vector3.new(hitboxSize, hitboxSize * 1.5, hitboxSize / 2)
    box.Parent = hrp

    local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
    local conn1, conn2
    if humanoid then
        text.Text = player.Name .. " | HP: " .. math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
        conn1 = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            text.Text = player.Name .. " | HP: " .. math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
        end)
        conn2 = humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
            text.Text = player.Name .. " | HP: " .. math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
        end)
    else
        text.Text = player.Name .. " | HP: ?"
    end

    espObjects[player] = {billboard, text, box, conn1, conn2}
end

-- Update ESP
local function updateAllESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if espEnabled then
                createESP(player)
            else
                removeESP(player)
            end
        end
    end
end

---- Switch Toggle
local function setESP(state)
    espEnabled = state
    switchLabel.Text = espEnabled and "ESP: ON" or "ESP: OFF"
    switch.BackgroundColor3 = espEnabled and Color3.fromRGB(40, 150, 40) or Color3.fromRGB(100, 40, 40)

    local goal = { Position = espEnabled and UDim2.new(0.6, 0, 0, 0) or UDim2.new(0, 0, 0, 0) }
    TweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal):Play()

    updateAllESP()
end

switch.MouseButton1Click:Connect(function()
    setESP(not espEnabled)
end)

-- Player Events
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if espEnabled then
            task.wait(1)
            createESP(player)
        end
    end)
end)
Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)

---- Input Handlers
hitboxInput.FocusLost:Connect(function()
    local val = tonumber(hitboxInput.Text)
    if val then
        if val < 1 then val = 1 elseif val > 90 then val = 90 end
        hitboxSize = val
        hitboxInput.Text = tostring(hitboxSize)
    else
        hitboxInput.Text = tostring(hitboxSize)
    end
    updateAllESP()
end)

opacityInput.FocusLost:Connect(function()
    local val = tonumber(opacityInput.Text)
    if val then
        if val < 0 then val = 0 elseif val > 1 then val = 1 end
        hitboxOpacity = val
        opacityInput.Text = tostring(hitboxOpacity)
    else
        opacityInput.Text = tostring(hitboxOpacity)
    end
    updateAllESP()
end)

local function updateColor()
    local r = tonumber(rInput.Text) or 255
    local g = tonumber(gInput.Text) or 0
    local b = tonumber(bInput.Text) or 0
    if r < 0 then r = 0 elseif r > 255 then r = 255 end
    if g < 0 then g = 0 elseif g > 255 then g = 255 end
    if b < 0 then b = 0 elseif b > 255 then b = 255 end
    hitboxColor = Color3.fromRGB(r, g, b)
    rInput.Text, gInput.Text, bInput.Text = tostring(r), tostring(g), tostring(b)
    updateAllESP()
end

rInput.FocusLost:Connect(updateColor)
gInput.FocusLost:Connect(updateColor)
bInput.FocusLost:Connect(updateColor)

-- Keybind (M) to hide/show GUI + disable ESP
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.M then
        guiVisible = not guiVisible
        Frame.Visible = guiVisible
        if guiVisible then
            setESP(true)
        else
            setESP(false)
        end
    end
end)

-- Default OFF
setESP(false)
