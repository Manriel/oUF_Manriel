local xPosition, yPosition = 170, 320;
local width, height, offset = 280, 45, 4

local mediaLib = LibStub:GetLibrary("LibSharedMedia-3.0");

local locale = GetLocale();
local arStrings = {};
if locale == "ruRU" then
	arStrings = {
		offline = 'Не в сети',
		dead = {
			'Мертв',
			'Мертв',
			'Мертва',
		},
		ghost = 'Призрак',
	}
else
	arStrings = {
		offline = 'Offline',
		dead = {
			'Dead',
			'Dead',
			'Dead',
		},,
		ghost = 'Ghost',
	}
end

if not mediaLib then return end;

mediaLib:Register('background', 'Manriel-Health', "Interface\\AddOns\\oUF_AlekkUI\\textures\\Ruben");
mediaLib:Register('background', 'Manriel-Rune', "Interface\\AddOns\\oUF_AlekkUI\\textures\\rothTex");
mediaLib:Register('background', 'Manriel-Glow', "Interface\\Addons\\oUF_AlekkUI\\media\\glowTex");
mediaLib:Register('border', 'Manriel-Border-Caith', "Interface\\AddOns\\oUF_AlekkUI\\textures\\Caith");
mediaLib:Register('border', 'Manriel-Border-Bubble', "Interface\\Addons\\oUF_AlekkUI\\textures\\bubbleTex");
mediaLib:Register('border', 'Manriel-Border-Castbar', "Interface\\AddOns\\oUF_AlekkUI\\textures\\border");
mediaLib:Register('font', 'CalibriBold', "Interface\\AddOns\\oUF_AlekkUI\\fonts\\CalibriBold.ttf");
mediaLib:Register('font', 'Calibri', "Interface\\AddOns\\oUF_AlekkUI\\fonts\\Calibri.ttf");

local fontName = mediaLib:Fetch('font', 'CalibriBold');
local fontNamePixel = mediaLib:Fetch('font', 'Calibri');
local baseFontSize = height*0.25

local textureHealthBar = mediaLib:Fetch('background', 'Manriel-Health');
local textureRuneBar = mediaLib:Fetch('background', 'Manriel-Rune');
local textureBorder = mediaLib:Fetch('border', 'Manriel-Border-Caith');
local textureBubble = mediaLib:Fetch('border', 'Manriel-Border-Bubble');
local textureCastBarBorder = mediaLib:Fetch('border', 'Manriel-Border-Castbar');
local textureGlow = mediaLib:Fetch('background', 'Manriel-Glow');

local backdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = mediaLib:Fetch('border', 'Manriel-Border-Castbar'), edgeSize = 12,
	insets = {left = 0, right = 0, top = 0, bottom = 0},
}

local backdrophp = {
	bgFile = mediaLib:Fetch('background', 'Manriel-Health'),
	insets = {left = 0, right = 0, top = 0, bottom = 0},
}

local classification = {
	worldboss = '%s |cffffd700Boss|r',
	rareelite = '%s |cffffd700R+|r',
	elite = '%s |cffffd700++|r',
	rare = '%s Rare',
	normal = '%s',
	trivial = '%s',
}

-- oUF.colors.power['MANA'] = {.30,.45,.65}
-- oUF.colors.power['RAGE'] = {.70,.30,.30}
-- oUF.colors.power['FOCUS'] = {.70,.45,.25}
-- oUF.colors.power['ENERGY'] = {.65,.65,.35}
-- oUF.colors.power['RUNIC_POWER'] = {.45,.45,.75}

-- oUF.colors.runes = {
-- 		[1] = {.69, .31, .31},
-- 		[2] = {.33, .59, .33},
-- 		[3] = {.31, .45, .63},
-- 		[4] = {.84, .75, .05},
-- }

-- oUF.colors.tapped = {.55,.57,.61}
-- oUF.colors.disconnected = {.5,.5,.5}

local formatVal = function(val)
	if val >= 1e6 then
		return string.format("%.1fm", val/1e6)
	elseif val >= 1e3 then
		return string.format("%.1fk", val/1e3)
	else
		return val
	end	
end

local setFontString = function(parent, fontStyle, fontHeight)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontStyle, fontHeight)
	fs:SetShadowColor(0,0,0)
	fs:SetShadowOffset(1, -1)
	fs:SetTextColor(1,1,1)
	fs:SetJustifyH("LEFT")
	return fs
end

local getDifficultyColor = function(level)
	if level == '??' or level == '-1' then
		return  1,0.84,1 -- .69,.31,.31
	else
	local levelDiff = UnitLevel('target') - UnitLevel('player')
		if levelDiff >= 5 then
			return .69,.31,.31
		elseif levelDiff >= 3 then
			return .71,.43,.27
		elseif levelDiff >= -2 then
			return .84,.75,.65
		elseif -levelDiff <= GetQuestGreenRange() then
			return .33,.59,.33
		else
			return  .55,.57,.61
		end
	end
end

local function updateColor(self, unit, Health)
	local color, colorRGB
	local _, class = UnitClass(unit)

	if(UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit)) then
		color = {.5,.5,.5}
	elseif(UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit)) then
		color = {.5,.5,.5}
	elseif(UnitIsPlayer(unit)) then
		color = oUF.colors.class[class]
	else
		colorRGB = FACTION_BAR_COLORS[UnitReaction(unit, 'player')]	
	end
	if(color) then
		Health:SetStatusBarColor(color[1], color[2], color[3])	
		Health:SetBackdropColor(color[1]/2.5, color[2]/2.5, color[3]/2.5,0.8)
	elseif(colorRGB) then
		Health:SetStatusBarColor(colorRGB.r, colorRGB.g, colorRGB.b)	
		Health:SetBackdropColor(colorRGB.r/2.5, colorRGB.g/2.5, colorRGB.b/2.5, 0.8)
	end
end

local function OverrideUpdateName(self, event, unit)
	if(self.unit ~= unit or not self.Name) then return end
	if(unit == 'player') then
		self.Name:Hide()
	else
		self.Name:SetText(UnitName(unit))
	end

	if (UnitClassification(unit)== "worldboss" or UnitClassification(unit)== "rareelite" or UnitClassification(unit)== "elite") then
		self:SetBackdropBorderColor(1,0.84,0,1)
	else
		self:SetBackdropBorderColor(1,1,1,1)
	end	
	
	if(unit == 'player' or unit == 'target') then
		local level = not UnitIsConnected(unit) and '??' or UnitLevel(unit) < 1 and '??' or UnitLevel(unit)
		self.Lvl:SetFormattedText(classification[UnitClassification(unit)], level)


		if UnitCanAttack("player", unit) then
			self.Lvl:SetTextColor(getDifficultyColor(level))
		else
			self.Lvl:SetTextColor(1, 1, 1)
		end

		local color
		if UnitIsPlayer(unit) then	
			color = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
			local class, className = UnitClass(unit)
			if ( className == 'WARLOCK' ) and (locale == 'ruRU') then
				class = 'Варлок'
			elseif (className == 'DEATHKNIGHT') and (locale == 'ruRU') then
				class='Р. смерти'
			end
			self.Class:SetText(class);
		else
			self.Class:SetText(UnitCreatureFamily(unit) or UnitCreatureType(unit))
		end
		if not color then color = { r = 1, g = 1, b = 1} end
		self.Class:SetVertexColor(color.r, color.g, color.b)
		self.Race:SetText(UnitRace(unit))
	end
end

local function PostUpdateHealth(Health, unit, min, max)
	local self = Health:GetParent()
	if(not UnitIsConnected(unit)) then
		Health:SetValue(0)
		Health.value:SetText('|cffD7BEA5'..arStrings['offline'])
	elseif(UnitIsDead(unit)) then
		Health:SetValue(0)
		Health.value:SetText('|cffD7BEA5'..arStrings['dead'][UnitSex(unit)])
	elseif(UnitIsGhost(unit)) then
		Health:SetValue(0)
		Health.value:SetText('|cffD7BEA5'..arStrings['ghost'])
	else
		if(unit=="player") then
			Health.value:SetFormattedText("%d | %d | %d|cffffffff%%",min, max ,floor(min/max*100))
		elseif (unit=="target") then
			Health.value:SetFormattedText("%.1f|cffffffff%% | %s", (min/max*100),formatVal(max))
		else
			Health.value:SetFormattedText("%d|cffffffff%%", floor(min/max*100))
		end
	end
	
	updateColor(self, unit, Health)
	self:UNIT_NAME_UPDATE(event, unit)
end

local function PostUpdatePower(Power, unit, min, max)-- (self, event, unit, bar, min, max)
	local self = Power:GetParent()
    if max == 0 or UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit) then  
        Power:SetValue(0) 
        if Power.value then
            Power.value:SetText()
        end
    elseif Power.value then
		if(unit=='player') then  
			Power.value:SetText(min .. ' | ' .. max)
		elseif(unit=="target") then
			Power.value:SetText(formatVal(min) .. ' | ' .. formatVal(max))
		else
			Power.value:SetText()  
		end
	end
	
	local _, pType = UnitPowerType(unit)
	local color = self.colors.power[pType] or {0.7,0.7,0.7}
	
	Power:SetStatusBarColor(color[1], color[2], color[3]) 
	Power:SetBackdropColor(color[1]/3, color[2]/3, color[3]/3,1)
	self:UNIT_NAME_UPDATE(event, unit)
end

local UnitSpecific = {
	player = function(self)

		self.Health.value:SetPoint("RIGHT", -2, 0);
		self.Power.value:SetPoint("RIGHT", self.Power, "RIGHT", -2, 0);

		local ClassIconsFrame = CreateFrame("Frame", 'oUF_Manriel_Player_ClassIcons', self.Health);
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

		self.Name:SetPoint("LEFT", self.Health, "LEFT", 2, 0);
		self.Lvl:SetPoint("LEFT", self.Power, "LEFT", 2, 0);
		self.Class:SetPoint("LEFT", self.Lvl, "RIGHT",  1, 0);
		self.Race:SetPoint("LEFT", self.Class, "RIGHT",  1, 0);

	end,

	target = function(self)

		self.Health.value:SetPoint("LEFT", 2, 0);
		self.Power.value:SetPoint("LEFT", self.Power, "LEFT", 2, 0)

		local CPointsFrame = CreateFrame("Frame", 'oUF_Manriel_Target_CPoints', self);
		CPointsFrame:SetAllPoints(self);
		-- CPointsFrame:SetBackdrop(backdrop);
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

		self.Name:SetPoint("RIGHT", self.Health, "RIGHT", -2, 0);
		self.Name:SetJustifyH("RIGHT");
		self.Race:SetPoint("RIGHT", self.Power, "RIGHT",  -2, 0)
		self.Class:SetPoint("RIGHT", self.Race, "LEFT",  -1, 0)
		self.Lvl:SetPoint("RIGHT", self.Class, "LEFT", -1, 0)

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
	local Health = CreateFrame("StatusBar", 'oUF_Manriel_Player_Health', self)
	Health:SetHeight( (height-offset-offset) * .8);
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
	local Power = CreateFrame("StatusBar", 'oUF_Manriel_Player_Power', self)
	Power:SetHeight( (height-offset-offset) * .2);
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
	Power.colorClass = true
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

	self.UNIT_NAME_UPDATE = OverrideUpdateName
	self.Health.PostUpdate = PostUpdateHealth
	self.Power.PostUpdate = PostUpdatePower

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