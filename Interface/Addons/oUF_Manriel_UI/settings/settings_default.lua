local parent, namespace = ...
local oUF = namespace.oUF
local ManrielUI = namespace.ManrielUI
local LSM = ManrielUI.lib.LSM

if ( not Manriel_UI_Config ) then
 	Manriel_UI_Config = {}
end

ManrielUI.config = {
		xPosition	= 200,
		yPosition	= 380,
		width		= 300,
		height		= 50,
		offset		= 4,
		classification = {
			worldboss = ' |cffffd700Boss|r',
			rareelite = ' |cffffd700R+|r',
			elite = ' |cffffd700++|r',
			rare = ' Rare',
			normal = '',
			trivial = '',
			minus = '',
		},

		fontName      = LSM:Fetch(LSM.MediaType.FONT, 'Calibri Bold'),
		baseFontSize  = 12,

		textureHealthBar       = LSM:Fetch(LSM.MediaType.STATUSBAR,  'Manriel-Health'),
		textureRuneBar         = LSM:Fetch(LSM.MediaType.STATUSBAR,  'Manriel-Rune'),
		texturePanel           = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Background');
		textureBorder          = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Caith'),
		textureBubble          = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Bubble'),
		textureCastBarBorder   = LSM:Fetch(LSM.MediaType.BORDER,     'Manriel-Border-Light'),
		textureGlow            = LSM:Fetch(LSM.MediaType.BORDER,     'Manriel-Glow'),
		textureBlizzardTooltip = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Blizzard Tooltip'),
	}

oUF.colors.power['MANA']        = {.30,.45,.65}
oUF.colors.power['RAGE']        = {.70,.30,.30}
oUF.colors.power['FOCUS']       = {.70,.45,.25}
oUF.colors.power['ENERGY']      = {.65,.65,.35}
oUF.colors.power['RUNIC_POWER'] = {.45,.45,.75}
oUF.colors.power['RUNES']       = {.77,.12,.23}
oUF.colors.power['INSANITY']    = {.60,.30,.70}

oUF.colors.tapped = {.55,.57,.61}
oUF.colors.disconnected = {.5,.5,.5}

--[[ Changing some variables ]]
SetCVar("screenshotQuality", 9)

cameraDistanceMaxZoomFactor = 2.6;