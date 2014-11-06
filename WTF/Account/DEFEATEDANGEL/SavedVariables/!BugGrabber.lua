
BugGrabberDB = {
	["session"] = 712,
	["lastSanitation"] = 3,
	["errors"] = {
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:185: ')' expected (to close '(' at line 184) near 'end'",
			["time"] = "2014/11/06 04:08:00",
			["locals"] = "",
			["stack"] = "",
			["session"] = 682,
			["counter"] = 1,
		}, -- [1]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:189: unexpected symbol near '='",
			["time"] = "2014/11/06 04:48:39",
			["locals"] = "",
			["stack"] = "",
			["session"] = 691,
			["counter"] = 1,
		}, -- [2]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:167: attempt to call field 'onUpdate' (a nil value)",
			["time"] = "2014/11/06 04:50:14",
			["locals"] = "icons = <unnamed> {\n 1 = <unnamed> {\n }\n __owner = oUF_ManrielUITarget {\n }\n PostUpdateIcon = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:170\n anchoredIcons = 0\n 0 = <userdata>\n PostCreateIcon = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:163\n createdIcons = 1\n gap = true\n numDebuffs = 18\n ForceUpdate = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:452\n growth-y = \"UP\"\n numBuffs = 18\n spacing = 2.5\n initialAnchor = \"BOTTOMRIGHT\"\n growth-x = \"LEFT\"\n spacing-y = 10\n size = 31.5\n}\nindex = 1\nbutton = <unnamed> {\n 0 = <userdata>\n count = <unnamed> {\n }\n UpdateTooltip = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:68\n cd = <unnamed> {\n }\n stealable = <unnamed> {\n }\n duration = <unnamed> {\n }\n icon = <unnamed> {\n }\n overlay = <unnamed> {\n }\n}\ncd = <unnamed> {\n 0 = <userdata>\n}\nicon = <unnamed> {\n 0 = <userdata>\n}\ncount = <unnamed> {\n 0 = <userdata>\n}\noverlay = <unnamed> {\n 0 = <userdata>\n}\nstealable = <unnamed> {\n 0 = <userdata>\n}\nUpdateTooltip = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:68\nOnEnter = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:72\nOnLeave = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:79\n",
			["stack"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:167: in function `PostCreateIcon'\n...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:130: in function <...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:83>\n...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:159: in function <...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:141>\n...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:293: in function <...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:287>\n...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:325: in function <...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:314>\n...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:430: in function `func'\nInterface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:158: in function <Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:149>\n(tail call): ?\n[C]: in function `Show'\nInterface\\FrameXML\\SecureStateDriver.lua:83: in function <Interface\\FrameXML\\SecureStateDriver.lua:73>\nInterface\\FrameXML\\SecureStateDriver.lua:137: in function <Interface\\FrameXML\\SecureStateDriver.lua:119>",
			["session"] = 694,
			["counter"] = 10,
		}, -- [3]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:168: '=' expected near 'end'",
			["time"] = "2014/11/06 04:51:39",
			["locals"] = "",
			["stack"] = "",
			["session"] = 696,
			["counter"] = 1,
		}, -- [4]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:167: unexpected symbol near ')'",
			["time"] = "2014/11/06 04:51:23",
			["locals"] = "",
			["stack"] = "",
			["session"] = 698,
			["counter"] = 3,
		}, -- [5]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\core.lua:185: attempt to call upvalue 'setFontString' (a nil value)",
			["time"] = "2014/11/06 04:08:00",
			["locals"] = "unit = \"player\"\nstyle = \"ManrielUI\"\nstyleFunc = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\core.lua:151\nheader = nil\nnum = 1\n(for index) = 1\n(for limit) = 1\n(for step) = 1\ni = 1\nobject = oUF_ManrielUIPlayer {\n 0 = <userdata>\n style = \"ManrielUI\"\n UNIT_EXITED_VEHICLE = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:38\n UNIT_ENTERED_VEHICLE = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:38\n PLAYER_ENTERING_WORLD = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:149\n __elements = <table> {\n }\n unit = \"player\"\n}\nobjectUnit = \"player\"\nsuffix = nil\nframe_metatable = <table> {\n __index = <unnamed> {\n }\n}\nobjects = <table> {\n 1 = oUF_ManrielUIPlayer {\n }\n}\nupdateActiveUnit = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:38\nUpdatePet = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:175\nenableTargetUpdate = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:20\noUF = <table> {\n DisableBlizzard = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\blizzard.lua:44\n SetActiveStyle = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:324\n EnableFactory = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\factory.lua:38\n ColorGradient = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\colors.lua:59\n SpawnHeader = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:496\n RegisterStyle = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:314\n AddElement = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:560\n Factory = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\factory.lua:27\n RegisterMetaFunction = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:303\n Tags = <table> {\n }\n DisableFactory = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\factory.lua:42\n objects = <table> {\n }\n colors = <table> {\n }\n version = \"1.1.beta2\"\n RunFactoryQueue = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\factory.lua:46\n HandleUnit = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\units.lua:8\n RegisterInitCallback = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:299\n IterateStyles = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:337\n Spawn = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:541\n}\nPrivate = <table> {\n enableTargetUpdate = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:20\n UpdateUnits = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\events.lua:37\n colors = <table> {\n }\n argcheck = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\private.lua:4\n frame_metatable = <table> {\n }\n error = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\private.lua:20\n print = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\private.lua:16\n}\nOnAttributeChanged = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:74\nOnShow = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:169\nactiveElements = <table> {\n}\nelements = <table> {\n Totems = <table> {\n }\n Portrait = <table> {\n }\n ReadyCheck = <table> {\n }\n Range = <table> {\n }\n Resting = <table> {\n }\n Aura = <table> {\n }\n PhaseIcon = <table> {\n }\n PvP = <table> {\n }\n LFDRole = <table> {\n }\n Threat = <table> {\n }\n Leader = <table> {\n }\n Castbar = <table> {\n }\n ResurrectIcon = <table> {\n }\n HealPrediction = <table> {\n }\n AltPowerBar = <table> {\n }\n QuestIcon = <table> {\n }\n CPoints = <table> {\n }\n Combat = <table> {\n }\n Health = <table> {\n }\n Power = <table> {\n }\n Assistant = <table> {\n }\n MasterLooter = <table> {\n }\n ClassIcons = <table> {\n }\n RaidIcon = <table> {\n }\n}\ncallback = <table> {\n 1 = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF_Smooth\\oUF_Smooth.lua:22\n}\n",
			["stack"] = "Interface\\AddOns\\oUF_Manriel_UI\\core.lua:185: in function `styleFunc'\nInterface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:262: in function <Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:192>\n(tail call): ?\nInterface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:552: in function `Spawn'\nInterface\\AddOns\\oUF_Manriel_UI\\core.lua:260: in function `func'\nInterface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\factory.lua:20: in function <Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\factory.lua:16>\n(tail call): ?",
			["session"] = 698,
			["counter"] = 6,
		}, -- [6]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:191: attempt to index global 'self' (a nil value)",
			["time"] = "2014/11/06 05:19:05",
			["locals"] = "",
			["stack"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:191: in function <Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:190>",
			["session"] = 700,
			["counter"] = 1530,
		}, -- [7]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:176: attempt to index global 'button' (a nil value)",
			["time"] = "2014/11/06 05:21:39",
			["locals"] = "unit = \"target\"\nicons = <unnamed> {\n 1 = <unnamed> {\n }\n __owner = oUF_ManrielUITarget {\n }\n PostUpdateIcon = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:169\n anchoredIcons = 0\n 0 = <userdata>\n PostCreateIcon = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:163\n createdIcons = 1\n gap = true\n numDebuffs = 18\n ForceUpdate = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:452\n growth-y = \"UP\"\n numBuffs = 18\n spacing = 2.5\n initialAnchor = \"BOTTOMRIGHT\"\n growth-x = \"LEFT\"\n spacing-y = 10\n size = 31.5\n}\nindex = 1\noffset = 0\nfilter = \"HELPFUL\"\nisDebuff = nil\nvisible = 0\nname = \"Знамя Орды\"\nrank = \"\"\ntexture = \"Interface\\Icons\\INV_BannerPVP_01\"\ncount = 0\ndtype = nil\nduration = 0\ntimeLeft = 0\ncaster = \"target\"\nisStealable = false\nshouldConsolidate = false\nspellID = 61574\ncanApplyAura = false\nisBossDebuff = false\nn = 1\nicon = <unnamed> {\n overlay = <unnamed> {\n }\n UpdateTooltip = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:68\n stealable = <unnamed> {\n }\n duration = <unnamed> {\n }\n cd = <unnamed> {\n }\n filter = \"HELPFUL\"\n owner = \"target\"\n 0 = <userdata>\n icon = <unnamed> {\n }\n count = <unnamed> {\n }\n}\nisPlayer = nil\nshow = true\ncd = <unnamed> {\n 0 = <userdata>\n}\nstealable = false\nsize = 31.5\ncreateAuraIcon = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:83\ncustomFilter = <function> defined @Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:135\nVISIBLE = 1\nHIDDEN = 0\n",
			["stack"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:176: in function `PostUpdateIcon'\n...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:245: in function <...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:141>\n...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:293: in function <...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:287>\n...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:325: in function <...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:314>\n...ace\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\elements\\aura.lua:430: in function `func'\nInterface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:158: in function <Interface\\AddOns\\oUF_Manriel_UI\\libs\\oUF\\ouf.lua:149>\n(tail call): ?\n[C]: in function `Show'\nInterface\\FrameXML\\SecureStateDriver.lua:83: in function <Interface\\FrameXML\\SecureStateDriver.lua:73>\nInterface\\FrameXML\\SecureStateDriver.lua:137: in function <Interface\\FrameXML\\SecureStateDriver.lua:119>",
			["session"] = 701,
			["counter"] = 1,
		}, -- [8]
		{
			["message"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:180: attempt to index global 'self' (a nil value)",
			["time"] = "2014/11/06 05:21:53",
			["locals"] = "",
			["stack"] = "Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:180: in function <Interface\\AddOns\\oUF_Manriel_UI\\functions.lua:179>",
			["session"] = 702,
			["counter"] = 370,
		}, -- [9]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] Аддон 'oUF_Manriel_UI' пытался вызвать защищенную функцию 'MultiBarBottomLeftButton12:Show()'.",
			["time"] = "2014/11/06 04:53:30",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:586>\n[C]: in function `Show'\nInterface\\FrameXML\\ActionButton.lua:301: in function <Interface\\FrameXML\\ActionButton.lua:275>\n[C]: ?\n[C]: in function `ActionButton_Update'\nInterface\\FrameXML\\ActionButton.lua:577: in function `ActionButton_OnEvent'\nInterface\\FrameXML\\ActionButton.lua:137: in function <Interface\\FrameXML\\ActionButton.lua:134>",
			["session"] = 712,
			["counter"] = 2,
		}, -- [10]
	},
}
