
  -----------------------------
  -- INIT
  -----------------------------

  --get the addon namespace
  local addon, ns = ...
  local gcfg = ns.rabs.cfg
  --get some values from the namespace
  local cfg = gcfg.bars.bags
  local dragFrameList = ns.rabs.dragFrameList

  -----------------------------
  -- FUNCTIONS
  -----------------------------

  if not cfg.enable then return end

  --bag button objects
  local buttonList = {
      MainMenuBarBackpackButton,
      CharacterBag0Slot,
      CharacterBag1Slot,
      CharacterBag2Slot,
      CharacterBag3Slot,
  }

  local NUM_BAG_BUTTONS = # buttonList
  local buttonWidth = MainMenuBarBackpackButton:GetWidth()
  local buttonHeight = MainMenuBarBackpackButton:GetHeight()
  local gap = 2

  --create the frame to hold the buttons
  local frame = CreateFrame("Frame", "rABS_BagFrame", UIParent, "SecureHandlerStateTemplate")
  if only1st then
    frame:SetWidth(buttonWidth + 2*cfg.padding)
  else
    frame:SetWidth(NUM_BAG_BUTTONS*buttonWidth + (NUM_BAG_BUTTONS-1)*gap + 2*cfg.padding)
  end
  frame:SetHeight(buttonHeight + 2*cfg.padding)
  frame:SetPoint(cfg.pos.a1,cfg.pos.af,cfg.pos.a2,cfg.pos.x,cfg.pos.y)
  frame:SetScale(cfg.scale)

  --move the buttons into position and reparent them
  for _, button in pairs(buttonList) do
    button:SetParent(frame)
    if cfg.only1st then
      button:Hide()
      button:SetAlpha(0)
    end
  end
  MainMenuBarBackpackButton:Show()
  MainMenuBarBackpackButton:SetAlpha(1)
  MainMenuBarBackpackButton:ClearAllPoints()
  MainMenuBarBackpackButton:SetPoint("RIGHT", -cfg.padding, 0)

  if not cfg.show then --wait...you no see me? :(
    frame:SetParent(ns.pastebin)
    return
  end

  --show/hide the frame on a given state driver
  RegisterStateDriver(frame, "visibility", "[petbattle] hide; show")

  --create drag frame and drag functionality
  if cfg.userplaced.enable then
    rCreateDragFrame(frame, dragFrameList, -2 , true) --frame, dragFrameList, inset, clamp
  end

  --create the mouseover functionality
  if cfg.mouseover.enable then
    rButtonBarFader(frame, buttonList, cfg.mouseover.fadeIn, cfg.mouseover.fadeOut) --frame, buttonList, fadeIn, fadeOut
  end
