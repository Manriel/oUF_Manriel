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


local getClassPower = {}
getClassPower.default = function(self, unit)
	return nil
end
getClassPower.player = function(self, unit)
	local ClassPowerFrame = CreateFrame("Frame", self:GetName() .. '_ClassPower', self);
	ClassPowerFrame:SetAllPoints(self);

	local ClassPower = {}
	for index = 1, 10 do
	    local Bar = CreateFrame('StatusBar', nil, ClassPowerFrame)
	    -- Position and size.
		Bar:SetSize(ClassPowerFrame:GetHeight()*0.5, ClassPowerFrame:GetHeight()*0.5)
		Bar:SetPoint('LEFT', ClassPowerFrame, 'TOPLEFT', (index-1) * ClassPowerFrame:GetWidth()+props.getOffset(), 0)
	    ClassPower[index] = Bar
	end
end

UI.templates.getClassPower = function(self, unit)
	if (getClassPower[unit]) then
		return getClassPower[unit](self, unit)
	else
		return getClassPower['default'](self, unit)
	end
end
