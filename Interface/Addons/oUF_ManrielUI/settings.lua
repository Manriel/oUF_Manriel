local parent, ns = ...
ns.ManrielUI.config = {
	xPosition	= 170,
	yPosition	= 320,
	width		= 280,
	height		= 45,
	offset		= 4,
	classification = {
		worldboss = '%s |cffffd700Boss|r',
		rareelite = '%s |cffffd700R+|r',
		elite = '%s |cffffd700++|r',
		rare = '%s Rare',
		normal = '%s',
		trivial = '%s',
	}
}

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
