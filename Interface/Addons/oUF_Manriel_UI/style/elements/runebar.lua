local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
	getOffset = function()
		return UI.config.offset;
	end,

	getTexture = function()
		return UI.config.textureHealthBar;
	end,

	getBackdrop = function()
		return {
			bgFile   = UI.config.texturePanel,
			tile = true,
			tileSize = 256,
			edgeFile = UI.config.textureCastBarBorder,
			edgeSize = 12,
			insets   = {
				left = 3,
				right = 3,
				top = 3,
				bottom = 3
			}
		}
	end,
}

local getRunes = {}
getRunes.default = function(self, unit)
	return nil
end
getRunes.player = function(self, unit)
	if select(2, UnitClass('player')) ~= 'DEATHKNIGHT' then return nil end

	local Runes = {}
	for index = 1, 6 do
		local bg = CreateFrame('Frame', self:GetName()..'_Rune'..index, self)
		if (index%2 == 0) then
			bg:SetPoint("TOP", self:GetName()..'_Rune'..(index-1), "BOTTOM", 0, props.getOffset())
		elseif (index == 1) then
			bg:SetPoint("TOPRIGHT", self, "TOPLEFT", 0, 0)
		else
			bg:SetPoint("RIGHT", self:GetName()..'_Rune'..(index-2), "LEFT", props.getOffset()*0.75, 0)
		end
		bg:SetFrameStrata('BACKGROUND')
		bg:SetSize( self:GetHeight() *0.5+props.getOffset()*0.5, self:GetHeight() *0.5 + props.getOffset()*0.5)
		bg:SetBackdrop(props.getBackdrop())
		-- bg:SetBackdropColor(0,0,0,1)

		-- Position and size of the rune bar indicators
		local Rune = CreateFrame('StatusBar', nil, bg)
		local r, g, b = unpack(self.colors.power.RUNES)
		Rune:SetStatusBarTexture(props.getTexture())
		Rune:SetStatusBarColor(r, g, b)
		Rune:SetOrientation("VERTICAL")
		Rune:SetPoint('TOPLEFT', bg, 'TOPLEFT', props.getOffset(), -props.getOffset())
		Rune:SetPoint('BOTTOMRIGHT', bg, 'BOTTOMRIGHT', -props.getOffset(), props.getOffset())

		Runes[index] = Rune
	end

	return Runes
end

UI.templates.getRunes = function(self, unit)
	if (getRunes[unit]) then
		return getRunes[unit](self, unit)
	else
		return getRunes['default'](self, unit)
	end
end
