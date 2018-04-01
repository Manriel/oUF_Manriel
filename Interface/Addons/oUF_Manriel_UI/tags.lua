local parent, namespace = ...
local oUF = namespace.oUF
local UI  = namespace.ManrielUI

-- define the tag functions
oUF.Tags.Methods['ManrielUI:curhpformatted'] = function(unit, realUnit)
    local curhp = _TAGS['curhp'](unit, realUnit)
    return UI.fn.formatVal(curhp)
end
oUF.Tags.Methods['ManrielUI:maxhpformatted'] = function(unit, realUnit)
    local maxhp = _TAGS['maxhp'](unit, realUnit)
    return UI.fn.formatVal(maxhp)
end

oUF.Tags.Methods['ManrielUI:smartHPString'] = function(unit, realUnit)
    local curhp = tonumber(_TAGS['curhp'](unit, realUnit))
    local maxhp = tonumber(_TAGS['maxhp'](unit, realUnit))
    local text;

	if(not UnitIsConnected(unit)) then
		text = '|cffD7BEA5'..UI.localeStrings['offline']
	elseif(UnitIsDead(unit)) then
		local unitSexId = UnitSex(unit);
		if (type(unitSexId)=='nil') then
			unitSexId = 2
		end
		text = '|cffD7BEA5'..UI.localeStrings['dead'][unitSexId]
	elseif(UnitIsGhost(unit)) then
		text = '|cffD7BEA5'..UI.localeStrings['ghost']
	else
		if(unit=="player") then
	      text = string.format("%d | %d | %d|cffffffff%%", curhp, maxhp, floor(curhp/maxhp*100))
	    elseif (unit=="target") then
	      text = string.format("%.1f|cffffffff%% | %s", (curhp/maxhp*100), UI.fn.formatVal(maxhp))
	    else
	      text = string.format("%d|cffffffff%%", floor(curhp/maxhp*100))
	    end
	end

    return text
end
oUF.Tags.Methods['ManrielUI:smartLvl'] = function(unit, realUnit)
    local level = not UnitIsConnected(unit) and '??' or UnitLevel(unit) < 1 and '??' or UnitLevel(unit)
    return string.format("%s%s", level, UI.config.classification[UnitClassification(unit)])
end


-- add the events
oUF.Tags.Events['ManrielUI:curhpformatted'] = 'UNIT_HEALTH UNIT_MAXHEALTH'
oUF.Tags.Events['ManrielUI:maxhpformatted'] = 'UNIT_HEALTH UNIT_MAXHEALTH'

oUF.Tags.Events['ManrielUI:smartHPString'] = 'UNIT_HEALTH UNIT_MAXHEALTH UNIT_CONNECTION'

oUF.Tags.Events['ManrielUI:smartLvl'] = 'UNIT_LEVEL PLAYER_LEVEL_UP UNIT_CLASSIFICATION_CHANGED'