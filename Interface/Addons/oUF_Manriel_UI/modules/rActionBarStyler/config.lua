
  -- // rActionBarStyler
  -- // zork - 2012

  -----------------------------
  -- INIT
  -----------------------------

  --get the addon namespace
  local cfg = CreateFrame("Frame")
  local addon, ns = ...
  ns.rabs = {}
  ns.rabs.cfg = cfg

  -----------------------------
  -- CONFIG
  -----------------------------

  --use "/rabs" to see the command list

  cfg.bars = {
    --BAR 1
    bar1 = {
      enable          = true, --enable module
      twoRows	        = false,
      scale           = 1,
      padding         = 2, --frame padding
      buttons         = {
        size            = 50,
        margin          = 0,
      },
      pos             = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 2 },
      userplaced      = {
        enable          = false,
      },
      mouseover       = {
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.2},
      },
      combat          = { --fade the bar in/out in combat/out of combat
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.2},
      },
    },
    --OVERRIDE BAR (vehicle ui)
    overridebar = { --the new vehicle and override bar
      enable          = true, --enable module
      scale           = 1,
      padding         = 2, --frame padding
      buttons         = {
        size            = 50,
        margin          = 0,
      },
      pos             = { a1 = "BOTTOM", a2 = "BOTTOM", af = "UIParent", x = 0, y = 2 },
      userplaced      = {
        enable          = false,
      },
      mouseover       = {
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.2},
      },
      combat          = { --fade the bar in/out in combat/out of combat
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.2},
      },
    },
    --BAR 2
    bar2 = {
      enable          = true, --enable module
      twoRows	        = true,
      vertical	  	  = true,
      scale           = 1,
      padding         = 2, --frame padding
      buttons         = {
        size            = 35,
        margin          = 2,
        num				= 10,
      },
      pos             = { a1 = "BOTTOMRIGHT", a2 = "BOTTOMLEFT", af = "rABS_MainMenuBar", x = 0, y = 0 },
      userplaced      = {
        enable          = false,
      },
      mouseover       = {
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.2},
      },
      combat          = { --fade the bar in/out in combat/out of combat
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.2},
      },
    },
    --BAR 3
    bar3 = {
      enable          = true, --enable module
      twoRows	        = true,
      vertical		    = true,
      scale           = 1,
      padding         = 2, --frame padding
      buttons         = {
        size            = 35,
        margin          = 2,
        num				= 10,
      },
      pos             = { a1 = "BOTTOMLEFT", a2 = "BOTTOMRIGHT", af = "rABS_MainMenuBar", x = 0, y = 0 },
      userplaced      = {
        enable          = false,
      },
      mouseover       = {
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.2},
      },
      combat          = { --fade the bar in/out in combat/out of combat
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.2},
      },
    },
    --BAR 4
    bar4 = {
      enable          = true, --enable module
      combineBar4AndBar5  = true, --by choosing true both bar 4 and 5 will react to the same hover effect, thus true/false at the same time, settings for bar5 will be ignored
      scale           = 1,
      padding         = 2, --frame padding
      buttons         = {
        size            = 35,
        margin          = 2,
      },
      pos             = { a1 = "BOTTOMRIGHT", a2 = "BOTTOMRIGHT", af = "UIParent", x = -0, y = 190 },
      userplaced      = {
        enable          = false,
      },
      mouseover       = {
        enable          = true,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.2, alpha = 0.3},
      },
      combat          = { --fade the bar in/out in combat/out of combat
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.2, alpha = 0.3},
      },
    },
    --BAR 5
    bar5 = {
      enable          = true, --enable module
      scale           = 1,
      padding         = 2, --frame padding
      buttons         = {
        size            = 35,
        margin          = 2,
      },
      pos             = { a1 = "BOTTOMRIGHT", a2 = "BOTTOMRIGHT", af = "UIParent", x = -36, y = 190 },
      userplaced      = {
        enable          = false,
      },
      mouseover       = {
        enable          = true,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.2, alpha = 0.3},
      },
      combat          = { --fade the bar in/out in combat/out of combat
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.2, alpha = 0.3},
      },
    },
    --PETBAR
    petbar = {
      enable          = true, --enable module
      show            = true, --true/false
      twoRows         = true,
      vertical        = false,
      scale           = 1,
      padding         = 2, --frame padding
      buttons         = {
        size            = 25,
        margin          = 2,
      },
      pos             = { a1 = "TOPLEFT", a2 = "CENTER", af = "UIParent", x = -450, y = -246 },
      userplaced      = {
        enable          = true,
      },
      mouseover       = {
        enable          = true,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.4},
      },
      combat          = { --fade the bar in/out in combat/out of combat
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.2},
      },
    },
    --STANCE- + POSSESSBAR
    stancebar = {
      enable          = true, --enable module
      show            = true, --true/false
      scale           = 1,
      padding         = 2, --frame padding
      buttons         = {
        size            = 30,
        margin          = 2,
      },
      pos             = { a1 = "BOTTOMLEFT", a2 = "TOPLEFT", af = "rABS_MainMenuBar", x = 0, y = 0 },
      userplaced      = {
        enable          = true,
      },
      mouseover       = {
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.4},
      },
      combat          = { --fade the bar in/out in combat/out of combat
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.2},
      },
    },
    --EXTRABAR
    extrabar = {
      enable          = true, --enable module
      scale           = 1,
      padding         = 10, --frame padding
      buttons         = {
        size            = 50,
        margin          = 5,
      },
      pos             = { a1 = "BOTTOMRIGHT", a2 = "BOTTOMRIGHT", af = "UIParent", x = -130, y = 230 },
      userplaced      = {
        enable          = true,
      },
      mouseover       = {
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.2},
      },
    },
    --VEHICLE EXIT (no vehicleui)
    leave_vehicle = {
      enable          = true, --enable module
      scale           = 1,
      padding         = 10, --frame padding
      buttons         = {
        size            = 30,
        margin          = 2,
      },
      pos             = { a1 = "BOTTOMRIGHT", a2 = "TOPRIGHT", af = "rABS_MainMenuBar", x = 0, y = 0 },
      userplaced      = {
        enable          = true,
      },
      mouseover       = {
        enable          = false,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0.2},
      },
    },
    --MICROMENU
    micromenu = {
      enable          = true, --enable module
      show            = true, --true/false
      scale           = 0.75,
      padding         = 2, --frame padding
      pos             = { a1 = "TOP", a2 = "TOP", af = "UIParent", x = 0, y = -30 },
      userplaced      = {
        enable          = true,
      },
      mouseover       = {
        enable          = true,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.3, alpha = 0},
      },
    },
    --BAGS
    bags = {
      enable          = true, --enable module
      show            = true, --true/false
      only1st         = true,
      scale           = 1,
      padding         = 5, --frame padding
      pos             = { a1 = "BOTTOMRIGHT", a2 = "BOTTOMRIGHT", af = "UIParent", x = -25, y = 0 },
      userplaced      = {
        enable          = true,
      },
      mouseover       = {
        enable          = true,
        fadeIn          = {time = 0.4, alpha = 1},
        fadeOut         = {time = 0.2, alpha = 0},
      },
    },
  }

cfg.buttons = {
  fontName = ns.ManrielUI.config.fontName,
  countFontSize = 12,   -- remove count text from the bars
  hotkeyFontSize = 12,  -- font size for the key bindings text
  nameFontSize = 10,    -- font size for the macro name text
  colors = {  --R,G,B
       normal = {0,0,0},
       pushed = {1,1,1},
    highlight = {.9,.8,.6},
      checked = {.9,.8,.6},
     outofrange = {.8,.3,.2},
    outofmana = {.3,.3,.7},
       usable = {1,1,1},
     unusable = {.4,.4,.4},
     equipped = {.3,.6,.3}
    },
  textures = {
    normal = "Interface\\Addons\\oUF_Manriel_UI\\textures\\icon",
    pushed = "Interface\\Addons\\oUF_Manriel_UI\\textures\\icon",
  }
}