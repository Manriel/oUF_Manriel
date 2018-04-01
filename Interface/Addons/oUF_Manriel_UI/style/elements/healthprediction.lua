local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
    getOffset = function()
        return UI.config.offset;
    end,
    getTexture = function()
        return UI.config.textureHealthBar;
    end
}

local getHealthPrediction = {}
getHealthPrediction.default = function(self, unit)
    -- Position and size
    local myBar = CreateFrame('StatusBar', self:GetName()..'_myBar', self.Health)
    myBar:ClearAllPoints()
    myBar:SetPoint('TOP', self.Health)
    myBar:SetPoint('BOTTOM', self.Health)
    myBar:SetPoint('LEFT', self.Health:GetStatusBarTexture(), 'RIGHT')
    myBar:SetStatusBarTexture(props.getTexture())
    myBar:SetStatusBarColor(0, 1, 0, 0.5)
    myBar:SetWidth(self.Health:GetWidth())
    myBar.Smooth = true

    local tex = myBar:GetStatusBarTexture()
    tex:SetBlendMode('ADD')

    local otherBar = CreateFrame('StatusBar', self:GetName()..'_otherBar', self.Health)
    otherBar:ClearAllPoints()
    otherBar:SetPoint('TOP', self.Health)
    otherBar:SetPoint('BOTTOM', self.Health)
    otherBar:SetPoint('LEFT', myBar:GetStatusBarTexture(), 'RIGHT')
    otherBar:SetStatusBarTexture(props.getTexture())
    otherBar:SetStatusBarColor(0, 1, 0, 0.25)
    otherBar:SetWidth(self.Health:GetWidth())
    otherBar.Smooth = true

    local tex = otherBar:GetStatusBarTexture()
    tex:SetBlendMode('ADD')

    local absorbBar = CreateFrame('StatusBar', self:GetName()..'_absorbBar', self.Health)
    absorbBar:ClearAllPoints()
    absorbBar:SetPoint('TOP', self.Health)
    absorbBar:SetPoint('BOTTOM', self.Health)
    absorbBar:SetPoint('LEFT', otherBar:GetStatusBarTexture(), 'RIGHT')
    absorbBar:SetStatusBarTexture(props.getTexture())
    absorbBar:SetStatusBarColor(1, 0.9568, 0.2666, 0.5)
    absorbBar:SetWidth(self.Health:GetWidth())
    absorbBar.Smooth = true

    local tex = absorbBar:GetStatusBarTexture()
    tex:SetBlendMode('ADD')

    local healAbsorbBar = CreateFrame('StatusBar', self:GetName()..'_healAbsorbBar', self.Health)
    healAbsorbBar:ClearAllPoints()
    healAbsorbBar:SetPoint('TOP')
    healAbsorbBar:SetPoint('BOTTOM')
    healAbsorbBar:SetPoint('RIGHT', absorbBar:GetStatusBarTexture(), 'LEFT')
    healAbsorbBar:SetWidth(self.Health:GetWidth())
    healAbsorbBar:SetStatusBarTexture(props.getTexture())
    healAbsorbBar:SetStatusBarColor(1, 0.9568, 0.2666, 0.25)
    healAbsorbBar:SetReverseFill(true)
    absorbBar.Smooth = true

    local overAbsorb = self.Health:CreateTexture(self:GetName()..'_overAbsorb', "OVERLAY")
    overAbsorb:SetPoint('TOP')
    overAbsorb:SetPoint('BOTTOM')
    overAbsorb:SetPoint('LEFT', self.Health, 'RIGHT', -props.getOffset(), 0)
    overAbsorb:SetWidth(10)
    overAbsorb:SetDrawLayer('OVERLAY', -1)

	local overHealAbsorb = self.Health:CreateTexture(self:GetName()..'_overHealAbsorb', "OVERLAY")
    overHealAbsorb:SetPoint('TOP')
    overHealAbsorb:SetPoint('BOTTOM')
    overHealAbsorb:SetPoint('LEFT', self.Health, 'LEFT', -props.getOffset(), 0)
    overHealAbsorb:SetWidth(10)
    overHealAbsorb:SetDrawLayer('OVERLAY', -1)

    -- Register with oUF
    local HealthPrediction = {
        myBar = myBar,
        otherBar = otherBar,
        absorbBar = absorbBar,
        healAbsorbBar = healAbsorbBar,
        overAbsorb = overAbsorb,
        overHealAbsorb = overHealAbsorb,
        maxOverflow = 1,
        frequentUpdates = true,
    }

    return HealthPrediction
end

UI.templates.getHealthPrediction = function(self, unit)
    if (getHealthPrediction[unit]) then
        return getHealthPrediction[unit](self, unit)
    else
        return getHealthPrediction['default'](self, unit)
    end
end
