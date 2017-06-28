local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
	getFont = function()
		return LSM:Fetch(LSM.MediaType.FONT, 'San Francisco (Bold)')
	end,

	getFontSize = function()
		return 9
	end,

	getOffset = function()
		return 4
	end,

}

local UpdateLvl = function(self, unit)
	local level = not UnitIsConnected(unit) and '??' or UnitLevel(unit) < 1 and '??' or UnitLevel(unit)
	self:SetFormattedText("%s%s", level, UI.config.classification[UnitClassification(unit)])

    if (UnitCanAttack("player", unit) and type(level) == 'integer') then
      self:SetTextColor(getDifficultyColor(level))
    else
      self:SetTextColor(1, 1, 1)
    end

    if (unit == 'player') then
    	self:Show()
    	self:ClearAllPoints()
    	if (type(self:GetParent():GetParent().AdditionalPower) ~= 'nil') then
	    	if (self:GetParent():GetParent().AdditionalPower:IsVisible()) then
		    	self:GetParent():GetParent().AdditionalPower:Hide()
		    	self:GetParent():GetParent().AdditionalPower:Show()
	    	else
		    	self:GetParent():GetParent().AdditionalPower:Show()
	    		self:GetParent():GetParent().AdditionalPower:Hide()
	    	end
    	end
    elseif (unit == 'target') then
    	self:Show()
    	self:ClearAllPoints()
		self:SetPoint("RIGHT", self:GetParent():GetParent().Class, "LEFT", -1, 0)
    else
    	self:Hide()
    end
end

local getLvl = {}
getLvl.default = function(self, unit)
	local Lvl = UI.fn.setFontString(self.Power, props.getFont(), props.getFontSize())
	Lvl:SetMaxLines(1)
	Lvl:SetPoint("RIGHT", -2, 0)
	Lvl:SetJustifyH("RIGHT")

	Lvl.ag = Lvl:CreateAnimationGroup()
	local ag = Lvl.ag
	ag.alpha = ag:CreateAnimation('Alpha')
	ag.alpha:SetOrder(1)
	ag.alpha:SetDuration(.5)
	ag:SetLooping("NONE")

	Lvl.PostUpdate = UpdateLvl;

	local callback = function(self, ...)
		if (type(self.Lvl) ~= 'nil' and self.Lvl.PostUpdate) then
			self.Lvl.PostUpdate(self.Lvl, self.unit)
		end
	end
	self.PostUpdate = UI.fn.addCallback(self.PostUpdate, callback)

	return Lvl
end

UI.templates.getLvl = function(self, unit)
	if (getLvl[unit]) then
		return getLvl[unit](self, unit)
	else
		return getLvl['default'](self, unit)
	end
end
