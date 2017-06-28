local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
	getFont = function()
		return LSM:Fetch(LSM.MediaType.FONT, 'San Francisco (Bold)')
	end,

	getFontSize = function()
		return 11
	end,

	getOffset = function()
		return 4
	end,

	getBorder = function()
		return LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Caith')
	end

}

local UpdateAuraTimer = function(self, elapsed)
  if (self.duration) then
    local duration = self.cd.duration or nil
    local timeLeft = self.cd.timeLeft or nil
    if (timeLeft) and (timeLeft > 0) and (duration) and (duration > 0) then
      local sec = timeLeft - GetTime()
      self.duration:SetText(gsub(format(SecondsToTimeAbbrev(sec)), "[ .]", ""))
    else
      self.duration:SetText('')
    end
  end

  local unit = self:GetParent():GetParent().unit
  --DevTools_Dump(self)
  if (unit == 'target') and not self.isPlayer and self.isDebuff then
  	self.icon:SetDesaturated(true);
  else
  	self.icon:SetDesaturated(false);
  end
end

local CreateIcon = function(icons, index)
  local button = CreateFrame("Button", icons:GetDebugName().."Button"..index, icons, 'BuffButtonTemplate')
  button:RegisterForClicks('RightButtonUp')

  local cd = CreateFrame("Cooldown", "$parentCooldown", button, "CooldownFrameTemplate")
  cd:SetAllPoints(button)

  local icon = button:CreateTexture(nil, "BORDER")
  icon:SetAllPoints(button)

  local count = button:CreateFontString(nil, "OVERLAY")
  count:SetFontObject(NumberFontNormal)
  count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -1, 0)

  local overlay = button:CreateTexture(nil, "OVERLAY")
  overlay:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays")
  overlay:SetAllPoints(button)
  overlay:SetTexCoord(.296875, .5703125, 0, .515625)
  button.overlay = overlay

  local stealable = button:CreateTexture(nil, 'OVERLAY')
  stealable:SetTexture[[Interface\TargetingFrame\UI-TargetingFrame-Stealable]]
  stealable:SetPoint('TOPLEFT', -3, 3)
  stealable:SetPoint('BOTTOMRIGHT', 3, -3)
  stealable:SetBlendMode('ADD')
  button.stealable = stealable

  button.icon = icon
  button.count = count
  button.cd = cd

  --[[ :PostCreateIcon(button)
   Callback which is called after a new aura icon button has been created.
   Arguments
   button - The newly created aura icon button.
   ]]
  if(icons.PostCreateIcon) then icons:PostCreateIcon(button) end

  return button
end

local PostCreateIcon = function(icons, button)
  button.overlay:ClearAllPoints()
  button.overlay:SetTexture(props.getBorder())
  button.overlay:SetTexCoord(0, 1, 0, 1)
  button.overlay:SetPoint("TOPLEFT", button, "TOPLEFT", -3, 3)
  button.overlay:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 3, -3)

  button.duration = UI.fn.setFontString(button, props.getFont(), props.getFontSize(), "THINOUTLINE")
  button.duration:SetJustifyH("CENTER")
  button.duration:SetPoint("TOP", button, "BOTTOM", 0, -2)
  button.cd:SetHideCountdownNumbers(true)

  button:SetScript('OnUpdate', UpdateAuraTimer)
end

local PostUpdateIcon = function(self, unit, icon, index, offset)
  icon.unit = unit

  local ParentFrame = self:GetParent()
  local AltPowerBar = ParentFrame.AltPowerBar
  if type(AltPowerBar) ~= 'nil' then
  	if AltPowerBar:IsShown() and unit == 'player' then
	    if AltPowerBar:IsVisible() then
	      ParentFrame.Debuffs:ClearAllPoints()
	      ParentFrame.Debuffs:SetPoint("BOTTOMLEFT", ParentFrame, "TOPLEFT", 0, AltPowerBar:GetHeight() + props.getFontSize() + props.getOffset()*2)
	    else
	      ParentFrame.Debuffs:ClearAllPoints()
	      ParentFrame.Debuffs:SetPoint("BOTTOMLEFT", ParentFrame, "TOPLEFT", 0, props.getFontSize())
	    end
    end
  end

  icon.overlay:SetVertexColor(.5, .5, .5, 1)
  icon.overlay:Show()

  icon.icon:SetTexCoord(.05, .95, .05, .95)

  if (icon.count) then
    icon.count:SetFont(props.getFont(), props.getFontSize(), "THINOUTLINE");
    icon.count:ClearAllPoints()
    icon.count:SetPoint("TOPRIGHT", 0, 0)
    icon.count:SetShadowColor(0,0,0)
    icon.count:SetShadowOffset(0,0)
  end

  if (icon.cd) then
    local filter = icon.filter
    local _, _, _, _, _, duration, expirationTime, _, _, _, _, _, _ = UnitAura(unit, index, filter)

    icon.cd.duration = duration
    icon.cd.timeLeft = expirationTime
  end
end

local PostUpdateGapIcon = function(self, unit, icon, index)
  if (icon.cd) then
    icon.cd.duration = 0
    icon.cd.timeLeft = 0
  end
end

local getAuras = {}
local getBuffs = {}
local getDebuffs = {}

getAuras.default = function(self, unit)
	return nil
end
getAuras.target = function(self, unit)
	local Auras = CreateFrame('StatusBar', self:GetName()..'_Auras', self)
	Auras:SetSize(self:GetWidth(), self:GetWidth()/2);
	Auras:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', -3, props.getFontSize() + props.getOffset())
	Auras['growth-x'] = 'LEFT'
	Auras['growth-y'] = 'UP' 
	Auras['spacing-x'] = 8
	Auras['spacing-y'] = 16
	Auras.initialAnchor = 'BOTTOMRIGHT'
	Auras.size = self:GetHeight()*0.7
	Auras.gap = true
	Auras.numBuffs = 18 
	Auras.numDebuffs = 18 
	Auras.disableCooldown = true
	Auras.showStealableBuffs = true

	Auras.PostCreateIcon = PostCreateIcon
	Auras.PostUpdateIcon = PostUpdateIcon
	Auras.PostUpdateGapIcon = PostUpdateGapIcon

	return Auras
end

getBuffs.default = function(self, unit)
	return nil
end
getBuffs.player = function(self, unit)
	local Buffs =  CreateFrame("StatusBar", self:GetName()..'_Buffs', self)
	Buffs.disableCooldown = true

	Buffs:Show()

	Buffs.size = self:GetHeight()*0.7
	Buffs:SetSize((8 + Buffs.size) * 16, (16 + Buffs.size) * 2);
	Buffs.initialAnchor = "TOPRIGHT"
	Buffs["growth-x"] = "LEFT"
	Buffs["growth-y"] = "DOWN"
	Buffs['spacing-x'] = 8
	Buffs['spacing-y'] = 16
	Buffs:SetPoint("TOPRIGHT", self:GetParent(), "TOPRIGHT", -8, -34)
	Buffs.CreateIcon = CreateIcon
	Buffs.PostCreateIcon = PostCreateIcon
	Buffs.PostUpdateIcon = PostUpdateIcon

	return Buffs
end

getDebuffs.default = function(self, unit)
	return nil
end
getDebuffs.player = function(self, unit)
	local Debuffs =  CreateFrame("StatusBar", self:GetName()..'_Debuffs', self)
	Debuffs:SetSize(self:GetWidth(), self:GetWidth()/2)
	Debuffs.size = self:GetHeight()*0.7
	Debuffs.initialAnchor = "BOTTOMLEFT"
	Debuffs["growth-x"] = "RIGHT"
	Debuffs["growth-y"] = "UP"
	Debuffs['spacing-x'] = 8
	Debuffs['spacing-y'] = 16
	Debuffs.disableCooldown = true

	Debuffs:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 0, props.getFontSize() + props.getOffset())
	Debuffs.PostCreateIcon = PostCreateIcon
	Debuffs.PostUpdateIcon = PostUpdateIcon

	return Debuffs
end

UI.templates.getAuras = function(self, unit)
	if (getAuras[unit]) then
		return getAuras[unit](self, unit)
	else
		return getAuras['default'](self, unit)
	end
end

UI.templates.getBuffs = function(self, unit)
	if (getBuffs[unit]) then
		return getBuffs[unit](self, unit)
	else
		return getBuffs['default'](self, unit)
	end
end

UI.templates.getDebuffs = function(self, unit)
	if (getDebuffs[unit]) then
		return getDebuffs[unit](self, unit)
	else
		return getDebuffs['default'](self, unit)
	end
end
