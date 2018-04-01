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

}

local UpdateName = function(self, unit)
	if(unit == 'player') then
		self:SetWidth((self:GetParent():GetWidth() - (props.getOffset() * 2) ) * 0.64)
		self:Hide()
	elseif (unit == 'target') then
		self:SetWidth((self:GetParent():GetWidth() - (props.getOffset() * 2) ) * 0.64)
		-- self:SetText(UnitName(unit))
		-- self:SetFormattedText('%.99s', UnitName(unit))
	else
		self:SetWidth((self:GetParent():GetWidth() - (props.getOffset() * 2) ) * 0.78)
		-- self:SetText(UnitName(unit))
		-- self:SetFormattedText('%.25s', UnitName(unit))
	end
end

local getName = {}
getName.default = function(self, unit)
	local Name = UI.fn.setFontString(self.Health, props.getFont(), props.getFontSize())
	Name:SetMaxLines(1)
	Name:SetPoint("RIGHT", -2, -1)
	Name:SetJustifyH("RIGHT")

	self:Tag(Name, '[name]')

	Name.PostUpdate = UpdateName;

	local callback = function(self, ...)
		if (type(self.Name) ~= 'nil' and self.Name.PostUpdate) then
			self.Name.PostUpdate(self.Name, self.unit)
		end
	end
	self.PostUpdate = UI.fn.addCallback(self.PostUpdate, callback)

	return Name
end
getName.player = function(self, unit)
	local Name = getName.default(self, unit)
	
	Name:SetMaxLines(2)
	Name:ClearAllPoints()
	Name:SetPoint("LEFT", 2, -1)
	Name:SetJustifyH("LEFT")
	
	return Name
end
getName.target = function(self, unit)
	local Name = getName.default(self, unit)
	Name:SetMaxLines(2)

	return Name
end
getName.focus = function(self, unit)
	local Name = getName.default(self, unit)
	Name:ClearAllPoints()
	Name:SetPoint("LEFT", 2, -1)
	Name:SetJustifyH("LEFT")

	return Name
end
getName.arena1 = getName.focus
getName.arena2 = getName.focus
getName.arena3 = getName.focus
getName.arena4 = getName.focus
getName.arena5 = getName.focus
getName.boss1 = getName.focus
getName.boss2 = getName.focus
getName.boss3 = getName.focus
getName.boss4 = getName.focus
getName.boss5 = getName.focus

UI.templates.getName = function(self, unit)
	if (getName[unit]) then
		return getName[unit](self, unit)
	else
		return getName['default'](self, unit)
	end
end
