local parent, namespace = ...
local oUF = namespace.oUF
local ManrielUI = namespace.ManrielUI
local LSM = ManrielUI.lib.LSM

local options = {
	type = "group",
	name = 'Manriel UI',
	childGroups = 'tab',
	args = {
		description = {
			name = 'Manriel UI config',
			order = 1,
			type = "header",
		},
		group1 = {
			type = "group",
			name = "Position and sizes",
			order = 1,
			args = {
				xPosition = {
					name = 'X Position',
					order = 2,
					type = "range",
					width = "full",
					min = 100, max = 250, step = 10,
					get = function() 

					end,
					set = function(_, value) 

					end,
				},

				yPosition = {
					name = 'Y Position',
					order = 3,
					type = "range",
					width = "full",
					min = 100, max = 450, step = 10,
					get = function() 

					end,
					set = function(_, value) 

					end,
				},
			},
		},

		group2 = {
			type = "group",
			name = "Fonts",
			order = 2,
			args = {
				fontName = {
					name = 'Font',
					order = 4,
					type = "select",
					get = function() return

					end,
					set = function(_, btn)

					end,
					values = {
						[LSM:Fetch(LSM.MediaType.FONT, 'San Francisco (Semi-bold)')] = 'San Francisco',
						[LSM:Fetch(LSM.MediaType.FONT, 'Calibri (Bold)')] = 'Calibri',
					},
				},

				fontSize = {
					name = 'Font Size',
					order = 5,
					type = "range",
					min = 8, max = 24, step = 1,
					get = function() 

					end,
					set = function(_, value) 

					end,
				},
			},
		},
	},
}

local AceConfig = LibStub("AceConfig-3.0")
AceConfig:RegisterOptionsTable(parent, options, nil)

LibStub("AceConfigDialog-3.0"):AddToBlizOptions(parent, 'Manriel UI')