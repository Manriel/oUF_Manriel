local parent, ns = ...
local oUF = ns.oUF
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

oUF.colors.power['MANA'] = {.30,.45,.65}
oUF.colors.power['RAGE'] = {.70,.30,.30}
oUF.colors.power['FOCUS'] = {.70,.45,.25}
oUF.colors.power['ENERGY'] = {.65,.65,.35}
oUF.colors.power['RUNIC_POWER'] = {.45,.45,.75}

oUF.colors.runes = {
		[1] = {.69, .31, .31},
		[2] = {.33, .59, .33},
		[3] = {.31, .45, .63},
		[4] = {.84, .75, .05},
}

oUF.colors.tapped = {.55,.57,.61}
oUF.colors.disconnected = {.5,.5,.5}

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
