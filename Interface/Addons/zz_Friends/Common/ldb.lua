local name, addon = ...

local embed = addon['LibInit']("zzCommon-ldb", 5, {'AddLDB','AddLDBIconOptions','OnText'})
if(type(embed) ~= 'function') then return end

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local ldbicon = LibStub("LibDBIcon-1.0")

local defaults = {
	['hide'] = false,
}

local function ldbiconUpdate(objname)
	local ldbobj = ldb:GetDataObjectByName(objname)
	if(ldbicon) then
		local db = ldbobj['zzInfo']['db']
		db[objname] = db[objname] or CopyTable(defaults)
		if(db[objname]['hide']) then
			ldbicon:Hide(objname)
		else
			ldbicon:Show(objname)
		end
	end
end

local function ldbOnClick(self, button)
	local objname = ldb:GetNameByDataObject(self)
	if(IsShiftKeyDown() and button == "LeftButton") then
		if(not ldbicon) then return end
		local db = self['zzInfo']['db']
		db[objname]['hide'] = not db[objname]['hide']
		ldbiconUpdate(objname)
	else
		if(InterfaceOptionsFrame:IsVisible() and not InCombatLockdown()) then
			InterfaceOptionsFrame:Hide()
		else
			InterfaceOptionsFrame_OpenToCategory(objname)
		end
	end
end

local function OnTooltipShow(self)
	self:AddLine("N/A")
end

local function minimapGet(pref)
	local objname = pref[#pref - 2]
	local ldbobj = ldb:GetDataObjectByName(objname)
	local db = ldbobj['zzInfo']['db']
	return db[objname][pref[#pref]]
end

local function minimapSet(pref,value)
	local objname = pref[#pref - 2]
	local ldbobj = ldb:GetDataObjectByName(objname)
	local db = ldbobj['zzInfo']['db']
	db[objname][pref[#pref]] = value
	ldbiconUpdate(objname)
end

local lib = {
	['AddLDB'] = function(self, objname, obj)
		obj = obj or {}
		local icon = (self['name'] and "Interface\\AddOns\\"..self['parentName'].."\\"..objname.."\\icon2.tga" or "Interface\\AddOns\\"..objname.."\\icon2.tga")
		local ldbobj = ldb:GetDataObjectByName(objname) or ldb:NewDataObject(objname, {
			['type'] = obj['type'] or 'launcher',
			['text'] = obj['text'] or objname,
			['icon'] = obj['icon'] or icon,
			['zzInfo'] = {}
		})
		ldbobj['OnClick'] = type(obj['OnClick']) == 'function' and function(_, button) obj['OnClick'](ldbobj, button) end or function(_, button) ldbOnClick(ldbobj, button) end
		ldbobj['OnTooltipShow'] = type(obj['OnTooltipShow']) == 'function' and obj['OnTooltipShow'] or nil
		if(ldbobj and ldbicon) then
			self['db']['global']['ldbicons'] = self['db']['global']['ldbicons'] or {}
			local db = self['db']['global']['ldbicons']
			ldbobj['zzInfo']['db'] = self['db']['global']['ldbicons']
			db[objname] = db[objname] or CopyTable(defaults)
			if(not ldbicon:IsRegistered(objname)) then
				ldbicon:Register(objname,ldbobj,db[objname])
			end
			ldbiconUpdate(objname)
		end
	end,
	['OnText'] = function(objname, message)
		local ldbobj = ldb:GetDataObjectByName(objname)
		ldbobj['text'] = message
	end,
	['AddLDBIconOptions'] = function(self)
		 return {
			['name']="Minimapicon",
			['type']='group',
			['inline']=true,
			['get'] = minimapGet,
			['set'] = minimapSet,
			['order'] = 100,
			['args']={
				['hide'] ={
					['type'] = 'toggle',
					['name'] = "Hide Minimapicon",
				},
				['minimapPos'] ={
					['type'] = 'range',
					['name'] = "Minimapicon Position",
					['min'] = 1,
					['max'] = 250,
					['step']=1,
				}
			}
		}
	end,
}

embed(lib)
