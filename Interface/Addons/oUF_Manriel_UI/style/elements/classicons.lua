local parent, namespace = ...
local UI  = namespace.ManrielUI

local props = {
}

local getClassIcons = {}
getClassIcons.default = function(self, unit)
	return nil
end
getClassIcons.player = function(self, unit)
	local ClassIconsFrame = CreateFrame("Frame", 'oUF_Manriel_player_ClassIcons', self.Health);
		ClassIconsFrame:SetAllPoints(self.Health);
		local ClassIcons = {}
		for index = 1, 6 do
		   local Icon = ClassIconsFrame:CreateTexture(nil, 'OVERLAY')
		   Icon:SetSize(self:GetHeight()*0.6, self:GetHeight()*0.6)
		   Icon:SetPoint('TOPLEFT', ClassIconsFrame, 'TOPLEFT', (index-1) * Icon:GetWidth(), 0)
		   ClassIcons[index] = Icon
		end
		self.ClassIcons = ClassIcons

	return ClassIcons
end

UI.templates.getClassIcons = function(self, unit)
	if (getClassIcons[unit]) then
		return getClassIcons[unit](self, unit)
	else
		return getClassIcons['default'](self, unit)
	end
end
