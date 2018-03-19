local parent, namespace = ...
local oUF = namespace.oUF
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
	getFont = function()
		return UI.config.fontNameAltBold;
	end,

	getFontSize = function()
		return (UI.config.baseFontSize / 12) * 11
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

local OverrideCastbarTime = function(self, duration)
	if(self.channeling) then
	    self.Time:SetFormattedText('%.1f / %.2f', self.max - duration, self.max)
	elseif(self.casting) then
	    self.Time:SetFormattedText('%.1f / %.2f', duration, self.max)
	end
end

local OverrideCastbarDelay = function(self, duration)
	if(self.channeling) then
		self.Time:SetFormattedText('%.1f / %.2f |cffff0000+ %.1f', self.max - duration, self.max, self.delay)
	elseif(self.casting) then
		self.Time:SetFormattedText('%.1f / %.2f |cffff0000+ %.1f', duration, self.max, self.delay)
	end
end

local getCastbar = {}
getCastbar.default = function(self, unit)
	local colorcb
	local _, classcb = UnitClass('player')
	colorcb = oUF.colors.class[classcb]

	local Castbar = CreateFrame('StatusBar', self:GetName()..'_Castbar', self)
	Castbar:SetPoint('TOP', self, 'BOTTOM')
	Castbar:SetStatusBarTexture(props:getTexture())
	Castbar:SetStatusBarColor(colorcb[1], colorcb[2], colorcb[3])
	Castbar:SetBackdropColor(colorcb[1]/3, colorcb[2]/3, colorcb[3]/3)
	Castbar:SetWidth(self:GetWidth() - props.getOffset()*2)
	Castbar:SetHeight(self:GetHeight() * .5 - props.getOffset()*2)
	
	Castbar.Spark = Castbar:CreateTexture(nil,'OVERLAY')
	Castbar.Spark:SetBlendMode("ADD")
	Castbar.Spark:SetHeight(Castbar:GetHeight()*1.5)
	Castbar.Spark:SetWidth(Castbar.Spark:GetHeight()*0.6)
	Castbar.Spark:SetVertexColor(colorcb[1], colorcb[2], colorcb[3])
	
	Castbar.Text = UI.fn.setFontString(Castbar, props.getFont(), props.getFontSize())
	Castbar.Text:SetPoint('LEFT', Castbar, 2, 0)

	Castbar.Time = UI.fn.setFontString(Castbar, props.getFont(), props.getFontSize())
	Castbar.Time:SetPoint('RIGHT', Castbar, -2, 0)
	
	local Background = CreateFrame('Frame', Castbar:GetName()..'_bg', Castbar)
	Background:SetPoint('TOPLEFT', Castbar, 'TOPLEFT', -props:getOffset(), props:getOffset())
	Background:SetPoint('BOTTOMRIGHT', Castbar, 'BOTTOMRIGHT', props:getOffset(), -props:getOffset())
	Background:SetBackdrop(props:getBackdrop())
	Background:SetBackdropColor(.3, .3, .3, 1)
	Background:SetFrameLevel(0)
	
	Castbar.SafeZone = Castbar:CreateTexture(nil,'BACKGROUND')
	Castbar.SafeZone:SetPoint('TOPRIGHT')
	Castbar.SafeZone:SetPoint('BOTTOMRIGHT')
	Castbar.SafeZone:SetHeight(20)
	Castbar.SafeZone:SetTexture(props:getTexture())	
	Castbar.SafeZone:SetVertexColor(1,1,.01,0.5)

	Castbar.bg = Background
	Castbar:Hide()

	Castbar.CustomTimeText = function( ... )
		-- body
	end
	Castbar.CustomDelayText = function( ... )
		-- body
	end

	self.Castbar = Castbar

	return Castbar
end
getCastbar.player = function(self, unit)
	local Castbar = getCastbar.default(self, unit)
	Castbar:ClearAllPoints()
	Castbar:SetPoint('BOTTOMLEFT', self, 'BOTTOMRIGHT', props.getOffset(), props.getOffset())
	Castbar:SetHeight(self:GetHeight()*0.5 - props.getOffset()*2)
	Castbar:SetWidth(UI.config.xPosition * 2 - props.getOffset()*2)
	Castbar:Show()

	Castbar.CustomTimeText = OverrideCastbarTime
	Castbar.CustomDelayText = OverrideCastbarDelay

	return Castbar
end
getCastbar.target = function(self, unit)
	local Castbar = getCastbar.default(self, unit)
	Castbar:ClearAllPoints()
	Castbar:SetPoint('TOPRIGHT', self.Health, 'TOPLEFT', -props.getOffset()*2, 0)
	Castbar:SetWidth(UI.config.xPosition * 2 - props.getOffset()*2)
	Castbar:SetHeight(self:GetHeight()*0.5 - props.getOffset()*2)

	Castbar:SetStatusBarColor(.81,.81,.25)
	Castbar:SetBackdropColor(.81/3,.81/3,.25/3)
	Castbar.Spark:SetVertexColor(.69,.31,.31)
	Castbar.SafeZone:SetVertexColor(1,1,.01,0.5)

	Castbar:Show()

	Castbar.CustomTimeText = OverrideCastbarTime
	Castbar.CustomDelayText = OverrideCastbarDelay

	return Castbar
end
getCastbar.focus = function(self, unit)
	local Castbar = getCastbar.default(self, unit)
	Castbar:SetPoint('TOPLEFT', self.Health, 'TOPRIGHT', props.getOffset()*2, 0)
	Castbar:SetWidth(UI.config.xPosition * 2 - props.getOffset()*2)
	Castbar:SetHeight(self:GetHeight()*0.4)

	Castbar:SetStatusBarColor(.79,.41,.31)
	Castbar:SetBackdropColor(.79/3,.41/3,.31/3)
	Castbar.Spark:SetVertexColor(.69,.31,.31)
	Castbar.SafeZone:SetVertexColor(1,1,.01,0.5)

	Castbar:Show()

	Castbar.CustomTimeText = OverrideCastbarTime
	Castbar.CustomDelayText = OverrideCastbarDelay

	return Castbar
end
getCastbar.arena1 = function(self, unit)
	local Castbar = getCastbar.default(self, unit)
	Castbar:SetPoint('TOPLEFT', self.Health, 'TOPRIGHT', props.getOffset()*2, 0)
	Castbar:SetWidth(UI.config.xPosition * 2 - props.getOffset()*2)
	Castbar:SetHeight(self:GetHeight()*0.4)

	Castbar:Show()

	Castbar.CustomTimeText = OverrideCastbarTime
	Castbar.CustomDelayText = OverrideCastbarDelay

	return Castbar
end

UI.templates.getCastbar = function(self, unit)
	if (getCastbar[unit]) then
		return getCastbar[unit](self, unit)
	else
		return getCastbar['default'](self, unit)
	end
end
