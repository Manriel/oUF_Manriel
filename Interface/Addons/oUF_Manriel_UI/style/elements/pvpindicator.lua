local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
}

local UpdatePvP = function(self, unit)
	
end

local getPvP = {}
getPvP.default = function(self, unit)
	local PvP = self.Health:CreateTexture(nil, 'OVERLAY')
	PvP:SetSize(self:GetHeight()*0.6, self:GetHeight()*0.6)

	PvP.PostUpdate = UpdatePvP;

	return PvP
end
getPvP.player = function(self, unit)
	local PvP = getPvP.default(self, unit)
	PvP:SetPoint('CENTER', self, 'TOPRIGHT', -1, -self:GetHeight()*0.2)

	return PvP
end
getPvP.target = function(self, unit)
	local PvP = getPvP.default(self, unit)
	PvP:SetPoint('CENTER', self, 'TOPLEFT', 1, -self:GetHeight()*0.2)

	return PvP
end

UI.templates.getPvP = function(self, unit)
	if (getPvP[unit]) then
		return getPvP[unit](self, unit)
	else
		return getPvP['default'](self, unit)
	end
end
