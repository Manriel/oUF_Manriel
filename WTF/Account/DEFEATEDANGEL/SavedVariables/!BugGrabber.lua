
BugGrabberDB = {
	["session"] = 1628,
	["lastSanitation"] = 3,
	["errors"] = {
		{
			["message"] = "Interface\\FrameXML\\SecureStateDriver.lua:11: attempt to concatenate local 'values' (a boolean value)",
			["time"] = "2014/11/26 19:14:44",
			["locals"] = "(*temporary) = <function> defined =[C]:-1\n",
			["stack"] = "Interface\\FrameXML\\SecureStateDriver.lua:11: in function <Interface\\FrameXML\\SecureStateDriver.lua:8>\n(tail call): ?\n...rface\\AddOns\\m_ActionBars\\elements\\ActionBarsLib.lua:186: in function `SetVisibility'\nInterface\\AddOns\\m_ActionBars\\ActionBars.lua:175: in main chunk",
			["session"] = 1565,
			["counter"] = 1,
		}, -- [1]
		{
			["message"] = "Interface\\AddOns\\m_ActionBars\\ActionBars.lua:109: attempt to index field 'ExtraButton' (a nil value)",
			["time"] = "2014/11/26 20:24:34",
			["locals"] = "",
			["stack"] = "Interface\\AddOns\\m_ActionBars\\ActionBars.lua:109: in main chunk",
			["session"] = 1593,
			["counter"] = 1,
		}, -- [2]
		{
			["message"] = "Interface\\AddOns\\m_ActionBars\\ActionBars.lua:86: attempt to index local 'btn' (a nil value)",
			["time"] = "2014/11/26 20:24:35",
			["locals"] = "",
			["stack"] = "Interface\\AddOns\\m_ActionBars\\ActionBars.lua:86: in function <Interface\\AddOns\\m_ActionBars\\ActionBars.lua:41>",
			["session"] = 1593,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = "Interface\\AddOns\\Recount\\GUI_Main.lua:596: attempt to index field '?' (a nil value)",
			["time"] = "2014/11/26 20:24:35",
			["locals"] = "self = <table> {\n SetMainWindowModeByLabel = <function> defined @Interface\\AddOns\\Recount\\Recount_Modes.lua:685\n ResetData = <function> defined @Interface\\AddOns\\Recount\\Recount.lua:926\n ResetPositionAllWindows = <function> defined @Interface\\AddOns\\Recount\\WindowOrder.lua:129\n modules = <table> {\n }\n FormatLongNums = <function> defined @Interface\\AddOns\\Recount\\GUI_Main.lua:80\n srcRetention = false\n SpellBuildingDamage = <function> defined @Interface\\AddOns\\Recount\\Tracker.lua:513\n FlagSync = <function> defined @Interface\\AddOns\\Recount\\LazySync.lua:516\n GetInheritGuardian = <function> defined @Interface\\AddOns\\Recount\\Recount.lua:1314\n UnregisterTracking = <function> defined @Interface\\AddOns\\Recount\\Tracker.lua:2336\n CheckPartyCombatWithPets = <function> defined @Interface\\AddOns\\Recount\\roster.lua:18\n InitFightData = <function> defined @Interface\\AddOns\\Recount\\Recount.lua:1066\n RequestVersion = <function> defined @Interface\\AddOns\\Recount\\LazySync.lua:577\n SpellAuraRefresh = <function> defined @Interface\\AddOns\\Recount\\Tracker.lua:743\n UpdateZoneGroupFilter = <function> defined @Interface\\AddOns\\Recount\\zonefilters.lua:78\n BossFound = <function> defined @Interface\\AddOns\\Recount\\Tracker.lua:1590\n InGroup = <function> defined @Interface\\AddOns\\Recount\\Recount.lua:1376\n MergedPetHealingDPS = <function> defined @Interface\\AddOns\\Recount\\Recount_Modes.lua:306\n SetStrataAndClamp = <function> defined @Interface\\AddOns\\Recount\\WindowOrder.lua:163\n ShortNumber = <function> defined @Interface\\AddOns\\Recount\\GUI_Main.lua:51\n FreeTableRecurse = <function> defined @Interface\\AddOns\\Recount\\Recount.lua:2195\n FreeComm = <function> defined @Interface\\AddOns\\Recount\\LazySync.lua:512\n db = <table> {\n }\n SetZoneGroupFilter = <function> defined @Interface\\AddOns\\Recount\\zonefilters.lua:56\n UnregisterAllComm = <function> defined @Interface\\AddOns\\ArkInventory\\Externals\\curse\\svn\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n SetWindowTop = <function> defined @Interface\\AddOns\\Recount\\WindowOrder.lua:45\n ReportVersions = <function> defined @Interface\\AddOns\\Recount\\Recount.lua:894\n CreateColorDropdown = <function> defined @Interface\\AddOns\\Recount\\GUI_Realtime.lua:168\n ResetFightData = <function> defined @Interface\\AddOns\\Recount\\Recount.lua:1009\n SpellMissed = <function> defined @Interface\\AddOns\\Recount\\Tracker.lua:620\n SetDeathLogDetails = <function> defined @Interface\\AddOns\\Recount\\GUI_Detail.lua:481\n FindTargetedUnit = <function> defined @Interface\\AddOns\\Recount\\roster.lua:99\n SpellAuraRemoved = <function> defined @Interface\\AddOns\\Recount\\Tracker.lua:785\n NewModule = <function> defined @Interface\\AddOns\\ArkInventory\\Externals\\curse\\svn\\Ace3-AceAddon\\AceAddon-3.0.lua:266\n IsBoss = <function> defined @Interface\\AddOns\\Recount\\Tracker.lua:398\n GetLazySyncAmount = <function> defined @Interface\\AddOns\\Recount\\LazySync.lua:609\n CreateFilterWeights = <function> defined @Interface\\AddOns\\Recount\\Recount.lua:1664\n UpdateSummaryMode = <function> defined @Interface\\AddOns\\Recount\\GUI_Detail.lua:1408\n SpellEnergize = <function> defined @Interface\\AddOns\\Recount\\TrackerModules\\TrackerModule_PowerGains.lua:58\n AddGain = <function> defined @Interface\\AddOns\\Recount\\TrackerModules\\TrackerModule_PowerGains.lua:67\n Deserialize = <function> defined @Interface\\AddOns\\BugSack\\Libs\\AceSerializer-3.0\\AceSerializer-3.0.lua:242\n AddDispelData = <function> defined @Interface\\AddOns\\Recount\\TrackerModules\\TrackerModule_Dispels.lua:44\n CheckFontStringLength = <function> defined @Interface\\AddOns\\Recount\\GUI_Graph.lua:749\n GetPetPrefixUnit = <function> defined @Interface\\AddOns\\Recount\\roster.lua:75\n GetName = <function> defined @Interface\\AddOns\\ArkInventory\\Externals\\curse\\svn\\Ace3-AceAddon\\AceAddon-3.0.lua:310\n SetActive = <function> defined @Interface\\AddOns\\Recount\\Tracker.lua:1076\n Colors = <table> {\n }\n CreateRealtimeWindow = <function> defined @Interface\\AddOns\\Recount\\GUI_Realtime.lua:386\n GetLazySyncTouched = <function> defined @Interface\\AddOns\\Recount\\LazySync.lua:616\n AddGuessedAbsorbData = <function> defined @Interface\\AddOns\\Recount\\Tracke",
			["stack"] = "Interface\\AddOns\\Recount\\GUI_Main.lua:596: in function `ResizeMainWindow'\nInterface\\AddOns\\Recount\\Recount-v6.0.3c release.lua:1949: in function `?'\n...y\\Externals\\curse\\svn\\Ace3-AceTimer\\AceTimer-3.0-17.lua:53: in function <...y\\Externals\\curse\\svn\\Ace3-AceTimer\\AceTimer-3.0.lua:48>",
			["session"] = 1593,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "Interface\\FrameXML\\ChatFrame.lua:3996: attempt to perform arithmetic on a nil value",
			["time"] = "2014/11/26 20:09:47",
			["locals"] = "self = ChatFrame1EditBox {\n focusMid = ChatFrame1EditBoxFocusMid {\n }\n headerSuffix = ChatFrame1EditBoxHeaderSuffix {\n }\n focusLeft = ChatFrame1EditBoxFocusLeft {\n }\n focusRight = ChatFrame1EditBoxFocusRight {\n }\n language = \"всеобщий\"\n chatLanguage = \"всеобщий\"\n tabCompleteTableIndex = 1\n 0 = <userdata>\n chatFrame = ChatFrame1 {\n }\n addSpaceToAutoComplete = true\n addHighlightedText = true\n languageID = 7\n header = ChatFrame1EditBoxHeader {\n }\n}\n",
			["stack"] = "Interface\\FrameXML\\ChatFrame.lua:3996: in function `ChatEdit_UpdateHeader'\nInterface\\FrameXML\\ChatFrame.lua:3676: in function `ChatEdit_ResetChatType'\nInterface\\FrameXML\\ChatFrame.lua:3657: in function `ChatEdit_OnShow'\n[string \"*:OnShow\"]:1: in function <[string \"*:OnShow\"]:1>\n[C]: in function `Show'\nInterface\\FrameXML\\ChatFrame.lua:3714: in function `ChatEdit_ActivateChat'\nInterface\\FrameXML\\ChatFrame.lua:3353: in function `ChatFrame_OpenChat'\n[string \"OPENCHAT\"]:1: in function <[string \"OPENCHAT\"]:1>",
			["session"] = 1593,
			["counter"] = 9,
		}, -- [5]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'oUF_Manriel_UI' пытался вызвать защищенную функцию 'MultiBarBottomLeftButton11:Show()'.",
			["time"] = "2014/11/27 22:21:21",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `Show'\nInterface\\FrameXML\\ActionButton.lua:301: in function <Interface\\FrameXML\\ActionButton.lua:275>\n[C]: ?\n[C]: in function `ActionButton_Update'\nInterface\\FrameXML\\ActionButton.lua:577: in function `ActionButton_OnEvent'\nInterface\\FrameXML\\ActionButton.lua:137: in function <Interface\\FrameXML\\ActionButton.lua:134>",
			["session"] = 1601,
			["counter"] = 1,
		}, -- [6]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'oUF_Manriel_UI' пытался вызвать защищенную функцию 'ActionButton4:Show()'.",
			["time"] = "2014/11/28 17:25:36",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `Show'\nInterface\\FrameXML\\ActionButton.lua:301: in function <Interface\\FrameXML\\ActionButton.lua:275>\n[C]: ?\n[C]: in function `ActionButton_Update'\nInterface\\FrameXML\\ActionButton.lua:263: in function `ActionButton_UpdateAction'\nInterface\\FrameXML\\ActionBarController.lua:138: in function `ActionBarController_ResetToDefault'\nInterface\\FrameXML\\ActionBarController.lua:127: in function `ActionBarController_UpdateAll'\nInterface\\FrameXML\\ActionBarController.lua:56: in function <Interface\\FrameXML\\ActionBarController.lua:45>\n[C]: in function `ChangeActionBarPage'\n[string \"ACTIONPAGE1\"]:1: in function <[string \"ACTIONPAGE1\"]:1>",
			["session"] = 1604,
			["counter"] = 1,
		}, -- [7]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'Stubby' пытался вызвать защищенную функцию 'CompactRaidFrame1:ClearAllPoints()'.",
			["time"] = "2014/11/28 17:30:11",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `ClearAllPoints'\nInterface\\FrameXML\\FlowContainer.lua:157: in function `FlowContainer_DoLayout'\nInterface\\FrameXML\\FlowContainer.lua:17: in function `FlowContainer_ResumeUpdates'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:185: in function `CompactRaidFrameContainer_LayoutFrames'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:130: in function `CompactRaidFrameContainer_TryUpdate'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:57: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 1604,
			["counter"] = 1,
		}, -- [8]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'oUF_Manriel_UI' пытался вызвать защищенную функцию 'MultiBarBottomLeft:Show()'.",
			["time"] = "2014/11/28 18:34:23",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `Show'\nInterface\\FrameXML\\MultiActionBars.lua:37: in function `MultiActionBar_Update'\nInterface\\FrameXML\\ActionBarController.lua:162: in function `ValidateActionBarTransition'\nInterface\\FrameXML\\ActionBarController.lua:130: in function `ActionBarController_UpdateAll'\nInterface\\FrameXML\\ActionBarController.lua:56: in function <Interface\\FrameXML\\ActionBarController.lua:45>",
			["session"] = 1609,
			["counter"] = 2,
		}, -- [9]
		{
			["message"] = "...terface\\AddOns\\ManyItemTooltips\\ManyItemTooltips.lua:75: script ran too long",
			["time"] = "2014/12/02 01:49:30",
			["locals"] = "(*temporary) = \"journal:0:476:0\"\n(*temporary) = \"|cff66bbff|Hjournal:0:476:0|h[Небесный Путь]|h|r\"\n(*temporary) = \"LeftButton\"\n(*temporary) = ChatFrame1 {\n 0 = <userdata>\n isUninteractable = false\n flashTimer = 0\n isInitialized = 1\n mouseOutTime = 0\n tellTimer = 38048.152\n hasBeenFaded = true\n resizeButton = ChatFrame1ResizeButton {\n }\n buttonFrame = ChatFrame1ButtonFrame {\n }\n oldAlpha = 0\n channelList = <table> {\n }\n defaultLanguage = \"всеобщий\"\n clickAnywhereButton = ChatFrame1ClickAnywhereButton {\n }\n isStaticDocked = true\n mouseInTime = 0\n editBox = ChatFrame1EditBox {\n }\n isDocked = 1\n isLocked = true\n name = \"Gen\"\n checkedGMOTD = true\n buttonSide = \"left\"\n zoneChannelList = <table> {\n }\n AddMessage = <function> defined @Interface\\AddOns\\BasicChatMods\\BasicCore.lua:70\n messageTypeList = <table> {\n }\n}\n = <function> defined @Interface\\AddOns\\ManyItemTooltips\\ManyItemTooltips.lua:64\n = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\modules\\tooltip.lua:134\n",
			["stack"] = "...terface\\AddOns\\ManyItemTooltips\\ManyItemTooltips.lua:75: in function <...terface\\AddOns\\ManyItemTooltips\\ManyItemTooltips.lua:64>\n[C]: ?\n...ace\\AddOns\\Blizzard_CombatLog\\Blizzard_CombatLog.lua:3593: in function <...ace\\AddOns\\Blizzard_CombatLog\\Blizzard_CombatLog.lua:3537>\n[C]: in function `SetItemRef'\nInterface\\FrameXML\\ChatFrame.lua:3339: in function <Interface\\FrameXML\\ChatFrame.lua:3338>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: in function `ChatFrame_OnHyperlinkShow'\n[string \"*:OnHyperlinkClick\"]:1: in function <[string \"*:OnHyperlinkClick\"]:1>",
			["session"] = 1618,
			["counter"] = 1,
		}, -- [10]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'ACP' пытался вызвать защищенную функцию 'CompactRaidFrame1:ClearAllPoints()'.",
			["time"] = "2014/12/03 21:54:23",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `ClearAllPoints'\nInterface\\FrameXML\\FlowContainer.lua:157: in function `FlowContainer_DoLayout'\nInterface\\FrameXML\\FlowContainer.lua:17: in function `FlowContainer_ResumeUpdates'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:185: in function `CompactRaidFrameContainer_LayoutFrames'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:130: in function `CompactRaidFrameContainer_TryUpdate'\n...actRaidFrames\\Blizzard_CompactRaidFrameContainer.lua:57: in function `CompactRaidFrameContainer_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 1622,
			["counter"] = 1,
		}, -- [11]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'oUF_Manriel_UI' пытался вызвать защищенную функцию 'ExtraBarButton12:Show()'.",
			["time"] = "2014/11/30 00:24:28",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `Show'\nInterface\\FrameXML\\ActionButton.lua:301: in function <Interface\\FrameXML\\ActionButton.lua:275>\n[C]: ?\n[C]: in function `ActionButton_Update'\nInterface\\FrameXML\\ActionButton.lua:577: in function `ActionButton_OnEvent'\nInterface\\FrameXML\\ActionButton.lua:137: in function <Interface\\FrameXML\\ActionButton.lua:134>",
			["session"] = 1627,
			["counter"] = 3,
		}, -- [12]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'm_ActionBars' пытался вызвать защищенную функцию 'RaidIconBar_holder:Hide()'.",
			["time"] = "2014/11/28 17:11:48",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `Hide'\nInterface\\AddOns\\m_ActionBars\\elements\\RaidMark.lua:147: in function <Interface\\AddOns\\m_ActionBars\\elements\\RaidMark.lua:146>",
			["session"] = 1628,
			["counter"] = 7,
		}, -- [13]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'oUF_Manriel_UI' пытался вызвать защищенную функцию 'ExtraBarButton11:Show()'.",
			["time"] = "2014/12/05 17:38:39",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `Show'\nInterface\\FrameXML\\ActionButton.lua:301: in function <Interface\\FrameXML\\ActionButton.lua:275>\n[C]: ?\n[C]: in function `ActionButton_Update'\nInterface\\FrameXML\\ActionButton.lua:577: in function `ActionButton_OnEvent'\nInterface\\FrameXML\\ActionButton.lua:137: in function <Interface\\FrameXML\\ActionButton.lua:134>",
			["session"] = 1628,
			["counter"] = 1,
		}, -- [14]
	},
}
