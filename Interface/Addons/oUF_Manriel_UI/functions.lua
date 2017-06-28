local parent, namespace = ...
local oUF = namespace.oUF
local UI  = namespace.ManrielUI

local fn = {}

fn.Val = function(value, defaultValue)
  if (value == nil) then
    return defaultValue;
  else
    return value;
  end
end

fn.CopyDeep = function (src)
  local dest = {}
  if type(src) == 'table' then
    for n, v in pairs (src) do
      if (type(v) == "table") then
        dest[n] = fn.CopyDeep(v);
      else
        dest[n] = v;
      end
    end
  else
    dest = src
  end
  return dest
end

fn.addCallback = function(param, callable)
  return function(...)
    if (type(param) ~= 'nil') then
      param(...)
    end

    callable(...)
  end
end

fn.formatVal = function(value)
  if value >= 1e13 then
    return string.format("%.1fT", value/1e12)
  elseif value >= 1e10 then
    return string.format("%.1fG", value/1e9)
  elseif value >= 1e6 then
    return string.format("%.1fM", value/1e6)
  elseif value >= 1e3 then
    return string.format("%.1fK", value/1e3)
  else
    return value
  end	
end

fn.setFontString = function(parent, fontStyle, fontHeight, flags)
  local fontString = parent:CreateFontString(nil, "OVERLAY")
  fontString:SetFont(fontStyle, fontHeight, flags)
  fontString:SetShadowColor(0,0,0)
  fontString:SetShadowOffset(1, -1)
  fontString:SetTextColor(1,1,1)
  fontString:SetJustifyH("LEFT")
  return fontString
end

fn.getDifficultyColor = function(level)
  if level == '??' or level == '-1' then
    return  1, 0.84, 1 -- .69,.31,.31
  else
    local levelDiff = UnitLevel('target') - UnitLevel('player')
    if levelDiff >= 5 then
      return .69, .31, .31
    elseif levelDiff >= 3 then
      return .71, .43, .27
    elseif levelDiff >= -2 then
      return .84, .75, .65
    elseif -levelDiff <= GetQuestGreenRange() then
      return .33, .59, .33
    else
      return .55, .57, .61
    end
  end
end

fn.updateColor = function(self, unit, statusBar)
  local color, colorRGB
  local _, class = UnitClass(unit)

  if(UnitIsTapDenied(unit)) then
    color = {.5,.5,.5}
  elseif(UnitIsDead(unit) or UnitIsGhost(unit) or not UnitIsConnected(unit)) then
    color = {.5,.5,.5}
  elseif(UnitIsPlayer(unit)) then
    color = oUF.colors.class[class]
  else
    colorRGB = FACTION_BAR_COLORS[UnitReaction(unit, 'player')]	
  end
  if(color) then
    statusBar:SetStatusBarColor(color[1], color[2], color[3])	
    statusBar:SetBackdropColor(color[1]/2.5, color[2]/2.5, color[3]/2.5,0.8)
  elseif(colorRGB) then
    statusBar:SetStatusBarColor(colorRGB.r, colorRGB.g, colorRGB.b)	
    statusBar:SetBackdropColor(colorRGB.r/2.5, colorRGB.g/2.5, colorRGB.b/2.5, 0.8)
  end
end

UI.fn = fn