--[[     Options start here     ]]
-- "true" means enabled, "false" means disabled

--[[ Changing some variables ]]
SetCVar("screenshotQuality", 9)
SetCVar("cameraDistanceMax", 50)
SetCVar("cameraDistanceMaxFactor", 2)

local sf = CreateFrame("Frame")
sf:RegisterEvent("PLAYER_LOGIN")

SlashCmdList["FRAME"] = function() print(GetMouseFocus():GetName()) end
SLASH_FRAME1 = "/frame"

SlashCmdList["PARENTFRAME"] = function() print(GetMouseFocus():GetParent():GetName()) end
SLASH_PARENTFRAME1 = "/parentframe"

SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"

SlashCmdList["RCSLASH"] = function() DoReadyCheck() end
SLASH_RCSLASH1 = "/rc"