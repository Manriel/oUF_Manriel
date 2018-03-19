local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
	getFont = function()
		return UI.config.fontNameAlt;
	end,

	getFontSize = function()
		return (UI.config.baseFontSize / 12) * 11;
	end,

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

local AltPowerPostUpdate = function (self, min, cur, max )
  local caption = self.caption
  if caption then
    caption:SetFormattedText("%s: %d / %d", self.powerName, cur, max)
    self:Show();
  else
  	self:Hide();
  end
end

local getAltPowerBar = {}
getAltPowerBar.default = function(self, unit)
	return nil
end
getAltPowerBar.player = function(self, unit)
	local AltPowerBar = CreateFrame('StatusBar', self:GetName()..'_AltPowerBar', self)
	AltPowerBar.colorTexture = true;
	local _, r, g, b
	_, r, g, b = UnitAlternatePowerTextureInfo(unit, 2)
	AltPowerBar:SetStatusBarTexture(props.getTexture())
	if(b) then
		AltPowerBar:SetStatusBarColor(r, g, b)
		AltPowerBar:SetBackdropColor(r/3, g/3, b/3)
		AltPowerBar:Show();
	else
		AltPowerBar:Hide();
	end

	AltPowerBar:EnableMouse(true);

	local Background = CreateFrame('Frame', AltPowerBar:GetName()..'_bg', AltPowerBar)
	Background:SetFrameStrata('BACKGROUND')
	Background:SetPoint('BOTTOMLEFT', self, 'TOPLEFT')
	Background:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT')
	Background:SetHeight(self:GetHeight()*0.4)
	Background:SetBackdrop(props.getBackdrop())
	Background:SetBackdropColor(0,0,0,1)

	AltPowerBar:SetPoint('TOPLEFT', Background, 'TOPLEFT', props.getOffset(), -props.getOffset())
	AltPowerBar:SetPoint('BOTTOMRIGHT', Background, 'BOTTOMRIGHT', -props.getOffset(), props.getOffset())
	AltPowerBar.caption = UI.fn.setFontString(AltPowerBar, props.getFont(), props.getFontSize())
	AltPowerBar.caption:SetAllPoints(AltPowerBar)
	AltPowerBar.caption:SetJustifyH("CENTER")

	AltPowerBar.bg = Background

	AltPowerBar.PostUpdate = AltPowerPostUpdate

	return AltPowerBar
end

UI.templates.getAltPowerBar = function(self, unit)
	if (getAltPowerBar[unit]) then
		return getAltPowerBar[unit](self, unit)
	else
		return getAltPowerBar['default'](self, unit)
	end
end
