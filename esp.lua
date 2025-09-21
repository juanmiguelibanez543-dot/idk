-- ESP GUI with Hitbox Expansion, Opacity & Color Picker (fixed version)
-- Toggle key = M

-- Services
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Store ESP objects
local espObjects = {}

-- Hitbox defaults
local hitboxSize = 4
local hitboxOpacity = 0.6
local hitboxColor = Color3.fromRGB(255, 0, 0) -- default Red

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "ESP_GUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 230, 0, 260)
Frame.Position = UDim2.new(0, 20, 0.5, -130)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "ESP Controller"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextStrokeTransparency = 0.7
Title.Font = Enum.Font.SourceSansSemibold
Title.TextScaled = true

-- ESP Toggle Button
local espToggle = Instance.new("TextButton", Frame)
espToggle.Size = UDim2.new(0.9, 0, 0, 30)
espToggle.Position = UDim2.new(0.05, 0, 0.2, 0)
espToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
espToggle.Text = "ESP: OFF"
espToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggle.Font = Enum.Font.SourceSans
espToggle.TextScaled = true
Instance.new("UICorner", espToggle).CornerRadius = UDim.new(0, 6)

-- Hitbox Size Input
local boxLabel = Instance.new("TextLabel", Frame)
boxLabel.Size = UDim2.new(0.4, 0, 0, 20)
boxLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
boxLabel.BackgroundTransparency = 1
boxLabel.Text = "Hitbox Size (1-90):"
boxLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
boxLabel.TextStrokeTransparency = 0.7
boxLabel.TextScaled = true
boxLabel.Font = Enum.Font.SourceSansSemibold

local hitboxInput = Instance.new("TextBox", Frame)
hitboxInput.Size = UDim2.new(0.4, 0, 0, 25)
hitboxInput.Position = UDim2.new(0.55, 0, 0.43, 0)
hitboxInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hitboxInput.Text = tostring(hitboxSize)
hitboxInput.TextColor3 = Color3.fromRGB(255, 255, 255)
hitboxInput.Font = Enum.Font.SourceSans
hitboxInput.TextScaled = true
Instance.new("UICorner", hitboxInput).CornerRadius = UDim.new(0, 6)

-- Hitbox Opacity Input
local opacityLabel = Instance.new("TextLabel", Frame)
opacityLabel.Size = UDim2.new(0.4, 0, 0, 20)
opacityLabel.Position = UDim2.new(0.05, 0, 0.63, 0)
opacityLabel.BackgroundTransparency = 1
opacityLabel.Text = "Hitbox Opacity (0-1):"
opacityLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
opacityLabel.TextStrokeTransparency = 0.7
opacityLabel.TextScaled = true
opacityLabel.Font = Enum.Font.SourceSansSemibold

local opacityInput = Instance.new("TextBox", Frame)
opacityInput.Size = UDim2.new(0.4, 0, 0, 25)
opacityInput.Position = UDim2.new(0.55, 0, 0.61, 0)
opacityInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
opacityInput.Text = tostring(hitboxOpacity)
opacityInput.TextColor3 = Color3.fromRGB(255, 255, 255)
opacityInput.Font = Enum.Font.SourceSans
opacityInput.TextScaled = true
Instance.new("UICorner", opacityInput).CornerRadius = UDim.new(0, 6)

-- Hitbox Color Picker
local colorLabel = Instance.new("TextLabel", Frame)
colorLabel.Size = UDim2.new(0.4, 0, 0, 20)
colorLabel.Position = UDim2.new(0.05, 0, 0.81, 0)
colorLabel.BackgroundTransparency = 1
colorLabel.Text = "Hitbox Color:"
colorLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
colorLabel.TextStrokeTransparency = 0.7
colorLabel.TextScaled = true
colorLabel.Font = Enum.Font.SourceSansSemibold

local colorDropdown = Instance.new("TextButton", Frame)
colorDropdown.Size = UDim2.new(0.4, 0, 0, 25)
colorDropdown.Position = UDim2.new(0.55, 0, 0.79, 0)
colorDropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
colorDropdown.Text = "Red"
colorDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
colorDropdown.Font = Enum.Font.SourceSans
colorDropdown.TextScaled = true
Instance.new("UICorner", colorDropdown).CornerRadius = UDim.new(0, 6)

local options = {
    Red = Color3.fromRGB(255, 0, 0),
    Blue = Color3.fromRGB(0, 0, 255),
    Black = Color3.fromRGB(0, 0, 0),
    Yellow = Color3.fromRGB(255, 255, 0),
    Green = Color3.fromRGB(0, 255, 0)
}
local optionKeys = {"Red", "Blue", "Black", "Yellow", "Green"}
local currentIndex = 1

-- Function to update all existing ESP boxes
local function updateAllESP()
    for player, objects in pairs(espObjects) do
        for _, obj in pairs(objects) do
            if obj:IsA("BoxHandleAdornment") then
                obj.Size = Vector3.new(hitboxSize, hitboxSize * 1.5, hitboxSize / 2)
                obj.Transparency = hitboxOpacity
                obj.Color3 = hitboxColor
            end
        end
    end
end

-- Inputs handlers
hitboxInput.FocusLost:Connect(function()
    local val = tonumber(hitboxInput.Text)
    if val then
        if val < 1 then val = 1 elseif val > 90 then val = 90 end
        hitboxSize = val
    end
    hitboxInput.Text = tostring(hitboxSize)
    updateAllESP()
end)

opacityInput.FocusLost:Connect(function()
    local val = tonumber(opacityInput.Text)
    if val then
        if val < 0 then val = 0 elseif val > 1 then val = 1 end
        hitboxOpacity = val
    end
    opacityInput.Text = tostring(hitboxOpacity)
    updateAllESP()
end)

colorDropdown.MouseButton1Click:Connect(function()
    currentIndex = currentIndex + 1
    if currentIndex > #optionKeys then currentIndex = 1 end
    local choice = optionKeys[currentIndex]
    hitboxColor = options[choice]
    colorDropdown.Text = choice
    updateAllESP()
end)

-- ESP Core
local espEnabled = false

local function createESP(player)
    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        -- create objects table
        local objects = {}

        -- Billboard for name + health
        local head = player.Character:FindFirstChild("Head")
        local billboard = Instance.new("BillboardGui", player.Character)
        billboard.Adornee = head or player.Character:FindFirstChild("HumanoidRootPart")
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3.5, 0)
        billboard.AlwaysOnTop = true

        local nameLabel = Instance.new("TextLabel", billboard)
        nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = player.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextStrokeTransparency = 0.5
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextScaled = true

        local healthLabel = Instance.new("TextLabel", billboard)
        healthLabel.Size = UDim2.new(1, 0, 0.5, 0)
        healthLabel.Position = UDim2.new(0, 0, 0.5, 0)
        healthLabel.BackgroundTransparency = 1
        healthLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
        healthLabel.TextStrokeTransparency = 0.5
        healthLabel.Font = Enum.Font.SourceSansBold
        healthLabel.TextScaled = true

        RunService.RenderStepped:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                healthLabel.Text = "HP: " .. math.floor(player.Character.Humanoid.Health)
            end
        end)

        -- Hitbox
        local box = Instance.new("BoxHandleAdornment", CoreGui)
        box.Adornee = player.Character.HumanoidRootPart
        box.Size = Vector3.new(hitboxSize, hitboxSize * 1.5, hitboxSize / 2)
        box.Color3 = hitboxColor
        box.Transparency = hitboxOpacity
        box.ZIndex = 1
        box.AlwaysOnTop = true

        table.insert(objects, billboard)
        table.insert(objects, box)
        espObjects[player] = objects
    end
end

local function removeESP(player)
    if espObjects[player] then
        for _, obj in pairs(espObjects[player]) do
            obj:Destroy()
        end
        espObjects[player] = nil
    end
end

-- Toggle ESP
espToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espToggle.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
    
    if espEnabled then
        for _, player in pairs(Players:GetPlayers()) do
            createESP(player)
        end
    else
        for player, objects in pairs(espObjects) do
            for _, obj in pairs(objects) do
                obj:Destroy()
            end
        end
        espObjects = {}
    end
end)

-- Toggle with M key
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.M then
        espToggle:Activate()
    end
end)

-- Player Added / CharacterAdded
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        if espEnabled then
            task.wait(0.8)
            createESP(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    removeESP(player)
end)
