local name, addon = ...
setmetatable(addon,getmetatable(CreateFrame("Frame")))
local LibStub = LibStub
addon['inits'] = addon['inits'] or {}
addon['preloads'] = addon['preloads'] or {}
addon['logouts'] = addon['logouts'] or {}
addon['qtip'] = LibStub('LibQTip-1.0')

local function embed(major, funclist,lib)
	local base = LibStub:GetLibrary(major, false)
	base['addons'] = base['addons'] or {}
	base['addons'][addon] = true
	if(lib) then
		for i= 1,#funclist do -- update lib
			base[funclist[i]] = lib[funclist[i]]
		end
		for v in pairs(base['addons']) do -- update embeded addons
			for i= 1,#funclist do
				v[funclist[i]] = base[funclist[i]]
			end
		end
	else
		for i= 1,#funclist do
			addon[funclist[i]] = base[funclist[i]]
		end
	end
end

addon['LibInit'] = function(major, minor, funclist)
	local lib = LibStub:NewLibrary(major, minor)
	if not lib then
		embed(major, funclist)
		return nil
	end
	return function(lib) embed(major, funclist,lib) end
end
