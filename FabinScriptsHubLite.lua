-- FABINSCRIPTS FPS BOOST HUB

local player = game.Players.LocalPlayer
local Lighting = game:GetService("Lighting")
local Terrain = workspace:FindFirstChildOfClass("Terrain")
local UIS = game:GetService("UserInputService")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FABINSCRIPTS"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,300,0,160)
Frame.Position = UDim2.new(0.5,-150,0.5,-80)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.BorderSizePixel = 0

-- Barra superior
local TopBar = Instance.new("Frame")
TopBar.Parent = Frame
TopBar.Size = UDim2.new(1,0,0,35)
TopBar.BackgroundColor3 = Color3.fromRGB(30,30,30)
TopBar.BorderSizePixel = 0

local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.Size = UDim2.new(1,-40,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Text = "FABINSCRIPTS FPS BOOST"
Title.TextColor3 = Color3.fromRGB(0,255,120)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Botão minimizar
local Minimize = Instance.new("TextButton")
Minimize.Parent = TopBar
Minimize.Size = UDim2.new(0,35,1,0)
Minimize.Position = UDim2.new(1,-35,0,0)
Minimize.Text = "-"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextScaled = true
Minimize.BackgroundColor3 = Color3.fromRGB(50,50,50)
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.BorderSizePixel = 0

-- Conteúdo
local Content = Instance.new("Frame")
Content.Parent = Frame
Content.Size = UDim2.new(1,0,1,-35)
Content.Position = UDim2.new(0,0,0,35)
Content.BackgroundTransparency = 1

local Button = Instance.new("TextButton")
Button.Parent = Content
Button.Size = UDim2.new(0.8,0,0,50)
Button.Position = UDim2.new(0.1,0,0.3,0)
Button.Text = "OTIMIZAR FPS 🚀"
Button.Font = Enum.Font.GothamBold
Button.TextScaled = true
Button.BackgroundColor3 = Color3.fromRGB(0,170,255)
Button.TextColor3 = Color3.new(1,1,1)
Button.BorderSizePixel = 0

-- Função FPS BOOST
local function FPSBOOST()

    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        Lighting.Brightness = 0
        Lighting.ClockTime = 14
        Lighting.EnvironmentDiffuseScale = 0
        Lighting.EnvironmentSpecularScale = 0
    end)

    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)

    for _,v in ipairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("Sky") then
            v:Destroy()
        end
    end

    for _,v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter")
        or v:IsA("Trail")
        or v:IsA("Smoke")
        or v:IsA("Fire")
        or v:IsA("Sparkles")
        or v:IsA("Explosion")
        or v:IsA("Beam") then
            v:Destroy()
        end

        if v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end

        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.CastShadow = false
            v.Reflectance = 0
        end
    end

    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
        Terrain.Decoration = false
    end

    pcall(function()
        local atm = Lighting:FindFirstChildOfClass("Atmosphere")
        if atm then atm:Destroy() end
    end)

end

Button.MouseButton1Click:Connect(function()
    Button.Text = "FPS OTIMIZADO ✅"
    FPSBOOST()
end)

-- Minimizar
local minimized = false

Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized

    if minimized then
        Frame.Size = UDim2.new(0,300,0,35)
        Minimize.Text = "+"
    else
        Frame.Size = UDim2.new(0,300,0,160)
        Minimize.Text = "-"
    end
end)

-- Arrastar
local dragging = false
local dragInput, dragStart, startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

print("FABINSCRIPTS HUB CARREGADO 🚀")
