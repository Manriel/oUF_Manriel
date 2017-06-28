local name, addon = ...
local parentName = addon['parentName'] or "BrokerPack"
local childName = "zz_Repair"
local defaults = {
	["autorepair"] = true,
	["listall"] = true,
}
local options = {
}
local db
local L = LibStub("AceLocale-3.0"):GetLocale(childName, true)

local slotNames = { "HeadSlot","NeckSlot","ShoulderSlot","BackSlot","ChestSlot","ShirtSlot","TabardSlot",
                    "WristSlot","HandsSlot","WaistSlot","LegsSlot","FeetSlot","Finger0Slot","Finger1Slot",
                    "Trinket0Slot","Trinket1Slot","MainHandSlot","SecondaryHandSlot",
                    "Bag0Slot","Bag1Slot","Bag2Slot","Bag3Slot" 
}

local statusItem = {}
local player = UnitName('player')
local realm = GetRealmName()

local function OnText(message)
	addon['OnText'](childName, message)
end

local function pickColor(v)
  local col = 'ffffff'
  if(v > 90) then
    col = '00ff00' -- grün
  elseif(v > 40) then
    col = 'ffff00' -- gelb
  elseif(v > 0) then
    col = 'ff9900' -- orange
  else
    col = 'ff0000' -- rot
  end
  return col
end

local function OnDataUpdate()
	local percent = 0
	local total = 0
	local cur = 0
	local lowest = 100
	wipe(statusItem)
	for k,v in pairs(slotNames) do
		local val, max = GetInventoryItemDurability(GetInventorySlotInfo(v))
		if(max) then
			total = total + max
			cur = cur + val
			statusItem[v] = addon['round'](val / (max/100),0)
			if(statusItem[v] < lowest) then
				lowest = statusItem[v]
			end
		end
	end

	if(db['showlowest']) then
		percent = lowest
	else
		percent = addon['round'](cur / (total/100),0)
	end
		percent = addon['colorize'](percent,pickColor(percent))
	OnText(percent.." %")
end

local function getGBLimit()
	local amount = GetGuildBankWithdrawMoney()
	local guildBankMoney = GetGuildBankMoney()
	if ( amount == -1 ) then
		amount = guildBankMoney
	else
		amount = min(amount, guildBankMoney)
	end
	return amount
end

local function MERCHANT_SHOW()
	if(CanMerchantRepair()) then
		local m = GetMoney()
		local r = GetRepairAllCost()
		local gbr = false
		if(db['guildbankrepair']) then
			if(CanGuildBankRepair()) then
				gbr = true
			end
		end
		if(r > 0 and (m > r or gbr) and db['autorepair']) then
			if(gbr) then
				if(getGBLimit() >= r) then
					RepairAllItems(1)
					addon['Print'](L['repaircostgb'](r))
				else
					if(m > r) then
						RepairAllItems()
						addon['Print'](L['repaircost'](r))
					else
						addon['Print'](addon['colorize'](L['Money low'],"ff0000"))
					end
				end
			else
				RepairAllItems()
				addon['Print'](L['repaircost'](r))
			end
			db['repairstats'] = db['repairstats'] or {}
			db['repairstats'][player] = db['repairstats'][player] or 0
			db['repairstats'][player] = db['repairstats'][player] + r
		end
	end
end

local function OnTooltip(tip)
	local zztip = type(tip.AddHeader) == 'function' and tip:AddHeader(childName) or tip:AddLine(childName)
	for k,v in pairs(statusItem) do
		local stat = statusItem[k]
		if(db['listall'] or stat < 100) then
			stat = addon['colorize'](stat,pickColor(stat))
			tip:AddDoubleLine(L[k], stat.." %")
		end
	end
	tip:AddLine(" ")
	tip:AddLine(L["Repair Charts"])
	local tmp = {}
	if(addon['db']['sv']['profileKeys']) then    
		for k,v in pairs(addon['db']['sv']['profileKeys']) do
			local n,_,m = strsplit(' ',k,3)
			if(n) then
				if(m == realm) then
					if(db['repairstats'] and db['repairstats'][n] and db['repairstats'][n] > 0) then
						tmp[n] = db['repairstats'][n]
					end
				end
			end
		end
	end
	for _,v in pairs(addon['sortArray'](tmp,false)) do
		tip:AddDoubleLine(addon['classcolor'](v,db['classes'][v]), addon['buildMoneyString'](db['repairstats'][v] or 0))
	end
	tip:AddLine(" ")
	tip:AddLine(L['HINT3'])
end

local function getPref(info)
-- print("get",info[#info])
	return db[info[#info]]
end

local function setPref(info,value)
	db[info[#info]] = value
	OnDataUpdate()
end

local function init()
	realm = GetRealmName()
	options = addon['InitConfig'](addon, childName, true, {
		['name'] = childName,
		['type'] = "data source",
		['OnTooltipShow'] = OnTooltip,
	}, getPref, setPref)
	db = addon['db']['profile'][childName]
	db['classes'] = db['classes'] or {}
	local _, class, _ = UnitClass('player')
	db['classes'][player] = class
	db['repairstats'] = db['repairstats'] or {}
	addon['AddConfigEntry'](addon, childName,"toggle","autorepair",L['Autorepair'],nil,1,nil,nil,nil,nil,options['args'][childName])
	addon['AddConfigEntry'](addon, childName,"toggle","showlowest",L['Show lowest'],L['Show durability of your lowest item only'],1,nil,nil,nil,nil,options['args'][childName])
	addon['AddConfigEntry'](addon, childName,"toggle","listall",L['Show all slots'],L['Show all slots in the tooltip instead of damaged only'],1,nil,nil,nil,nil,options['args'][childName])
	addon['AddConfigEntry'](addon, childName,"toggle","guildbankrepair",L['Allow Guildbank Repair'],nil,1,nil,nil,nil,nil,options['args'][childName])
	addon['RegisterFunc']({'MERCHANT_SHOW'},"OnEvent", MERCHANT_SHOW)
	addon['RegisterEventThrottle'](childName,{"UPDATE_INVENTORY_DURABILITY","UPDATE_INVENTORY_ALERTS","UNIT_INVENTORY_CHANGED","EQUIPMENT_SWAP_FINISHED"}, 2, OnDataUpdate)
	OnDataUpdate()
end
addon['startup'](addon, name, childName, init, true, defaults)
