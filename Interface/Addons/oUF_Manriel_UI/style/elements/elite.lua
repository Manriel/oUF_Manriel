	local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local UpdateElite = function(self, unit)
	local parent = self:GetParent()
	local unit = unit or parent.unit

	if (UnitClassification(unit)== "worldboss" or UnitClassification(unit)== "rareelite" or UnitClassification(unit)== "elite" or UnitLevel(unit) < 0) then
		if UnitClassification(unit)== "worldboss" or UnitClassification(unit)== "rareelite" or UnitLevel(unit) < 0 then
			parent:SetBackdropBorderColor(1,0.84,0,1)
			self.tex:SetVertexColor(1,0.84,0,1)
		else
			parent:SetBackdropBorderColor(1,1,1,1)
			self.tex:SetVertexColor(1,1,1,1)
		end
		self:Show()
	else
		parent:SetBackdropBorderColor(1,1,1,1)
		self.tex:SetVertexColor(1,1,1,1)
		self:Hide()
	end
end

local getElite = {}

getElite.default = function(self, unit)
	local elite = CreateFrame('Frame', self:GetName()..'_EliteTexture', self)
	elite:SetSize(self:GetHeight()*1.9,self:GetHeight()*1.9)
	elite.tex = elite:CreateTexture(nil, 'OVERLAY')
	elite.tex:SetTexture([[Interface\Addons\oUF_Manriel_UI\textures\dragon]])

	if (unit == 'arena1' or unit == 'arena2' or unit == 'arena3' or unit == 'arena4' or unit == 'arena5' or 
		unit == 'boss1' or unit == 'boss1' or unit == 'boss1' or unit == 'boss1' or unit == 'boss1' or
		unit == 'player' or unit == 'pet' or unit == 'focus') then
		elite:SetPoint('TOPLEFT', self, 'TOPLEFT', -self:GetHeight()*0.61, self:GetHeight()*0.18)
		elite.tex:SetTexCoord(1, 0, 0, 1)
	else
		elite:SetPoint('TOPRIGHT', self, 'TOPRIGHT', self:GetHeight()*0.61, self:GetHeight()*0.18)
		elite.tex:SetTexCoord(0, 1, 0, 1)
	end
	elite.tex:SetAllPoints(elite)

	elite:Hide()

	elite.PostUpdate = UpdateElite;

	local callback = function(self, ...)
		if (type(self.Elite) ~= 'nil' and self.Elite.PostUpdate) then
			self.Elite.PostUpdate(self.Elite, self.unit)
		end
	end
	self.PostUpdate = UI.fn.addCallback(self.PostUpdate, callback)

	return elite
end

UI.templates.getElite = function(self, unit)
	if (getElite[unit]) then
		return getElite[unit](self. unit)
	else
		return getElite['default'](self, unit)
	end
end
