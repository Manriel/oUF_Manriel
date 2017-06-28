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

local PutInEditbox = function(text)
	local data = {
		url = text
	}

	StaticPopup_Show("WOWHEAD_LINK", 'Wowhead link', '', data);
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
    local questID = block.id;

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

StaticPopupDialogs["WOWHEAD_LINK"] = {
    OnShow = function (self, data)
        self.editBox:SetText(data.url)
        self.editBox:HighlightText()
    end,
    text = '%s',
    button1 = OKAY,
    editBoxWidth = 350,
    hasEditBox=true,
    preferredIndex = 3
}