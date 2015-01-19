
BugGrabberDB = {
	["lastSanitation"] = 3,
	["session"] = 2055,
	["errors"] = {
		{
			["message"] = "[string \"SetRaidTargetIcon(«target», 8);\"]:1: unexpected symbol near '�'",
			["time"] = "2015/01/17 15:30:18",
			["locals"] = "msg = \"SetRaidTargetIcon(«target», 8);\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2091: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4387: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4041: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2686: in function <Interface\\FrameXML\\ChatFrame.lua:2679>\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:348: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:649: in function `SecureActionButton_OnClick'\n[string \"*:OnClick\"]:2: in function <[string \"*:OnClick\"]:1>",
			["session"] = 2049,
			["counter"] = 2,
		}, -- [1]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'oUF_Manriel_UI' пытался вызвать защищенную функцию 'ActionButton6:Show()'.",
			["time"] = "2015/01/17 15:33:27",
			["locals"] = "",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:589: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:589>\n[C]: in function `Show'\nInterface\\FrameXML\\ActionButton.lua:301: in function `ActionButton_Update'\nInterface\\FrameXML\\ActionButton.lua:263: in function `ActionButton_UpdateAction'\nInterface\\FrameXML\\ActionBarController.lua:138: in function `ActionBarController_ResetToDefault'\nInterface\\FrameXML\\ActionBarController.lua:127: in function `ActionBarController_UpdateAll'\nInterface\\FrameXML\\ActionBarController.lua:56: in function <Interface\\FrameXML\\ActionBarController.lua:45>\n[C]: in function `ChangeActionBarPage'\n[string \"ACTIONPAGE1\"]:1: in function <[string \"ACTIONPAGE1\"]:1>",
			["session"] = 2049,
			["counter"] = 1,
		}, -- [2]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'Recount' пытался вызвать защищенную функцию 'CompactRaidFrame5:Show()'.",
			["time"] = "2015/01/17 15:44:19",
			["locals"] = "",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:589: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:589>\n[C]: in function `Show'\nInterface\\FrameXML\\CompactUnitFrame.lua:290: in function `CompactUnitFrame_UpdateVisible'\nInterface\\FrameXML\\CompactUnitFrame.lua:248: in function `CompactUnitFrame_UpdateAll'\nInterface\\FrameXML\\CompactUnitFrame.lua:100: in function <Interface\\FrameXML\\CompactUnitFrame.lua:47>",
			["session"] = 2049,
			["counter"] = 1,
		}, -- [3]
		{
			["message"] = "Interface\\AddOns\\ArkInventory\\ArkInventory-3.04.19.lua:26: Cannot find a library instance of \"LibDataBroker-1.1\".",
			["time"] = "2015/01/19 21:59:47",
			["locals"] = "self = <table> {\n NewLibrary = <function> defined @Interface\\AddOns\\!Swatter\\Support\\LibStub.lua:11\n minors = <table> {\n }\n minor = 2\n IterateLibraries = <function> defined @Interface\\AddOns\\!Swatter\\Support\\LibStub.lua:28\n GetLibrary = <function> defined @Interface\\AddOns\\!Swatter\\Support\\LibStub.lua:21\n libs = <table> {\n }\n}\nmajor = \"LibDataBroker-1.1\"\nsilent = nil\n",
			["stack"] = "[C]: in function `error'\nInterface\\AddOns\\!Swatter\\Support\\LibStub.lua:23: in function `LibStub'\nInterface\\AddOns\\ArkInventory\\ArkInventory-3.04.19.lua:26: in main chunk",
			["session"] = 2053,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "...erface\\AddOns\\ArkInventory\\ArkInventoryCompanion.lua:14: attempt to index field 'Const' (a nil value)",
			["time"] = "2015/01/19 21:59:47",
			["locals"] = "",
			["stack"] = "...erface\\AddOns\\ArkInventory\\ArkInventoryCompanion.lua:14: in main chunk",
			["session"] = 2053,
			["counter"] = 1,
		}, -- [5]
		{
			["message"] = "...nterface\\AddOns\\ArkInventory\\ArkInventoryStorage.lua:76: attempt to index field 'Table' (a nil value)",
			["time"] = "2015/01/19 21:59:47",
			["locals"] = "",
			["stack"] = "...nterface\\AddOns\\ArkInventory\\ArkInventoryStorage.lua:76: in main chunk",
			["session"] = 2053,
			["counter"] = 1,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\ArkInventory\\ArkInventoryMoney.lua:2: attempt to index field 'Const' (a nil value)",
			["time"] = "2015/01/19 21:59:47",
			["locals"] = "",
			["stack"] = "Interface\\AddOns\\ArkInventory\\ArkInventoryMoney.lua:2: in main chunk",
			["session"] = 2053,
			["counter"] = 1,
		}, -- [7]
		{
			["message"] = "[string \"<unnamed>:OnLoad\"]:1: attempt to call field 'OnLoad' (a nil value)",
			["time"] = "2015/01/19 21:59:47",
			["locals"] = "",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 2053,
			["counter"] = 1,
		}, -- [8]
		{
			["message"] = "[string \"ARKINV_Frame1SearchFilter:OnLoad\"]:1: attempt to index field 'Localise' (a nil value)",
			["time"] = "2015/01/19 21:59:47",
			["locals"] = "",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 2053,
			["counter"] = 1,
		}, -- [9]
		{
			["message"] = "[string \"ARKINV_Frame1ScrollContainer:OnLoad\"]:1: attempt to call field 'Frame_Container_OnLoad' (a nil value)",
			["time"] = "2015/01/19 21:59:47",
			["locals"] = "",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 2053,
			["counter"] = 1,
		}, -- [10]
		{
			["message"] = "[string \"ARKINV_Frame1StatusGold:OnLoad\"]:1: attempt to call field 'SmallMoneyFrame_OnLoad' (a nil value)",
			["time"] = "2015/01/19 21:59:47",
			["locals"] = "",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 2053,
			["counter"] = 1,
		}, -- [11]
		{
			["message"] = "[string \"ARKINV_Frame1:OnLoad\"]:1: attempt to call field 'Frame_Main_OnLoad' (a nil value)",
			["time"] = "2015/01/19 21:59:47",
			["locals"] = "",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 2053,
			["counter"] = 1,
		}, -- [12]
		{
			["message"] = "[string \"ARKINV_Frame1ChangerWindowBag1:OnLoad\"]:1: attempt to call field 'Frame_Changer_Slot_OnLoad' (a nil value)",
			["time"] = "2015/01/19 21:59:47",
			["locals"] = "",
			["stack"] = "[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 2053,
			["counter"] = 1,
		}, -- [13]
		{
			["message"] = "...erface\\AddOns\\ArkInventory\\ArkInventoryTranslate.lua:316: attempt to index field 'db' (a nil value)",
			["time"] = "2015/01/19 22:00:09",
			["locals"] = "",
			["stack"] = "...erface\\AddOns\\ArkInventory\\ArkInventoryTranslate.lua:316: in function <...erface\\AddOns\\ArkInventory\\ArkInventoryTranslate.lua:298>",
			["session"] = 2053,
			["counter"] = 7,
		}, -- [14]
	},
}
