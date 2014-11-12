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

	textureHealthBar = LSM:Fetch(LSM.MediaType.STATUSBAR, 'Manriel-Health'),
	textureRuneBar = LSM:Fetch(LSM.MediaType.STATUSBAR, 'Manriel-Rune'),
	textureBorder = LSM:Fetch(LSM.MediaType.BORDER, 'Manriel-Border-Caith'),
	textureBubble = LSM:Fetch(LSM.MediaType.BORDER, 'Manriel-Border-Bubble'),
	textureCastBarBorder = LSM:Fetch(LSM.MediaType.BORDER, 'Manriel-Border-Light'),
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

local backdrop = {	
	bgFile = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Background'),
	edgeFile = LSM:Fetch(LSM.MediaType.BORDER, 'Manriel-Border'),
	edgeSize = 32,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
	tile = true,
	tileSize = 256
}

local sf = CreateFrame("Frame")
sf:RegisterEvent("PLAYER_LOGIN")
tt = _G["GameTooltip"]
if tt then tt:SetBackdrop(backdrop) end
tt = _G["ItemRefTooltip"]
if tt then tt:SetBackdrop(backdrop) end
tt = _G["ShoppingTooltip1"]
if tt then tt:SetBackdrop(backdrop) end
tt = _G["ShoppingTooltip2"]
if tt then tt:SetBackdrop(backdrop) end
tt = _G["ShoppingTooltip3"]
if tt then tt:SetBackdrop(backdrop) end

SlashCmdList["FRAME"] = function() print(GetMouseFocus():GetName()) end
SLASH_FRAME1 = "/frame"

SlashCmdList["PARENTFRAME"] = function() print(GetMouseFocus():GetParent():GetName()) end
SLASH_PARENTFRAME1 = "/parentframe"

SlashCmdList["RELOADUI"] = function() ReloadUI() end
SLASH_RELOADUI1 = "/rl"

SlashCmdList["RCSLASH"] = function() DoReadyCheck() end
SLASH_RCSLASH1 = "/rc"


local sf = CreateFrame("Frame")
sf:SetScript("OnEvent", function()
	local scale = UIParent:GetWidth() / 1923;
	print(UIParent:GetWidth());
	print(scale);
	UIParent:SetScale(scale);
end)
sf:RegisterEvent("PLAYER_LOGIN")