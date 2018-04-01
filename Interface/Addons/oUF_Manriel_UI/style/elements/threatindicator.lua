local parent, namespace = ...
local UI  = namespace.ManrielUI

local props = {
}

local UpdateThreatIndicator = function(self, inCombat)
	local parent = self:GetParent();
end

local getThreatIndicator = {}
getThreatIndicator.default = function(self, unit)
	return nil
end
getThreatIndicator.player = function(self, unit)
	local threatIndicator = self.Health:CreateTexture(nil, 'OVERLAY')
	threatIndicator:SetSize(self:GetHeight()*0.5, self:GetHeight()*0.5)
	threatIndicator:SetPoint('TOPRIGHT', 2, threatIndicator:GetHeight()/1.8)

	threatIndicator.PostUpdate = UpdateThreatIndicator;

	return Combat
end

UI.templates.getThreatIndicator = function(self, unit)
	if (getThreatIndicator[unit]) then
		return getThreatIndicator[unit](self, unit)
	else
		return getThreatIndicator['default'](self, unit)
	end
end
