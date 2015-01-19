
  -----------------------------
  -- INIT
  -----------------------------

  --get the addon namespace
  local addon, ns = ...
  local gcfg = ns.rabs.cfg
  --get some values from the namespace
  local cfg = gcfg.bars.petbar
  local dragFrameList = ns.rabs.dragFrameList

  -----------------------------
  -- FUNCTIONS
  -----------------------------

  if not cfg.enable then return end

  local num = NUM_PET_ACTION_SLOTS
  local buttonList = {}

  --create the frame to hold the buttons
  local frame = CreateFrame("Frame", "rABS_PetBar", UIParent, "SecureHandlerStateTemplate")
  if cfg.twoRows then
    local rows = 2
    local cols = ceil(num/2)
    if cfg.vertical then
      frame:SetWidth(cfg.buttons.size*rows + (rows-1)*cfg.buttons.margin + 2*cfg.padding)
      frame:SetHeight(cfg.buttons.size*cols + (cols-1)*cfg.buttons.margin + 2*cfg.padding)
    else
      frame:SetWidth(cfg.buttons.size*cols + (cols-1)*cfg.buttons.margin + 2*cfg.padding)
      frame:SetHeight(cfg.buttons.size*rows + (rows-1)*cfg.buttons.margin + 2*cfg.padding)
    end
  else
    frame:SetWidth(num*cfg.buttons.size + (num-1)*cfg.buttons.margin + 2*cfg.padding)
    frame:SetHeight(cfg.buttons.size + 2*cfg.padding)
  end
  frame:SetPoint(cfg.pos.a1,cfg.pos.af,cfg.pos.a2,cfg.pos.x,cfg.pos.y)
  frame:SetScale(cfg.scale)

  --move the buttons into position and reparent them
  PetActionBarFrame:SetParent(frame)
  PetActionBarFrame:EnableMouse(false)

  for i=1, num do
    local button = _G["PetActionButton"..i]
    table.insert(buttonList, button) --add the button object to the list
    button:SetSize(cfg.buttons.size, cfg.buttons.size)
    button:ClearAllPoints()
    if i == 1 then
      button:SetPoint("TOPLEFT", frame, "TOPLEFT", cfg.padding, -cfg.padding)
    else
      local previous = _G["PetActionButton"..i-1]
      if cfg.twoRows and i == (num/2+1) then
        previous = _G["PetActionButton1"]
        if cfg.vertical then
          button:SetPoint("LEFT", previous, "RIGHT", cfg.buttons.margin, 0)
        else
          button:SetPoint("TOP", previous, "BOTTOM", 0, -cfg.buttons.margin)
        end
      else
        if cfg.vertical then
          button:SetPoint("TOP", previous, "BOTTOM", 0, -cfg.buttons.margin)
        else
          button:SetPoint("LEFT", previous, "RIGHT", cfg.buttons.margin, 0)
        end
      end
    end
    --cooldown fix
    local cd = _G["PetActionButton"..i.."Cooldown"]
    cd:SetAllPoints(button)
  end

  if not cfg.show then --wait...you no see me? :(
    frame:SetParent(ns.pastebin)
    return
  end

  --show/hide the frame on a given state driver
  RegisterStateDriver(frame, "visibility", "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; [@pet,exists,nomounted] show; hide")

  --create drag frame and drag functionality
  if cfg.userplaced.enable then
    rCreateDragFrame(frame, dragFrameList, -2 , true) --frame, dragFrameList, inset, clamp
  end

  --create the mouseover functionality
  if cfg.mouseover.enable then
    rButtonBarFader(frame, buttonList, cfg.mouseover.fadeIn, cfg.mouseover.fadeOut) --frame, buttonList, fadeIn, fadeOut
  end

  --create the combat fader
  if cfg.combat.enable then
    rCombatFrameFader(frame, cfg.combat.fadeIn, cfg.combat.fadeOut) --frame, buttonList, fadeIn, fadeOut
  end