local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
	getFont = function()
		return UI.config.fontNameAltBold;
	end,

	getFontSize = function()
		return (UI.config.baseFontSize / 4) * 3;
	end,

	getOffset = function()
		return UI.config.offset;
	end,

	getTexture = function()
		return UI.config.textureHealthBar;
	end

}

local updatePower = function(Power, unit, cur, min, max)
  
  if max == 0 or UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit) then
    Power:SetValue(0) 
    if Power.value then
      Power.value:SetText()
    end
  elseif Power.value then
    if(unit=='player') then
      Power.value:SetText(cur .. ' | ' .. max)
    elseif(unit=="target") then
      Power.value:SetText(UI.fn.formatVal(cur) .. ' | ' .. UI.fn.formatVal(max))
    else
      Power.value:SetFormattedText("%d%%", floor(cur/max*100))
    end
  end
  
  local _, pType = UnitPowerType(unit)
  local color = Power:GetParent().colors.power[pType] or {0.7,0.7,0.7}

  Power:SetStatusBarColor(color[1], color[2], color[3]) 
  Power:SetBackdropColor(color[1]/3, color[2]/3, color[3]/3,1)
end

local getPower = {}
getPower.default = function(self, unit)
	local Power = CreateFrame("StatusBar", self:GetName()..'_Power', self)
	Power:SetHeight( (self:GetHeight() - (props.getOffset() * 2) ) * .3);
	Power:SetPoint("LEFT", self.Health)
	Power:SetPoint("RIGHT", self.Health)
	Power:SetPoint("TOP", self.Health, "BOTTOM", 0, 0)
	Power:SetStatusBarTexture(props.getTexture())

	-- Add a background
	local Background = Power:CreateTexture(nil, 'BACKGROUND')
	Background:SetAllPoints(Power)
	Background:SetTexture(props.getTexture())
	-- Make the background darker.
	Background.multiplier = .5

	-- Options
	Power.displayAltPower = true
	Power.frequentUpdates = true
	Power.colorTapping = true
	Power.colorDisconnected = true
	Power.colorHappiness = true
	Power.colorPower = true
	Power.colorReaction = true
	-- Special options
	Power.Smooth = true

	Power.value = UI.fn.setFontString(Power, props.getFont(), props.getFontSize())
	Power.value:SetPoint("LEFT", Power, "LEFT", 2, 0)
	Power.bg = Background

	Power.PostUpdate = updatePower

	return Power
end
getPower.player = function(self, unit)
	local Power = getPower.default(self, unit)
	Power.value:ClearAllPoints()
	Power.value:SetPoint("RIGHT", -2, 0)

	return Power
end
getPower.focus = function(self, unit)
	local Power = getPower.default(self, unit)
	Power.value:ClearAllPoints()
	Power.value:SetPoint("RIGHT", -2, 0)

	return Power
end
getPower.arena1 = getPower.focus
getPower.arena2 = getPower.focus
getPower.arena3 = getPower.focus
getPower.arena4 = getPower.focus
getPower.arena5 = getPower.focus
getPower.boss1 = getPower.focus
getPower.boss2 = getPower.focus
getPower.boss3 = getPower.focus
getPower.boss4 = getPower.focus
getPower.boss5 = getPower.focus

UI.templates.getPower = function(self, unit)
	if (getPower[unit]) then
		return getPower[unit](self, unit)
	else
		return getPower['default'](self, unit)
	end
end
