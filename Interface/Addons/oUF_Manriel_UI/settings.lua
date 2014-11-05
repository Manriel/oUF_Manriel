local parent, ns = ...
local UI = ns.ManrielUI
local LSM = UI.lib.LSM

UI.config = {
	xPosition	= 170,
	yPosition	= 320,
	width		= 280,
	height		= 45,
	offset		= 4,
	classification = {
		worldboss = ' |cffffd700Boss|r',
		rareelite = ' |cffffd700R+|r',
		elite = ' |cffffd700++|r',
		rare = ' Rare',
		normal = '',
		trivial = '',
	},

	fontName = LSM:Fetch(LSM.MediaType.FONT, 'Calibri Bold'),
	fontNamePixel = LSM:Fetch(LSM.MediaType.FONT, 'Calibri'),
	baseFontSize = 12,

	textureHealthBar = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Health'),
	textureRuneBar = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Rune'),
	textureBorder = LSM:Fetch(LSM.MediaType.BORDER, 'Manriel-Border-Caith'),
	textureBubble = LSM:Fetch(LSM.MediaType.BORDER, 'Manriel-Border-Bubble'),
	textureCastBarBorder = LSM:Fetch(LSM.MediaType.BORDER, 'Manriel-Border-Castbar'),
	textureGlow = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Glow'),
	textureBlizzardTooltip = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Blizzard Tooltip'),
}



--[[ Changing some variables ]]
SetCVar("screenshotQuality", 9)
SetCVar("cameraDistanceMax", 50)
SetCVar("cameraDistanceMaxFactor", 2)

-- local sf = CreateFrame("Frame")
-- sf:RegisterEvent("PLAYER_LOGIN")

SlashCmdList["FRAME"] = function() print(GetMouseFocus():GetName()) end
SLASH_FRAME1 = "/frame"

SlashCmdList["PARENTFRAME"] = function() print(GetMouseFocus():GetParent():GetName()) end
SLASH_PARENTFRAME1 = "/parentframe"

SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"

SlashCmdList["RCSLASH"] = function() DoReadyCheck() end
SLASH_RCSLASH1 = "/rc"
