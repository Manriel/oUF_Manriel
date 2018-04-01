local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
}

local getAssistant = {}
getAssistant.default = function(self, unit)
	local Assistant = self.Health:CreateTexture(nil, "OVERLAY")
	Assistant:SetSize(self:GetHeight()*0.4, self:GetHeight()*0.4);
	Assistant:SetPoint("RIGHT", self.MasterLooter, "LEFT", 0, (Assistant:GetHeight()*0.1));

	return Assistant
end
getAssistant.player = function(self, unit)
	local Assistant = getAssistant.default(self, unit)
	Assistant:ClearAllPoints()
	Assistant:SetPoint("LEFT", self.MasterLooter, "RIGHT", 0, (Assistant:GetHeight()*0.1));
	
	return Assistant
end

UI.templates.getAssistant = function(self, unit)
	if (getAssistant[unit]) then
		return getAssistant[unit](self, unit)
	else
		return getAssistant['default'](self, unit)
	end
end
