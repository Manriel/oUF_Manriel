local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
}

local UpdatePvP = function(self, unit)
	
end

local getRaidIcon = {}
getRaidIcon.default = function(self, unit)
	local RaidIcon = self.Health:CreateTexture(nil, "OVERLAY")
	RaidIcon:SetSize(self:GetHeight()*0.5, self:GetHeight()*0.5);
	RaidIcon:SetPoint("TOP", self, 0, RaidIcon:GetHeight()/2)

	return RaidIcon
end

UI.templates.getRaidIcon = function(self, unit)
	if (getRaidIcon[unit]) then
		return getRaidIcon[unit](self, unit)
	else
		return getRaidIcon['default'](self, unit)
	end
end
