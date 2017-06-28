local name, addon = ...

local embed = addon['LibInit']("zzCommon-Conf", 8, {'AddConfigMenu','AddConfigEntry','InitConfig'})
if(type(embed) ~= 'function') then return end

local function getPref(pref)
	return pref['handler']['db']['profile'][pref[#pref]]
end

local function setPref(pref,value)
	pref['handler']['db']['profile'][pref[#pref]] = value
end
local addedPanels = {}
local select = select

local lib = {
	['InitConfig'] = function(self, parentName, AddLDBIconOptions, AddLDB, gp, sp)
		local options
		if(not self['options']) then
			options = {
				['type']='group',
				['handler']=self,
				['get']=gp or getPref,
				['set']=sp or setPref,
				['childGroups']='tab',
				['args']={
					[parentName] = {
						['name'] = parentName,
						['type']='group',
						['order']=1,
						['args']={
							['minimap'] = AddLDBIconOptions and self['AddLDBIconOptions'](self) or nil
						}
					}
				}
			}
			self['options'] = options
			self['options']['args']['profile'] = LibStub("AceDBOptions-3.0"):GetOptionsTable(self['db'])
			LibStub("AceConfig-3.0"):RegisterOptionsTable(parentName, self['options'])
			if(not addedPanels[parentName]) then
				addedPanels[parentName] = true
				LibStub("AceConfigDialog-3.0"):AddToBlizOptions(parentName, parentName)
			end
		else
			options = {
				['name'] = parentName,
				['type']='group',
				['handler']=self,
				['get']=gp or getPref,
				['set']=sp or setPref,
				['childGroups']='tab',
				['args']={
					[parentName] = {
						['name'] = parentName,
						['type']='group',
						['order']=1,
						['args']={
							['minimap'] = AddLDBIconOptions and self['AddLDBIconOptions'](self) or nil
						}
					}
				}
			}
			LibStub("AceConfig-3.0"):RegisterOptionsTable(parentName, options)
			if(not addedPanels[parentName]) then
				addedPanels[parentName] = true
				LibStub("AceConfigDialog-3.0"):AddToBlizOptions(parentName, parentName, self['parentName'])
			end
		end
		if(AddLDB) then
			self['AddLDB'](self, parentName,AddLDB)
		end
		return options
	end,
	['AddConfigMenu'] = function(self, menuName, parentMenu)
		if(not parentMenu) then	parentMenu = self['options'] end
		local menuHandler,menuChildGroups,menuGet,menuSet,menuOrder,menuDesc,menuDisabled,menuHidden
		if(type(menuName) == 'table') then
			menuHandler = menuName['menuHandler'] or self
			menuChildGroups = menuName['childGroups'] or 'tree'
			menuGet = menuName['menuGet']  or getPref
			menuSet = menuName['menuSet'] or setPref
			menuOrder = menuName['order'] or 1
			menuDesc = menuName['desc']  or ''
			menuDisabled = menuName['disabled']  or false
			menuHidden = menuName['hidden']  or false
			menuName = menuName['name']
		else
			menuHandler = self
			menuGet = 'getPref'
			menuSet = 'setPref'
			menuOrder = 1
			menuDesc = ''
		end
		parentMenu['args'][menuName] = {
			['type'] = 'group',
			['name'] = menuName,
			['desc'] = menuDesc,
			['childGroups'] = menuChildGroups,
			['handler'] = menuHandler,
			['get'] = menuGet,
			['set'] = menuSet,
			['order'] = menuOrder,
			['args']  = {},
			['hidden'] = menuHidden,
			['disabled'] = menuDisabled,
		}
		return parentMenu['args'][menuName]
	end,
	['AddConfigEntry'] = function(self, parentName, ...)
		local menu = select(10,...) or self['options']['args'][parentName]
		if(menu) then
			local entryName = select(2,...)
			menu['args'][entryName] = {
				['type'] = select(1,...),
				['name'] = select(3,...),
				['desc'] = select(4,...),
				['order'] = select(5,...)
			}
			if(select(1,...) == 'range') then
				menu['args'][entryName]['min'] =  select(6,...)
				menu['args'][entryName]['max'] =  select(7,...)
				menu['args'][entryName]['step'] =  select(8,...)
				menu['args'][entryName]['isPercent'] =  select(9,...)
			elseif(select(1,...) == 'execute') then
				menu['args'][entryName]['func'] =  select(6,...)
			elseif(select(1,...) == 'color') then
				menu['args'][entryName]['get'] =  select(6,...)
				menu['args'][entryName]['set'] =  select(7,...)
				menu['args'][entryName]['hasAlpha'] = true
			elseif(select(1,...) == 'select') then
				menu['args'][entryName]['values'] = select(6,...)
			end
		end
	end
}

embed(lib)