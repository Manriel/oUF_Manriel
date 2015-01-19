local addon, ns = ...
local cfg = CreateFrame("Frame")

--ActionBars config  
cfg.mAB = {
	size = 27,						-- setting up default buttons size
	spacing = 2, 					-- spacing between buttons
	media = {						-- MEDIA
		textures_normal = "Interface\\Addons\\m_ActionBars\\media\\icon",
		textures_pushed = "Interface\\Addons\\m_ActionBars\\media\\icon",
		textures_btbg = "Interface\\Buttons\\WHITE8x8",
		button_font = "Interface\\Addons\\m_ActionBars\\media\\font.ttf",
	},
}

cfg.bars = {
	["Bar1"] = {
		hide_bar = false,				show_in_combat = false,
		show_on_mouseover = false,		bar_alpha = 1,				fadeout_alpha = 1,
		orientation = "HORIZONTAL",		rows = 1,					buttons = 12,	
		button_size = 45,				button_spacing = cfg.mAB.spacing,
		position = {a="BOTTOM", x=0, y=4},
		custom_visibility_macro = false	-- set a custom visibility macro for this bar or 'false' to disable 
										-- (e.g. "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists]hide;show")
		},
	["Bar2"] = {
		hide_bar = false,				show_in_combat = false,
		show_on_mouseover = false,		bar_alpha = 1,				fadeout_alpha = 1,
		orientation = "VERTICAL",		rows = 2,					buttons = 10,	
		button_size = 35,				button_spacing = cfg.mAB.spacing,
		position = {a="BOTTOM", x=-322, y=4},
		custom_visibility_macro = false
		},
	["Bar3"] = {
		hide_bar = false,				show_in_combat = false,
		show_on_mouseover = false,		bar_alpha = 1,				fadeout_alpha = 1,
		orientation = "VERTICAL",		rows = 2,					buttons = 10,	
		button_size = 35,				button_spacing = cfg.mAB.spacing,
		position = {a="BOTTOM", x=322, y= 4},
		custom_visibility_macro = false
		},
	["Bar4"] = {
		hide_bar = false,				show_in_combat = false,
		show_on_mouseover = true,		bar_alpha = 1,			fadeout_alpha = 0.3,
		orientation = "VERTICAL",		rows = 1,					buttons = 12,	
		button_size = 35,				button_spacing = cfg.mAB.spacing,
		position = {a="BOTTOMRIGHT", x=-41, y=190},
		custom_visibility_macro = false
		},
	["Bar5"] = {
		hide_bar = false,				show_in_combat = false,
		show_on_mouseover = true,		bar_alpha = 1,			fadeout_alpha = 0.3,
		orientation = "VERTICAL",		rows = 1,					buttons = 12,	
		button_size = 35,				button_spacing = cfg.mAB.spacing,
		position = {a="BOTTOMRIGHT", x=-4, y=190},
		custom_visibility_macro = false
		},
	["Bar6"] = {
		hide_bar = true,				show_in_combat = false,
		show_on_mouseover = false,		bar_alpha = 1,				fadeout_alpha = 1,
		orientation = "HORIZONTAL",		rows = 1,					buttons = 12,	
		button_size = cfg.mAB.size,		button_spacing = cfg.mAB.spacing,
		position = {a="BOTTOM", x=0, y=3},
		custom_visibility_macro = false
		},
	["StanceBar"] = {
		hide_bar = false,				show_in_combat = false,
		show_on_mouseover = false,		bar_alpha = 1,				fadeout_alpha = 1,
		orientation = "HORIZONTAL",		rows = 1,					buttons = 6,	
		button_size = 30,				button_spacing = cfg.mAB.spacing,
		position = {a="BOTTOM", x=-188, y=52},
		custom_visibility_macro = false
		},
	["PetBar"] = {
		hide_bar = false,				show_in_combat = false,		scale = 1,
		show_on_mouseover = true,		bar_alpha = 1,				fadeout_alpha = 1,
		orientation = "HORIZONTAL",		rows = 2,						buttons = 10, 
		button_size = cfg.mAB.size+2,			button_spacing = cfg.mAB.spacing,
		position = {a="CENTER", x=-440, y=-210},
		custom_visibility_macro = false
		},
	["MicroMenu"] = {
		hide_bar = false,				show_on_mouseover = false,	scale = 0.85,
		lock_to_CharacterFrame = true,					-- position MicroMenu bar right on top of your CharacterFrame
		position = {a="BOTTOMRIGHT", x=-25, y=300},  	-- if not locked
		},
		
	["ExitVehicleButton"] = {
		hide_bar = false,               disable = false,				user_placed = true,	
		position = {a="BOTTOM", x=255, y=52},
		},
	["ExtraButton"] = {
		disable = false,
		position = {a="BOTTOMRIGHT", x=-130, y=230},
		},

	["RaidIconBar"] = {
		hide = true,					in_group_only = true,
		show_on_mouseover = true,		bar_alpha = 1,				fadeout_alpha = 0,
		orientation = "HORIZONTAL",		rows = 1,
		button_size = 19,				button_spacing = 1,
		position = {a="BOTTOM", x=251, y=10},
		},
	["WorldMarkerBar"] = {
		hide = false,					disable_in_combat = false,	
		show_on_mouseover = true,		bar_alpha = 1,				fadeout_alpha = 0,
		orientation = "HORIZONTAL",		rows = 1,
		button_size = 19,				button_spacing = 1,
		position = {a="TOP", x=0, y=-30},
		},
	}
	
--ButtonsStyler config
cfg.buttons = {
	hide_hotkey = false,		-- remove key binding text from the bars
	hide_macro_name = true,		-- remove macro name text from the bars
	count_font_size = 12,		-- remove count text from the bars
	hotkey_font_size = 11,		-- font size for the key bindings text
	name_font_size = 8,			-- font size for the macro name text
	colors = {	--R,G,B
		   normal = {0,0,0},
		   pushed = {1,1,1},
		highlight = {.9,.8,.6},
		  checked = {.9,.8,.6},
	   outofrange = {.8,.3,.2},
		outofmana = {.3,.3,.7},
		   usable = {1,1,1},
		 unusable = {.4,.4,.4},
		 equipped = {.3,.6,.3}
	  }
}
  
--my personal settings
--[[ if GetUnitName("player") == "Strigoy" or GetUnitName("player") == "Strig" then
	cfg.config_bottomleftbar = {"HORIZONTAL", 1, 12, 30, cfg.mAB.spacing, true, false, false, 1, .3,		
		["Position"] = { a= "BOTTOMRIGHT",	x=	-26,	y= 260}}
	cfg.config_extrabar = {"HORIZONTAL", 1, 8, cfg.mAB.size, cfg.mAB.spacing, false, false, false, 1, 0.5,
		["Position"] = { a= "BOTTOM",		x=	0,		y= 183}}
end ]]
  
  -- HANDOVER
  ns.cfg = cfg
