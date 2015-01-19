
  -----------------------------
  -- INIT
  -----------------------------

  --get the addon namespace
  local addon, ns = ...
  local gcfg = ns.rabs.cfg
  --get some values from the namespace
  local cfg = gcfg.bars.bar2
  local dragFrameList = ns.rabs.dragFrameList

  -----------------------------
  -- FUNCTIONS
  -----------------------------

  if not cfg.enable then return end

  local num = cfg.buttons.num or NUM_ACTIONBAR_BUTTONS
  local buttonList = {}

  --create the frame to hold the buttons
  local frame = CreateFrame("Frame", "rABS_MultiBarBottomLeft", UIParent, "SecureHandlerStateTemplate")
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
    if cfg.vertical then
      frame:SetWidth(cfg.buttons.size + 2*cfg.padding)
      frame:SetHeight(num*cfg.buttons.size + (num-1)*cfg.buttons.margin + 2*cfg.padding)
    else
      frame:SetWidth(num*cfg.buttons.size + (num-1)*cfg.buttons.margin + 2*cfg.padding)
      frame:SetHeight(cfg.buttons.size + 2*cfg.padding)
    end
  end
  
  frame:SetPoint(cfg.pos.a1,cfg.pos.af,cfg.pos.a2,cfg.pos.x,cfg.pos.y)
  frame:SetScale(cfg.scale)

  --move the buttons into position and reparent them
  MultiBarBottomLeft:SetParent(frame)
  MultiBarBottomLeft:EnableMouse(false)

  for i=1, NUM_ACTIONBAR_BUTTONS do
    local button = _G["MultiBarBottomLeftButton"..i]
    table.insert(buttonList, button) --add the button object to the list
    button:SetSize(cfg.buttons.size, cfg.buttons.size)
    button:ClearAllPoints()
    if i == 1 then
      button:SetPoint("TOPLEFT", frame, "TOPLEFT", cfg.padding, -cfg.padding)
    else
      local previous = _G["MultiBarBottomLeftButton"..i-1]
      if cfg.twoRows and i == (num/2+1) then
        previous = _G["MultiBarBottomLeftButton1"]
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

    if i > num then
      button:SetAlpha(0)
    end
  end

  --show/hide the frame on a given state driver
  RegisterStateDriver(frame, "visibility", "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; show")

  --create drag frame and drag functionality
  if cfg.userplaced.enable then
    rCreateDragFrame(frame, dragFrameList, -2 , true) --frame, dragFrameList, inset, clamp
  end

  --create the mouseover functionality
  if cfg.mouseover.enable then
    rButtonBarFader(frame, buttonList, cfg.mouseover.fadeIn, cfg.mouseover.fadeOut) --frame, buttonList, fadeIn, fadeOut
    frame.mouseover = cfg.mouseover
  end

  --create the combat fader
  if cfg.combat.enable then
    rCombatFrameFader(frame, cfg.combat.fadeIn, cfg.combat.fadeOut) --frame, buttonList, fadeIn, fadeOut
  end
  