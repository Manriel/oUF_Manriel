local dataobj = LibStub("LibDataBroker-1.1"):NewDataObject("AutoLootToggle", {
	icon = "Interface\\Icons\\INV_Misc_Bag_07_Black",
	label = "AutoLoot",
	text = "--",
	type     = "launcher"
})

local tooltip
local self = CreateFrame"Frame"
local currentAL

self:RegisterEvent("ADDON_LOADED")
self:RegisterEvent("PLAYER_LOGIN")
self:RegisterEvent("GROUP_ROSTER_UPDATE")

self:SetScript("OnEvent", function(self, event, ...)
  self[event](self, ...)
end)

local AutoLootToggleDB

function self:ADDON_LOADED(name)
	if (type(Manriel_UI_Config.AutoLootToggleDB) == 'nil') then
		Manriel_UI_Config.AutoLootToggleDB = { solo = true, group = false, raid = false}
	end
	AutoLootToggleDB = Manriel_UI_Config.AutoLootToggleDB
end

function self:PLAYER_LOGIN()
	if AutoLootToggleDB.solo ~= true then
		dataobj.text = ("AutoLoot: |cffff0000OFF|r")
		dataobj.icon = ("Interface\\Icons\\INV_Misc_Bag_07_Red")
		_G.SetCVar("autoLootDefault", "0")
		currentAL = false
	elseif AutoLootToggleDB.solo ~= false then
		dataobj.text = ("AutoLoot: |cff00ff00ON|r")
		dataobj.icon = ("Interface\\Icons\\INV_Misc_Bag_07_Green")
		_G.SetCVar("autoLootDefault", "1")
		currentAL = true
	end
end

function self:GROUP_ROSTER_UPDATE()
	if IsInRaid() then
		if AutoLootToggleDB.raid ~= true then
			dataobj.text = ("AutoLoot: |cffff0000OFF|r")
			dataobj.icon = ("Interface\\Icons\\INV_Misc_Bag_07_Red")
			_G.SetCVar("autoLootDefault", "0")
			currentAL = false
		elseif AutoLootToggleDB.raid ~= false then
			dataobj.text = ("AutoLoot: |cff00ff00ON|r")
			dataobj.icon = ("Interface\\Icons\\INV_Misc_Bag_07_Green")
			_G.SetCVar("autoLootDefault", "1")
			currentAL = true
		end
	elseif GetNumSubgroupMembers(LE_PARTY_CATEGORY) > 0 then
		if AutoLootToggleDB.group ~= true then
			dataobj.text = ("AutoLoot: |cffff0000OFF|r")
			dataobj.icon = ("Interface\\Icons\\INV_Misc_Bag_07_Red")
			_G.SetCVar("autoLootDefault", "0")
			currentAL = false
		elseif AutoLootToggleDB.group ~= false then
			dataobj.text = ("AutoLoot: |cff00ff00ON|r")
			dataobj.icon = ("Interface\\Icons\\INV_Misc_Bag_07_Green")
			_G.SetCVar("autoLootDefault", "1")
			currentAL = true
		end
	else
		if AutoLootToggleDB.solo ~= true then
			dataobj.text = ("AutoLoot: |cffff0000OFF|r")
			dataobj.icon = ("Interface\\Icons\\INV_Misc_Bag_07_Red")
			_G.SetCVar("autoLootDefault", "0")
			currentAL = false
		elseif AutoLootToggleDB.solo ~= false then
			dataobj.text = ("AutoLoot: |cff00ff00ON|r")
			dataobj.icon = ("Interface\\Icons\\INV_Misc_Bag_07_Green")
			_G.SetCVar("autoLootDefault", "1")
			currentAL = true
		end
	end
end

function self:ToggleSolo()
  AutoLootToggleDB.solo = not AutoLootToggleDB.solo
end

function self:ToggleGroup()
  AutoLootToggleDB.group = not AutoLootToggleDB.group
end

function self:ToggleRaid()
  AutoLootToggleDB.raid = not AutoLootToggleDB.raid
end

function dataobj.OnTooltipShow(tip)
	if not tooltip then tooltip = tip end
	tip:ClearLines()
	tip:AddLine("AutoLootToggle")
	tip:AddLine(" ")
	tip:AddDoubleLine("Current AutoLoot Setting:", currentAL and "|cff00ff00ON|r" or "|cffff0000OFF|r")
	tip:AddLine(" ")
	tip:AddDoubleLine("Solo:", AutoLootToggleDB.solo and "|cff00ff00ON|r" or "|cffff0000OFF|r")
	tip:AddDoubleLine("Party:", AutoLootToggleDB.group and "|cff00ff00ON|r" or "|cffff0000OFF|r")
	tip:AddDoubleLine("Raid:", AutoLootToggleDB.raid and "|cff00ff00ON|r" or "|cffff0000OFF|r")
	tip:AddLine(" ")
	tip:AddLine("|cff69b950Left-Click:|r |cffeeeeeeToggle current AutoLoot setting|r")
	tip:AddLine(" ")
	tip:AddLine("|cff69b950Right-Click:|r |cffeeeeeeToggle default solo setting|r")
	tip:AddLine("|cff69b950Shift-Right-Click:|r |cffeeeeeeToggle default party setting|r")
	tip:AddLine("|cff69b950Alt-Right-Click:|r |cffeeeeeeToggle default raid setting|r")
	tip:Show()
end

function dataobj.OnClick()
	local button = GetMouseButtonClicked()
	if button == "LeftButton" then
		if _G.GetCVar("autoLootDefault") == "0" then
			_G.SetCVar("autoLootDefault", "1")
			dataobj.text = ("AutoLoot: |cff00ff00ON|r")
			dataobj.icon = ("Interface\\Icons\\INV_Misc_Bag_07_Green")
			currentAL = true
		elseif _G.GetCVar("autoLootDefault") == "1" then
			_G.SetCVar("autoLootDefault", "0")
			dataobj.text = ("AutoLoot: |cffff0000OFF|r")
			dataobj.icon = ("Interface\\Icons\\INV_Misc_Bag_07_Red")
			currentAL = false
		end
	elseif ( button == "RightButton" ) then
		if IsShiftKeyDown() then
			self:ToggleGroup();
		else
			if IsAltKeyDown() then
				self:ToggleRaid();
			else
				self:ToggleSolo()
			end
		end
	end
	dataobj.OnTooltipShow(tooltip)
end