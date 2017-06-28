local name, addon = ...

local embed = addon['LibInit']("zzCommon-Frames", 10, {'AddDrag','LoadFrame','GetFrameCoords','CreateSecureFrame'})
if(type(embed) ~= 'function') then return end
local base = LibStub('zzCommon-Frames')
base['frames'] = base['frames'] or {}

local round = addon['round'] or function(num, idp)
	return math.floor(num * (10^(idp or 0)) + 0.5) / (10^(idp or 0))
end

local function dragAble(self)
	return true
end

local defaults = {
	['parent'] = UIParent,
	['inherit'] = "SecureHandlerBaseTemplate SecureHandlerStateTemplate SecureHandlerEnterLeaveTemplate SecureHandlerMouseUpDownTemplate",
	['width'] = 30,
	['height'] = 30,
	['selfPoint'] = "CENTER",
	['relativTo'] = UIParent,
	['relativPoint'] = "CENTER",
	['xoff'] = 0,
	['yoff'] = 0,
	['dragAble'] = dragAble,
	['db'] = {},
}

local function setDefaultValues(self)
	if(not self['db'] and self['name'] and addon['db']) then
		addon['db']['profile'][self['name']] = addon['db']['profile'][self['name']] or {}
		addon['db']['profile'][self['name']]['points'] = addon['db']['profile'][self['name']]['points'] or {}
		self['db'] = addon['db']['profile'][self['name']]['points']
	end
	for k, v in pairs(defaults) do
		if(self[k] == nil) then
			self[k] = v
		end
	end
	return self
end

local function saveFrame(self)
	local db = self['db']
	local fn = self:GetName()
	db[fn] = db[fn] or {
		['xpos'] = 0,
		['ypos'] = 0,
	}
	local x, y = self:GetCenter() 
	local s = self:GetEffectiveScale()
	local uis = UIParent:GetScale()
	x = x*s - GetScreenWidth()*uis/2
	y = y*s - GetScreenHeight()*uis/2
	db[fn]['xpos'] = addon['round'](x/uis,0)
	db[fn]['ypos'] = addon['round'](y/uis,0)
end

local function loadFrame() end -- dummy

local schedules = {}
local scheduleframe = CreateFrame("Frame")
scheduleframe:SetScript("OnEvent", function(self, event)
	for i=1,#schedules do
		schedules[i]['func'](schedules[i]['frame'])
	end
	wipe(schedules)
	self:UnregisterEvent()
end)

local function addSchedule(self, func)
	schedules[#schedules + 1] = {
		['frame'] = self,
		['func'] = func,
	}
	if(#schedules == 1) then
		scheduleframe:RegisterEvent("PLAYER_REGEN_ENABLED")
	end
end

local function getCoords(self)
	local s = self:GetEffectiveScale()
	local uis = UIParent:GetScale()
	local fn = self:GetName()
	return self['db'][fn]['xpos']*uis/s, self['db'][fn]['ypos']*uis/s
end

loadFrame = function(self) -- local because of previous dummy
	if not self then return end
	if( InCombatLockdown() ) then
		addSchedule(self, loadFrame)
		return
	end
	self:SetMovable(true)
	local db = self['db']
	local fn = self:GetName()
	db[fn] = db[fn] or {
		['xpos'] = 0,
		['ypos'] = 0,
	}
	local x, y = getCoords(self)
	self:ClearAllPoints()
	self:SetPoint("CENTER", UIParent, "CENTER", x, y)
	self:SetUserPlaced(true)
end

local function dragView2(self)
	if(IsAltKeyDown() and self['dragAble']()) then
		self['tex']:SetTexture(0, .5, 0, .5)
	else
		self['tex']:SetTexture(0, 0, 0 , 0)
	end
end

local function storePoints(self)
	wipe(self['db'])
	for i = 1, self:GetNumPoints() do

		self['db'][#self['db'] + 1] = {self:GetPoint(i)}
		self['db'][#self['db']][2] = self['db'][#self['db']][2] and self['db'][#self['db']][2]:GetName() or "UIParent"
		self['db'][#self['db']][4] = round(self['db'][#self['db']][4])
		self['db'][#self['db']][5] = round(self['db'][#self['db']][5])
-- print("save", self:GetName(),self:GetPoint(i),self['db'][#self['db']][4],self['db'][#self['db']][5])
	end
end

local function restorePoints(self)
	if(#self['db']<1) then
		storePoints(self)
	end
	self:ClearAllPoints()
	for i = 1, #self['db'] do
		if(self['db'][i][2] == "UIParent") then
			self['db'][i][2] = UIParent
		end
--		print("load", self:GetName(),self['db'][i][1],_G[self['db'][i][2]],self['db'][i][3],self['db'][i][4],self['db'][i][5])
		self:SetPoint(self['db'][i][1],self['db'][i][2] == "UIParent" and UIParent or _G[self['db'][i][2]],self['db'][i][3],self['db'][i][4],self['db'][i][5])
	end
	
end
local function toggle(self)
	if(self:IsVisible()) then
		self:Hide()
	else
		self:Show()
	end
end

local function center(self)
	self:ClearAllPoints()
	self:SetPoint("Center", UIParent,"Center",0,0)
	saveFrame(self)
end

local function center2(self)
	self:ClearAllPoints()
	self:SetPoint("Center", UIParent,"Center",0,0)
	storePoints(self)
end

local function startMove(self)
	if InCombatLockdown() then return end
	if(self['locked']) then return end
	if(self['moveparent']) then
		self:GetParent():StartMoving()
		self:GetParent():SetUserPlaced(false)
	else
		self:StartMoving()
		self:SetUserPlaced(false)
	end
	
end

local function stopMove(self)
	if(self['moveparent']) then
		self:GetParent():StopMovingOrSizing()
		saveFrame(self:GetParent())
	else
		self:StopMovingOrSizing()
		saveFrame(self)
	end
end

local function startMove2(self)
	if(not self:dragAble()) then return end
	self:StartMoving()
	self:SetUserPlaced(false)
end

local function stopMove2(self)
	self:StopMovingOrSizing()
	storePoints(self)
end

local function dragView(self)
	if(IsAltKeyDown() and self:GetParent()['dragAble']() and not InCombatLockdown()) then
		self['tex']:SetTexture(0, .5, 0, .5)
		self:Show()
	else
		if(self:IsVisible()) then
			self['tex']:SetTexture(0, 1, 0 , 0)
			stopMove(self)
			self:Hide()
		end
	end
end
local function checkShow(self, elapsed)
	self['elapsed'] = self['elapsed'] + elapsed
	if(self['elapsed']>1) then
		dragView(self)
		self['elapsed'] = 0
	end
end
local lib = {
	['GetFrameCoords'] = function(self)
		return getCoords(self)
	end,
	['LoadFrame'] = function(self)
		loadFrame(self)
	end,
	['AddDrag'] = function(self,typ,tab)
		tab = tab or {
			['width'] = 32,
			['height'] = 32,
			['anchor'] = "BOTTOMLEFT",
			['parentanchor'] = "TOPLEFT",
			['xOffset'] = 0,
			['yOffset'] = 0,
			['offset'] = 16,
		}
		loadFrame(self)
		self['center'] = center
		self['toggle'] = toggle
		self['dragframe'] = self['dragframe'] or CreateFrame("Frame","$PARENTdrag",self)
		self['dragframe']['elapsed'] = 0
		self['dragframe']:SetFrameStrata("LOW")
		self:SetMovable(true)
		self['dragframe']:SetMovable(true)
		self['dragframe']:EnableMouse(true)
		self['dragframe'].moveparent = true
		self['dragframe']:SetScript("OnUpdate", checkShow)
		self['dragframe']:SetScript("OnMouseDown", startMove)
		self['dragframe']:SetScript("OnMouseUp", stopMove)
		if(typ == "BOX") then
			self['dragframe']:SetWidth(tab['width'])
			self['dragframe']:SetHeight(tab['height'])
			self['dragframe']:SetPoint(tab['anchor'], self, tab['parentanchor'], tab['xOffset'], tab['yOffset'])
		else
			local offset = tab['offset']
			self['dragframe']:ClearAllPoints()
			self['dragframe']:SetPoint("TOPLEFT", self, "TOPLEFT", -offset/2, offset/2)
			self['dragframe']:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", offset/2, -offset/2)
		end
		self['dragframe']['tex'] = self['dragframe']['tex'] or self['dragframe']:CreateTexture()
		self['dragframe']['tex']:SetAllPoints(self.dragframe)
		self['dragframe']['tex']:SetTexture(0,0,0,0)
		self['dragframe']:RegisterEvent("MODIFIER_STATE_CHANGED")
		self['dragframe']:SetScript("OnEvent",dragView)
		self['dragframe']:Hide()
	end,
	['CreateSecureFrame'] = function(fname)
		if(type(fname) == 'string') then fname = {['name'] = fname} end
		fname = setDefaultValues(fname)
		local f = CreateFrame("Frame", fname['name'], fname['parent'], fname['inherit'], fname['id']) 
		f:SetSize(fname['width'], fname['height'])
		f:SetPoint(fname['selfPoint'], fname['relativTo'], fname['relativPoint'], fname['xoff'], fname['yoff'])
		f['db'] = fname['db']
		f['center'] = center2
		f['toggle'] = toggle
		f['dragAble'] = fname['dragAble']
		f['tex'] = f:CreateTexture()
		f['tex']:SetAllPoints(f)
		f['tex']:SetTexture(0,0,0,0)
		f['tex']:SetDrawLayer("BACKGROUND")
		f:RegisterEvent("MODIFIER_STATE_CHANGED")
		f:SetScript("OnEvent",dragView2)
		f:SetMovable(true)
		f:EnableMouse(true)
		f:SetScript("OnMouseUp", stopMove2)
		f:SetScript("OnMouseDown", startMove2)
		restorePoints(f)
		base['frames'][#base['frames'] + 1] = f
		return f
	end,
}

embed(lib)