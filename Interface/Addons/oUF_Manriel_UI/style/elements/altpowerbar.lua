local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
	getFont = function()
		return LSM:Fetch(LSM.MediaType.FONT, 'San Francisco (Semi-bold)')
	end,

	getFontSize = function()
		return 11
	end,

	getOffset = function()
		return 4
	end,

	getTexture = function()
		return LSM:Fetch(LSM.MediaType.STATUSBAR,  'Manriel-Health')
	end,

	getBackdrop = function()
		return {
			bgFile   = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Background'),
			tile = true,
			tileSize = 256,
			edgeFile = LSM:Fetch(LSM.MediaType.BORDER,     'Manriel-Border-Light'),
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

local AltPowerPostUpdate = function ( self, min, cur, max )
  local caption = self.caption
  if caption then
    caption:SetFormattedText("%s: %d / %d", self.powerName, cur, max)
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
	end

	if(b) then
		AltPowerBar:SetBackdropColor(r/3, g/3, b/3)
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
