--// ESP GUI with M Keybind Toggle
--// Rounded GUI, smooth switch, soft text
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
Frame.Size = UDim2.new(0, 220, 0, 100)
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

-- Switch container (TextButton = clickable background)
local switch = Instance.new("TextButton", Frame)
switch.Size = UDim2.new(0.9, 0, 0, 30)
switch.Position = UDim2.new(0.05, 0, 0.55, 0)
switch.BackgroundColor3 = Color3.fromRGB(100, 40, 40) -- red = off
switch.Text = "" -- invisible text
local switchCorner = Instance.new("UICorner", switch)
switchCorner.CornerRadius = UDim.new(1, 0)

-- Knob
local knob = Instance.new("Frame", switch)
knob.Size = UDim2.new(0.4, 0, 1, 0)
knob.Position = UDim2.new(0, 0, 0, 0)
knob.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
local knobCorner = Instance.new("UICorner", knob)
knobCorner.CornerRadius = UDim.new(1, 0)

-- Label
local switchLabel = Instance.new("TextLabel", Frame)
switchLabel.Size = UDim2.new(1, 0, 0, 20)
switchLabel.Position = UDim2.new(0, 0, 0.3, 0)
switchLabel.BackgroundTransparency = 1
switchLabel.Text = "ESP: OFF"
switchLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
switchLabel.TextStrokeTransparency = 0.7
switchLabel.Font = Enum.Font.SourceSansSemibold
switchLabel.TextScaled = true

---- ESP State
local espEnabled = false
local espObjects = {}
local guiVisible = true -- track GUI visibility

-- ESP functions
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
    box.Color3 = Color3.fromRGB(255, 0, 0)
    box.Transparency = 0.6
    box.Size = Vector3.new(4, 6, 2)
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

    -- animate knob
    local goal = { Position = espEnabled and UDim2.new(0.6, 0, 0, 0) or UDim2.new(0, 0, 0, 0) }
    TweenService:Create(knob, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal):Play()

    updateAllESP()
end

switch.MouseButton1Click:Connect(function()
    setESP(not espEnabled)
end)

-- Player events
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

-- Keybind (M) to hide/show GUI + disable/enable ESP
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.M then
        guiVisible = not guiVisible
        Frame.Visible = guiVisible
        if guiVisible then
            setESP(true) -- turn back on when showing
        else
            setESP(false) -- auto turn off when hidden
        end
    end
end)

-- Default OFF
setESP(false)