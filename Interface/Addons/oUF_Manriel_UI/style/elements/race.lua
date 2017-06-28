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

local UpdateRace = function(self, unit)
	self:SetText(UnitRace(unit))

	if (unit == 'player') then
		self:Show()
    	self:ClearAllPoints()
		self:SetPoint("LEFT", self:GetParent():GetParent().Class, "RIGHT", 1, 0)
    elseif (unit == 'target') then
    	self:Show()
    	self:ClearAllPoints()
		self:SetPoint("RIGHT", self:GetParent(), "RIGHT",  -1, 0);
    else
    	self:Hide()
    end
end

local getRace = {}
getRace.default = function(self, unit)
	local Race = UI.fn.setFontString(self.Power, props.getFont(), props.getFontSize())
	Race:SetMaxLines(1)
	Race:SetPoint("RIGHT", -2, 0)
	Race:SetJustifyH("RIGHT")

	Race.ag = Race:CreateAnimationGroup()
	local ag = Race.ag
	ag.alpha = ag:CreateAnimation('Alpha')
	ag.alpha:SetOrder(1)
	ag.alpha:SetDuration(.5)
	ag.alpha:SetSmoothing("OUT")
	ag:SetLooping("NONE")

	Race.PostUpdate = UpdateRace;

	local callback = function(self, ...)
		if (type(self.Race) ~= 'nil' and self.Race.PostUpdate) then
			self.Race.PostUpdate(self.Race, self.unit)
		end
	end
	self.PostUpdate = UI.fn.addCallback(self.PostUpdate, callback)

	return Race
end

UI.templates.getRace = function(self, unit)
	if (getRace[unit]) then
		return getRace[unit](self, unit)
	else
		return getRace['default'](self, unit)
	end
end
