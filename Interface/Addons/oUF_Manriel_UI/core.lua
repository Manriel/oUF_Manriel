local parent, ns = ...
local oUF = ns.oUF
local UI = ns.ManrielUI
local config = UI.config

local xPosition, yPosition, width, height, offset, classification = config.xPosition, config.yPosition, config.width, config.height, config.offset, config.classification
local fontName, fontNamePixel, baseFontSize = config.fontName, config.fontNamePixel, config.baseFontSize
local textureHealthBar, textureRuneBar, textureBorder, textureBubble, textureCastBarBorder, textureGlow, textureBlizzardTooltip = config.textureHealthBar, config.textureRuneBar, config.textureBorder, config.textureBubble, config.textureCastBarBorder, config.textureGlow, config.textureBlizzardTooltip 

local backdrop = {
	bgFile = textureBlizzardTooltip,
	edgeFile = textureCastBarBorder,
	edgeSize = 12,
	insets = {left = 0, right = 0, top = 0, bottom = 0},
}

local backdrophp = {
	bgFile = textureHealthBar,
	insets = {left = 0, right = 0, top = 0, bottom = 0},
}

local setFontString = UI.methods.setFontString

local UnitSpecific = {
	player = function(self)

		self.Health.value:SetPoint("RIGHT", -2, -1)
		self.Power.value:SetPoint("RIGHT", self.Power, "RIGHT", -2, -1)

		local ClassIconsFrame = CreateFrame("Frame", 'oUF_Manriel_player_ClassIcons', self.Health);
		ClassIconsFrame:SetAllPoints(self.Health);
		local ClassIcons = {}
		for index = 1, 6 do
		   local Icon = ClassIconsFrame:CreateTexture(nil, 'OVERLAY')
		   Icon:SetSize(height*0.6, height*0.6)
		   Icon:SetPoint('TOPLEFT', ClassIconsFrame, 'TOPLEFT', (index-1) * Icon:GetWidth(), 0)
		   ClassIcons[index] = Icon
		end
		self.ClassIcons = ClassIcons


		local Combat = self.Health:CreateTexture(nil, 'OVERLAY')
		Combat:SetSize(height*0.5, height*0.5)
		Combat:SetPoint('TOPRIGHT', 2, Combat:GetHeight()/1.8)
		self.Combat = Combat

		self.Leader:SetPoint("LEFT", self.Health, "TOPLEFT", 0, (self.Leader:GetHeight()*0.2));
		self.MasterLooter:SetPoint("LEFT", self.Leader, "RIGHT", 0, (self.MasterLooter:GetHeight()*0.1));

		self.Name:SetPoint("LEFT", self.Health, "LEFT", 2, -1);
		self.Lvl:SetPoint("LEFT", self.Power, "LEFT", 2, -1);
		self.Class:SetPoint("LEFT", self.Lvl, "RIGHT",  1, 0);
		self.Race:SetPoint("LEFT", self.Class, "RIGHT",  1, 0);

		local Debuffs =  CreateFrame("StatusBar", 'oUF_Manriel_player_Debuffs', self)
		Debuffs:SetSize(width, width/2);
		Debuffs.size = height*0.7
		Debuffs.spacing = 2.5
		Debuffs.initialAnchor = "BOTTOMLEFT"
		Debuffs["growth-x"] = "RIGHT"
		Debuffs["growth-y"] = "UP"
		Debuffs:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, 10)
		Debuffs.PostCreateIcon = UI.methods.PostCreateIcon
		Debuffs.PostUpdateIcon = UI.methods.PostUpdateIcon
		
		self.Debuffs = Debuffs

		local Buffs =  CreateFrame("StatusBar", 'oUF_Manriel_player_Buffs', self)
		Buffs:SetSize(width, width/2);
		Buffs.size = height*0.7
		Buffs.spacing = 5
		Buffs.initialAnchor = "TOPRIGHT"
		Buffs["growth-x"] = "LEFT"
		Buffs["growth-y"] = "DOWN"
		Buffs:SetPoint("TOPRIGHT", self:GetParent(), "TOPRIGHT", -5, -10)
		Buffs.PostCreateIcon = UI.methods.PostCreateIcon
		Buffs.PostUpdateIcon = UI.methods.PostUpdateIcon
		
		self.Buffs = Buffs

	end,

	target = function(self)

		self.Health.value:SetPoint("LEFT", 2, -1)
		self.Power.value:SetPoint("LEFT", self.Power, "LEFT", 2, -1)

		local CPointsFrame = CreateFrame("Frame", 'oUF_Manriel_target_CPoints', self);
		CPointsFrame:SetAllPoints(self);
		local CPoints = {}
		for index = 1, MAX_COMBO_POINTS do
			local CPoint = CPointsFrame:CreateTexture(nil, 'OVERLAY')
			CPoint:SetSize(height*0.5, height*0.5)
			CPoint:SetPoint('LEFT', CPointsFrame, 'TOPLEFT', (index-1) * CPoint:GetWidth()+offset, 0)
			CPoint:SetTexture(textureBubble);
			if ((index >= 3) and (index <= 4)) then
				CPoint:SetVertexColor(.67,.67,.33);
			elseif (index < 4) then
				CPoint:SetVertexColor(.69,.31,.31)
			else
				CPoint:SetVertexColor(.33,.63,.33)	
			end
			CPoints[index] = CPoint
		end
		self.CPoints = CPoints

		self.Leader:SetPoint("RIGHT", self.Health, "TOPRIGHT", 0, (self.Leader:GetHeight()*0.2));
		self.MasterLooter:SetPoint("RIGHT", self.Leader, "LEFT", 0, (self.MasterLooter:GetHeight()*0.1));

		self.Name:SetPoint("RIGHT", self.Health, "RIGHT", -2, -1);
		self.Name:SetJustifyH("RIGHT");
		self.Race:SetPoint("RIGHT", self.Power, "RIGHT",  -2, -1)
		self.Class:SetPoint("RIGHT", self.Race, "LEFT",  -1, 0)
		self.Lvl:SetPoint("RIGHT", self.Class, "LEFT", -1, 0)

		local Auras = CreateFrame('StatusBar', 'oUF_Manriel_target_Auras', self)
		Auras:SetSize(width, width/2);
		Auras:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', 0, 10)
		Auras['growth-x'] = 'LEFT'
		Auras['growth-y'] = 'UP' 
		Auras['spacing-y'] = 10
		Auras.initialAnchor = 'BOTTOMRIGHT'
		Auras.size = height*0.7
		Auras.spacing = 2.5
		Auras.gap = true
		Auras.numBuffs = 18 
		Auras.numDebuffs = 18 

		Auras.PostCreateIcon = UI.methods.PostCreateIcon
		Auras.PostUpdateIcon = UI.methods.PostUpdateIcon
		
		self.Auras = Auras
		
		-- self.sortAuras = {}
		-- self.sortAuras.selfFirst = true

	end,

	targattargat = function(self)

	end,

	focus = function(self)

	end,
}

local Style = function(self, unit)
	
	self:RegisterForClicks("AnyUp")

	self:SetSize(width, height);
	self:SetBackdrop(backdrop);
	self:SetBackdropColor(0,0,0,1);

	-- Position and size
	local Health = CreateFrame("StatusBar", 'oUF_Manriel_'..unit..'_Health', self)
	Health:SetHeight( (height-offset-offset) * .7);
	Health:SetPoint('TOP', 0, -offset)
	Health:SetPoint('LEFT', offset, 0)
	Health:SetPoint('RIGHT', -offset, 0)
	Health:SetStatusBarTexture(textureHealthBar)

	-- Add a background
	local Background = Health:CreateTexture(nil, 'BACKGROUND')
	Background:SetAllPoints(Health)
	Background:SetTexture(textureHealthBar)
	-- Make the background darker.
	Background.multiplier = .5

	-- Options
	Health.frequentUpdates = true
	Health.colorTapping = true
	Health.colorDisconnected = true
	Health.colorHappiness = true
	Health.colorClass = true
	Health.colorReaction = true
	Health.colorHealth = true
	-- Special options
	Health.Smooth = true

	Health.value = setFontString(Health, fontName, baseFontSize)

	-- Register it with oUF
	self.Health = Health
	self.Health.bg = Background

	-- Position and size
	local Power = CreateFrame("StatusBar", 'oUF_Manriel_'..unit..'_Power', self)
	Power:SetHeight( (height-offset-offset) * 0.3);
	Power:SetPoint("LEFT", self.Health)
	Power:SetPoint("RIGHT", self.Health)
	Power:SetPoint("TOP", self.Health, "BOTTOM", 0, 0)
	Power:SetStatusBarTexture(textureHealthBar)

	-- Add a background
	local Background = Power:CreateTexture(nil, 'BACKGROUND')
	Background:SetAllPoints(Power)
	Background:SetTexture(textureHealthBar)
	-- Make the background darker.
	Background.multiplier = .5

	-- Options
	Power.frequentUpdates = true
	Power.colorTapping = true
	Power.colorDisconnected = true
	Power.colorHappiness = true
	Power.colorPower = true
	-- Power.colorClass = true
	Power.colorReaction = true
	-- Special options
	Power.Smooth = true

	Power.value = setFontString(Power, fontName, baseFontSize-1)

	-- Register it with oUF
	self.Power = Power
	self.Power.bg = Background

	local Leader = self.Health:CreateTexture(nil, "OVERLAY")
	Leader:SetSize(height*0.4, height*0.4);
	self.Leader = Leader
	
	local MasterLooter = self.Health:CreateTexture(nil, 'OVERLAY')
	MasterLooter:SetSize(height*0.4, height*0.4);
	self.MasterLooter = MasterLooter

	local RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(height*0.4, height*0.4);
	RaidIcon:SetPoint("TOP", self, 0, RaidIcon:GetHeight()/2)
	self.RaidIcon = RaidIcon

	local Name = setFontString(self.Health, fontName, baseFontSize)
	Name:SetWidth(width-offset-offset)
	self.Name = Name
	lvl = setFontString(self.Power, fontName, baseFontSize-1)
	self.Lvl = lvl
	class = setFontString(self.Power, fontName, baseFontSize-1)
	self.Class = class
	race = setFontString(self.Power, fontName, baseFontSize-1)
	self.Race = race

	self.UNIT_NAME_UPDATE = UI.methods.OverrideUpdateName
	self.Health.PostUpdate = UI.methods.PostUpdateHealth
	self.Power.PostUpdate = UI.methods.PostUpdatePower

	if(UnitSpecific[unit]) then
		return UnitSpecific[unit](self)
	end

end;

oUF:RegisterStyle('ManrielUI', Style);
oUF:Factory(function(self)

	oUF:SetActiveStyle('ManrielUI');
	self:Spawn("player"):SetPoint("BOTTOMRIGHT",	UIParent,	'BOTTOM',	-xPosition,	yPosition);
	self:Spawn("target"):SetPoint("BOTTOMLEFT",		UIParent,	'BOTTOM',	xPosition,	yPosition);

end);