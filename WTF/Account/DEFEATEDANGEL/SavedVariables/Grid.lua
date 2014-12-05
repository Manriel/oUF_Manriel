
GridDB = {
	["namespaces"] = {
		["GridFrame"] = {
			["profiles"] = {
				["Default"] = {
					["fontSize"] = 9,
					["cornerSize"] = 7,
					["iconBorderSize"] = 0,
					["enableBarColor"] = true,
					["textlength"] = 12,
					["texture"] = "Manriel-Health",
					["rightClickMenu"] = false,
					["frameHeight"] = 23,
					["enableText2"] = true,
					["invertBarColor"] = true,
					["orientation"] = "HORIZONTAL",
					["statusmap"] = {
						["corner2"] = {
							["dispel_poison"] = false,
							["dispel_curse"] = false,
						},
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
							["player_target"] = false,
							["buff_Словосилы:Щит"] = false,
							["buff_PowerWord:Shield"] = true,
							["alert_lowMana"] = false,
							["alert_lowHealth"] = false,
						},
						["corner4"] = {
							["assistant"] = false,
							["master_looter"] = false,
							["leader"] = false,
							["alert_aggro"] = false,
						},
						["corner3"] = {
							["buff_PowerWord:Shield"] = true,
							["role"] = false,
						},
						["corner1"] = {
							["alert_heals"] = false,
							["debuff_WeakenedSoul"] = true,
							["alert_aggro"] = false,
						},
						["frameAlpha"] = {
							["alert_lowMana"] = false,
							["alert_feignDeath"] = false,
						},
						["icon"] = {
							["dispel_magic"] = false,
							["buff_Молитвавосстановления"] = true,
							["raid_icon"] = false,
							["dispel_curse"] = false,
							["dispel_poison"] = false,
							["dispel_disease"] = false,
							["buff_BeaconofLight"] = false,
							["buff_PrayerofMending"] = true,
						},
					},
					["frameWidth"] = 70,
					["font"] = "Calibri Bold",
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
		["GridRoster"] = {
		},
		["GridStatusMouseover"] = {
		},
		["GridStatusRole"] = {
		},
		["GridStatusRaidIcon"] = {
		},
		["GridStatusRange"] = {
		},
		["GridStatusVoiceComm"] = {
		},
		["GridStatus"] = {
			["profiles"] = {
				["Default"] = {
					["colors"] = {
						["PALADIN"] = {
							["r"] = 0.96,
							["g"] = 0.55,
							["b"] = 0.73,
						},
						["MAGE"] = {
							["r"] = 0.41,
							["g"] = 0.8,
							["b"] = 0.94,
						},
						["DRUID"] = {
							["r"] = 1,
							["g"] = 0.49,
							["b"] = 0.04,
						},
						["MONK"] = {
							["r"] = 0,
							["g"] = 1,
							["b"] = 0.59,
						},
						["DEATHKNIGHT"] = {
							["r"] = 0.77,
							["g"] = 0.12,
							["b"] = 0.23,
						},
						["PRIEST"] = {
							["r"] = 1,
							["g"] = 1,
							["b"] = 1,
						},
						["WARLOCK"] = {
							["r"] = 0.58,
							["g"] = 0.51,
							["b"] = 0.79,
						},
						["HUNTER"] = {
							["r"] = 0.67,
							["g"] = 0.83,
							["b"] = 0.45,
						},
						["WARRIOR"] = {
							["r"] = 0.78,
							["g"] = 0.61,
							["b"] = 0.43,
						},
						["SHAMAN"] = {
							["r"] = 0,
							["g"] = 0.44,
							["b"] = 0.87,
						},
						["ROGUE"] = {
							["r"] = 1,
							["g"] = 0.96,
							["b"] = 0.41,
						},
					},
				},
			},
		},
		["GridStatusAggro"] = {
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
		["GridStatusReadyCheck"] = {
		},
		["GridStatusName"] = {
		},
		["GridStatusGroup"] = {
		},
		["GridLayout"] = {
			["profiles"] = {
				["Default"] = {
					["hideTab"] = true,
					["backgroundTexture"] = "Manriel-Background",
					["layouts"] = {
						["raid_outside"] = true,
						["solo"] = "Нет",
					},
					["ScaleSize"] = 1.2,
					["FrameLock"] = true,
					["borderSize"] = 32,
					["Spacing"] = 0,
					["anchor"] = "BOTTOM",
					["backgroundColor"] = {
						["a"] = 0,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["groupAnchor"] = "BOTTOMLEFT",
					["PosY"] = 39,
					["layout"] = "Нет",
					["PosX"] = 0,
					["borderTexture"] = "Manriel-Border",
					["horizontal"] = true,
					["Padding"] = 0,
					["borderColor"] = {
						["a"] = 0,
						["b"] = 1,
						["g"] = 1,
						["r"] = 1,
					},
					["anchorRel"] = "BOTTOM",
				},
			},
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
					["alert_lowHealth"] = {
						["threshold"] = 15,
						["priority"] = 15,
					},
					["alert_death"] = {
						["color"] = {
							["a"] = 0.8,
							["b"] = 0.607843137254902,
							["g"] = 0.607843137254902,
							["r"] = 0.607843137254902,
						},
					},
				},
			},
		},
		["GridStatusMana"] = {
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
					["buff_Словосилы:Щит"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
					},
					["buff_PowerWord:Shield"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
					},
					["buff_LifeCocoon"] = {
						["icon"] = "Interface\\Icons\\ability_monk_chicocoon",
					},
					["buff_PrayerofMending"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_PrayerOfMendingtga",
					},
					["buff_Милость"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_HopeAndGrace",
					},
					["buff_Renew"] = {
						["icon"] = "Interface\\Icons\\Spell_Holy_Renew",
					},
					["buff_EarthShield"] = {
						["icon"] = "Interface\\Icons\\Spell_Nature_SkinofEarth",
					},
					["buff_Rejuvenation"] = {
						["icon"] = "Interface\\Icons\\Spell_Nature_Rejuvenation",
					},
					["buff_Lifebloom"] = {
						["icon"] = "Interface\\Icons\\INV_Misc_Herb_Felblossom",
					},
				},
			},
		},
	},
	["profileKeys"] = {
		["Манриэль - Ясеневый лес"] = "Default",
		["Манриэль - Голдринн"] = "Default",
		["Лавлиэт - Ясеневый лес"] = "Default",
		["Чивва - Ясеневый лес"] = "Default",
		["Шепот - Ясеневый лес"] = "Default",
		["Ещеживая - Подземье"] = "Default",
		["Лотаниэль - Подземье"] = "Default",
		["Тиндэлен - Свежеватель Душ"] = "Default",
	},
	["global"] = {
		["debug"] = {
			["GridFrame"] = false,
		},
	},
	["profiles"] = {
		["Default"] = {
			["minimap"] = {
				["minimapPos"] = 155.120237467451,
				["hide"] = false,
			},
		},
	},
}
