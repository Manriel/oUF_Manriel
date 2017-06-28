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
	end

}

local updateHealth = function(Health, unit, min, max)
  local arStrings = UI.localeStrings

  local self = Health:GetParent()
  if(not UnitIsConnected(unit)) then
    Health:SetValue(0)
    Health.value:SetText('|cffD7BEA5'..arStrings['offline'])
  elseif(UnitIsDead(unit)) then
    Health:SetValue(0)
    local unitSexId = UnitSex(unit);
    if (type(unitSexId)=='nil') then
    	unitSexId = 2
    end
    Health.value:SetText('|cffD7BEA5'..arStrings['dead'][unitSexId])
  elseif(UnitIsGhost(unit)) then
    Health:SetValue(0)
    Health.value:SetText('|cffD7BEA5'..arStrings['ghost'])
  else
    if(unit=="player") then
      Health.value:SetFormattedText("%d | %d | %d|cffffffff%%", min, max, floor(min/max*100))
    elseif (unit=="target") then
      Health.value:SetFormattedText("%.1f|cffffffff%% | %s", (min/max*100), UI.fn.formatVal(max))
    else
      Health.value:SetFormattedText("%d|cffffffff%%", floor(min/max*100))
    end
  end
end

local getHealth = {}
getHealth.default = function(self, unit)
	local Health = CreateFrame("StatusBar", self:GetName()..'_Health', self)
	Health:SetHeight( (self:GetHeight() - (props.getOffset() * 2) ) * .7);
	Health:SetPoint('TOP', 0, -props.getOffset())
	Health:SetPoint('LEFT', props.getOffset(), 0)
	Health:SetPoint('RIGHT', -props.getOffset(), 0)
	Health:SetStatusBarTexture(props.getTexture())

	-- Add a background
	local Background = Health:CreateTexture(nil, 'BACKGROUND')
	Background:SetAllPoints(Health)
	Background:SetTexture(props.getTexture())
	-- Make the background darker.
	Background.multiplier = .5

	-- Options
	Health.frequentUpdates = true
	Health.colorTapping = true
	Health.colorDisconnected = true
	Health.colorHappiness = true
	Health.colorClass = true
	Health.colorReaction = true
	Health.colorHealth = true
	-- Special options
	Health.Smooth = true

	Health.value = UI.fn.setFontString(Health, props.getFont(), props.getFontSize())
	Health.value:SetPoint("LEFT", 2, -1)

	Health.bg = Background

	Health.PostUpdate = updateHealth

	return Health
end
getHealth.player = function(self, unit)
	local Health = getHealth.default(self, unit)
	Health.value:ClearAllPoints()
	Health.value:SetPoint("RIGHT", -2, -1)

	return Health
end
getHealth.focus = function(self, unit)
	local Health = getHealth.default(self, unit)
	Health.value:ClearAllPoints()
	Health.value:SetPoint("RIGHT", -2, -1)

	return Health
end
getHealth.arena1 = getHealth.focus
getHealth.arena2 = getHealth.focus
getHealth.arena3 = getHealth.focus
getHealth.arena4 = getHealth.focus
getHealth.arena5 = getHealth.focus
getHealth.boss1 = getHealth.focus
getHealth.boss2 = getHealth.focus
getHealth.boss3 = getHealth.focus
getHealth.boss4 = getHealth.focus
getHealth.boss5 = getHealth.focus

UI.templates.getHealth = function(self, unit)
	if (getHealth[unit]) then
		return getHealth[unit](self, unit)
	else
		return getHealth['default'](self, unit)
	end
end
