local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
	getFont = function()
		return LSM:Fetch(LSM.MediaType.FONT, 'San Francisco (Bold)')
	end,

	getFontSize = function()
		return 9
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
				left = 0,
				right = 0,
				top = 0,
				bottom = 0
			}
		}
	end

}

local updateReputation = function(self, unit, cur, max, name, factionID, standingID, standingText)
	if type(self.text) ~= 'nil' and max > 0 then
		local percent = math.floor(100 * cur/max)
		self.text:SetFormattedText("%s [%s] %i | %i (%i%%)", name, standingText, cur, max, percent);
	else
		self.text:SetText("");
	end
end

local updateExperience = function(self, unit, cur, max, exhaustion, level, showHonor)
	if type(self.text) ~= 'nil' then
		local percent = math.floor(100 * cur/max)
		self.text:SetFormattedText("%i | %i (%i%%)", cur, max, percent);
	end
end

local getExperience = {}
getExperience.default = function(self, unit, parent)
	return nil
end
getExperience.player = function(self, unit, parent)
	local Experience = CreateFrame('StatusBar', self:GetName()..'_Experience', parent)
	Experience:SetPoint('TOPLEFT', props.getOffset(), -props.getOffset())
	Experience:SetPoint('BOTTOMRIGHT', -props.getOffset(), props.getOffset())
	Experience:SetStatusBarTexture(props.getTexture());
	Experience:SetStatusBarColor(1,1,1,1)
	local Rested = CreateFrame('StatusBar', nil, Experience)
	Rested:SetAllPoints(Experience)
	Rested:SetStatusBarTexture(props.getTexture());
	Rested:SetStatusBarColor(.7,1,.7,.5)

	local Value = Experience:CreateFontString(nil, 'OVERLAY')
	Value:SetAllPoints(Experience)
	Value:SetFont(props.getFont(), props.getFontSize())

	Experience.Rested = Rested

	Experience.text = Value

	Experience.PostUpdate = updateExperience

	return Experience
end

local getReputation = {}
getReputation.default = function(self, unit, parent)
	return nil
end
getReputation.player = function(self, unit, parent)
	local Reputation = CreateFrame('StatusBar', self:GetName()..'_Reputation', parent)
	Reputation:SetPoint('TOPLEFT', props.getOffset(), -props.getOffset())
	Reputation:SetPoint('BOTTOMRIGHT', -props.getOffset(), props.getOffset())
	Reputation:SetStatusBarTexture(props.getTexture());
	Reputation.colorStanding = true

	local Value = Reputation:CreateFontString(nil, 'OVERLAY')
	Value:SetAllPoints(Reputation)
	Value:SetFont(props.getFont(), props.getFontSize())

	Reputation.text = Value

	Reputation.PostUpdate = updateReputation

	return Reputation
end

local getXpRepBar = function(self, unit)
	if (unit ~= 'player') then return nil end
	local XpRepBar = CreateFrame('Frame', self:GetName()..'_XpRepBar', self)
	XpRepBar:SetPoint('BOTTOM', UIParent)
	XpRepBar:SetHeight(self:GetHeight()/2.5);
	XpRepBar:SetWidth(604);
	XpRepBar:SetBackdrop(props.getBackdrop());

	return XpRepBar
end

UI.templates.getXpRepBar = function(self, unit)
	local XpRepBar = getXpRepBar(self, unit)
	if (not XpRepBar) then return nil end

	if (getExperience[unit]) then
		XpRepBar.Experience = getExperience[unit](self, unit, XpRepBar)
	else
		XpRepBar.Experience = getExperience['default'](self, unit, XpRepBar)
	end
	if (getReputation[unit]) then
		XpRepBar.Reputation = getReputation[unit](self, unit, XpRepBar)
	else
		XpRepBar.Reputation = getReputation['default'](self, unit, XpRepBar)
	end

	XpRepBar:SetScript('OnEnter', function(self, motion) 
		XpRepBar.Experience:Hide();
		XpRepBar.Reputation:Show();
	end);
	XpRepBar:SetScript('OnLeave', function(self, motion)
		XpRepBar.Experience:Show();
		XpRepBar.Reputation:Hide();
	end);

	XpRepBar.MODIFIER_STATE_CHANGED = function(self, key, state)
		if ((key == 'LALT' or key == 'RALT') and state == 1) then
			XpRepBar.Experience:Hide();
			XpRepBar.Reputation:Show();
		elseif ((key == 'LALT' or key == 'RALT') and state == 0) then
			XpRepBar.Experience:Show();
			XpRepBar.Reputation:Hide();
		end
	end

	XpRepBar:RegisterEvent("MODIFIER_STATE_CHANGED")
	XpRepBar:SetScript("OnEvent", function(self, event, ...) XpRepBar[event](self, ...) end)

	return XpRepBar
end

