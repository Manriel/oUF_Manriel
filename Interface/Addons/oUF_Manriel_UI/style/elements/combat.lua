local parent, namespace = ...
local UI  = namespace.ManrielUI

local props = {
}

local UpdateCombat = function(self, inCombat)
	local parent = self:GetParent():GetParent();
	local unit = parent.unit
	if (inCombat) then
		if (parent.Lvl) then
			parent.Lvl.ag.alpha:SetFromAlpha(parent.Lvl:GetAlpha());
			parent.Lvl:SetAlpha(.2);
			parent.Lvl.ag.alpha:SetToAlpha(.2);
			parent.Lvl.ag:Play()
		end
		if (parent.Class) then
			parent.Class.ag.alpha:SetFromAlpha(parent.Class:GetAlpha());
			parent.Class:SetAlpha(.2);
			parent.Class.ag.alpha:SetToAlpha(.2);
			parent.Class.ag:Play()
		end
		if (parent.Race) then
			parent.Race.ag.alpha:SetFromAlpha(parent.Race:GetAlpha());
			parent.Race:SetAlpha(.2);
			parent.Race.ag.alpha:SetToAlpha(.2);
			parent.Race.ag:Play()
		end
	else
		if (parent.Lvl) then
			parent.Lvl.ag.alpha:SetFromAlpha(parent.Lvl:GetAlpha());
			parent.Lvl:SetAlpha(1);
			parent.Lvl.ag.alpha:SetToAlpha(1);
			parent.Lvl.ag:Play()
		end
		if (parent.Class) then
			parent.Class.ag.alpha:SetFromAlpha(parent.Class:GetAlpha());
			parent.Class:SetAlpha(1);
			parent.Class.ag.alpha:SetToAlpha(1);
			parent.Class.ag:Play()
		end
		if (parent.Race) then
			parent.Race.ag.alpha:SetFromAlpha(parent.Race:GetAlpha());
			parent.Race:SetAlpha(1);
			parent.Race.ag.alpha:SetToAlpha(1);
			parent.Race.ag:Play()
		end
	end
end

local getCombat = {}
getCombat.default = function(self, unit)
	return nil
end
getCombat.player = function(self, unit)
	local Combat = self.Health:CreateTexture(nil, 'OVERLAY')
	Combat:SetSize(self:GetHeight()*0.5, self:GetHeight()*0.5)
	Combat:SetPoint('TOPRIGHT', 2, Combat:GetHeight()/1.8)

	Combat.PostUpdate = UpdateCombat;

	return Combat
end

UI.templates.getCombat = function(self, unit)
	if (getCombat[unit]) then
		return getCombat[unit](self, unit)
	else
		return getCombat['default'](self, unit)
	end
end
