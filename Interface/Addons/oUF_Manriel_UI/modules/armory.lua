local parent, ns = ...
local UI = ns.ManrielUI
local LSM = UI.lib.LSM
local arStrings = UI.localeStrings

local A = ns.A

--	Armory link on right click player
local realmName = string.lower(GetRealmName())
local realmLocale = GetLocale()
local lang = "en"
local region = "eu"

realmName = realmName:gsub("'", "")
realmName = realmName:gsub(" ", "-")

-- see http://us.battle.net/wow/en/forum/topic/2878487920

if realmLocale == "enUS" or realmLocale == "es_MX" then
	region = "us"
end
if realmLocale == "enGB" or realmLocale == "esES" or realmLocale == "frFR" or realmLocale == "ruRU" or realmLocale == "deDE" then
	region = "eu"
end
if realmLocale == "koKR" then
	region = "kr"
end
if realmLocale == "zhTW" then
	region = "tw"
end
if realmLocale == "zhCN" then
	region = "cn"
end

if realmLocale == "ruRU" then
	lang = "ru"
elseif realmLocale == "frFR" then
	lang = "fr"
elseif realmLocale == "deDE" then
	lang = "de"
elseif realmLocale == "esES" or realmLocale == "esMX" then
	lang = "es"
elseif realmLocale == "ptBR" or realmLocale == "ptPT" then
	lang = "pt"
elseif realmLocale == "itIT" then
	lang = "it"
elseif realmLocale == "zhTW" then
	lang = "zh"
elseif realmLocale == "koKR" then
	lang = "kr"
elseif realmLocale == "zhCN" then
	lang = "zh"
else
	lang = "en"
end

local PutInEditbox = function(txt)
	local frame = _G["BCM_URLCopyFrame"]
	if frame then
		frame.editBox:SetText(txt)
		frame.editBox:HighlightText()
		frame:Show()
	else
		local editbox = LAST_ACTIVE_CHAT_EDIT_BOX
		editbox:SetText(txt)
		editbox:HighlightText()
		editbox:Show()
		editbox:SetFocus()
	end
end

-- Dropdown menu link
hooksecurefunc("UnitPopup_OnClick", function(self)
	local dropdownFrame = UIDROPDOWNMENU_INIT_MENU
	local name = dropdownFrame.name
	if name and self.value == "ARMORYLINK" then
		if region == "us" then
			linkurl = "http://"..region..".battle.net/wow/"..lang.."/character/"..realmName.."/"..name.."/advanced"
			PutInEditbox(linkurl)
			return
		elseif region == "eu" then
			linkurl = "http://"..region..".battle.net/wow/"..lang.."/character/"..realmName.."/"..name.."/advanced"
			PutInEditbox(linkurl)
			return
		elseif region == "tw" then
			linkurl = "http://"..region..".battle.net/wow/"..lang.."/character/"..realmName.."/"..name.."/advanced"
			PutInEditbox(linkurl)
			return
		elseif region == "kr" then
			linkurl = "http://"..region..".battle.net/wow/"..lang.."/character/"..realmName.."/"..name.."/advanced"
			PutInEditbox(linkurl)
			return
		elseif region == "cn" then
			linkurl = "http://www.battlenet.com.cn/wow/"..lang.."/character/"..realmName.."/"..name.."/advanced"
			PutInEditbox(linkurl)
			return
		else
			print("|cFFFFFF00".. arStrings.unsupportedRealm .."|r")
			return
		end
	end
end)

UnitPopupButtons["ARMORYLINK"] = {text = arStrings.armoryLink, dist = 0, func = UnitPopup_OnClick}
table.insert(UnitPopupMenus["FRIEND"], #UnitPopupMenus["FRIEND"] - 1, "ARMORYLINK")
table.insert(UnitPopupMenus["PARTY"], #UnitPopupMenus["PARTY"] - 1, "ARMORYLINK")
table.insert(UnitPopupMenus["RAID"], #UnitPopupMenus["RAID"] - 1, "ARMORYLINK")
table.insert(UnitPopupMenus["PLAYER"], #UnitPopupMenus["PLAYER"] - 1, "ARMORYLINK")