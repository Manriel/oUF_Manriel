local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
	getFont = function()
		return UI.config.fontNameAltBold;
	end,

	getFontSize = function()
		return (UI.config.baseFontSize / 4) * 3
	end,

	getOffset = function()
		return UI.config.offset;
	end,

}

local UpdateClass = function(self, unit)
	local color
    if UnitIsPlayer(unit) then	
      local class, className = UnitClass(unit)
      color = RAID_CLASS_COLORS[className]
      self:SetText(class);
    else
      self:SetText(UnitCreatureFamily(unit) or UnitCreatureType(unit))
    end
    if not color then color = { r = 1, g = 1, b = 1} end
    self:SetVertexColor(color.r, color.g, color.b)

    if (unit == 'player') then
    	self:Show()
    	self:ClearAllPoints()
		self:SetPoint("LEFT", self:GetParent():GetParent().Lvl, "RIGHT",  1, 0);
    elseif (unit == 'target') then
    	self:Show()
    	self:ClearAllPoints()
		self:SetPoint("RIGHT", self:GetParent():GetParent().Race, "LEFT",  -1, 0);
    else
    	self:Hide()
    end
end

local getClass = {}
getClass.default = function(self, unit)
	local Class = UI.fn.setFontString(self.Power, props.getFont(), props.getFontSize())
	Class:SetMaxLines(1)
	Class:SetPoint("RIGHT", -2, 0)
	Class:SetJustifyH("RIGHT")

	Class.ag = Class:CreateAnimationGroup()
	local ag = Class.ag
	ag.alpha = ag:CreateAnimation('Alpha')
	ag.alpha:SetOrder(1)
	ag.alpha:SetDuration(.5)
	ag.alpha:SetSmoothing("OUT")
	ag:SetLooping("NONE")

	Class.PostUpdate = UpdateClass;

	local callback = function(self, ...)
		if (type(self.Class) ~= 'nil' and self.Class.PostUpdate) then
			self.Class.PostUpdate(self.Class, self.unit)
		end
	end
	self.PostUpdate = UI.fn.addCallback(self.PostUpdate, callback)

	return Class
end
getClass.player = function(self, unit)
	local Class = getClass.default(self, unit)

	return Class
end
getClass.target = function(self, unit)
	local Class = getClass.default(self, unit)

	return Class
end

UI.templates.getClass = function(self, unit)
	if (getClass[unit]) then
		return getClass[unit](self, unit)
	else
		return getClass['default'](self, unit)
	end
end
