-- Script for Roblox Studio: Switch sky based on time of day.
-- Place this in ServerScriptService.

local Lighting = game:GetService("Lighting")

local NIGHT_START = 18 -- 6 PM
local NIGHT_END = 6    -- 6 AM

local function isNight(clockTime)
	return clockTime >= NIGHT_START or clockTime < NIGHT_END
end

local function getSky(name)
	local sky = Lighting:FindFirstChild(name)
	if not sky then
		warn("Sky not found in Lighting: " .. name)
		return nil
	end
	return sky
end

local function setSky(skyName)
	for _, child in ipairs(Lighting:GetChildren()) do
		if child:IsA("Sky") then
			child.Enabled = (child.Name == skyName)
		end
	end
end

local function updateSky()
	local clockTime = Lighting.ClockTime
	if isNight(clockTime) then
		if getSky("aurora") then
			setSky("aurora")
		end
	else
		if getSky("cloudy") then
			setSky("cloudy")
		end
	end
end

Lighting:GetPropertyChangedSignal("ClockTime"):Connect(updateSky)
updateSky()
