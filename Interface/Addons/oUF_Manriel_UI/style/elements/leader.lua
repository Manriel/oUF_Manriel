local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
}


local getLeader = {}
getLeader.default = function(self, unit)
	local Leader = self.Health:CreateTexture(nil, "OVERLAY")
	Leader:SetSize(self:GetHeight()*0.4, self:GetHeight()*0.4);
	Leader:SetPoint("RIGHT", self.Health, "TOPRIGHT", 0, (Leader:GetHeight()*0.2));

	return Leader
end
getLeader.player = function(self, unit)
	local Leader = getLeader.default(self, unit)
	Leader:ClearAllPoints()
	Leader:SetPoint("LEFT", self.Health, "TOPLEFT", 0, (Leader:GetHeight()*0.2))
	
	return Leader
end

UI.templates.getLeader = function(self, unit)
	if (getLeader[unit]) then
		return getLeader[unit](self, unit)
	else
		return getLeader['default'](self, unit)
	end
end
