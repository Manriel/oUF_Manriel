local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
}

local getMasterLooter = {}
getMasterLooter.default = function(self, unit)
	local MasterLooter = self.Health:CreateTexture(nil, "OVERLAY")
	MasterLooter:SetSize(self:GetHeight()*0.4, self:GetHeight()*0.4);
	MasterLooter:SetPoint("RIGHT", self.Leader, "LEFT", 0, (MasterLooter:GetHeight()*0.1));

	return MasterLooter
end
getMasterLooter.player = function(self, unit)
	local MasterLooter = getMasterLooter.default(self, unit)
	MasterLooter:ClearAllPoints()
	MasterLooter:SetPoint("LEFT", self.Leader, "RIGHT", 0, (MasterLooter:GetHeight()*0.1));
	
	return MasterLooter
end

UI.templates.getMasterLooter = function(self, unit)
	if (getMasterLooter[unit]) then
		return getMasterLooter[unit](self, unit)
	else
		return getMasterLooter['default'](self, unit)
	end
end
