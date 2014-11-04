
GridDB = {
	["namespaces"] = {
		["GridFrame"] = {
			["profiles"] = {
				["Default"] = {
					["invertTextColor"] = true,
					["fontSize"] = 9,
					["statusmap"] = {
						["text2"] = {
							["unit_name"] = false,
							["unit_healthDeficit"] = true,
							["alert_lowHealth"] = false,
							["alert_vehicleui"] = false,
						},
						["text"] = {
							["alert_offline"] = false,
							["unit_healthDeficit"] = false,
							["alert_heals"] = false,
							["alert_death"] = false,
							["alert_feignDeath"] = false,
						},
						["border"] = {
							["buff_Словосилы:Щит"] = false,
							["player_target"] = false,
							["alert_lowHealth"] = false,
							["alert_lowMana"] = false,
						},
						["corner4"] = {
							["alert_aggro"] = false,
						},
						["corner1"] = {
							["alert_heals"] = false,
						},
						["frameAlpha"] = {
							["alert_lowMana"] = false,
							["alert_feignDeath"] = false,
						},
						["icon"] = {
							["dispel_magic"] = false,
							["dispel_poison"] = false,
							["dispel_disease"] = false,
							["buff_Молитвавосстановления"] = true,
							["dispel_curse"] = false,
						},
					},
					["iconBorderSize"] = 0,
					["enableBarColor"] = true,
					["textlength"] = 20,
					["rightClickMenu"] = false,
					["frameHeight"] = 23,
					["enableText2"] = true,
					["orientation"] = "HORIZONTAL",
					["cornerSize"] = 7,
					["frameWidth"] = 94,
				},
			},
		},
		["GridStatusVehicle"] = {
		},
		["LibDualSpec-1.0"] = {
		},
		["GridStatusResurrect"] = {
		},
		["GridStatusAbsorbs"] = {
		},
		["GridStatusTarget"] = {
		},
		["GridStatusAuras"] = {
			["profiles"] = {
				["Default"] = {
					["buff_Молитвавосстановления"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_PrayerOfMendingtga",
					},
					["buff_Обновление"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_Renew",
					},
					["buff_PowerWord:Shield"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
					},
					["buff_PrayerofMending"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_PrayerOfMendingtga",
					},
					["buff_Милость"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_HopeAndGrace",
					},
					["buff_Словосилы:Щит"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
					},
				},
			},
		},
		["GridStatusMana"] = {
		},
		["GridStatusHealth"] = {
			["profiles"] = {
				["Default"] = {
					["alert_offline"] = {
						["color"] = {
							["a"] = 1,
							["r"] = 0.376470588235294,
							["b"] = 0.376470588235294,
							["g"] = 0.376470588235294,
						},
					},
					["unit_healthDeficit"] = {
						["threshold"] = 95,
					},
					["alert_death"] = {
						["color"] = {
							["a"] = 0.8,
							["r"] = 0.607843137254902,
							["g"] = 0.607843137254902,
							["b"] = 0.607843137254902,
						},
					},
					["alert_lowHealth"] = {
						["threshold"] = 15,
						["priority"] = 15,
					},
				},
			},
		},
		["GridLayout"] = {
			["profiles"] = {
				["Default"] = {
					["hideTab"] = true,
					["backgroundTexture"] = "Manriel-Background",
					["layouts"] = {
						["solo"] = "Нет",
						["raid_outside"] = true,
					},
					["ScaleSize"] = 1.2,
					["FrameLock"] = true,
					["borderSize"] = 32,
					["Spacing"] = 0,
					["anchor"] = "BOTTOMLEFT",
					["backgroundColor"] = {
						["a"] = 0,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["groupAnchor"] = "BOTTOMLEFT",
					["PosY"] = 37,
					["layout"] = "Нет",
					["anchorRel"] = "BOTTOMLEFT",
					["borderColor"] = {
						["a"] = 0,
						["r"] = 1,
						["g"] = 1,
						["b"] = 1,
					},
					["Padding"] = 0,
					["horizontal"] = true,
					["borderTexture"] = "Manriel-Border",
					["PosX"] = 482,
				},
			},
		},
		["GridStatusRange"] = {
		},
		["GridStatusHeals"] = {
			["profiles"] = {
				["Default"] = {
					["alert_heals"] = {
						["minimumValue"] = 0.05,
					},
				},
			},
		},
		["GridStatus"] = {
			["profiles"] = {
				["Default"] = {
					["colors"] = {
						["HUNTER"] = {
							["b"] = 0.45,
							["g"] = 0.83,
							["r"] = 0.67,
						},
						["SHAMAN"] = {
							["b"] = 0.87,
							["g"] = 0.44,
							["r"] = 0,
						},
						["MAGE"] = {
							["b"] = 0.94,
							["g"] = 0.8,
							["r"] = 0.41,
						},
						["DRUID"] = {
							["b"] = 0.04,
							["g"] = 0.49,
							["r"] = 1,
						},
						["MONK"] = {
							["b"] = 0.59,
							["g"] = 1,
							["r"] = 0,
						},
						["DEATHKNIGHT"] = {
							["b"] = 0.23,
							["g"] = 0.12,
							["r"] = 0.77,
						},
						["PRIEST"] = {
							["b"] = 1,
							["g"] = 1,
							["r"] = 1,
						},
						["WARLOCK"] = {
							["b"] = 0.79,
							["g"] = 0.51,
							["r"] = 0.58,
						},
						["WARRIOR"] = {
							["b"] = 0.43,
							["g"] = 0.61,
							["r"] = 0.78,
						},
						["PALADIN"] = {
							["b"] = 0.73,
							["g"] = 0.55,
							["r"] = 0.96,
						},
						["ROGUE"] = {
							["b"] = 0.41,
							["g"] = 0.96,
							["r"] = 1,
						},
					},
				},
			},
		},
		["GridStatusAggro"] = {
		},
		["GridStatusVoiceComm"] = {
		},
		["GridStatusReadyCheck"] = {
		},
		["GridStatusName"] = {
		},
		["GridStatusGroup"] = {
		},
		["GridStatusRaidIcon"] = {
		},
		["GridStatusRole"] = {
		},
		["GridStatusMouseover"] = {
		},
		["GridRoster"] = {
		},
	},
	["global"] = {
		["debug"] = {
			["GridFrame"] = false,
		},
	},
	["profileKeys"] = {
		["Лавлиэт - Ясеневый лес"] = "Default",
		["Чивва - Ясеневый лес"] = "Default",
		["Манриэль - Ясеневый лес"] = "Default",
		["Ещеживая - Подземье"] = "Default",
		["Лотаниэль - Подземье"] = "Default",
		["Шепот - Ясеневый лес"] = "Default",
	},
	["profiles"] = {
		["Default"] = {
			["minimap"] = {
				["minimapPos"] = 158.936971730635,
				["hide"] = false,
			},
		},
	},
}
