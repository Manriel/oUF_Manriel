
CliqueDB = nil
CliqueDB3 = {
	["char"] = {
		["Манриэль - Ясеневый лес"] = {
			["sec_profileKey"] = "Manriel Shadow",
			["fastooc"] = false,
			["alerthidden"] = true,
			["downclick"] = false,
			["pri_profileKey"] = "Манриэль - Ясеневый лес",
			["specswap"] = true,
		},
		["Тиндэлен - Свежеватель Душ"] = {
			["alerthidden"] = true,
		},
		["Лейреи - Ясеневый лес"] = {
			["alerthidden"] = true,
		},
	},
	["profileKeys"] = {
		["Манриэль - Голдринн"] = "Манриэль - Голдринн",
		["Чивва - Ясеневый лес"] = "Чивва - Ясеневый лес",
		["Лотаниэль - Подземье"] = "Лотаниэль - Подземье",
		["Эксплорер - Подземье"] = "Эксплорер - Подземье",
		["Тиндэлен - Свежеватель Душ"] = "Тиндэлен - Свежеватель Душ",
		["Шепот - Ясеневый лес"] = "Шепот - Ясеневый лес",
		["Ещеживая - Подземье"] = "Ещеживая - Подземье",
		["Манриэль - Ясеневый лес"] = "Манриэль - Ясеневый лес",
		["Лавлиэт - Ясеневый лес"] = "Лавлиэт - Ясеневый лес",
		["Лейреи - Ясеневый лес"] = "Лейреи - Ясеневый лес",
		["Аскелла - Свежеватель Душ"] = "Аскелла - Свежеватель Душ",
	},
	["profiles"] = {
		["Манриэль - Голдринн"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Чивва - Ясеневый лес"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Лотаниэль - Подземье"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Эксплорер - Подземье"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Тиндэлен - Свежеватель Душ"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Manriel Shadow"] = {
			["bindings"] = {
				{
					["type"] = "menu",
					["key"] = "CTRL-SHIFT-BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [1]
				{
					["macrotext"] = "/focus [@mouseover]",
					["type"] = "macro",
					["key"] = "CTRL-SHIFT-BUTTON3",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
				{
					["spell"] = "Призрачный облик",
					["key"] = "SHIFT-BUTTON4",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_priest_spectralguise",
					["type"] = "spell",
				}, -- [3]
				{
					["spell"] = "Уход в тень",
					["key"] = "BUTTON4",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Magic_LesserInvisibilty",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Быстрое исцеление",
					["key"] = "BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_FlashHeal",
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Глубинный ужас",
					["key"] = "CTRL-BUTTON5",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shadow_PsychicHorrors",
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Слово силы: Щит",
					["key"] = "BUTTON5",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
					["type"] = "spell",
				}, -- [7]
				{
					["spell"] = "Безмолвие",
					["key"] = "SHIFT-BUTTON5",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\ability_priest_silence",
					["type"] = "spell",
				}, -- [8]
				{
					["spell"] = "Левитация",
					["key"] = "ALT-BUTTON4",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_LayOnHands",
					["type"] = "spell",
				}, -- [9]
				{
					["spell"] = "Молитва восстановления",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_PrayerOfMendingtga",
					["type"] = "spell",
				}, -- [10]
				{
					["spell"] = "Божественное перышко",
					["key"] = "ALT-BUTTON2",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_priest_angelicfeather",
					["type"] = "spell",
				}, -- [11]
				{
					["spell"] = "Духовное рвение",
					["key"] = "ALT-CTRL-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\priest_spell_leapoffaith_a",
					["type"] = "spell",
				}, -- [12]
				{
					["spell"] = "Ментальный крик",
					["key"] = "SHIFT-BUTTON4",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shadow_PsychicScream",
					["type"] = "spell",
				}, -- [13]
				{
					["spell"] = "Слово Тьмы: Смерть",
					["key"] = "BUTTON5",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shadow_DemonicFortitude",
					["type"] = "spell",
				}, -- [14]
			},
		},
		["Ещеживая - Подземье"] = {
			["bindings"] = {
				{
					["sets"] = {
						["default"] = true,
					},
					["type"] = "target",
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Манриэль - Ясеневый лес"] = {
			["bindings"] = {
				{
					["spell"] = "Уход в тень",
					["key"] = "BUTTON4",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Magic_LesserInvisibilty",
					["type"] = "spell",
				}, -- [1]
				{
					["spell"] = "Призрачный облик",
					["key"] = "SHIFT-BUTTON4",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_priest_spectralguise",
					["type"] = "spell",
				}, -- [2]
				{
					["spell"] = "Исповедь",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_Penance",
					["type"] = "spell",
				}, -- [3]
				{
					["spell"] = "Внутреннее зрение",
					["key"] = "ALT-BUTTON3",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_MindVision",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Кольцо света",
					["key"] = "ALT-BUTTON2",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_HolyNova",
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Архангел",
					["key"] = "CTRL-BUTTON4",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\ability_priest_archangel",
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Ясность воли",
					["key"] = "ALT-BUTTON1",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_priest_clarityofwill",
					["type"] = "spell",
				}, -- [7]
				{
					["spell"] = "Щит души",
					["key"] = "ALT-BUTTON5",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_shaman_astralshift",
					["type"] = "spell",
				}, -- [8]
				{
					["spell"] = "Слово силы: Барьер",
					["key"] = "CTRL-BUTTON5",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_holy_powerwordbarrier",
					["type"] = "spell",
				}, -- [9]
				{
					["spell"] = "Массовое рассеивание",
					["key"] = "SHIFT-BUTTON3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Arcane_MassDispel",
					["type"] = "spell",
				}, -- [10]
				{
					["macrotext"] = "/focus mouseover\n",
					["type"] = "macro",
					["key"] = "CTRL-BUTTON3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [11]
				{
					["spell"] = "Иссушение разума",
					["key"] = "CTRL-BUTTON1",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shadow_MindShear",
					["type"] = "spell",
				}, -- [12]
				{
					["spell"] = "Безмолвие",
					["key"] = "BUTTON5",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\ability_priest_silence",
					["type"] = "spell",
				}, -- [13]
				{
					["spell"] = "Щупальца Бездны",
					["key"] = "BUTTON4",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_priest_voidtendrils",
					["type"] = "spell",
				}, -- [14]
				{
					["spell"] = "Рассеивание заклинаний",
					["key"] = "BUTTON3",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Nature_NullifyDisease",
					["type"] = "spell",
				}, -- [15]
				{
					["spell"] = "Молитва исцеления",
					["key"] = "CTRL-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_PrayerOfHealing02",
					["type"] = "spell",
				}, -- [16]
				{
					["spell"] = "Подчиняющий разум",
					["key"] = "SHIFT-BUTTON5",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shadow_SoulLeech_3",
					["type"] = "spell",
				}, -- [17]
				{
					["spell"] = "Подавление боли",
					["key"] = "SHIFT-BUTTON5",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_PainSupression",
					["type"] = "spell",
				}, -- [18]
				{
					["type"] = "target",
					["key"] = "BUTTON1",
					["sets"] = {
						["global"] = true,
					},
				}, -- [19]
				{
					["spell"] = "Исчадие Тьмы",
					["key"] = "SHIFT-BUTTON5",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shadow_Shadowfiend",
					["type"] = "spell",
				}, -- [20]
				{
					["spell"] = "Слово силы: Щит",
					["key"] = "BUTTON5",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
					["type"] = "spell",
				}, -- [21]
				{
					["spell"] = "Священный огонь",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_SearingLight",
					["type"] = "spell",
				}, -- [22]
				{
					["spell"] = "Исцеление",
					["key"] = "BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
					["type"] = "spell",
				}, -- [23]
				{
					["type"] = "menu",
					["key"] = "CTRL-SHIFT-BUTTON2",
					["sets"] = {
						["global"] = true,
					},
				}, -- [24]
				{
					["spell"] = "Кара",
					["key"] = "BUTTON1",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_HolySmite",
					["type"] = "spell",
				}, -- [25]
				{
					["spell"] = "Быстрое исцеление",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_FlashHeal",
					["type"] = "spell",
				}, -- [26]
				{
					["spell"] = "Молитва восстановления",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_PrayerOfMendingtga",
					["type"] = "spell",
				}, -- [27]
				{
					["spell"] = "Слово Тьмы: Боль",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shadow_ShadowWordPain",
					["type"] = "spell",
				}, -- [28]
				{
					["spell"] = "Каскад",
					["key"] = "CTRL-BUTTON2",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_priest_cascade",
					["type"] = "spell",
				}, -- [29]
				{
					["spell"] = "Очищение",
					["key"] = "BUTTON3",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_DispelMagic",
					["type"] = "spell",
				}, -- [30]
				{
					["spell"] = "Духовное рвение",
					["key"] = "ALT-CTRL-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\priest_spell_leapoffaith_a",
					["type"] = "spell",
				}, -- [31]
				{
					["spell"] = "Левитация",
					["key"] = "ALT-BUTTON4",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_LayOnHands",
					["type"] = "spell",
				}, -- [32]
			},
		},
		["Шепот - Ясеневый лес"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Лавлиэт - Ясеневый лес"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
		["Лейреи - Ясеневый лес"] = {
			["bindings"] = {
				{
					["spell"] = "Незаметность",
					["key"] = "BUTTON5",
					["sets"] = {
						["ooc"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_Stealth",
					["type"] = "spell",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [3]
				{
					["spell"] = "Исчезновение",
					["key"] = "BUTTON5",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Ability_Vanish",
					["type"] = "spell",
				}, -- [4]
			},
		},
		["Аскелла - Свежеватель Душ"] = {
			["bindings"] = {
				{
					["type"] = "target",
					["sets"] = {
						["default"] = true,
					},
					["key"] = "BUTTON1",
					["unit"] = "mouseover",
				}, -- [1]
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
			},
		},
	},
}
