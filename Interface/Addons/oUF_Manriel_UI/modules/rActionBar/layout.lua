
-- rActionBar_Default: layout
-- zork, 2016

-- Default Bar Layout for rActionBar

-----------------------------
-- Variables
-----------------------------

local A, L = ...

local rActionBar      = L.rActionBar
local rButtonTemplate = L.rButtonTemplate
local LSM             = L.ManrielUI.lib.LSM
local fn              = L.ManrielUI.fn

-----------------------------
-- Fader
-----------------------------

local fader = {
  full = {
    fadeInAlpha = 1,
    fadeInDuration = 0.3,
    fadeInSmooth = "OUT",
    fadeOutAlpha = 0,
    fadeOutDuration = 0.9,
    fadeOutSmooth = "OUT",
  },
  half = {
    fadeInAlpha = 1,
    fadeInDuration = 0.3,
    fadeInSmooth = "OUT",
    fadeOutAlpha = .3,
    fadeOutDuration = 0.9,
    fadeOutSmooth = "OUT",
  }
}

-----------------------------
-- BagBar
-----------------------------

local bagbar = {
  framePoint      = { "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -30, 5 },
  frameScale      = 1,
  framePadding    = 3,
  buttonWidth     = 32,
  buttonHeight    = 32,
  buttonMargin    = 2,
  numCols         = 1, --number of buttons per column
  showOneBag      = true,
  startPoint      = "BOTTOMRIGHT", --start postion of first button: BOTTOMLEFT, TOPLEFT, TOPRIGHT, BOTTOMRIGHT
  fader           = fader.full,
}
--create
rActionBar:CreateBagBar(A, bagbar)

-----------------------------
-- MicroMenuBar
-----------------------------

local micromenubar = {
  framePoint      = { "TOP", UIParent, "TOP", 0, -18 },
  frameScale      = .8,
  framePadding    = 3,
  buttonWidth     = 28,
  buttonHeight    = 58,
  buttonMargin    = 0,
  numCols         = 12,
  startPoint      = "BOTTOMLEFT",
  fader           = fader.full,
}
--create
rActionBar:CreateMicroMenuBar(A, micromenubar)

-----------------------------
-- Bar1
-----------------------------

local bar1 = {
  framePoint      = { "BOTTOM", UIParent, "BOTTOM", 0, 18 },
  frameScale      = 1,
  framePadding    = 3,
  buttonWidth     = 48,
  buttonHeight    = 48,
  buttonMargin    = 1,
  numCols         = 12,
  startPoint      = "BOTTOMLEFT",
  fader           = nil,
}
--create
rActionBar:CreateActionBar1(A, bar1)

-----------------------------
-- Bar2
-----------------------------

local bar2 = {
  framePoint      = { "BOTTOMRIGHT", A.."Bar1", "BOTTOMLEFT", 0, -18 },
  frameScale      = 1,
  framePadding    = 3,
  buttonWidth     = 32,
  buttonHeight    = 32,
  buttonMargin    = 1,
  numCols         = 2,
  numButtons      = 10,
  startPoint      = "TOPLEFT",
  fader           = nil,
}
--create
rActionBar:CreateActionBar2(A, bar2)

-----------------------------
-- Bar3
-----------------------------

local bar3 = {
  framePoint      = { "BOTTOMLEFT", A.."Bar1", "BOTTOMRIGHT", 0, -18 },
  frameScale      = 1,
  framePadding    = 3,
  buttonWidth     = 32,
  buttonHeight    = 32,
  buttonMargin    = 1,
  numCols         = 2,
  numButtons      = 10,
  startPoint      = "TOPLEFT",
  fader           = nil,
}
--create
rActionBar:CreateActionBar3(A, bar3)

-----------------------------
-- Bar4
-----------------------------

local bar4 = {
  framePoint      = { "BOTTOMRIGHT", Minimap, "TOPRIGHT", 0, 5 },
  frameScale      = 1,
  framePadding    = 3,
  buttonWidth     = 40,
  buttonHeight    = 40,
  buttonMargin    = 1,
  numCols         = 1,
  startPoint      = "TOPRIGHT",
  fader           = fader.half,
}
--create
rActionBar:CreateActionBar4(A, bar4)

-----------------------------
-- Bar5
-----------------------------

local bar5 = {
  framePoint      = { "RIGHT", A.."Bar4", "LEFT", 0, 0 },
  frameScale      = 1,
  framePadding    = 1,
  buttonWidth     = 40,
  buttonHeight    = 40,
  buttonMargin    = 1,
  numCols         = 1,
  startPoint      = "TOPRIGHT",
  fader           = fader.half,
}
--create
rActionBar:CreateActionBar5(A, bar5)

-----------------------------
-- StanceBar
-----------------------------

local stancebar = {
  framePoint      = { "BOTTOMLEFT", A.."Bar1", "TOPLEFT", 0, 0 },
  frameScale      = 1,
  framePadding    = 3,
  buttonWidth     = 32,
  buttonHeight    = 32,
  buttonMargin    = 1,
  numCols         = 12,
  startPoint      = "BOTTOMLEFT",
  fader           = nil,
}
--create
rActionBar:CreateStanceBar(A, stancebar)

-----------------------------
-- PetBar
-----------------------------

--petbar
local petbar = {
  framePoint      = { "BOTTOMLEFT", A.."Bar1", "TOPLEFT", 0, 0},
  frameScale      = 0.8,
  framePadding    = 3,
  buttonWidth     = 32,
  buttonHeight    = 32,
  buttonMargin    = 1,
  numCols         = 12,
  startPoint      = "BOTTOMLEFT",
  fader           = nil,
}
--create
rActionBar:CreatePetBar(A, petbar)

-----------------------------
-- ExtraBar
-----------------------------

local extrabar = {
  framePoint      = { "BOTTOMRIGHT", A.."Bar1", "TOPRIGHT", 0, 0 },
  frameScale      = 1,
  framePadding    = 3,
  buttonWidth     = 48,
  buttonHeight    = 48,
  buttonMargin    = 1,
  numCols         = 1,
  startPoint      = "BOTTOMLEFT",
  fader           = nil,
}
--create
rActionBar:CreateExtraBar(A, extrabar)

-----------------------------
-- VehicleExitBar
-----------------------------

local vehicleexitbar = {
  framePoint      = { "BOTTOMRIGHT", A.."Bar1", "TOPRIGHT", 0, 0 },
  frameScale      = 1,
  framePadding    = 3,
  buttonWidth     = 32,
  buttonHeight    = 32,
  buttonMargin    = 1,
  numCols         = 1,
  startPoint      = "BOTTOMLEFT",
  fader           = nil,
}
--create
rActionBar:CreateVehicleExitBar(A, vehicleexitbar)

-----------------------------
-- PossessExitBar
-----------------------------

local possessexitbar = {
  framePoint      = { "BOTTOMRIGHT", A.."Bar1", "TOPRIGHT", 0, 0 },
  frameScale      = 1,
  framePadding    = 3,
  buttonWidth     = 32,
  buttonHeight    = 32,
  buttonMargin    = 1,
  numCols         = 1,
  startPoint      = "BOTTOMLEFT",
  fader           = nil,
}
--create
rActionBar:CreatePossessExitBar(A, possessexitbar)

-----------------------------
-- actionButtonConfig
-----------------------------

local actionButtonConfig = {}

--backdrop
actionButtonConfig.backdrop = {
  bgFile   = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Background'),
  tile = true,
  tileSize = 256,
  edgeFile = LSM:Fetch(LSM.MediaType.BORDER,     'Manriel-Border-Light'),
  edgeSize = 12,
  insets   = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
  },
  backgroundColor = { 1, 1, 1, 1 },
  borderColor = { 1, 1, 1, 1 },
  points = {
    {"TOPLEFT", -3, 3 },
    {"BOTTOMRIGHT", 3, -3 },
  },
}

--icon
actionButtonConfig.icon = {
  texCoord = {.05, .95, .05, .95},
  points = {
    {"TOPLEFT", 2, -2 },
    {"BOTTOMRIGHT", -2, 2 },
  },
}

--flyoutBorder
actionButtonConfig.flyoutBorder = {
  file = ""
}

--flyoutBorderShadow
actionButtonConfig.flyoutBorderShadow = {
  file = ""
}

--border
actionButtonConfig.border = {
  file = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Caith'),
  points = {
    {"TOPLEFT", -2, 2 },
    {"BOTTOMRIGHT", 2, -2 },
  },
}

--normalTexture
actionButtonConfig.normalTexture = {
  file = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Icon'),
  color = { .5, .5, .5 , 1 },
  points = {
    {"TOPLEFT", -1, 1 },
    {"BOTTOMRIGHT", 1, -1 },
  },
}
--pushedTexture
actionButtonConfig.pushedTexture = {
  file = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Caith'),
  color = { 1, .81, 0, 1 },
  points = {
    {"TOPLEFT", -1, 1 },
    {"BOTTOMRIGHT", 1, -1 },
  },
}
--checkedTexture
actionButtonConfig.checkedTexture = {
  file = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Caith'),
  color = { 1, .81, 0, .5 },
  points = {
    {"TOPLEFT", -1, 1 },
    {"BOTTOMRIGHT", 1, -1 },
  },
}

--cooldown
actionButtonConfig.cooldown = {
  points = {
    {"TOPLEFT", 2, -2 },
    {"BOTTOMRIGHT", -2, 2 },
  },
}

--name (macro name fontstring)
actionButtonConfig.name = {
  font = { LSM:Fetch(LSM.MediaType.FONT, 'San Francisco (Bold)'), 10, "OUTLINE"},
  points = {
    {"BOTTOMLEFT", 2, 2 },
    {"BOTTOMRIGHT", -2, 2 },
  },
}

--hotkey
actionButtonConfig.hotkey = {
  font = { LSM:Fetch(LSM.MediaType.FONT, 'San Francisco (Bold)'), 11, "OUTLINE"},
  points = {
    {"TOPLEFT", 2, -2 },
    {"TOPRIGHT", -2, -2 },
  },
  --alpha = 0,
}

--count
actionButtonConfig.count = {
  font = { LSM:Fetch(LSM.MediaType.FONT, 'San Francisco (Bold)'), 11, "OUTLINE"},
  points = {
    {"BOTTOMRIGHT", -2, 2 },
  },
}

--rButtonTemplate:StyleAllActionButtons
rButtonTemplate:StyleAllActionButtons(actionButtonConfig)


-----------------------------
-- extraButtonConfig
-----------------------------

local extraButtonConfig = fn.CopyDeep(actionButtonConfig)
extraButtonConfig.buttonstyle = { file = "" }

--rButtonTemplate:StyleExtraActionButton
rButtonTemplate:StyleExtraActionButton(extraButtonConfig)