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

methods.setFontString = function(parent, fontStyle, fontHeight)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetFont(fontStyle, fontHeight)
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
		self.Name:SetText(UnitName(unit))
	end

	if (UnitClassification(unit)== "worldboss" or UnitClassification(unit)== "rareelite" or UnitClassification(unit)== "elite") then
		self:SetBackdropBorderColor(1,0.84,0,1)
	else
		self:SetBackdropBorderColor(1,1,1,1)
	end	
	
	if(unit == 'player' or unit == 'target') then
		local level = not UnitIsConnected(unit) and '??' or UnitLevel(unit) < 1 and '??' or UnitLevel(unit)
		self.Lvl:SetFormattedText("%s%s", level, config.classification[UnitClassification(unit)])


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

methods.UpdateAuraIcon = function(self, unit, icon, index, offset)
	icon.icon:SetDesaturated( (unit == 'target') and (not icon.isPlayer) and (icon.isDebuff) );
	if (icon.count) then
		icon.count:SetFont(config.fontNamePixel, icon:GetHeight()/2.5, "OUTLINE");
		icon.count:SetShadowColor(0,0,0)
		icon.count:SetShadowOffset(0,0)
	end
end