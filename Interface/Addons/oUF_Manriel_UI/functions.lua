local parent, ns = ...
local oUF = ns.oUF
local UI = ns.ManrielUI
local methods = UI.methods
local arStrings = UI.localeStrings
local config = UI.config

local formatVal = function(val)
	if val >= 1e6 then
		return string.format("%.1fm", val/1e6)
	elseif val >= 1e3 then
		return string.format("%.1fk", val/1e3)
	else
		return val
	end	
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

local updateColor = function(self, unit, sb)
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
		sb:SetStatusBarColor(color[1], color[2], color[3])	
		sb:SetBackdropColor(color[1]/2.5, color[2]/2.5, color[3]/2.5,0.8)
	elseif(colorRGB) then
		sb:SetStatusBarColor(colorRGB.r, colorRGB.g, colorRGB.b)	
		sb:SetBackdropColor(colorRGB.r/2.5, colorRGB.g/2.5, colorRGB.b/2.5, 0.8)
	end
end

local UpdateAuraTimer = function(self, elapsed)
	if (self.duration) then
		local duration = self.cd.duration or nil
		local timeLeft = self.cd.timeLeft or nil
		if (timeLeft) and (timeLeft > 0) and (duration) and (duration > 0) then
			local sec = timeLeft - GetTime()
			self.duration:SetText(gsub(format(SecondsToTimeAbbrev(sec)), "[ .]", ""))
		else
			self.duration:SetText('')
		end
	end
end

methods.setFontString = function(parent, fontStyle, fontHeight, flags)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontStyle, fontHeight, flags)
	fs:SetShadowColor(0,0,0)
	fs:SetShadowOffset(1, -1)
	fs:SetTextColor(1,1,1)
	fs:SetJustifyH("LEFT")
	return fs
end

methods.OverrideUpdateName = function(self, event, unit)
	if(self.unit ~= unit or not self.Name) then return end
	if(unit == 'player') then
		self.Name:Hide()
	else
		if (unit == 'target') then
			self.Name:SetFormattedText('%.49s', UnitName(unit))
		else
			self.Name:SetFormattedText('%.25s', UnitName(unit))
		end
	end

	if (UnitClassification(unit)== "worldboss" or UnitClassification(unit)== "rareelite" or UnitClassification(unit)== "elite") then
		if UnitClassification(unit)== "worldboss" or UnitClassification(unit)== "rareelite" then
			self:SetBackdropBorderColor(1,0.84,0,1)
			self.elite.tex:SetVertexColor(1,0.84,0,1)
		else
			self:SetBackdropBorderColor(1,1,1,1)
			self.elite.tex:SetVertexColor(1,1,1,1)
		end
		self.elite:Show()
	else
		self:SetBackdropBorderColor(1,1,1,1)
		self.elite.tex:SetVertexColor(1,1,1,1)
		self.elite:Hide()
	end	
	
	if(unit == 'player' or unit == 'target') then
		local level = not UnitIsConnected(unit) and '??' or UnitLevel(unit) < 1 and '??' or UnitLevel(unit)
		self.Lvl:SetFormattedText("%s%s", level, config.classification[UnitClassification(unit)])


		if UnitCanAttack("player", unit) then
			self.Lvl:SetTextColor(getDifficultyColor(level))
		else
			self.Lvl:SetTextColor(1, 1, 1)
		end

		local locale = GetLocale()
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

methods.PostUpdateHealth = function(Health, unit, min, max)
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
			Health.value:SetFormattedText("%d | %d | %d|cffffffff%%", min, max, floor(min/max*100))
		elseif (unit=="target") then
			Health.value:SetFormattedText("%.1f|cffffffff%% | %s", (min/max*100), formatVal(max))
		else
			Health.value:SetFormattedText("%d|cffffffff%%", floor(min/max*100))
		end
	end
	
	updateColor(self, unit, Health)
	self:UNIT_NAME_UPDATE(event, unit)
end

methods.PostUpdatePower = function(Power, unit, min, max)-- (self, event, unit, bar, min, max)
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

methods.AltPowerPostUpdate = function ( self, min, cur, max )
	local caption = self.caption
	if caption then
		caption:SetFormattedText("%s: %d / %d", self.powerName, cur, max)
	end
end

methods.PostCreateIcon = function(icons, button)

	button.overlay:SetTexture(config.textureBorder)
	button.overlay:SetTexCoord(0, 1, 0, 1)
	button.overlay:ClearAllPoints()
	button.overlay:SetPoint("TOPLEFT", button, "TOPLEFT", -3, 3)
	button.overlay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 3, -3)
	if (not button.overlay:IsShown()) then
		button.overlay:SetVertexColor(0, 0, 0, 1)
		button.overlay:Show()
	end

	button.duration = methods.setFontString(button, config.fontName, config.baseFontSize, "THINOUTLINE")
	button.duration:SetJustifyH("CENTER")
	button.duration:SetPoint("TOP", button, "BOTTOM", 0, -2)
	button.cd:SetHideCountdownNumbers(true)

	button:SetScript('OnUpdate', UpdateAuraTimer)
end

methods.PostUpdateIcon = function(self, unit, icon, index, offset)
	local ParentFrame = self:GetParent()
	local AltPowerBar = ParentFrame.AltPowerBar
	if AltPowerBar and unit == 'player' then
		if AltPowerBar:IsShown() then
			ParentFrame.Debuffs:ClearAllPoints()
			ParentFrame.Debuffs:SetPoint("BOTTOMLEFT", ParentFrame, "TOPLEFT", 0, AltPowerBar:GetHeight()+12+config.offset*2)
		else
			ParentFrame.Debuffs:ClearAllPoints()
			ParentFrame.Debuffs:SetPoint("BOTTOMLEFT", ParentFrame, "TOPLEFT", 0, 12)
		end
	end

	icon.overlay:Show()

	icon.icon:SetTexCoord(.1, .9, .1, .9)
	icon.icon:SetDesaturated( (unit == 'target') and (UnitIsEnemy("player","target")) and (not icon.isPlayer) and (icon.isDebuff) );
	if (icon.count) then
		icon.count:SetFont(config.fontName, icon:GetHeight()/2.5, "THINOUTLINE");
		icon.count:ClearAllPoints()
		icon.count:SetPoint("TOPRIGHT", 0, 0)
		icon.count:SetShadowColor(0,0,0)
		icon.count:SetShadowOffset(0,0)
	end

	if (icon.cd) then
		local filter = icon.filter
		local _, _, _, _, _, duration, expirationTime, _, _, _, _, _, _ = UnitAura(unit, index, filter)
		
		icon.cd.duration = duration
		icon.cd.timeLeft = expirationTime
	end
end

methods.PostUpdateGapIcon = function(self, unit, icon, index)
	if (icon.cd) then
		icon.cd.duration = 0
		icon.cd.timeLeft = 0
	end
end

local function AuraSort (a)
	local tmpA = a
	local resultA = {}

	for i = 1, #a do
		resultA[i] = i
	end

	local zeroCount = 0

	for i = 1, #a do
		for j = i, #a do

			if tmpA[i] ~= false and tmpA[j] ~= false and (i ~= j) and (tmpA[i] < tmpA[j]) then
				local tmp = tmpA[i]
				tmpA[i] = tmpA[j]
				tmpA[j] = tmp

				tmp = resultA[i]
				resultA[i] = resultA[j]
				resultA[j] = tmp
			end

		end

		if a[i] ~= false and a[i] == 0 then
			zeroCount = zeroCount + 1
		end
	end

	local tmpB = {}
	local resultB = {}
	local counter = 1
	
	for i = 1, #a do
		if tmpA[i] and tmpA[i] > 0 then
			tmpB[i+zeroCount] = tmpA[i]
			resultB[i+zeroCount] = resultA[i]
		elseif tmpA[i] and tmpA[i] == 0 then
			tmpB[counter] = tmpA[i]
			resultB[counter] = resultA[i]
			counter = counter + 1
		end
	end

	return resultB
end

methods.Auras_SetPosition = function(icons, from, to)
	local sizex = (icons.size or 16) + (icons['spacing-x'] or icons.spacing or 0)
	local sizey = (icons.size or 16) + (icons['spacing-y'] or icons.spacing or 0)
	local anchor = icons.initialAnchor or "BOTTOMLEFT"
	local growthx = (icons["growth-x"] == "LEFT" and -1) or 1
	local growthy = (icons["growth-y"] == "DOWN" and -1) or 1
	local cols = math.floor(icons:GetWidth() / sizex + .5)

	local a = {}

	for index = from, to do
		local unit = icons.unit
		if not unit then print(index) end

	    local name, rank, texture, count, debuffType, duration, expirationTime, _, _, shouldConsolidate, spellId = UnitAura(unit, index);

	    if name then
	    	local timeLeft = expirationTime - GetTime()
	    	if timeLeft > 0 then
	    		a[index] = timeLeft
	    	else 
	    		a[index] = 0
	    	end
	    else
	    	a[index] = false
	    end
	end

	local aSort = AuraSort(a)

	for i = from, to do
		local j = aSort[i]
		local button = icons[j]

		-- Bail out if the to range is out of scope.
		if(not button) then break end
		local col = (i - 1) % cols
		local row = math.floor((i - 1) / cols)

		button:ClearAllPoints()
		button:SetPoint(anchor, icons, anchor, col * sizex * growthx, row * sizey * growthy)
	end
end

methods.OverrideCastbarTime = function(self, duration)
		if(self.channeling) then
			self.Time:SetFormattedText('%.1f / %.2f', self.max - duration, self.max)
		elseif(self.casting) then
			self.Time:SetFormattedText('%.1f / %.2f', duration, self.max)
		end	
end

methods.OverrideCastbarDelay = function(self, duration)
		if(self.channeling) then
			self.Time:SetFormattedText('%.1f / %.2f |cffff0000+ %.1f', self.max - duration, self.max, self.delay)
		elseif(self.casting) then
			self.Time:SetFormattedText('%.1f / %.2f |cffff0000+ %.1f', duration, self.max, self.delay)
		end	
end

methods.DruidManaPreUpdate = function(unit)
	local offset = config.offset
	if(unit == 'player' and UnitPowerType(unit) == SPELL_POWER_MANA) then
		oUF_ManrielUIPlayer.Power:SetHeight( (oUF_ManrielUIPlayer:GetHeight()-offset-offset) * 0.3)
		oUF_ManrielUIPlayer.DruidMana:Hide()
	else
		oUF_ManrielUIPlayer.Power:SetHeight( (oUF_ManrielUIPlayer:GetHeight()-offset-offset) * 0.15)
		oUF_ManrielUIPlayer.DruidMana:Show()
	end
end
