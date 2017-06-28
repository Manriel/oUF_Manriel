local parent, namespace = ...
local UI = namespace.ManrielUI
local config = UI.config
local LSM = UI.lib.LSM
local arStrings = UI.localeStrings

local backdrop = {	
	bgFile = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Background'),
	edgeFile = LSM:Fetch(LSM.MediaType.BORDER, 'Manriel-Border'),
	edgeSize = 32,
	insets = {left = 3, right = 3, top = 3, bottom = 3},
	tile = true,
	tileSize = 256
}

local GameTooltip = _G["GameTooltip"]
if GameTooltip then GameTooltip:SetBackdrop(backdrop) end

local ItemRefTooltip = _G["ItemRefTooltip"]
if ItemRefTooltip then ItemRefTooltip:SetBackdrop(backdrop) end

local ShoppingTooltip1 = _G["ShoppingTooltip1"]
if ShoppingTooltip1 then ShoppingTooltip1:SetBackdrop(backdrop) end

local ShoppingTooltip2 = _G["ShoppingTooltip2"]
if ShoppingTooltip2 then ShoppingTooltip2:SetBackdrop(backdrop) end

local ShoppingTooltip3 = _G["ShoppingTooltip3"]
if ShoppingTooltip3 then ShoppingTooltip3:SetBackdrop(backdrop) end


---------------------------------------------------- Position
GameTooltip_SetDefaultAnchor = function(self, parent)
	self:SetOwner(parent, "ANCHOR_NONE")
	self:SetPoint("TOPLEFT", oUF_ManrielUI, "TOPLEFT", 3, -30)
	self.default = 1
end

---------------------------------------------------- Statusbar
local _G = getfenv(0)
local sb = _G["GameTooltipStatusBar"]
sb:SetStatusBarTexture(config.textureHealthBar)
sb:SetPoint("TOPLEFT", GameTooltip, "BOTTOMLEFT", 3, 11)
sb:SetPoint("TOPRIGHT", GameTooltip, "BOTTOMRIGHT", -3, 11)
sb:SetHeight(8)

---------------------------------------------------- Colors
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local UnitSelectionColor = UnitSelectionColor

function GameTooltip_UnitColor(unit)
	local r, g, b

	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		r, g, b = RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	-- elseif UnitIsTapped(unit) and not UnitIsTappedByPlayer(unit) or UnitIsDead(unit) then
	elseif UnitIsTapDenied(unit) then
		r, g, b = .6, .6, .6
	else
		r, g, b = UnitSelectionColor(unit)
	end

	return r, g, b
end

---------------------------------------------------- Unit tooltip styling
local classification = config.classification

local OnTooltipSetUnit = function(self)
	local lines = self:NumLines()
	local name, unit = self:GetUnit()

	if(not unit) then return end

	local race = UnitRace(unit)
	local level = UnitLevel(unit)
	local class, _ = UnitClass(unit)
	local crtype = UnitCreatureType(unit)
	local classif = UnitClassification(unit)
	local titleName = GetUnitName(unit, true)

	if(level and level==-1) then level = UnitLevel("player") + 3 end

	_G["GameTooltipTextLeft1"]:SetText(titleName) -- .. " - " .. realm )

	if(UnitIsPlayer(unit)) then
		if (GetGuildInfo(unit)) then
			_G["GameTooltipTextLeft2"]:SetFormattedText("<%s>", GetGuildInfo(unit))
		end

		for i = 2, lines do
			if(_G["GameTooltipTextLeft"..i]:GetText():find("^"..race)) then
				_G["GameTooltipTextLeft"..i]:SetFormattedText("%s %s %s", level, race, class)
				break
			end
		end
	else
		for i = 2, lines do
			if((level and _G["GameTooltipTextLeft"..i]:GetText():find("^"..LEVEL)) or (crtype and _G["GameTooltipTextLeft"..i]:GetText():find("^"..crtype))) then
				_G["GameTooltipTextLeft"..i]:SetFormattedText("%s%s %s", level, classification[classif] or "", crtype or "")
				break
			end
		end
	end
	if(UnitExists(unit.."target") and unit~="player") then
		local r, g, b = 0, 1, 0
		local text = ""

		if(UnitIsEnemy("player", unit.."target")) then
			r, g, b = 1, 0, 0
		elseif(not UnitIsFriend("player", unit.."target")) then
			r, g, b = 1, 1, 0
		end

		if(UnitName(unit.."target")==UnitName("player")) then
			text = arStrings['target']..": "..arStrings['you']
		else
			text = arStrings['target']..": "..UnitName(unit.."target")
		end

		self:AddLine(text, r, g, b)
	end
	for i = 1, lines do
		if(_G["GameTooltipTextLeft"..i]:GetText():find(PVP_ENABLED)) then
			_G["GameTooltipTextLeft"..i]:SetText(nil)
			break
		end
	end
end

GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)

---------------------------------------------------- Item Levels
--[[local AddItemlevel = function(self)
	local _, link = self:GetItem()
	local level = link and select(4, GetItemInfo(link))
	if(level and level>0) then
		local name = self:GetName()
		local oldtext = _G[name.."TextLeft1"]:GetText()
		_G[name.."TextLeft1"]:SetFormattedText("|cffffffff%s|r %s", level, oldtext)
	end
end
--
GameTooltip:HookScript("OnTooltipSetItem", AddItemlevel)
ItemRefTooltip:HookScript("OnTooltipSetItem", AddItemlevel)
--]]
--[[ This addon is heavily inspired by Shantalya's sTooltip ]]

local _G = getfenv(0)

local frame = CreateFrame("Frame", "ItemRefTooltipIconFrame", _G["ItemRefTooltip"])
frame:SetPoint("TOPRIGHT", _G["ItemRefTooltip"], "TOPLEFT", -1, 0)
frame:SetHeight(38)
frame:SetWidth(38)

local tex = frame:CreateTexture("ItemRefTooltipIcon", "TOOLTIP")
tex:SetAllPoints(frame)

local AddItemIcon = function()
	local frame = _G["ItemRefTooltipIconFrame"]
	local texture = _G["ItemRefTooltipIcon"]
	frame:Hide()

	local _, link = _G["ItemRefTooltip"]:GetItem()
	local icon = link and GetItemIcon(link)
	if(not icon) then return end

	texture:SetTexture(icon)
	frame:Show()
end

hooksecurefunc("SetItemRef", AddItemIcon)