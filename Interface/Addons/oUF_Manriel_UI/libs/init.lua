local parent, namespace = ...

local UI = namespace.ManrielUI

-- Registring shared media
local LSM = LibStub:GetLibrary("LibSharedMedia-3.0");
UI.lib.LSM = LSM

LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-None', 			[[Interface\AddOns\oUF_Manriel_UI\textures\blank]]);
LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-Background',	[[Interface\AddOns\oUF_Manriel_UI\textures\panels-halback256]]);
LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-Caith',			[[Interface\AddOns\oUF_Manriel_UI\textures\Caith]]);
LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-Bubble',		[[Interface\Addons\oUF_Manriel_UI\textures\bubbleTex]]);
LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-Icon',			[[Interface\Addons\oUF_Manriel_UI\textures\icon]]);

LSM:Register(LSM.MediaType.STATUSBAR, 'Manriel-Health',			[[Interface\AddOns\oUF_Manriel_UI\textures\Ruben]]);
LSM:Register(LSM.MediaType.STATUSBAR, 'Manriel-Rune',			[[Interface\AddOns\oUF_Manriel_UI\textures\rothTex]]);

LSM:Register(LSM.MediaType.BORDER, 'Manriel-Border', 			[[Interface\AddOns\oUF_Manriel_UI\textures\panels-border32]]);
LSM:Register(LSM.MediaType.BORDER, 'Manriel-Border-Light',		[[Interface\AddOns\oUF_Manriel_UI\textures\panels-border16]]);
LSM:Register(LSM.MediaType.BORDER, 'Manriel-Glow',				[[Interface\Addons\oUF_Manriel_UI\textures\glowTex]]);

LSM:Register(LSM.MediaType.FONT, 'Calibri Bold', 	[[Interface\AddOns\oUF_Manriel_UI\fonts\CalibriBold.ttf]], 	LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);
LSM:Register(LSM.MediaType.FONT, 'Calibri', 		[[Interface\AddOns\oUF_Manriel_UI\fonts\Calibri.ttf]], 		LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);

LSM:Register(LSM.MediaType.FONT, 'San Francisco (Black)', 		[[Interface\AddOns\oUF_Manriel_UI\fonts\SF-UI-Display-Black.ttf]], 		LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);
LSM:Register(LSM.MediaType.FONT, 'San Francisco (Heavy)', 		[[Interface\AddOns\oUF_Manriel_UI\fonts\SF-UI-Display-Heavy.ttf]], 		LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);
LSM:Register(LSM.MediaType.FONT, 'San Francisco (Bold)', 		[[Interface\AddOns\oUF_Manriel_UI\fonts\SF-UI-Display-Bold.ttf]], 		LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);
LSM:Register(LSM.MediaType.FONT, 'San Francisco (Semi-bold)', 	[[Interface\AddOns\oUF_Manriel_UI\fonts\SF-UI-Display-Semibold.ttf]], 	LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);
LSM:Register(LSM.MediaType.FONT, 'San Francisco (Medium)', 		[[Interface\AddOns\oUF_Manriel_UI\fonts\SF-UI-Display-Medium.ttf]], 	LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);
LSM:Register(LSM.MediaType.FONT, 'San Francisco (Regular)', 	[[Interface\AddOns\oUF_Manriel_UI\fonts\SF-UI-Display-Regular.ttf]], 	LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);
LSM:Register(LSM.MediaType.FONT, 'San Francisco (Light)', 		[[Interface\AddOns\oUF_Manriel_UI\fonts\SF-UI-Display-Light.ttf]], 		LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);
LSM:Register(LSM.MediaType.FONT, 'San Francisco (Thin)', 		[[Interface\AddOns\oUF_Manriel_UI\fonts\SF-UI-Display-Thin.ttf]], 		LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);
LSM:Register(LSM.MediaType.FONT, 'San Francisco (Ultralight)', 	[[Interface\AddOns\oUF_Manriel_UI\fonts\SF-UI-Display-Ultralight.ttf]], LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);
