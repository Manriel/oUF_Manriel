local name, addon = ...
local parentName = addon['parentName'] or "BrokerPack"
local childName = "zz_Friends"
local crealm = GetRealmName()
local defaults = {
}
local options = {
}
local roster,friendroster,bnetroster = {}, {}, {}

local updateDelay = 15
local fmt = "|c0000ff00%s|r |c00ffffff%s|r"
local db = {}
local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local ldbicon = LibStub("LibDBIcon-1.0")
local function anymod()
	return IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown()
end

local function ldbOnClick(self, button)
	if(IsInGuild() and not anymod() and button == "LeftButton") then
		ToggleGuildFrame()
	elseif(not anymod() and (button == "LeftButton" or button == "RightButton")) then
		ToggleFriendsFrame()
	elseif(IsShiftKeyDown() and button == "LeftButton") then
		addon['db']['global']['ldbicons'][childName]['hide'] = not addon['db']['global']['ldbicons'][childName]['hide']
		if(ldbicon) then
			if(addon['db']['global']['ldbicons'][childName]['hide']) then 
				ldbicon:Hide(childName)
			else
				ldbicon:Show(childName)
			end
		end
	end
end

local function OnTooltipShow(tip)
	local zztip = type(tip.AddHeader) == 'function' and tip:AddHeader(childName) or tip:AddLine(childName)
	tip:AddLine("")
	tip:AddLine(format(fmt,"Leftclick","Toggles Guild or Friendframe"))
	tip:AddLine(format(fmt,"Rightclick","Toggles Friendframe"))
	tip:AddLine(format(fmt,"Shift+Leftclick","Toggles minimap icon"))
end

local function OnText(message)
	addon['OnText'](childName, message)
end

local function count(v)
	local c = 0
	for _ in pairs(v) do
		c = c + 1
	end
	return c
end
local function BNGetToonInfo(...)
	print(...)
	return ...
end
local function checkRoster(self, event, ...)
	local newroster = {}
	local rostername, online, _
	local dontShow = false

	if(event == "GUILD_ROSTER_UPDATE") then
		for i=1,GetNumGuildMembers() do
			rostername, _, _, _, _, _, _, _, online = GetGuildRosterInfo(i)
			if(online and rostername) then
				newroster[rostername]=true
			end
		end
		roster = newroster
	elseif(event == "FRIENDLIST_UPDATE") then
		for i = 1, GetNumFriends() do
			rostername, _, _, _, online, _, _ = GetFriendInfo(i)
			if(online and rostername) then
				newroster[rostername]=true
			end
		end
		friendroster = newroster
	elseif(event == "BN_FRIEND_TOON_ONLINE" or event == "BN_FRIEND_TOON_OFFLINE") then
		local _, numOnline = BNGetNumFriends()
		local presenceID, isFriend,client,accid
		for i = 1, numOnline do
			dontShow = false
			presenceID, _, _, _, rostername, accid, client, online, _, _, _, _, _, isFriend, _, _ = BNGetFriendInfo(i)
			if(client == BNET_CLIENT_WOW) then
				local _, toonName, game, realmName,realmID = BNGetGameAccountInfo(accid)
				if(realmName == crealm and friendroster[toonName]) then
					dontShow = true
				end
			end
			if(online and rostername and not dontShow) then
				newroster[rostername]=true
			end
		end
		bnetroster = newroster
	end
	local afkmsg = ""
	if(UnitIsAFK("player")) then
		afkmsg = " AFK"
	elseif(UnitIsDND("player")) then
		afkmsg = " DND"
	end
	OnText(format("|c0000ff00%i|r/|c0000ffff%i|r|c00ff0000%s|r", count(roster),count(friendroster)+count(bnetroster),afkmsg))
end

local function OnUpdate()
	GuildRoster()
	checkRoster(nil, "FRIENDLIST_UPDATE")
	checkRoster(nil, "BN_FRIEND_TOON_ONLINE")
	C_Timer.After(updateDelay, OnUpdate)
end

local function init()
	options = addon['InitConfig'](addon, childName, true, {
		['name'] = childName,
		['type'] = "data source",
		['OnTooltipShow'] = OnTooltipShow,
		['OnClick'] = ldbOnClick,
	})
	db = addon['db']['profile'][childName]
	crealm = GetRealmName()
	addon['RegisterFunc']({"GUILD_ROSTER_UPDATE","FRIENDLIST_UPDATE","CHAT_MSG_CHANNEL_JOIN","CHAT_MSG_CHANNEL_LEAVE","PLAYER_FLAGS_CHANGED","UNIT_FLAGS","BN_FRIEND_TOON_ONLINE","BN_FRIEND_TOON_OFFLINE"},"OnEvent", checkRoster)
	C_Timer.After(updateDelay, OnUpdate)
end

addon['startup'](addon, name, childName, init, true, defaults)
