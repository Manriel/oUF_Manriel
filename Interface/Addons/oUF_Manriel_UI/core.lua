local parent, ns = ...
local oUF = ns.oUF
local UI = ns.ManrielUI
local config = UI.config

local xPosition, yPosition, width, height, offset, classification = config.xPosition, config.yPosition, config.width, config.height, config.offset, config.classification
local fontName, fontNamePixel, baseFontSize = config.fontName, config.fontNamePixel, config.baseFontSize
local textureHealthBar, textureRuneBar, textureBorder, textureBubble, textureCastBarBorder, textureGlow, textureBlizzardTooltip, texturePanel = config.textureHealthBar, config.textureRuneBar, config.textureBorder, config.textureBubble, config.textureCastBarBorder, config.textureGlow, config.textureBlizzardTooltip, config.texturePanel

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

local backdropPanel = {
	bgFile = texturePanel,
	tile = true,
	tileSize = 256,
	edgeFile = textureCastBarBorder,
	edgeSize = 12,
	insets = {
		left = 3,
		right = 3,
		top = 3,
		bottom = 3
	}
};

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

		if select(2, UnitClass('player')) == 'DEATHKNIGHT' then
			local Runes = {}
			for index = 1, 6 do
				local bg = CreateFrame('Frame', 'oUF_Manriel_player_Rune'..index, self)
				if (index%2 == 0) then
					bg:SetPoint("TOP", 'oUF_Manriel_player_Rune'..(index-1), "BOTTOM", 0, offset)
				elseif (index == 1) then
					bg:SetPoint("TOPRIGHT", self, "TOPLEFT", 0, 0)
				else
					bg:SetPoint("RIGHT", 'oUF_Manriel_player_Rune'..(index-2), "LEFT", offset*0.75, 0)
				end
				bg:SetFrameStrata('BACKGROUND')
				bg:SetSize( height*0.5+offset*0.5, height*0.5+offset*0.5)
				bg:SetBackdrop(backdrop)
				bg:SetBackdropColor(0,0,0,1)

				-- Position and size of the rune bar indicators
				local Rune = CreateFrame('StatusBar', nil, bg)
				Rune:SetStatusBarTexture(textureRuneBar)
				Rune:SetOrientation("VERTICAL")
				Rune:SetPoint('TOPLEFT', bg, 'TOPLEFT', offset, -offset)
				Rune:SetPoint('BOTTOMRIGHT', bg, 'BOTTOMRIGHT', -offset, offset)

				Runes[index] = Rune
			end
			self.Runes = Runes
		elseif select(2, UnitClass('player')) == 'DRUID' then
			-- Position and size
			local DruidMana = CreateFrame("StatusBar", nil, self)
			DruidMana:SetPoint('BOTTOMLEFT', self.Power, 'BOTTOMLEFT', 0, 0)
			DruidMana:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMRIGHT', 0, 0)
			DruidMana:SetHeight( (self:GetHeight()-offset-offset) * 0.15)
			DruidMana:SetStatusBarTexture(textureHealthBar)
			DruidMana.colorPower = true

			-- Add a background
			local Background = DruidMana:CreateTexture(nil, 'BACKGROUND')
			Background:SetAllPoints(DruidMana)
			Background:SetTexture(textureHealthBar)
			Background.multiplier = .5

			-- Register it with oUF
			self.DruidMana = DruidMana
			self.DruidMana.bg = Background

			local EclipseBar = CreateFrame('Frame', nil, self)
			EclipseBar:SetPoint('BOTTOM', self.Power, 'BOTTOM', 0, 0)
			EclipseBar:SetSize(self:GetWidth()-offset-offset , (self:GetHeight()-offset-offset) * 0.15)
			-- EclipseBar:SetAlpha(1);

			-- Position and size
			local LunarBar = CreateFrame('StatusBar', nil, self)
			LunarBar:SetPoint('LEFT', EclipseBar, 'LEFT')
			LunarBar:SetSize(self:GetWidth()-offset-offset , (self:GetHeight()-offset-offset) * 0.15)
			LunarBar:SetStatusBarTexture(textureHealthBar)
			LunarBar:SetStatusBarColor(0, 0, 1)

			local SolarBar = CreateFrame('StatusBar', nil, self)
			SolarBar:SetPoint('LEFT', LunarBar:GetStatusBarTexture(), 'RIGHT')
			SolarBar:SetSize(self:GetWidth()-offset-offset , (self:GetHeight()-offset-offset) * 0.15)
			SolarBar:SetStatusBarTexture(textureHealthBar)
			SolarBar:SetStatusBarColor(1, 1, 0)

			print(EclipseBar:GetFrameLevel())
			print(DruidMana:GetFrameLevel())
			print(self.Power:GetFrameLevel())
			print(EclipseBar:GetFrameStrata())
			print(DruidMana:GetFrameStrata())
			print(self.Power:GetFrameStrata())
			-- Register with oUF
			EclipseBar.LunarBar = LunarBar
			EclipseBar.SolarBar = SolarBar
			self.EclipseBar = EclipseBar
		end

		local Combat = self.Health:CreateTexture(nil, 'OVERLAY')
		Combat:SetSize(height*0.5, height*0.5)
		Combat:SetPoint('TOPRIGHT', 2, Combat:GetHeight()/1.8)
		self.Combat = Combat

		self.Leader:SetPoint("LEFT", self.Health, "TOPLEFT", 0, (self.Leader:GetHeight()*0.2));
		self.MasterLooter:SetPoint("LEFT", self.Leader, "RIGHT", 0, (self.MasterLooter:GetHeight()*0.1));

		self.Name:SetPoint("LEFT", self.Health, "LEFT", 2, -1);
		self.Name:SetWidth( (width-offset-offset)*0,7 )
		self.Lvl:SetPoint("LEFT", self.Power, "LEFT", 2, -1);
		self.Class:SetPoint("LEFT", self.Lvl, "RIGHT",  1, 0);
		self.Race:SetPoint("LEFT", self.Class, "RIGHT",  1, 0);
		self.PvP:SetPoint('CENTER', self, 'TOPRIGHT', height*0.1, -height*0.2)

		local Debuffs =  CreateFrame("StatusBar", 'oUF_Manriel_player_Debuffs', self)
		-- local Debuffs =  CreateFrame("StatusBar", 'oUF_Manriel_player_Debuffs', self, 'SecureAuraHeaderTemplate')
		-- Debuffs:SetAttribute("unit", "player")
		-- Debuffs:SetAttribute("filter", "HARMFUL")
		-- Debuffs:SetAttribute("template", "MyDebuffButtonTemplate")
		-- Debuffs:SetAttribute("minWidth", width)
		-- Debuffs:SetAttribute("minHeight", height)
		-- Debuffs:Show();

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

		-- local Buffs =  CreateFrame("StatusBar", 'oUF_Manriel_player_Buffs', self, 'SecureAuraHeaderTemplate')
		-- Buffs:SetAttribute("unit", "player")
		-- Buffs:SetAttribute("filter", "HELPFUL")
		-- Buffs:SetAttribute("template", "MyBuffButtonTemplate")
		-- Buffs:SetAttribute("minWidth", width)
		-- Buffs:SetAttribute("minHeight", height)

		-- Buffs:SetAttribute("point", "TOPRIGHT")
		-- Buffs:SetAttribute("xOffset", -width)
		-- Buffs:SetAttribute("yOffset", 0)

		-- Buffs:SetAttribute("separateOwn", 0)
		-- Buffs:SetAttribute("sortMethod", "TIME")
		-- Buffs:SetAttribute("sortDirection","-")
		-- Buffs:SetAttribute("wrapAfter",3)
		-- Buffs:SetAttribute("wrapXOffset", 0)
		-- Buffs:SetAttribute("wrapYOffset", -height)
		-- Buffs:SetAttribute("maxWraps", 10)

		-- Buffs:SetAttribute("includeWeapons", 1)
		-- Buffs:SetAttribute("weaponTemplate", "MyBuffButtonTemplate")

		-- Buffs:Show()

		-- Buffs:SetSize(width, width/2);
		-- Buffs.size = height*0.7
		-- Buffs.spacing = 5
		-- Buffs.initialAnchor = "TOPRIGHT"
		-- Buffs["growth-x"] = "LEFT"
		-- Buffs["growth-y"] = "DOWN"
		-- Buffs:SetPoint("TOPRIGHT", self:GetParent(), "TOPRIGHT", -5, -10)
		-- Buffs.PostCreateIcon = UI.methods.PostCreateIcon
		-- Buffs.PostUpdateIcon = UI.methods.PostUpdateIcon
		
		-- self.Buffs = Buffs

		local colorcb
		local _, classcb = UnitClass('player')
		colorcb = oUF.colors.class[classcb]

		local Castbar = CreateFrame('StatusBar', 'oUF_Manriel_player_Castbar', self)
		Castbar:SetPoint('BOTTOM', UIParent, 'BOTTOM', 0, yPosition+3)
		Castbar:SetStatusBarTexture(textureHealthBar)
		Castbar:SetStatusBarColor(colorcb[1], colorcb[2], colorcb[3])
		Castbar:SetBackdrop(backdrophp)
		Castbar:SetBackdropColor(colorcb[1]/3, colorcb[2]/3, colorcb[3]/3)
		Castbar:SetHeight(height*0.6 - offset*2)
		Castbar:SetWidth(xPosition*2 - offset*2)
		
		Castbar.Spark = Castbar:CreateTexture(nil,'OVERLAY')
		Castbar.Spark:SetBlendMode("ADD")
		Castbar.Spark:SetHeight(Castbar:GetHeight()*1.5)
		Castbar.Spark:SetWidth(Castbar.Spark:GetHeight()*0.6)
		Castbar.Spark:SetVertexColor(colorcb[1], colorcb[2], colorcb[3])
		
		Castbar.Text = setFontString(Castbar, fontName, baseFontSize)
		Castbar.Text:SetPoint('LEFT', Castbar, 2, 0)

		Castbar.Time = setFontString(Castbar, fontName, baseFontSize)
		Castbar.Time:SetPoint('RIGHT', Castbar, -2, 0)
		Castbar.CustomTimeText = OverrideCastbarTime
		Castbar.CustomDelayText = OverrideCastbarDelay
		
		local Castbar2 = CreateFrame('Frame', 'oUF_Manriel_player_Castbar_', Castbar)
		Castbar2:SetPoint('TOPLEFT', Castbar, 'TOPLEFT', -4, 3)
		Castbar2:SetPoint('BOTTOMRIGHT', Castbar, 'BOTTOMRIGHT', 4, -3)
		Castbar2:SetBackdrop(backdrop)
		Castbar2:SetBackdropColor(0,0,0,1)
		Castbar2:SetFrameLevel(0)
		
		Castbar.SafeZone = Castbar:CreateTexture(nil,'BACKGROUND')
		Castbar.SafeZone:SetPoint('TOPRIGHT')
		Castbar.SafeZone:SetPoint('BOTTOMRIGHT')
		Castbar.SafeZone:SetHeight(20)
		Castbar.SafeZone:SetTexture(textureHealthBar)
		Castbar.SafeZone:SetVertexColor(1,1,.01,0.5)

		self.Castbar = Castbar
		-- self.Castbar2 = Castbar2

		local ExperienceFrame = CreateFrame('Frame', 'oUF_Manriel_player_XP_', self)
		ExperienceFrame:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 4, -4)
		ExperienceFrame:SetPoint('TOPRIGHT', UIParent, 'TOPRIGHT', -4, -4)
		ExperienceFrame:SetHeight(height/2);
		ExperienceFrame:SetBackdrop(backdropPanel);
		local Experience = CreateFrame('StatusBar', 'oUF_Manriel_player_XP', ExperienceFrame)
		Experience:SetPoint('TOPLEFT', 3, -3)
		Experience:SetPoint('BOTTOMRIGHT', -3, 3)
		Experience:SetStatusBarTexture(textureHealthBar);
		Experience:SetStatusBarColor(1,1,1,1)
		self.Experience = Experience
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
		self.PvP:SetPoint('CENTER', self, 'TOPLEFT', height*0.2, -height*0.2)

		local Auras = CreateFrame('StatusBar', 'oUF_Manriel_target_Auras', self, 'SecureActionButtonTemplate')
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

		local Castbar = CreateFrame('StatusBar', 'oUF_Manriel_target_Castbar', self)
		Castbar:SetPoint('BOTTOM', oUF_Manriel_player_Castbar, 'TOP', 0, 6)
		Castbar:SetStatusBarTexture(textureHealthBar)
		Castbar:SetStatusBarColor(.81,.81,.25)
		Castbar:SetBackdrop(backdrophp)
		Castbar:SetBackdropColor(.81/3,.81/3,.25/3)
		Castbar:SetHeight(height*0.4 - offset)
		Castbar:SetWidth(xPosition*2 - offset*2)
		
		Castbar.Spark = Castbar:CreateTexture(nil,'OVERLAY')
		Castbar.Spark:SetBlendMode("ADD")
		Castbar.Spark:SetHeight(Castbar:GetHeight()*1.5)
		Castbar.Spark:SetWidth(Castbar.Spark:GetHeight()*0.6)
		Castbar.Spark:SetVertexColor(.69,.31,.31)
		
		Castbar.Text = setFontString(Castbar, fontName, baseFontSize)
		Castbar.Text:SetPoint('LEFT', Castbar, 2, 0)

		Castbar.Time = setFontString(Castbar, fontName, baseFontSize)
		Castbar.Time:SetPoint('RIGHT', Castbar, -2, 0)
		Castbar.CustomTimeText = OverrideCastbarTime
		Castbar.CustomDelayText = OverrideCastbarDelay
		
		local Castbar2 = CreateFrame('Frame', 'oUF_Manriel_player_Castbar_', Castbar)
		Castbar2:SetPoint('TOPLEFT', Castbar, 'TOPLEFT', -4, 3)
		Castbar2:SetPoint('BOTTOMRIGHT', Castbar, 'BOTTOMRIGHT', 4, -3)
		Castbar2:SetBackdrop(backdrop)
		Castbar2:SetBackdropColor(0,0,0,1)
		Castbar2:SetFrameLevel(0)
		
		Castbar.SafeZone = Castbar:CreateTexture(nil,'BACKGROUND')
		Castbar.SafeZone:SetPoint('TOPRIGHT')
		Castbar.SafeZone:SetPoint('BOTTOMRIGHT')
		Castbar.SafeZone:SetHeight(20)
		Castbar.SafeZone:SetTexture(textureHealthBar)
		Castbar.SafeZone:SetVertexColor(1,1,.01,0.5)

		self.Castbar = Castbar

	end,

	targettarget = function(self)
		self.Health:SetHeight( (self:GetHeight()-offset-offset) * .8);
		self.Power:SetHeight( (self:GetHeight()-offset-offset) * .2);

		self.Health.value:SetPoint("LEFT", 2, 0)
		self.Power.value:Hide();


		self.Name:SetPoint("RIGHT", self.Health, "RIGHT", -2, 0);
		self.Name:SetJustifyH("RIGHT");
	end,

	focus = function(self)
		self.Health:SetHeight( (self:GetHeight()-offset-offset) * .8);
		self.Power:SetHeight( (self:GetHeight()-offset-offset) * .2);

		self.Health.value:SetPoint("RIGHT", -2, 0)
		self.Power.value:Hide();

		self.Name:SetPoint("LEFT", self.Health, "LEFT", 2, 0);

		local Castbar = CreateFrame('StatusBar', 'oUF_Manriel_target_Castbar', self)
		Castbar:SetPoint('TOP', oUF_Manriel_player_Castbar, 'BOTTOM', 0, -6)
		Castbar:SetStatusBarTexture(textureHealthBar)
		Castbar:SetStatusBarColor(.79,.41,.31)
		Castbar:SetBackdrop(backdrophp)
		Castbar:SetBackdropColor(.79/3,.41/3,.31/3)
		Castbar:SetHeight(height*0.4 - offset*2)
		Castbar:SetWidth(xPosition*2 - offset*2)
		
		Castbar.Spark = Castbar:CreateTexture(nil,'OVERLAY')
		Castbar.Spark:SetBlendMode("ADD")
		Castbar.Spark:SetHeight(Castbar:GetHeight()*1.5)
		Castbar.Spark:SetWidth(Castbar.Spark:GetHeight()*0.6)
		Castbar.Spark:SetVertexColor(.69,.31,.31)
		
		Castbar.Text = setFontString(Castbar, fontName, baseFontSize)
		Castbar.Text:SetPoint('LEFT', Castbar, 2, 0)

		Castbar.Time = setFontString(Castbar, fontName, baseFontSize)
		Castbar.Time:SetPoint('RIGHT', Castbar, -2, 0)
		Castbar.CustomTimeText = OverrideCastbarTime
		Castbar.CustomDelayText = OverrideCastbarDelay
		
		local Castbar2 = CreateFrame('Frame', 'oUF_Manriel_player_Castbar_', Castbar)
		Castbar2:SetPoint('TOPLEFT', Castbar, 'TOPLEFT', -4, 3)
		Castbar2:SetPoint('BOTTOMRIGHT', Castbar, 'BOTTOMRIGHT', 4, -3)
		Castbar2:SetBackdrop(backdrop)
		Castbar2:SetBackdropColor(0,0,0,1)
		Castbar2:SetFrameLevel(0)
		
		Castbar.SafeZone = Castbar:CreateTexture(nil,'BACKGROUND')
		Castbar.SafeZone:SetPoint('TOPRIGHT')
		Castbar.SafeZone:SetPoint('BOTTOMRIGHT')
		Castbar.SafeZone:SetHeight(20)
		Castbar.SafeZone:SetTexture(textureHealthBar)
		Castbar.SafeZone:SetVertexColor(1,1,.01,0.5)

		self.Castbar = Castbar
	end,
	
	focustarget = function(self)
		self.Health:SetHeight( (self:GetHeight()-offset-offset) * .8);
		self.Power:SetHeight( (self:GetHeight()-offset-offset) * .2);

		self.Health.value:SetPoint("LEFT", 2, 0)
		self.Power.value:Hide();

		self.Name:SetPoint("RIGHT", self.Health, "RIGHT", -2, 0);
		self.Name:SetJustifyH("RIGHT");
	end,

	pet = function(self)
		self.Health:SetHeight( (self:GetHeight()-offset-offset) * .8);
		self.Power:SetHeight( (self:GetHeight()-offset-offset) * .2);

		self.Health.value:SetPoint("LEFT", 2, 0)
		self.Power.value:Hide();

		self.Name:SetPoint("RIGHT", self.Health, "RIGHT", -2, 0);
		self.Name:SetJustifyH("RIGHT");
	end


}

local UnitSpecificSizes = function(self, unit)
	if unit == 'player' or unit == 'target' then
		self:SetSize(width, height);
	elseif unit == 'targettarget' or unit == 'focus' or unit == 'focustarget' or unit == 'pet' then
		self:SetSize(width/2, height/1.75);
	end
end

local Style = function(self, unit)
	
	self:RegisterForClicks("AnyUp")

	UnitSpecificSizes(self, unit);

	self:SetBackdrop(backdrop);
	self:SetBackdropColor(0,0,0,1);

	-- Position and size
	local Health = CreateFrame("StatusBar", 'oUF_Manriel_'..unit..'_Health', self)
	Health:SetHeight( (self:GetHeight()-offset-offset) * .7);
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
	Power:SetHeight( (self:GetHeight()-offset-offset) * 0.3);
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

	self.UNIT_NAME_UPDATE = UI.methods.OverrideUpdateName
	self.Health.PostUpdate = UI.methods.PostUpdateHealth
	self.Power.PostUpdate = UI.methods.PostUpdatePower

	local elite = CreateFrame('Frame', 'oUF_Manriel_'..unit..'_EliteTexture', self)
	elite:SetPoint('TOPRIGHT', self, 'TOPRIGHT', self:GetHeight()*0.61, self:GetHeight()*0.18)
	elite:SetSize(self:GetHeight()*1.9,self:GetHeight()*1.9)
	elite.tex = elite:CreateTexture(nil, 'OVERLAY')
	elite.tex:SetTexture([[Interface\Addons\oUF_Manriel_UI\textures\dragon]])
	elite.tex:SetAllPoints(elite)
	elite:Hide()

	self.elite = elite

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
	Name:SetMaxLines(1);
	self.Name = Name
	lvl = setFontString(self.Power, fontName, baseFontSize-1)
	self.Lvl = lvl
	class = setFontString(self.Power, fontName, baseFontSize-1)
	self.Class = class
	race = setFontString(self.Power, fontName, baseFontSize-1)
	self.Race = race

	local PvP = self.Health:CreateTexture(nil, 'OVERLAY')
	PvP:SetSize(height*0.8, height*0.8)
	self.PvP = PvP

	if(UnitSpecific[unit]) then
		return UnitSpecific[unit](self)
	end

end;

oUF:RegisterStyle('ManrielUI', Style);
oUF:Factory(function(self)

	oUF:SetActiveStyle('ManrielUI');
	self:Spawn("player"):SetPoint(		"BOTTOMRIGHT",		UIParent,	'BOTTOM',	-xPosition,	yPosition);
	self:Spawn("target"):SetPoint(		"BOTTOMLEFT",		UIParent,	'BOTTOM',	xPosition,	yPosition);
	self:Spawn("targettarget"):SetPoint("TOPRIGHT",			oUF_ManrielUITarget,	'BOTTOMRIGHT',	0,	0);
	self:Spawn("focus"):SetPoint(		"TOPRIGHT",			oUF_ManrielUIPlayer,	'BOTTOMRIGHT',	0,	0);
	self:Spawn("focustarget"):SetPoint(	"TOPLEFT",			oUF_ManrielUITarget,	'BOTTOMLEFT',	0,	0);
	self:Spawn("pet"):SetPoint(			"TOPLEFT",			oUF_ManrielUIPlayer,	'BOTTOMLEFT',	0,	0);

end);