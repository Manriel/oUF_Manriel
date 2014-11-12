
BugGrabberDB = {
	["session"] = 1180,
	["lastSanitation"] = 3,
	["errors"] = {
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:90: invalid option in `format'",
			["time"] = "2014/11/12 02:04:18",
			["locals"] = "self = oUF_ManrielUITarget {\n 0 = <userdata>\n MasterLooter = <unnamed> {\n }\n PARTY_LOOT_METHOD_CHANGED = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\masterlooter.lua:73\n PLAYER_ENTERING_WORLD = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:149\n Leader = <unnamed> {\n }\n Race = <unnamed> {\n }\n UNIT_HEALTH_FREQUENT = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\health.lua:147\n UNIT_MAXHEALTH = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\health.lua:147\n __elements = <table> {\n }\n Power = oUF_Manriel_target_Power {\n }\n UNIT_POWER_BAR_SHOW = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\power.lua:191\n UNIT_COMBO_POINTS = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\cpoints.lua:70\n style = \"ManrielUI\"\n Lvl = <unnamed> {\n }\n RAID_TARGET_UPDATE = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\ricons.lua:58\n UNIT_CONNECTION = <table> {\n }\n UNIT_POWER = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\power.lua:191\n Class = <unnamed> {\n }\n Auras = oUF_Manriel_target_Auras {\n }\n GROUP_ROSTER_UPDATE = <table> {\n }\n PARTY_LEADER_CHANGED = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\leader.lua:53\n PvP = <unnamed> {\n }\n UNIT_AURA = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:314\n SmoothBar = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF_Smooth\\oUF_Smooth.lua:17\n UNIT_MAXPOWER = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\power.lua:191\n UNIT_DISPLAYPOWER = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\power.lua:191\n UNIT_FACTION = <table> {\n }\n Health = oUF_Manriel_target_Health {\n }\n CPoints = <table> {\n }\n unit = \"target\"\n Name = <unnamed> {\n }\n elite = oUF_Manriel_target_EliteTexture {\n }\n RaidIcon = <unnamed> {\n }\n UNIT_POWER_BAR_HIDE = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\power.lua:191\n PLAYER_TARGET_CHANGED = <table> {\n }\n UNIT_NAME_UPDATE = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:84\n}\nevent = nil\nunit = \"target\"\nconfig = <table> {\n offset = 4\n classification = <table> {\n }\n yPosition = 320\n textureBlizzardTooltip = \"Interface\\Tooltips\\UI-Tooltip-Background\"\n fontNamePixel = \"Interface\\AddOns\\oUF_Manriel_UI\\fonts\\Calibri.ttf\"\n xPosition = 170\n fontName = \"Interface\\AddOns\\oUF_Manriel_UI\\fonts\\CalibriBold.ttf\"\n width = 280\n textureGlow = \"Interface\\Addons\\oUF_Manriel_UI\\media\\glowTex\"\n textureRuneBar = \"Interface\\AddOns\\oUF_Manriel_UI\\textures\\rothTex\"\n textureBubble = \"Interface\\Addons\\oUF_Manriel_UI\\textures\\bubbleTex\"\n textureBorder = \"Interface\\AddOns\\oUF_Manriel_UI\\textures\\Caith\"\n height = 45\n textureHealthBar = \"Interface\\AddOns\\oUF_Manriel_UI\\textures\\Ruben\"\n textureCastBarBorder = \"Interface\\AddOns\\oUF_Manriel_UI\\textures\\panels-border16\"\n baseFontSize = 12\n}\ngetDifficultyColor = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:18\n",
			["stack"] = "[C]: in function `SetFormattedText'\nInterface\\AddOns\\oUF_Manriel_UI\\functions.lua:90: in function `UNIT_NAME_UPDATE'\nInterface\\AddOns\\oUF_Manriel_UI\\functions.lua:160: in function <Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:138>\n(tail call): ?\n(tail call): ?\nInterface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:158: in function <Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:149>\n(tail call): ?\n[C]: in function `Show'\nInterface\\FrameXML\\SecureStateDriver.lua:83: in function <Interface\\FrameXML\\SecureStateDriver.lua:73>\nInterface\\FrameXML\\SecureStateDriver.lua:137: in function <Interface\\FrameXML\\SecureStateDriver.lua:119>",
			["session"] = 1098,
			["counter"] = 7,
		}, -- [1]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:90: ')' expected near '='",
			["time"] = "2014/11/12 02:33:00",
			["locals"] = "",
			["stack"] = "",
			["session"] = 1109,
			["counter"] = 2,
		}, -- [2]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\core.lua:289: attempt to call upvalue 'setFontString' (a nil value)",
			["time"] = "2014/11/12 02:33:00",
			["locals"] = "unit = \"player\"\nstyle = \"ManrielUI\"\nstyleFunc = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\core.lua:254\nheader = nil\nnum = 1\n(for index) = 1\n(for limit) = 1\n(for step) = 1\ni = 1\nobject = oUF_ManrielUIPlayer {\n 0 = <userdata>\n style = \"ManrielUI\"\n UNIT_EXITED_VEHICLE = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:38\n UNIT_ENTERED_VEHICLE = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:38\n PLAYER_ENTERING_WORLD = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:149\n __elements = <table> {\n }\n unit = \"player\"\n}\nobjectUnit = \"player\"\nsuffix = nil\nframe_metatable = <table> {\n __index = <unnamed> {\n }\n}\nobjects = <table> {\n 1 = oUF_ManrielUIPlayer {\n }\n}\nupdateActiveUnit = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:38\nUpdatePet = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:175\nenableTargetUpdate = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:20\noUF = <table> {\n DisableBlizzard = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\blizzard.lua:44\n SetActiveStyle = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:324\n EnableFactory = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\factory.lua:38\n ColorGradient = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\colors.lua:59\n SpawnHeader = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:496\n RegisterStyle = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:314\n AddElement = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:560\n Factory = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\factory.lua:27\n RegisterMetaFunction = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:303\n Tags = <table> {\n }\n DisableFactory = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\factory.lua:42\n objects = <table> {\n }\n colors = <table> {\n }\n version = \"1.1.beta5\"\n RunFactoryQueue = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\factory.lua:46\n HandleUnit = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\units.lua:8\n RegisterInitCallback = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:299\n IterateStyles = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:337\n Spawn = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:541\n}\nPrivate = <table> {\n enableTargetUpdate = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:20\n UpdateUnits = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\events.lua:37\n colors = <table> {\n }\n argcheck = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\private.lua:4\n frame_metatable = <table> {\n }\n error = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\private.lua:20\n print = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\private.lua:16\n}\nOnAttributeChanged = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:74\nOnShow = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:169\nactiveElements = <table> {\n}\nelements = <table> {\n Totems = <table> {\n }\n Portrait = <table> {\n }\n ReadyCheck = <table> {\n }\n Range = <table> {\n }\n Resting = <table> {\n }\n Aura = <table> {\n }\n PhaseIcon = <table> {\n }\n PvP = <table> {\n }\n LFDRole = <table> {\n }\n Threat = <table> {\n }\n Leader = <table> {\n }\n Castbar = <table> {\n }\n ResurrectIcon = <table> {\n }\n HealPrediction = <table> {\n }\n AltPowerBar = <table> {\n }\n QuestIcon = <table> {\n }\n CPoints = <table> {\n }\n Combat = <table> {\n }\n Health = <table> {\n }\n Power = <table> {\n }\n Assistant = <table> {\n }\n MasterLooter = <table> {\n }\n ClassIcons = <table> {\n }\n RaidIcon = <table> {\n }\n}\ncallback = <table> {\n 1 = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF_Smooth\\oUF_Smooth.lua:22\n}\n",
			["stack"] = "Interface\\AddOns\\oUF_Manriel_UI\\core.lua:289: in function `styleFunc'\nInterface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:262: in function <Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:192>\n(tail call): ?\nInterface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:552: in function `Spawn'\nInterface\\AddOns\\oUF_Manriel_UI\\core.lua:378: in function `func'\nInterface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\factory.lua:20: in function <Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\factory.lua:16>\n(tail call): ?",
			["session"] = 1109,
			["counter"] = 2,
		}, -- [3]
		{
			["message"] = "[string \"ParentUI:SetScale(1)\"]:1: attempt to index global 'ParentUI' (a nil value)",
			["time"] = "2014/11/12 03:02:40",
			["locals"] = "(*temporary) = \"ParentUI:SetScale(1)\"\n(*temporary) = <function> defined =[C]:-1\n",
			["stack"] = "[string \"ParentUI:SetScale(1)\"]:1: in main chunk\n[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2091: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4387: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4041: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4080: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1121,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "[string \"print UIParent:GetScale()\"]:1: '=' expected near 'UIParent'",
			["time"] = "2014/11/12 03:04:53",
			["locals"] = "msg = \"print UIParent:GetScale()\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2091: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4387: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4041: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4080: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1124,
			["counter"] = 1,
		}, -- [5]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\settings-Параметры.lua:94: attempt to index global 'oUF_ManrielUI' (a nil value)",
			["time"] = "2014/11/12 03:07:15",
			["locals"] = "",
			["stack"] = "Interface\\AddOns\\oUF_Manriel_UI\\settings-Параметры.lua:94: in main chunk",
			["session"] = 1125,
			["counter"] = 1,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\settings-Параметры.lua:93: attempt to index global 'oUF_ManrielUI' (a nil value)",
			["time"] = "2014/11/12 03:07:36",
			["locals"] = "",
			["stack"] = "Interface\\AddOns\\oUF_Manriel_UI\\settings-Параметры.lua:93: in main chunk",
			["session"] = 1126,
			["counter"] = 1,
		}, -- [7]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\settings-Параметры.lua:93: attempt to call method 'SetScale' (a nil value)",
			["time"] = "2014/11/12 03:07:50",
			["locals"] = "",
			["stack"] = "Interface\\AddOns\\oUF_Manriel_UI\\settings-Параметры.lua:93: in main chunk",
			["session"] = 1128,
			["counter"] = 2,
		}, -- [8]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'ACP' пытался вызвать защищенную функцию 'CompactRaidFrameContainer:Hide()'.",
			["time"] = "2014/11/12 03:22:23",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `Hide'\n...mpactRaidFrames\\Blizzard_CompactRaidFrameManager.lua:526: in function `CompactRaidFrameManager_UpdateContainerVisibility'\n...mpactRaidFrames\\Blizzard_CompactRaidFrameManager.lua:471: in function <...mpactRaidFrames\\Blizzard_CompactRaidFrameManager.lua:460>\n...mpactRaidFrames\\Blizzard_CompactRaidFrameManager.lua:510: in function `CompactRaidFrameManager_SetSetting'\n...rd_CUFProfiles\\Blizzard_CompactUnitFrameProfiles.lua:579: in function `func'\n...rd_CUFProfiles\\Blizzard_CompactUnitFrameProfiles.lua:556: in function `CompactUnitFrameProfiles_ApplyProfile'\n...rd_CUFProfiles\\Blizzard_CompactUnitFrameProfiles.lua:176: in function `CompactUnitFrameProfiles_ApplyCurrentSettings'\n...rd_CUFProfiles\\Blizzard_CompactUnitFrameProfiles.lua:85: in function `CompactUnitFrameProfiles_CancelChanges'\n...rd_CUFProfiles\\Blizzard_CompactUnitFrameProfiles.lua:78: in function <...rd_CUFProfiles\\Blizzard_CompactUnitFrameProfiles.lua:76>\n[C]: in function `pcall'\nInterface\\FrameXML\\InterfaceOptionsFrame.lua:217: in function <Interface\\FrameXML\\InterfaceOptionsFrame.lua:216>\n[C]: in function `securecall'\nInterface\\FrameXML\\InterfaceOptionsFrame.lua:252: in function <Interface\\FrameXML\\InterfaceOptionsFrame.lua:248>\n[C]: in function `Click'\nInterface\\FrameXML\\UIParent.lua:3340: in function `ToggleGameMenu'\n[string \"TOGGLEGAMEMENU\"]:1: in function <[string \"TOGGLEGAMEMENU\"]:1>",
			["session"] = 1157,
			["counter"] = 3,
		}, -- [9]
		{
			["message"] = "Interface\\FrameXML\\BuffFrame.lua:303: Usage: CancelUnitBuff(\"unit\", [index] or [\"name\", \"rank\"][, \"filter\"])",
			["time"] = "2014/11/12 04:18:04",
			["locals"] = "self = bBuffsAuraButton1 {\n 0 = <userdata>\n duration = bBuffsAuraButton1Duration {\n }\n text = <unnamed> {\n }\n bg = <unnamed> {\n }\n iconBorder = <unnamed> {\n }\n barUpdate = 0.027000000700355\n count = bBuffsAuraButton1Count {\n }\n filter = \"HELPFUL\"\n timer = <unnamed> {\n }\n timerUpdate = 0.53800001181662\n icon = <unnamed> {\n }\n bar = <unnamed> {\n }\n}\n",
			["stack"] = "[C]: in function `CancelUnitBuff'\nInterface\\FrameXML\\BuffFrame.lua:303: in function `BuffButton_OnClick'\n[string \"*:OnClick\"]:1: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1170,
			["counter"] = 66,
		}, -- [10]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'oUF_Manriel_UI' пытался вызвать защищенную функцию 'ActionButton11:Show()'.",
			["time"] = "2014/11/12 04:56:08",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `Show'\nInterface\\FrameXML\\ActionButton.lua:301: in function <Interface\\FrameXML\\ActionButton.lua:275>\n[C]: ?\n[C]: in function `ActionButton_Update'\nInterface\\FrameXML\\ActionButton.lua:263: in function `ActionButton_UpdateAction'\nInterface\\FrameXML\\ActionBarController.lua:138: in function `ActionBarController_ResetToDefault'\nInterface\\FrameXML\\ActionBarController.lua:127: in function `ActionBarController_UpdateAll'\nInterface\\FrameXML\\ActionBarController.lua:56: in function <Interface\\FrameXML\\ActionBarController.lua:45>\n[C]: in function `ChangeActionBarPage'\n[string \"ACTIONPAGE2\"]:1: in function <[string \"ACTIONPAGE2\"]:1>",
			["session"] = 1175,
			["counter"] = 1,
		}, -- [11]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'oUF_Manriel_UI' пытался вызвать защищенную функцию 'MultiBarBottomLeftButton12:Show()'.",
			["time"] = "2014/11/12 04:56:51",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `Show'\nInterface\\FrameXML\\ActionButton.lua:301: in function <Interface\\FrameXML\\ActionButton.lua:275>\n[C]: ?\n[C]: in function `ActionButton_Update'\nInterface\\FrameXML\\ActionButton.lua:577: in function `ActionButton_OnEvent'\nInterface\\FrameXML\\ActionButton.lua:137: in function <Interface\\FrameXML\\ActionButton.lua:134>",
			["session"] = 1179,
			["counter"] = 2,
		}, -- [12]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'oUF_Manriel_UI' пытался вызвать защищенную функцию 'MultiBarBottomLeftButton11:Show()'.",
			["time"] = "2014/11/12 04:57:43",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `Show'\nInterface\\FrameXML\\ActionButton.lua:301: in function <Interface\\FrameXML\\ActionButton.lua:275>\n[C]: ?\n[C]: in function `ActionButton_Update'\nInterface\\FrameXML\\ActionButton.lua:577: in function `ActionButton_OnEvent'\nInterface\\FrameXML\\ActionButton.lua:137: in function <Interface\\FrameXML\\ActionButton.lua:134>",
			["session"] = 1180,
			["counter"] = 2,
		}, -- [13]
	},
}
