local whitelist = {
    "Idklol120394",
    "br1xlol",
    "",
}

local function isWhitelisted(name)
	for _, v in ipairs(whitelist) do
		if string.lower(v) == string.lower(name) then
			return true
		end
	end
	return false
end

local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
if not isWhitelisted(player.Name) then
	player:Kick("Not Whitelisted")
	return
end


local Players = game:GetService("Players")

local player = Players.LocalPlayer

local FFlags = {
    GameNetPVHeaderRotationalVelocityZeroCutoffExponent = -5000,
    LargeReplicatorWrite5 = true,
    LargeReplicatorEnabled9 = true,
    AngularVelociryLimit = 360,
    TimestepArbiterVelocityCriteriaThresholdTwoDt = 2147483646,
    S2PhysicsSenderRate = 15000,
    DisableDPIScale = true,
    MaxDataPacketPerSend = 2147483647,
    PhysicsSenderMaxBandwidthBps = 20000,
    TimestepArbiterHumanoidLinearVelThreshold = 21,
    MaxMissedWorldStepsRemembered = -2147483648,
    PlayerHumanoidPropertyUpdateRestrict = true,
    SimDefaultHumanoidTimestepMultiplier = 0,
    StreamJobNOUVolumeLengthCap = 2147483647,
    DebugSendDistInSteps = -2147483648,
    GameNetDontSendRedundantNumTimes = 1,
    CheckPVLinearVelocityIntegrateVsDeltaPositionThresholdPercent = 1,
    CheckPVDifferencesForInterpolationMinVelThresholdStudsPerSecHundredth = 1,
    LargeReplicatorSerializeRead3 = true,
    ReplicationFocusNouExtentsSizeCutoffForPauseStuds = 2147483647,
    CheckPVCachedVelThresholdPercent = 10,
    CheckPVDifferencesForInterpolationMinRotVelThresholdRadsPerSecHundredth = 1,
    GameNetDontSendRedundantDeltaPositionMillionth = 1,
    InterpolationFrameVelocityThresholdMillionth = 5,
    StreamJobNOUVolumeCap = 2147483647,
    InterpolationFrameRotVelocityThresholdMillionth = 5,
    CheckPVCachedRotVelThresholdPercent = 10,
    WorldStepMax = 30,
    InterpolationFramePositionThresholdMillionth = 5,
    TimestepArbiterHumanoidTurningVelThreshold = 1,
    SimOwnedNOUCountThresholdMillionth = 2147483647,
    GameNetPVHeaderLinearVelocityZeroCutoffExponent = -5000,
    NextGenReplicatorEnabledWrite4 = true,
    TimestepArbiterOmegaThou = 1073741823,
    MaxAcceptableUpdateDelay = 1,
    LargeReplicatorSerializeWrite4 = true
}

local defaultFFlags = {
    GameNetPVHeaderRotationalVelocityZeroCutoffExponent = 8,
    LargeReplicatorWrite5 = false,
    LargeReplicatorEnabled9 = false,
    AngularVelociryLimit = 180,
    TimestepArbiterVelocityCriteriaThresholdTwoDt = 100,
    S2PhysicsSenderRate = 60,
    DisableDPIScale = false,
    MaxDataPacketPerSend = 1024,
    PhysicsSenderMaxBandwidthBps = 10000,
    TimestepArbiterHumanoidLinearVelThreshold = 10,
    MaxMissedWorldStepsRemembered = 10,
    PlayerHumanoidPropertyUpdateRestrict = false,
    SimDefaultHumanoidTimestepMultiplier = 1,
    StreamJobNOUVolumeLengthCap = 1000,
    DebugSendDistInSteps = 10,
    GameNetDontSendRedundantNumTimes = 10,
    CheckPVLinearVelocityIntegrateVsDeltaPositionThresholdPercent = 50,
    CheckPVDifferencesForInterpolationMinVelThresholdStudsPerSecHundredth = 100,
    LargeReplicatorSerializeRead3 = false,
    ReplicationFocusNouExtentsSizeCutoffForPauseStuds = 100,
    CheckPVCachedVelThresholdPercent = 50,
    CheckPVDifferencesForInterpolationMinRotVelThresholdRadsPerSecHundredth = 100,
    GameNetDontSendRedundantDeltaPositionMillionth = 100,
    InterpolationFrameVelocityThresholdMillionth = 100,
    StreamJobNOUVolumeCap = 1000,
    InterpolationFrameRotVelocityThresholdMillionth = 100,
    CheckPVCachedRotVelThresholdPercent = 50,
    WorldStepMax = 60,
    InterpolationFramePositionThresholdMillionth = 100,
    TimestepArbiterHumanoidTurningVelThreshold = 10,
    SimOwnedNOUCountThresholdMillionth = 1000,
    GameNetPVHeaderLinearVelocityZeroCutoffExponent = 8,
    NextGenReplicatorEnabledWrite4 = false,
    TimestepArbiterOmegaThou = 1000,
    MaxAcceptableUpdateDelay = 10,
    LargeReplicatorSerializeWrite4 = false
}

local desyncActive = false
local firstActivation = true

local function applyFFlags(flags)
    for name, value in pairs(flags) do
        pcall(function()
            setfflag(tostring(name), tostring(value))
        end)
    end
end

local function respawn(plr)
    local char = plr.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
ce
        plr.Character = newChar
        task.wait()
        plr.Character = char
        newChar:Destroy()
    end
end

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

-- Clean old UI
if CoreGui:FindFirstChild("BhxbDesyncUI") then
    CoreGui.BhxbDesyncUI:Destroy()
end

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BhxbDesyncUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = CoreGui

-- Main Frame (BIGGER GUI)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 260)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -130)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 145, 60)
stroke.Thickness = 2
stroke.Transparency = 0.25
stroke.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundTransparency = 1
title.Text = "Bhxb Desync"
title.Font = Enum.Font.GothamBlack
title.TextSize = 28
title.TextColor3 = Color3.fromRGB(255, 145, 60)
title.Parent = mainFrame

-- Button (SAME SIZE AS BEFORE)
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 200, 0, 60)
button.Position = UDim2.new(0.5, -100, 0.6, 0)
button.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
button.Text = "Desync: OFF"
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.GothamBold
button.TextSize = 22
button.TextScaled = false
button.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 12)
btnCorner.Parent = button

button.MouseButton1Click:Connect(function()
    desyncActive = not desyncActive
    if desyncActive then
        applyFFlags(FFlags)
        if firstActivation then
            respawn(player)
            firstActivation = false
        end
        button.Text = "Desync: ON"
        button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        applyFFlags(defaultFFlags)
        button.Text = "Desync: OFF"
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    end
end)
