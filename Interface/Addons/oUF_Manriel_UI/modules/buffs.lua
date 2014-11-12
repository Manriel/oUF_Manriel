local buffHeader = CreateFrame("Frame", "Buffs", UIParent, "SecureAuraHeaderTemplate")
local debuffHeader = CreateFrame("Frame", "Debuffs", UIParent, "SecureAuraHeaderTemplate")
local f = CreateFrame("Frame","Buff")
local f2 = CreateFrame("Frame","Buff2")

------------------
-- Options
------------------
local defaultColor = {r = 0.30, g = 0.50, b = 1.0}
local tempBuffColor = {r = 0.5, g = 0.0, b = 0.5}
local barWidth = 32      -- IF YOU EDIT THE BAR WIDTH OR HEIGHT MAKE SURE TO CHANGE THE VALUES IN bAuraButtonTemplate.xml TO MATCH.
local barHeight = 32      -- NOT DOING SO WILL CAUSE THE BARS TO ACT STRANGELY
local barScale = 1
local barAlpha = 1
local buffAnchorPoint =  "TOPRIGHT"
local buffAnchorFrame = UIParent
local buffAnchorFramePoint = "TOPRIGHT"
local buffX = 0
local buffY = -100
local debuffAnchorPoint = "TOPRIGHT"
local debuffAnchorFrame = UIParent
local debuffAnchorFramePoint = "TOPRIGHT"
local debuffX = -200
local debuffY = -100
local font = "Fonts\\FRIZQT__.TTF"
local fontSize = 12
local texture = "Interface\\Addons\\bBuffBars\\HalT"

--Lower this to make bars update more smoothly, raise it to gain more performance
local updateFrequency = 0.1

--Lower this only if text timer is being unresponsive.
local timerFrequency = 1


-----------------
-- Buff Headers - Don't edit below here if you don't know what you are doing
-----------------
buffHeader:SetAttribute("unit", "player")
buffHeader:SetAttribute("filter", "HELPFUL")
buffHeader:SetAttribute("template", "MyBuffButtonTemplate")
buffHeader:SetAttribute("minWidth", barWidth)
buffHeader:SetAttribute("minHeight", barHeight)

buffHeader:SetAttribute("point", "TOPRIGHT")
buffHeader:SetAttribute("xOffset", -barWidth)
buffHeader:SetAttribute("yOffset", 0)

buffHeader:SetAttribute("separateOwn", 0)
buffHeader:SetAttribute("sortMethod", "TIME")
buffHeader:SetAttribute("sortDirection","-")
buffHeader:SetAttribute("wrapAfter",3)
buffHeader:SetAttribute("wrapXOffset", 0)
buffHeader:SetAttribute("wrapYOffset", -barHeight)
buffHeader:SetAttribute("maxWraps", 10)

buffHeader:SetAttribute("includeWeapons", 1)
buffHeader:SetAttribute("weaponTemplate", "MyBuffButtonTemplate")

buffHeader:SetPoint(buffAnchorPoint, buffAnchorFrame, buffAnchorFramePoint, buffX, buffY)
buffHeader:SetScale(barScale)
buffHeader:SetAlpha(barAlpha)
buffHeader:Show()

-- Buff Headers
debuffHeader:SetAttribute("unit", "player")
debuffHeader:SetAttribute("filter", "HARMFUL")
debuffHeader:SetAttribute("template", "MyDebuffButtonTemplate")
debuffHeader:SetAttribute("minWidth", barWidth)
debuffHeader:SetAttribute("minHeight", barHeight)

debuffHeader:SetAttribute("point", "TOPRIGHT")
debuffHeader:SetAttribute("xOffset", -barWidth)
debuffHeader:SetAttribute("yOffset", 0)

debuffHeader:SetAttribute("separateOwn", 0)
debuffHeader:SetAttribute("sortMethod", "TIME")
debuffHeader:SetAttribute("sortDirection","-")
debuffHeader:SetAttribute("wrapAfter",3)
debuffHeader:SetAttribute("wrapXOffset", 0)
debuffHeader:SetAttribute("wrapYOffset", -barHeight)
debuffHeader:SetAttribute("maxWraps", 10)

debuffHeader:SetPoint(debuffAnchorPoint, debuffAnchorFrame, debuffAnchorFramePoint, debuffX, debuffY)
debuffHeader:SetScale(barScale)
debuffHeader:SetAlpha(barAlpha)
debuffHeader:Show()

------------------------------
-- Basic Functions
------------------------------

--Make local copy for trivially faster look up
local UnitAura = _G.UnitAura
local GetTime = _G.GetTime
local string_format = string.format
local math_floor = math.floor
local math_mod = mod
local string_gsub = string.gsub
local string_match = string.match

-- Formats the time text
local function formatTime(timeLeft)
   local hours, minutes, seconds = 0, 0, 0
   if( timeLeft >= 3600 ) then
      hours = math_floor(timeLeft / 3600)
      timeLeft = math_mod(timeLeft, 3600)
   end

   if( timeLeft >= 60 ) then
      minutes = math_floor(timeLeft / 60)
      timeLeft = math_mod(timeLeft, 60)
   end

   seconds = timeLeft > 0 and timeLeft or 0

   if( hours > 0 ) then
      return string_format("%d:%02d:%02d", hours, minutes, seconds)
   elseif (minutes > 0 ) then
      return string_format("%02d:%02d", minutes, seconds)
   else
      return string_format("%02d",seconds)
   end
end
-- provide a simple iterator to the header
local function iter_active_children(self, i)
   i = i + 1
   local child = self:GetAttribute("child" .. i)
   if child and child:IsShown() then
      return i, child, child:GetAttribute("index")
   end
end
function buffHeader:ActiveChildren() return iter_active_children, self, 0 end
function debuffHeader:ActiveChildren() return iter_active_children, self, 0 end

-- Parse out name/rank from a temp weapon buff
local function parseName(slotID)
   if( not tooltip ) then
      tooltip = CreateFrame("GameTooltip", "Tooltip", UIParent, "GameTooltipTemplate")
      tooltip:SetOwner(UIParent, "ANCHOR_NONE")
   end
   
   tooltip:SetInventoryItem("player", slotID)
   
   for i=1, tooltip:NumLines() do
      local text = _G["bBTooltipTextLeft" .. i]:GetText()
      local name = string_match(text, "^(.+) %(%d+[^%)]+%)$")
      if( name ) then
         -- Strip any remaining brackets for things such as fishing which shows +100 Fishing as well
         name = string_gsub(name, " %(%d+[^%)]+%)", "")
         return name
      end
   end
   
   return nil, nil
end

--------------------------
-- Begin Buff Functions
---------------------------

local currentTime, name, icon, count, debuffType, duration, endTime
local function updateBuffTimer(self, elapsed)
   if self.barUpdate < updateFrequency then
      self.barUpdate = self.barUpdate + elapsed
   else
      name,_,_,_,_,duration,endTime = UnitAura("player", self:GetID(), self.filter)
      if name and duration > 1 then
         currentTime = GetTime()
         self.bar:SetValue(endTime - currentTime)
         self.timer:SetText(formatTime(endTime - currentTime))
      end
      self.barUpdate = 0
   end
   if self.timerUpdate < timerFrequency then
      self.timerUpdate = self.timerUpdate + elapsed
   else
      name,_,_,_,_,duration,endTime = UnitAura("player", self:GetID(), self.filter)
      if name and duration > 1 then
         currentTime = GetTime()
         self.bar:SetValue(endTime - currentTime)
         self.timer:SetText(formatTime(endTime - currentTime))
      end
      self.timerUpdate = 0
   end      
end

local enchantExpiration
local function updateWeaponTimer(self, elapsed)
   if self.barUpdate < updateFrequency then
      self.barUpdate = self.barUpdate + elapsed
   else
      if self.slotID == 16 then -- using fancy select() here like below was slower
         _, enchantExpiration = GetWeaponEnchantInfo()    
      elseif self.slotID == 17 then   
         _,_,_,_, enchantExpiration = GetWeaponEnchantInfo()
      else
         _,_,_,_,_,_,_,enchantExpiration = GetWeaponEnchantInfo()
      end
      self.bar:SetValue(enchantExpiration/1000)
      self.barUpdate = 0
   end
   if self.timerUpdate < timerFrequency then 
      self.timerUpdate = self.timerUpdate + elapsed
   else
      if self.slotID == 16 then
         _, enchantExpiration = GetWeaponEnchantInfo()         
      elseif self.slotID == 17 then
         _,_,_,_, enchantExpiration = GetWeaponEnchantInfo()
      else
         _,_,_,_,_,_,_,enchantExpiration = GetWeaponEnchantInfo()
      end
      self.timer:SetText(formatTime(enchantExpiration/1000))
      self.timerUpdate = 0
   end
end

local function createBar(button)
   button.timerUpdate = 0
   button.barUpdate = 0
   button.filter = ""
   -- Create Icon
   button.icon = button:CreateTexture(nil, "BORDER")
   button.icon:SetPoint("TOPLEFT",button,"TOPLEFT")
   button.icon:SetWidth(barHeight)
   button.icon:SetHeight(barHeight)
   
   button.bar = CreateFrame("StatusBar", nil, button)
   button.bar:SetHeight(barHeight)
   button.bar:SetWidth(barWidth-barHeight)
   button.bar:SetPoint("TOPRIGHT",button,"TOPRIGHT")
   button.bar:SetStatusBarTexture(texture)
   
   button.bg = CreateFrame("StatusBar", nil, button)
   button.bg:SetMinMaxValues(0, 1)
   button.bg:SetValue(1)
   button.bg:SetAllPoints(button.bar)
   button.bg:SetFrameLevel(0)
   button.bg:SetStatusBarTexture(texture)   
      
   -- Icon border
   button.iconBorder = button:CreateTexture(nil, "OVERLAY")
   button.iconBorder:SetAllPoints(button.icon)
   button.iconBorder:SetTexture("Interface\\AddOns\\bBuffBars\\gloss")
   
   -- Timer text
   button.timer = button.bar:CreateFontString(nil, "OVERLAY")
   button.timer:SetJustifyH("RIGHT")
   button.timer:SetJustifyV("CENTER")
   button.timer:SetPoint("TOPRIGHT", button.bar, "TOPRIGHT", -1, 0)
   button.timer:SetFont(font, fontSize)
   button.timer:SetShadowOffset(1, -1)
   button.timer:SetShadowColor(0, 0, 0, 1)
   button.timer:SetHeight(barHeight)
   
   -- Buff Name Text
   button.text = button.bar:CreateFontString(nil, "OVERLAY")
   button.text:SetJustifyH("LEFT")
   button.text:SetJustifyV("CENTER")
   button.text:SetPoint("TOPLEFT", button.bar, "TOPLEFT", 2, 0)
   button.text:SetFont(font, fontSize)
   button.text:SetShadowOffset(1, -1)
   button.text:SetShadowColor(0, 0, 0, 1)
   button.text:SetHeight(barHeight)
   button.text:SetWidth(barWidth - 40)
end

local color, timeLeft
local function updateBar(button, currentTime, auraType)
   if not button.icon then createBar(button) end
    
   name,_, icon, count, debuffType, duration, endTime = UnitAura("player", button:GetID(), auraType)
   if name then
      button.icon:SetTexture(icon)
      if duration > 0 then
         timeLeft = endTime-currentTime
         button.bar:SetMinMaxValues(0,duration)
         button.bar:SetValue(timeLeft)
         button.timer:SetText(formatTime(timeLeft))
         button:SetScript("OnUpdate",updateBuffTimer)
      else
         button.bar:SetMinMaxValues(0,1)
         button.bar:SetValue(1)
         button.timer:SetText("")
         button:SetScript("OnUpdate",nil)
      end
      if count > 0 then
         button.text:SetFormattedText("[%s] %s",count,name)
      else
         button.text:SetText(name)
      end
      button.filter = auraType
      if name == "Blessing of Protection" then
         color = { r = 0.01, g = 0.01, b = 0.01 }
      elseif( auraType == "HARMFUL" ) then
         color = DebuffTypeColor[debuffType] or DebuffTypeColor.none
      else
         color = defaultColor
      end

      button.bar:SetStatusBarColor(color.r, color.g, color.b, 0.80)
      button.bg:SetStatusBarColor(color.r, color.g, color.b, 0.30)
    end
end

local RETURNS_PER_ITEM = 3
local numItems = 3
local enchantIndex, hasEnchant, enchantExpiration,enchantCharges, wEnch, slotID
local function updateWeaponBar(...)
   for itemIndex = numItems, 1, -1 do
      hasEnchant, enchantExpiration, enchantCharges = select(RETURNS_PER_ITEM * (itemIndex - 1) + 1, ...);
      if hasEnchant then
         wEnch = buffHeader:GetAttribute("tempEnchant"..itemIndex)
         if wEnch then
            if not wEnch.icon then createBar(wEnch) end
            wEnch.slotID = 15 + itemIndex
            wEnch.icon:SetTexture(GetInventoryItemTexture("player",wEnch.slotID))
      
            wEnch.bar:SetMinMaxValues(0,1800)  
            wEnch.bar:SetStatusBarColor(tempBuffColor.r, tempBuffColor.g, tempBuffColor.b, 0.80)
            wEnch.bg:SetStatusBarColor(tempBuffColor.r, tempBuffColor.g, tempBuffColor.b, 0.30)
            wEnch.text:SetText(parseName(wEnch.slotID))
            wEnch:SetScript("OnUpdate",updateWeaponTimer)
         end
      end
   end
end

local hasMainHand, hasOffHand, wEnch1, wEnch2
local function updateStyle(self, event, unit)
   if unit == "player" then
      currentTime = GetTime()
      for _,button in buffHeader:ActiveChildren() do updateBar(button, currentTime, "HELPFUL") end
      for _,button in debuffHeader:ActiveChildren() do updateBar(button, currentTime, "HARMFUL") end
   
      --updateWeaponBar(GetWeaponEnchantInfo()) --Commented out until I can remove the hack
   end
end

local function prepBuffs(self, event)
   -- Initially seperated out to provide better Entering/Exiting Vehicle support, but that currently taints. Leaving it in because hey why not, it saves an if statement.
   BuffFrame:UnregisterEvent("UNIT_AURA")
   TemporaryEnchantFrame:UnregisterEvent("UNIT_AURA")
   TemporaryEnchantFrame:Hide()
   BuffFrame:Hide()
   ConsolidatedBuffs:Hide()  
   updateStyle(nil, nil, "player")
end

f2:RegisterEvent("PLAYER_ENTERING_WORLD")
f2:SetScript("OnEvent",prepBuffs)
f:RegisterEvent("UNIT_AURA")
f:SetScript("OnEvent",updateStyle)

--Hack to work around the fact that UNIT_AURA isn't called for temporary enchants for rogues, and rarely shaman
--if select(2, UnitClass("player")) == "ROGUE" then
   local hackTimer = 0
   local function rogueHack(self, elapsed)
      if hackTimer < 0.25 then
         hackTimer = hackTimer + elapsed
      else
         updateWeaponBar(GetWeaponEnchantInfo())
         hackTimer = 0
      end
   end
   f:SetScript("OnUpdate", rogueHack)
--end 