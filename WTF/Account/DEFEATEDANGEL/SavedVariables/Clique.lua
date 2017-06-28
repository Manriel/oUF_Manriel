
CliqueDB = nil
CliqueDB3 = {
	["char"] = {
		["Манриэль - Ясеневый лес"] = {
			["spec1_profileKey"] = "Manriel Discipline",
			["spec2_profileKey"] = "Manriel Holy",
			["spec3_profileKey"] = "Manriel Shadow",
			["sec_profileKey"] = "Manriel Shadow",
			["fastooc"] = false,
			["alerthidden"] = true,
			["downclick"] = false,
			["pri_profileKey"] = "Манриэль - Ясеневый лес",
			["specswap"] = true,
		},
	["profileKeys"] = {
		["Манриэль - Ясеневый лес"] = "Manriel Discipline",
	},
	["profiles"] = {
		["Manriel Discipline"] = {
			["bindings"] = {
				{
					["spell"] = "Уход в тень",
					["key"] = "BUTTON4",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = 135994,
					["type"] = "spell",
				}, -- [1]
				{
					["spell"] = "Слово силы: Щит",
					["key"] = "BUTTON5",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = 135940,
					["type"] = "spell",
				}, -- [2]
				{
					["spell"] = "Божественное перышко",
					["key"] = "ALT-BUTTON5",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = 642580,
					["type"] = "spell",
				}, -- [3]
				{
					["macrotext"] = "/focus [@mouseover]",
					["type"] = "macro",
					["key"] = "CTRL-SHIFT-BUTTON3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
				}, -- [4]
				{
					["spell"] = "Ментальный крик",
					["key"] = "SHIFT-BUTTON4",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = 136184,
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Массовое рассеивание",
					["key"] = "SHIFT-BUTTON3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = 135739,
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Исповедь",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["friend"] = true,
						["default"] = true,
						["enemy"] = true,
					},
					["icon"] = 237545,
					["type"] = "spell",
				}, -- [7]
				{
					["spell"] = "Темное восстановление",
					["key"] = "BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 136202,
					["type"] = "spell",
				}, -- [8]
				{
					["spell"] = "Мольба",
					["key"] = "BUTTON2",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135915,
					["type"] = "spell",
				}, -- [9]
				{
					["spell"] = "Ясность воли",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 1022947,
					["type"] = "spell",
				}, -- [10]
				{
					["spell"] = "Слово силы: Барьер",
					["key"] = "SHIFT-BUTTON5",
					["sets"] = {
						["global"] = true,
					},
					["icon"] = 253400,
					["type"] = "spell",
				}, -- [11]
				{
					["spell"] = "Левитация",
					["key"] = "ALT-BUTTON4",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135928,
					["type"] = "spell",
				}, -- [12]
				{
					["spell"] = "Духовное рвение",
					["key"] = "CTRL-SHIFT-BUTTON5",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 463835,
					["type"] = "spell",
				}, -- [13]
				{
					["spell"] = "Слово силы: Сияние",
					["key"] = "CTRL-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 1386546,
					["type"] = "spell",
				}, -- [14]
				{
					["spell"] = "Очищение",
					["key"] = "BUTTON3",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135894,
					["type"] = "spell",
				}, -- [15]
				{
					["spell"] = "Подавление боли",
					["key"] = "SHIFT-BUTTON5",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135936,
					["type"] = "spell",
				}, -- [16]
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
					["spell"] = "Слияние с Тьмой",
					["key"] = "SHIFT-BUTTON5",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = 237563,
					["type"] = "spell",
				}, -- [2]
				{
					["spell"] = "Уход в тень",
					["key"] = "BUTTON4",
					["sets"] = {
						["default"] = true,
					},
					["icon"] = 135994,
					["type"] = "spell",
				}, -- [3]
				{
					["spell"] = "Массовое рассеивание",
					["key"] = "SHIFT-BUTTON3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = 135739,
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Ментальный крик",
					["key"] = "SHIFT-BUTTON4",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = 136184,
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Темное восстановление",
					["key"] = "BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 136202,
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Рассеивание заклинаний",
					["key"] = "BUTTON3",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = 136066,
					["type"] = "spell",
				}, -- [7]
				{
					["spell"] = "Исчадие Тьмы",
					["key"] = "SHIFT-BUTTON5",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = 136199,
					["type"] = "spell",
				}, -- [8]
				{
					["spell"] = "Очищение от болезни",
					["key"] = "BUTTON3",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135935,
					["type"] = "spell",
				}, -- [9]
				{
					["spell"] = "Безмолвие",
					["key"] = "BUTTON4",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = 458230,
					["type"] = "spell",
				}, -- [10]
				{
					["spell"] = "Левитация",
					["key"] = "ALT-BUTTON4",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135928,
					["type"] = "spell",
				}, -- [11]
				{
					["spell"] = "Слово Тьмы: Смерть",
					["key"] = "BUTTON5",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = 136149,
					["type"] = "spell",
				}, -- [12]
				{
					["spell"] = "Слово силы: Щит",
					["key"] = "BUTTON5",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135940,
					["type"] = "spell",
				}, -- [13]
			},
		},
		["Manriel Holy"] = {
			["bindings"] = {
				{
					["type"] = "menu",
					["key"] = "CTRL-SHIFT-BUTTON2",
					["sets"] = {
						["default"] = true,
					},
				}, -- [1]
				{
					["type"] = "target",
					["key"] = "CTRL-SHIFT-BUTTON1",
					["sets"] = {
						["default"] = true,
					},
				}, -- [2]
				{
					["spell"] = "Слово Света: Освящение",
					["key"] = "SHIFT-BUTTON5",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = 237541,
					["type"] = "spell",
				}, -- [3]
				{
					["spell"] = "Божественная звезда",
					["key"] = "CTRL-BUTTON5",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = 537026,
					["type"] = "spell",
				}, -- [4]
				{
					["spell"] = "Массовое рассеивание",
					["key"] = "SHIFT-BUTTON3",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = 135739,
					["type"] = "spell",
				}, -- [5]
				{
					["spell"] = "Божественное перышко",
					["key"] = "ALT-BUTTON5",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = 642580,
					["type"] = "spell",
				}, -- [6]
				{
					["spell"] = "Кольцо света",
					["key"] = "ALT-BUTTON2",
					["sets"] = {
						["global"] = true,
						["default"] = true,
					},
					["icon"] = 135922,
					["type"] = "spell",
				}, -- [7]
				{
					["spell"] = "Исцеление",
					["key"] = "BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135913,
					["type"] = "spell",
				}, -- [8]
				{
					["spell"] = "Оберегающий дух",
					["key"] = "BUTTON5",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 237542,
					["type"] = "spell",
				}, -- [9]
				{
					["spell"] = "Уход в тень",
					["key"] = "BUTTON4",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135994,
					["type"] = "spell",
				}, -- [10]
				{
					["spell"] = "Обновление",
					["key"] = "BUTTON2",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135953,
					["type"] = "spell",
				}, -- [11]
				{
					["spell"] = "Кара",
					["key"] = "BUTTON1",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = 135924,
					["type"] = "spell",
				}, -- [12]
				{
					["spell"] = "Круг исцеления",
					["key"] = "CTRL-BUTTON2",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135887,
					["type"] = "spell",
				}, -- [13]
				{
					["spell"] = "Рассеивание заклинаний",
					["key"] = "BUTTON3",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = 136066,
					["type"] = "spell",
				}, -- [14]
				{
					["spell"] = "Слово Света: Наказание",
					["key"] = "BUTTON2",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = 135886,
					["type"] = "spell",
				}, -- [15]
				{
					["spell"] = "Священный огонь",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["enemy"] = true,
					},
					["icon"] = 135972,
					["type"] = "spell",
				}, -- [16]
				{
					["spell"] = "Духовное рвение",
					["key"] = "CTRL-SHIFT-BUTTON5",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 463835,
					["type"] = "spell",
				}, -- [17]
				{
					["spell"] = "Молитва исцеления",
					["key"] = "CTRL-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135943,
					["type"] = "spell",
				}, -- [18]
				{
					["spell"] = "Очищение",
					["key"] = "BUTTON3",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135894,
					["type"] = "spell",
				}, -- [19]
				{
					["spell"] = "Слово Света: Безмятежность",
					["key"] = "SHIFT-BUTTON2",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135937,
					["type"] = "spell",
				}, -- [20]
				{
					["spell"] = "Левитация",
					["key"] = "ALT-BUTTON4",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135928,
					["type"] = "spell",
				}, -- [21]
				{
					["spell"] = "Молитва восстановления",
					["key"] = "ALT-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135944,
					["type"] = "spell",
				}, -- [22]
				{
					["spell"] = "Быстрое исцеление",
					["key"] = "SHIFT-BUTTON1",
					["sets"] = {
						["friend"] = true,
					},
					["icon"] = 135907,
					["type"] = "spell",
				}, -- [23]
			},
		},
	},
}
