local name, addon = ...

local embed = addon['LibInit']("zzCommon-Base", 25, {'RegisterFunc','HandleFunclist','round','split','classcolor','colorize','Print','buildMoneyString','RegisterEventThrottle','RGB2Hex','Hex2RGB','sortArray','IsTwink','getItemId','itemInfo','startup'})
if(type(embed) ~= 'function') then return end

local table = table
local string = string
local math = math
local type = type
local tostring = tostring
local tonumber = tonumber

local throttles = {}
local schedules = {}
local newtmp = {}

local ScheduleCheckDelay = .5
local function checkSchedule()
	for k = #schedules,1,-1	do
		local v = schedules[k]
		if(v['lastcall'] + v['delay'] < GetTime()) then
			v['func'](v['event'], v['arg1'], v['arg2'])
			tremove(schedules, k)
		end
	end
	if(#schedules > 0) then
		C_Timer.After(ScheduleCheckDelay, checkSchedule)
	end
end

C_Timer.After(ScheduleCheckDelay, checkSchedule)

local function scheduleThrottle(obj, arg1, arg2)
	local found,v = false
	for k = 1, #schedules do
		local v = schedules[k]
		if(v['name'] == obj['name']) then
			v = obj
			v['arg1'] = arg1
			v['arg2'] = arg2
			found = true
			break
		end
	end
	if(not found) then
		schedules[#schedules + 1] = obj
		schedules[#schedules]['arg1'] = arg1
		schedules[#schedules]['arg2'] = arg2
	end
	C_Timer.After(ScheduleCheckDelay, checkSchedule)
end

local function eventThrottle(self, event, ...)
	for k = 1, #throttles do
		local v = throttles[k]
		if(v['event'] == event) then
			if(v['lastcall'] + v['delay'] < GetTime()) then
				v['lastcall'] = GetTime()
				v['func'](event, ...)
			else
				scheduleThrottle(v, ...)
			end
		end
	end
end

local lib = {
	['RegisterFunc'] = function(event,typ,func)
		local f = CreateFrame("Frame")
		if(type(event) == "table") then
			for i = 1, #event do
				f:RegisterEvent(event[i])
			end
		elseif(event) then
			f:RegisterEvent(event)
		end
		if(typ and type(func) == 'function') then
			f:SetScript(typ, func)
		end
		return f
	end,
	['HandleFunclist'] = function(lib, list)
		for _, v in ipairs(lib[list]) do
			v()
		end
	end,
	['RGB2Hex'] = function(r,g,b)
		r = r <= 255 and r >= 0 and r or 0
		g = g <= 255 and g >= 0 and g or 0
		b = b <= 255 and b >= 0 and b or 0
		return string.format("%02x%02x%02x", r, g, b)
	end,
	['Hex2RGB'] = function(hex)
		local r, g, b = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6)
		return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
	end,
	['sortArray'] = function(tmp,dir)
		wipe(newtmp)
		local n = 1
		local cnt = 0
		local maximum = 0
		local first
		for k,v in pairs(tmp) do
			cnt = cnt + 1
			if(v > maximum) then
				maximum = v + 1
			end
			first = first or k
		end
		while(cnt > 0) do
			local mx, mn = dir and maximum or 0,first
			for k,v in pairs(tmp) do
				if(dir) then
					if(tonumber(v)<=tonumber(mx)) then
						mx = v
						mn = k
					end
				else
					if(tonumber(v)>=tonumber(mx)) then
						mx = v
						mn = k
					end
				end
			end
			newtmp[n] = mn
			tmp[mn] = nil
			cnt = 0
			for k,v in pairs(tmp) do
				cnt = cnt + 1
			end
			n = n + 1
			mn = 0
			mx = dir and mx or 0
		end
		return newtmp
	end,
	['split'] = function(s, delim)
--		assert (type (delim) == "string" and string.len (delim) > 0, "bad delimiter")
		local start = 1
		local t = {}
		while true do
			local pos = string.find (s, delim, start, true)
			if not pos then	break end
			table.insert (t, string.sub (s, start, pos - 1))
			start = pos + string.len (delim)
		end
		table.insert (t, string.sub (s, start))
		return t
	end,
	['round'] = function(num, idp)
		return math.floor(num * (10^(idp or 0)) + 0.5) / (10^(idp or 0))
	end,
	['classcolor'] = function(text,class)
		if(not RAID_CLASS_COLORS[class]) then
			class="PRIEST"
		end
		return string.format("|c%s%s|r",RAID_CLASS_COLORS[tostring(class)]['colorStr'],text)
	end,
	['colorize'] = function(text,color)
		return string.format("|cff%s%s|r",color,text)
	end,
	['Print'] = function(message)
		SELECTED_CHAT_FRAME:AddMessage(tostring(message))
	end,
	['buildMoneyString'] = function(money, color, tab, abrevK, abrevM)
		tab = tab or {}
		local iconSize = tab['iconSize'] or 12
		local goldicon = tab['goldicon'] or format("\124TInterface\\MoneyFrame\\UI-GoldIcon:%d:%d:1:0\124t", iconSize, iconSize)
		local silvericon = tab['silvericon'] or format("\124TInterface\\MoneyFrame\\UI-SilverIcon:%d:%d:1:0\124t", iconSize, iconSize)
		local coppericon = tab['coppericon'] or format("\124TInterface\\MoneyFrame\\UI-CopperIcon:%d:%d:1:0\124t", iconSize, iconSize)

		local moneystring = ''
		local g,s,c
		local neg = false
		local abrev = ""
		if(abrevM and money >= 10000000000) then
			abrev = abrevM
			money = addon['round'](money / 10000000000,1) * 10000
		elseif(abrevK and money >= 10000000) then
			abrev = abrevK
			money = addon['round'](money / 10000000,1) * 10000
		end
		if(money <0) then 
			neg = true
			money = money * -1
		end
		if(abrev=="") then
			g=floor(money/10000)
			s=floor((money-(g*10000))/100)
			c=money-s*100-g*10000
		else
			g = money/10000
			s = 0
			c = 0
		end
		if(money > 0) then
			if(g>0) then
				moneystring = format("%s%s%s",g,abrev,goldicon)
			end
			if(s>0) then
				moneystring = format("%s%s%s",moneystring,s,silvericon)
			end
			if(c>0) then
				moneystring = format("%s%s%s",moneystring,c,coppericon)
			end
		else
			moneystring = format("%s%s",'0',coppericon)
		end
		if(neg) then
			moneystring = format("-%s",moneystring)
		end
		if(color) then
			if(neg) then
				moneystring = addon['colorize'](moneystring,"ff0000")
			elseif(money ~= 0) then
				moneystring = addon['colorize'](moneystring,"44dd44")
			end
		end
		return moneystring
	end,
	['RegisterEventThrottle'] = function(storename, event, delay, func)
		local found = 0
		if(type(event) ~= 'table') then event = {event} end
		for i = 1, #event do
			found = 0
			local ev = event[i]
			local sn = storename..i
			for k = 1, #throttles do
				local v = throttles[k]
				if(v['name'] == sn) then
					found = k
					break
				end
			end
		
			if(found == 0) then
				local f = CreateFrame("Frame")
				f:RegisterEvent(ev)
				f:SetScript("OnEvent", eventThrottle)
--				lib['RegisterFunc'](ev, "OnEvent", eventThrottle)
			end
			throttles[#throttles + 1] = {
				['name'] = sn,
				['event'] = ev,
				['delay'] = delay,
				['func'] = func,
				['lastcall'] = GetTime() - delay,
			}
		end
	end,
	['IsTwink'] = function(addon, name)
		local realm = GetRealmName()
		local _
		if(addon['db']['sv']['profileKeys']) then
			for k,v in pairs(addon['db']['sv']['profileKeys']) do
				local n,m = strsplit(" - ",k,2)
				_,m = strsplit(" ",m,2)
				if(n) then
					if(n == name and m == realm) then
						return true
					end
				end
			end
		end
		return false
	end,
	['getItemId'] = function(link)
		local id = nil
		if(link) then
			local _, _, itemString = string.find(link, "^|c%x+|H(.+)|h%[.*%]")
			_,id,_ = strsplit(":",itemString)
		end
		return id
	end,
	['itemInfo'] = function(id)
		local i = {}
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(id)
		if(itemName) then
			i = {
				['itemId'] = id,
				['itemName'] = itemName,
				['itemLink'] = itemLink,
				['itemRarity'] = itemRarity,
				['itemLevel'] = itemLevel,
				['itemMinLevel'] = itemMinLevel,
				['itemType'] = itemType,
				['itemSubType'] = itemSubType,
				['itemStackCount'] = itemStackCount,
				['itemEquipLoc'] = itemEquipLoc,
				['itemTexture'] = itemTexture,
				['itemSellPrice'] = itemSellPrice
			}
		end
		return i
	end,
	['startup'] = function(addon, name, childName, init, default, defaults)
		if(name==childName) then
			addon['frame'] = addon['RegisterFunc']({'PLAYER_LOGOUT','ADDON_LOADED','PLAYER_ENTERING_WORLD'},"OnEvent", function(self, event, arg1,...)
				if(event=='ADDON_LOADED') then
					if(arg1 ~= childName) then return end
					addon['db'] = addon['db'] or LibStub("AceDB-3.0"):New(childName.."DB", nil, default)
					if(type(defaults) == 'table') then
						addon['db']['profile'][childName] = addon['db']['profile'][childName] or CopyTable(defaults)
					else
						addon['db']['profile'][childName] = addon['db']['profile'][childName] or {}
					end
					if(self:IsEventRegistered("PLAYER_ENTERING_WORLD") and IsAddOnLoaded("AddonLoader")) then
						if(GetAddOnMetadata(name, "X-LoadOn-Always")) then
							init(self, event, ...)
							self:UnregisterEvent("PLAYER_ENTERING_WORLD")
						end
					end
					addon['HandleFunclist'](addon, 'preloads')
				elseif(event=='PLAYER_LOGOUT') then
					addon['HandleFunclist'](addon, 'logouts')
				elseif(event=='PLAYER_ENTERING_WORLD') then
					local found = false
					for i = 1, #addon['inits'] do
						if(addon['inits'][i] == init) then
							found = true
						end
					end
					if(not found) then
						init(self, event, ...)
					end
					addon['HandleFunclist'](addon, 'inits')
				end
				self:UnregisterEvent(event)
				if(type(addon[event]) == 'function') then
					addon[event](self, event, arg1, ...)
				end
			end)
		else
			addon['RegisterBroker'](childName,init,default,defaults)
		end
	end,
}



embed(lib)