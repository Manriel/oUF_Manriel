local parent, ns = ...

local UI = {
	lib = {},
	config = {},
	localeStrings = {},
	methods = {},
}

-- Registring shared media
local LSM = LibStub:GetLibrary("LibSharedMedia-3.0");
UI.lib.LSM = LSM

LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-None', 		[[Interface\AddOns\oUF_ManrielUI\textures\blank]]);
LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-Background',[[Interface\AddOns\oUF_ManrielUI\textures\panels-halback]]);
LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-Health',	[[Interface\AddOns\oUF_ManrielUI\textures\Ruben]]);
LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-Rune',		[[Interface\AddOns\oUF_ManrielUI\textures\rothTex]]);
LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-Glow',		[[Interface\Addons\oUF_ManrielUI\media\glowTex]]);

LSM:Register(LSM.MediaType.BORDER, 'Manriel-Border', 		[[Interface\AddOns\oUF_ManrielUI\textures\panels-border32]]);
LSM:Register(LSM.MediaType.BORDER, 'Manriel-Border-Light',	[[Interface\AddOns\oUF_ManrielUI\textures\panels-border16]]);
LSM:Register(LSM.MediaType.BORDER, 'Manriel-Border-Caith',	[[Interface\AddOns\oUF_ManrielUI\textures\Caith]]);
LSM:Register(LSM.MediaType.BORDER, 'Manriel-Border-Bubble',	[[Interface\Addons\oUF_ManrielUI\textures\bubbleTex]]);
LSM:Register(LSM.MediaType.BORDER, 'Manriel-Border-Castbar',[[Interface\AddOns\oUF_ManrielUI\textures\border]]);

LSM:Register(LSM.MediaType.FONT, 'Calibri Bold', [[Interface\AddOns\oUF_ManrielUI\fonts\CalibriBold.ttf]], LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);
LSM:Register(LSM.MediaType.FONT, 'Calibri', [[Interface\AddOns\oUF_ManrielUI\fonts\Calibri.ttf]], LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);

ns.ManrielUI = UI