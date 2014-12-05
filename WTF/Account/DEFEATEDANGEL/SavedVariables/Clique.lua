
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
	},
	["profileKeys"] = {
		["Манриэль - Ясеневый лес"] = "Манриэль - Ясеневый лес",
		["Манриэль - Голдринн"] = "Манриэль - Голдринн",
		["Лавлиэт - Ясеневый лес"] = "Лавлиэт - Ясеневый лес",
		["Чивва - Ясеневый лес"] = "Чивва - Ясеневый лес",
		["Шепот - Ясеневый лес"] = "Шепот - Ясеневый лес",
		["Ещеживая - Подземье"] = "Ещеживая - Подземье",
		["Лотаниэль - Подземье"] = "Лотаниэль - Подземье",
		["Тиндэлен - Свежеватель Душ"] = "Тиндэлен - Свежеватель Душ",
	},
	["profiles"] = {
		["Манриэль - Голдринн"] = {
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
		["Чивва - Ясеневый лес"] = {
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
		["Лотаниэль - Подземье"] = {
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
		["Тиндэлен - Свежеватель Душ"] = {
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
		["Шепот - Ясеневый лес"] = {
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
					["spell"] = "Исповедь",
					["key"] = "BUTTON2",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_Penance",
					["type"] = "spell",
				}, -- [2]
				{
					["spell"] = "Массовое рассеивание",
					["key"] = "CTRL-BUTTON3",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Arcane_MassDispel",
					["type"] = "spell",
				}, -- [3]
				{
					["spell"] = "Призрачный облик",
					["key"] = "SHIFT-BUTTON4",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_priest_spectralguise",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Очищение",
					["key"] = "BUTTON3",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_DispelMagic",
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Внутреннее зрение",
					["key"] = "ALT-BUTTON3",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_MindVision",
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Кольцо света",
					["key"] = "ALT-BUTTON2",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_HolyNova",
					["type"] = "spell",
				}, -- [7]
				{
					["spell"] = "Слово силы: Барьер",
					["key"] = "CTRL-BUTTON5",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_holy_powerwordbarrier",
					["type"] = "spell",
				}, -- [8]
				{
					["spell"] = "Рассеивание заклинаний",
					["key"] = "SHIFT-BUTTON3",
					["sets"] = {
						["default"] = true,
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Nature_NullifyDisease",
					["type"] = "spell",
				}, -- [9]
				{
					["macrotext"] = "/focus mouseover",
					["type"] = "macro",
					["key"] = "ALT-BUTTON3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [10]
				{
					["spell"] = "Исцеление",
					["key"] = "BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_GreaterHeal",
					["type"] = "spell",
				}, -- [11]
				{
					["type"] = "target",
					["key"] = "BUTTON1",
					["sets"] = {
						["global"] = true,
					},
				}, -- [12]
				{
					["spell"] = "Священный огонь",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_SearingLight",
					["type"] = "spell",
				}, -- [13]
				{
					["spell"] = "Слово силы: Щит",
					["key"] = "BUTTON5",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
					["type"] = "spell",
				}, -- [14]
				{
					["spell"] = "Левитация",
					["key"] = "ALT-BUTTON4",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_LayOnHands",
					["type"] = "spell",
				}, -- [15]
				{
					["spell"] = "Духовное рвение",
					["key"] = "ALT-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\priest_spell_leapoffaith_a",
					["type"] = "spell",
				}, -- [16]
				{
					["spell"] = "Каскад",
					["key"] = "CTRL-BUTTON2",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_priest_cascade",
					["type"] = "spell",
				}, -- [17]
				{
					["spell"] = "Быстрое исцеление",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_FlashHeal",
					["type"] = "spell",
				}, -- [18]
				{
					["type"] = "menu",
					["key"] = "CTRL-SHIFT-BUTTON2",
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
					["spell"] = "Подавление боли",
					["key"] = "SHIFT-BUTTON5",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_PainSupression",
					["type"] = "spell",
				}, -- [21]
				{
					["spell"] = "Слово Тьмы: Боль",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shadow_ShadowWordPain",
					["type"] = "spell",
				}, -- [22]
				{
					["spell"] = "Молитва исцеления",
					["key"] = "CTRL-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_PrayerOfHealing02",
					["type"] = "spell",
				}, -- [23]
				{
					["spell"] = "Безмолвие",
					["key"] = "BUTTON5",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\ability_priest_silence",
					["type"] = "spell",
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
					["spell"] = "Иссушение разума",
					["key"] = "CTRL-BUTTON1",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shadow_MindShear",
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
					["spell"] = "Щупальца Бездны",
					["key"] = "BUTTON4",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_priest_voidtendrils",
					["type"] = "spell",
				}, -- [28]
			},
		},
		["Ещеживая - Подземье"] = {
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
					["spell"] = "Уход в тень",
					["key"] = "BUTTON4",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Magic_LesserInvisibilty",
					["type"] = "spell",
				}, -- [2]
				{
					["macrotext"] = "/focus [@mouseover]",
					["type"] = "macro",
					["key"] = "CTRL-SHIFT-BUTTON3",
					["sets"] = {
						["default"] = true,
					},
				}, -- [3]
				{
					["spell"] = "Призрачный облик",
					["key"] = "SHIFT-BUTTON4",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = "Interface\\Icons\\spell_priest_spectralguise",
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Безмолвие",
					["key"] = "SHIFT-BUTTON5",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\ability_priest_silence",
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Духовное рвение",
					["key"] = "ALT-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "INTERFACE\\ICONS\\priest_spell_leapoffaith_a",
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Глубинный ужас",
					["key"] = "CTRL-BUTTON5",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shadow_PsychicHorrors",
					["type"] = "spell",
				}, -- [7]
				{
					["spell"] = "Молитва восстановления",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_PrayerOfMendingtga",
					["type"] = "spell",
				}, -- [8]
				{
					["spell"] = "Ментальный крик",
					["key"] = "SHIFT-BUTTON4",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Shadow_PsychicScream",
					["type"] = "spell",
				}, -- [9]
				{
					["spell"] = "Левитация",
					["key"] = "ALT-BUTTON4",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_LayOnHands",
					["type"] = "spell",
				}, -- [10]
				{
					["spell"] = "Быстрое исцеление",
					["key"] = "BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_FlashHeal",
					["type"] = "spell",
				}, -- [11]
				{
					["spell"] = "Божественное перышко",
					["key"] = "ALT-BUTTON2",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = "Interface\\Icons\\ability_priest_angelicfeather",
					["type"] = "spell",
				}, -- [12]
				{
					["spell"] = "Слово силы: Щит",
					["key"] = "BUTTON5",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
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
	},
}
