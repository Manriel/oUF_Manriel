local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
	getFont = function()
		return UI.config.fontNameAlt;
	end,

	getFontSize = function()
		return (UI.config.baseFontSize / 12) * 11;
	end,

	getOffset = function()
		return UI.config.offset;
	end,

	getTexture = function()
		return UI.config.textureHealthBar;
	end

}

local AdditionalPower_OnShow = function( self )
	local parent = self:GetParent() 
	local Power = parent.Power
	local Lvl = parent.Lvl

	Power:SetHeight( (parent:GetHeight() - (props.getOffset() * 2) ) * .15);
	Power.value:ClearAllPoints()
	Power.value:SetPoint("RIGHT", Power, "BOTTOMRIGHT", -1, 0)
	Lvl:ClearAllPoints()
	Lvl:SetPoint("LEFT", Lvl:GetParent(), "BOTTOMLEFT", 1, 0)
end

local AdditionalPower_OnHide = function (self)
	local parent = self:GetParent() 
	local Power = parent.Power
	local Lvl = parent.Lvl

	Power:SetHeight( (parent:GetHeight() - (props.getOffset() * 2) ) * .3);
	Power.value:ClearAllPoints()
	Power.value:SetPoint("RIGHT", Power, "RIGHT", -2, 0)
	Lvl:ClearAllPoints()
	Lvl:SetPoint("LEFT", Lvl:GetParent(), "LEFT", 1, 0)
end

local getAdditionalPower = {}
getAdditionalPower.default = function(self, unit)
	return nil
end
getAdditionalPower.player = function(self, unit)
	local AdditionalPower = CreateFrame("StatusBar", self:GetName()..'_AdditionalPower', self)

	AdditionalPower.colorPower = true

	AdditionalPower:SetPoint('TOPLEFT', self.Power, 'BOTTOMLEFT')
	AdditionalPower:SetPoint('TOPRIGHT', self.Power, 'BOTTOMRIGHT')
	AdditionalPower:SetHeight( (self:GetHeight() - (props.getOffset()*2) ) * 0.15)
	AdditionalPower:SetStatusBarTexture(props.getTexture())

	-- Add a background
	local Background = AdditionalPower:CreateTexture(nil, 'BACKGROUND')
	Background:SetAllPoints(AdditionalPower)
	Background:SetTexture(props.getTexture())
	Background:SetVertexColor(0,0,0,1)
	Background.multiplier = .5

	AdditionalPower.bg = Background

	AdditionalPower:SetScript('OnShow', AdditionalPower_OnShow)
	AdditionalPower:SetScript('OnHide', AdditionalPower_OnHide)

	return AdditionalPower
end

UI.templates.getAdditionalPower = function(self, unit)
	if (getAdditionalPower[unit]) then
		return getAdditionalPower[unit](self, unit)
	else
		return getAdditionalPower['default'](self, unit)
	end
end
