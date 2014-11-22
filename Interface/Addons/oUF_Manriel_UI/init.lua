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

LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-None', 		[[Interface\AddOns\oUF_Manriel_UI\textures\blank]]);
LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-Background',[[Interface\AddOns\oUF_Manriel_UI\textures\panels-halback]]);
LSM:Register(LSM.MediaType.BACKGROUND, 'Manriel-Glow',		[[Interface\Addons\oUF_Manriel_UI\media\glowTex]]);

LSM:Register(LSM.MediaType.STATUSBAR, 'Manriel-Health',	[[Interface\AddOns\oUF_Manriel_UI\textures\Ruben]]);
LSM:Register(LSM.MediaType.STATUSBAR, 'Manriel-Rune',		[[Interface\AddOns\oUF_Manriel_UI\textures\rothTex]]);

LSM:Register(LSM.MediaType.BORDER, 'Manriel-Border', 		[[Interface\AddOns\oUF_Manriel_UI\textures\panels-border32]]);
LSM:Register(LSM.MediaType.BORDER, 'Manriel-Border-Light',	[[Interface\AddOns\oUF_Manriel_UI\textures\panels-border16]]);
LSM:Register(LSM.MediaType.BORDER, 'Manriel-Border-Caith',	[[Interface\AddOns\oUF_Manriel_UI\textures\Caith]]);
LSM:Register(LSM.MediaType.BORDER, 'Manriel-Border-Bubble',	[[Interface\Addons\oUF_Manriel_UI\textures\bubbleTex]]);

LSM:Register(LSM.MediaType.FONT, 'Calibri Bold', [[Interface\AddOns\oUF_Manriel_UI\fonts\CalibriBold.ttf]], LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);
LSM:Register(LSM.MediaType.FONT, 'Calibri', [[Interface\AddOns\oUF_Manriel_UI\fonts\Calibri.ttf]], LSM.LOCALE_BIT_ruRU + LSM.LOCALE_BIT_western);

ns.ManrielUI = UI


local function HideBlizzardAuraFrames(self, event)
   -- Initially seperated out to provide better Entering/Exiting Vehicle support, but that currently taints. Leaving it in because hey why not, it saves an if statement.
   BuffFrame:UnregisterEvent("UNIT_AURA")
   TemporaryEnchantFrame:UnregisterEvent("UNIT_AURA")
   TemporaryEnchantFrame:Hide()
   BuffFrame:Hide()
   ConsolidatedBuffs:Hide()
end

local sf = CreateFrame("Frame")
sf.PLAYER_ENTERING_WORLD = function(self)
	local scale = GetScreenWidth() * UIParent:GetEffectiveScale() / 1920;
	print(GetScreenWidth());
	print(scale);
	UIParent:SetScale(scale);

	-- HideBlizzardAuraFrames(self)
end

sf:RegisterEvent("PLAYER_ENTERING_WORLD")
sf:SetScript("OnEvent", function(self, event, ...) sf[event](self, ...) end)