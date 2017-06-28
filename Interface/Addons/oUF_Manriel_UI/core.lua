local parent, namespace = ...
local oUF = namespace.oUF
local UI = namespace.ManrielUI

local Style = UI.getStyle

oUF:RegisterStyle('ManrielUI', Style);
oUF:SetActiveStyle('ManrielUI');

oUF:Factory(function(self)

	self:Spawn("player"):SetPoint(		"BOTTOMRIGHT",		UIParent,	'BOTTOM',	-UI.config.xPosition,	UI.config.yPosition);
	self:Spawn("pet"):SetPoint(			"TOPLEFT",			oUF_ManrielUIPlayer,	'BOTTOMLEFT',	0,	0);

	self:Spawn("target"):SetPoint(		"BOTTOMLEFT",		UIParent,	'BOTTOM',	UI.config.xPosition,	UI.config.yPosition);
	self:Spawn("targettarget"):SetPoint("TOPRIGHT",			oUF_ManrielUITarget,	'BOTTOMRIGHT',	0,	0);

	self:Spawn("focus"):SetPoint(		"TOPRIGHT",			oUF_ManrielUIPlayer,	'BOTTOMRIGHT',	0,	0);
	self:Spawn("focustarget"):SetPoint(	"TOPLEFT",			oUF_ManrielUITarget,	'BOTTOMLEFT',	0,	0);

	self:Spawn("boss1"):SetPoint(		"BOTTOMLEFT",		UIParent,				'BOTTOMLEFT',	4,	210);
	self:Spawn("boss2"):SetPoint(		"BOTTOMLEFT",		oUF_ManrielUIBrena1,	'TOPLEFT',	0,	28);
	self:Spawn("boss3"):SetPoint(		"BOTTOMLEFT",		oUF_ManrielUIBrena2,	'TOPLEFT',	0,	28);
	self:Spawn("boss4"):SetPoint(		"BOTTOMLEFT",		oUF_ManrielUIBrena3,	'TOPLEFT',	0,	28);
	self:Spawn("boss5"):SetPoint(		"BOTTOMLEFT",		oUF_ManrielUIBrena4,	'TOPLEFT',	0,	28);

	self:Spawn("boss1target"):SetPoint("BOTTOMLEFT",		oUF_ManrielUIBoss1,    'BOTTOMRIGHT',	2,	0);
	self:Spawn("boss2target"):SetPoint("BOTTOMLEFT",		oUF_ManrielUIBoss2,	'BOTTOMRIGHT',	2,	0);
	self:Spawn("boss3target"):SetPoint("BOTTOMLEFT",		oUF_ManrielUIBoss3,	'BOTTOMRIGHT',	2,	0);
	self:Spawn("boss4target"):SetPoint("BOTTOMLEFT",		oUF_ManrielUIBoss4,	'BOTTOMRIGHT',	2,	0);
	self:Spawn("boss5target"):SetPoint("BOTTOMLEFT",		oUF_ManrielUIBoss5,	'BOTTOMRIGHT',	2,	0);

	self:Spawn("arena1"):SetPoint(		"BOTTOMLEFT",		UIParent,				'BOTTOMLEFT',	4,	210);
	self:Spawn("arena2"):SetPoint(		"BOTTOMLEFT",		oUF_ManrielUIArena1,	'TOPLEFT',	0,	28);
	self:Spawn("arena3"):SetPoint(		"BOTTOMLEFT",		oUF_ManrielUIArena2,	'TOPLEFT',	0,	28);
	self:Spawn("arena4"):SetPoint(		"BOTTOMLEFT",		oUF_ManrielUIArena3,	'TOPLEFT',	0,	28);
	self:Spawn("arena5"):SetPoint(		"BOTTOMLEFT",		oUF_ManrielUIArena4,	'TOPLEFT',	0,	28);

	self:Spawn("arena1target"):SetPoint("BOTTOMLEFT",		oUF_ManrielUIArena1,    'BOTTOMRIGHT',	2,	0);
	self:Spawn("arena2target"):SetPoint("BOTTOMLEFT",		oUF_ManrielUIArena2,	'BOTTOMRIGHT',	2,	0);
	self:Spawn("arena3target"):SetPoint("BOTTOMLEFT",		oUF_ManrielUIArena3,	'BOTTOMRIGHT',	2,	0);
	self:Spawn("arena4target"):SetPoint("BOTTOMLEFT",		oUF_ManrielUIArena4,	'BOTTOMRIGHT',	2,	0);
	self:Spawn("arena5target"):SetPoint("BOTTOMLEFT",		oUF_ManrielUIArena5,	'BOTTOMRIGHT',	2,	0);

end);