
CliqueDB = nil
CliqueDB3 = {
	["profileKeys"] = {
		["Манриэль - Ясеневый лес"] = "Манриэль - Ясеневый лес",
		["Ещеживая - Подземье"] = "Ещеживая - Подземье",
		["Лотаниэль - Подземье"] = "Лотаниэль - Подземье",
		["Лавлиэт - Ясеневый лес"] = "Лавлиэт - Ясеневый лес",
	},
	["profiles"] = {
		["Манриэль - Ясеневый лес"] = {
			["bindings"] = {
				{
					["type"] = "menu",
					["key"] = "BUTTON2",
					["sets"] = {
						["global"] = true,
					},
				}, -- [1]
				{
					["type"] = "target",
					["key"] = "BUTTON1",
					["sets"] = {
						["global"] = true,
					},
				}, -- [2]
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
	},
}
