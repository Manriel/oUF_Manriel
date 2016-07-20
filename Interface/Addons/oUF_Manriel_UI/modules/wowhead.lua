local parent, ns = ...
local UI = ns.ManrielUI
local arStrings = UI.localeStrings

local function getWowheadDomain()
	local lang = GetLocale()
	lang = lang:sub(1,2)
	if 	lang == 'ru' or
		lang == 'de' or
		lang == 'es' or
		lang == 'fr' or
		lang == 'it' or
		lang == 'pt'
			then
		return lang..".wowhead.com"
	else
		return "www.wowhead.com"
	end
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

local function Quest_ShowOnWowhead(questID)
	if questID > 0 then
		local domain = getWowheadDomain()
		linkurl = 'http://'..domain..'/quest='..questID..'#comments'
		PutInEditbox(linkurl)
	end
end

hooksecurefunc("QuestObjectiveTracker_OnOpenDropDown", function(self)
	local block = self.activeFrame;
    local questLogIndex = block.questLogIndex;
    local questID = select(8, GetQuestLogTitle(questLogIndex));

	local info = UIDropDownMenu_CreateInfo();
	info.isNotRadio = true;
	info.notCheckable = true;

	info.text = arStrings['wowheadQuestLink'];
	info.func = function(_, questID) Quest_ShowOnWowhead(questID) end;
	info.arg1 = questID;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end)

hooksecurefunc("QuestMapQuestOptionsDropDown_Initialize", function(...)
	local self = ...
	local questID = self.questID

	local info = UIDropDownMenu_CreateInfo();
	info.isNotRadio = true;
	info.notCheckable = true;

	info.text = arStrings['wowheadQuestLink'];
	info.func = function(_, questID) Quest_ShowOnWowhead(questID) end;
	info.arg1 = self.questID;
	UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);
end)