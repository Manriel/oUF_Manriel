
-- rButtonTemplate: core
-- zork, 2016

-----------------------------
-- Variables
-----------------------------

local A, L = ...

-----------------------------
-- rButtonTemplate Global
-----------------------------

local rButtonTemplate = {}
rButtonTemplate.addonName = A

-----------------------------
-- Init
-----------------------------

local function CallButtonFunctionByName(button, func, ...)
  if button and func and button[func] then
    button[func](button, ...)
  end
end

local function ResetAlpha(self,a)
  if not self.__alpha then return end
  if a == self.__alpha then return end
  self:SetAlpha(self.__alpha)
  print(self:GetName(),a)
end

local function ResetNormalTexture(self, file)
  if not self.__normalTextureFile then return end
  if file == self.__normalTextureFile then return end
  self:SetNormalTexture(self.__normalTextureFile)
end

local function ResetTexture(self, file)
  if not self.__textureFile then return end
  if file == self.__textureFile then return end
  self:SetTexture(self.__textureFile)
end

local function ResetVertexColor(self,r,g,b,a)
  if not self.__vertexColor then return end
  local r2,g2,b2,a2 = unpack(self.__vertexColor)
  if not a2 then a2 = 1 end
  if r ~= r2 or g ~= g2 or b ~= b2 or a ~= a2 then
    self:SetVertexColor(r2,g2,b2,a2)
  end
end

local function ApplyPoints(self, points)
  if not points then return end
  self:ClearAllPoints()
  for i, point in next, points do
    self:SetPoint(unpack(point))
  end
end

local function ApplyTexCoord(texture,texCoord)
  if not texCoord then return end
  texture:SetTexCoord(unpack(texCoord))
end

local function ApplyVertexColor(texture,color)
  if not color then return end
  texture.__vertexColor = color
  texture:SetVertexColor(unpack(color))
  hooksecurefunc(texture, "SetVertexColor", ResetVertexColor)
end

local function ApplyAlpha(region,alpha)
  if not alpha then return end
  --region.__alpha = alpha
  region:SetAlpha(alpha)
  --hooksecurefunc(region, "SetAlpha", ResetAlpha)
end

local function ApplyFont(fontString,font)
  if not font then return end
  fontString:SetFont(unpack(font))
end

local function ApplyTexture(texture,file)
  if not file then return end
  texture.__textureFile = file
  texture:SetTexture(file)
  hooksecurefunc(texture, "SetTexture", ResetTexture)
end

local function ApplyNormalTexture(button,file)
  if not file then return end
  button.__normalTextureFile = file
  button:SetNormalTexture(file)
  hooksecurefunc(button, "SetNormalTexture", ResetNormalTexture)
end

local function SetupTexture(texture,cfg,func,button)
  if not texture or not cfg then return end
  ApplyTexCoord(texture,cfg.texCoord)
  ApplyPoints(texture,cfg.points)
  ApplyVertexColor(texture,cfg.color)
  ApplyAlpha(texture,cfg.alpha)
  if func == "SetTexture" then
    ApplyTexture(texture,cfg.file)
  elseif func == "SetNormalTexture" then
    ApplyNormalTexture(button,cfg.file)
  elseif cfg.file then
    CallButtonFunctionByName(button,func,cfg.file)
  end
end

local function SetupFontString(fontString,cfg)
  if not fontString or not cfg then return end
  ApplyPoints(fontString, cfg.points)
  ApplyFont(fontString,cfg.font)
  ApplyAlpha(fontString,cfg.alpha)
end

local function SetupCooldown(cooldown,cfg)
  if not cooldown or not cfg then return end
  ApplyPoints(cooldown, cfg.points)
end

local function SetupBackdrop(button,backdrop)
  if not backdrop then return end
  local bg = CreateFrame("Frame", nil, button)
  ApplyPoints(bg, backdrop.points)
  bg:SetFrameLevel(button:GetFrameLevel()-1)
  bg:SetBackdrop(backdrop)
  if backdrop.backgroundColor then
    bg:SetBackdropColor(unpack(backdrop.backgroundColor))
  end
  if backdrop.borderColor then
    bg:SetBackdropBorderColor(unpack(backdrop.borderColor))
  end
end

function rButtonTemplate:StyleActionButton(button, cfg)
  if not button then return end
  if button.__styled then return end

  local buttonName = button:GetName()
  local icon = _G[buttonName.."Icon"]
  local flash = _G[buttonName.."Flash"]
  local flyoutBorder = _G[buttonName.."FlyoutBorder"]
  local flyoutBorderShadow = _G[buttonName.."FlyoutBorderShadow"]
  local flyoutArrow = _G[buttonName.."FlyoutArrow"]
  local hotkey = _G[buttonName.."HotKey"]
  local count = _G[buttonName.."Count"]
  local name = _G[buttonName.."Name"]
  local border = _G[buttonName.."Border"]
  local NewActionTexture = button.NewActionTexture
  local cooldown = _G[buttonName.."Cooldown"]
  local normalTexture = button:GetNormalTexture()
  local pushedTexture = button:GetPushedTexture()
  local highlightTexture = button:GetHighlightTexture()
  --normal buttons do not have a checked texture, but checkbuttons do and normal actionbuttons are checkbuttons
  local checkedTexture = nil
  if button.GetCheckedTexture then checkedTexture = button:GetCheckedTexture() end
  local floatingBG = _G[buttonName.."FloatingBG"]

  --hide stuff
  if floatingBG then floatingBG:Hide() end

  --backdrop
  SetupBackdrop(button,cfg.backdrop)

  --textures
  SetupTexture(icon,cfg.icon,"SetTexture",icon)
  SetupTexture(flash,cfg.flash,"SetTexture",flash)
  SetupTexture(flyoutBorder,cfg.flyoutBorder,"SetTexture",flyoutBorder)
  SetupTexture(flyoutBorderShadow,cfg.flyoutBorderShadow,"SetTexture",flyoutBorderShadow)
  SetupTexture(border,cfg.border,"SetTexture",border)
  SetupTexture(normalTexture,cfg.normalTexture,"SetNormalTexture",button)
  SetupTexture(pushedTexture,cfg.pushedTexture,"SetPushedTexture",button)
  SetupTexture(highlightTexture,cfg.highlightTexture,"SetHighlightTexture",button)
  SetupTexture(checkedTexture,cfg.checkedTexture,"SetCheckedTexture",button)

  --cooldown
  SetupCooldown(cooldown,cfg.cooldown)

  --hotkey+count+name
  SetupFontString(hotkey,cfg.hotkey)
  SetupFontString(count,cfg.count)
  SetupFontString(name,cfg.name)

  button.__styled = true
end

function rButtonTemplate:StyleExtraActionButton(cfg)

  local button = ExtraActionButton1

  if button.__styled then return end

  local buttonName = button:GetName()

  local icon = _G[buttonName.."Icon"]
  --local flash = _G[buttonName.."Flash"] --wierd the template has two textures of the same name
  local hotkey = _G[buttonName.."HotKey"]
  local count = _G[buttonName.."Count"]
  local buttonstyle = button.style --artwork around the button
  local cooldown = _G[buttonName.."Cooldown"]

  local normalTexture = button:GetNormalTexture()
  local pushedTexture = button:GetPushedTexture()
  local highlightTexture = button:GetHighlightTexture()
  local checkedTexture = button:GetCheckedTexture()

  --backdrop
  SetupBackdrop(button,cfg.backdrop)

  --textures
  SetupTexture(icon,cfg.icon,"SetTexture",icon)
  SetupTexture(buttonstyle,cfg.buttonstyle,"SetTexture",buttonstyle)
  SetupTexture(normalTexture,cfg.normalTexture,"SetNormalTexture",button)
  SetupTexture(pushedTexture,cfg.pushedTexture,"SetPushedTexture",button)
  SetupTexture(highlightTexture,cfg.highlightTexture,"SetHighlightTexture",button)
  SetupTexture(checkedTexture,cfg.checkedTexture,"SetCheckedTexture",button)

  --cooldown
  SetupCooldown(cooldown,cfg.cooldown)

  --hotkey, count
  SetupFontString(hotkey,cfg.hotkey)
  SetupFontString(count,cfg.count)

  button.__styled = true
end

function rButtonTemplate:StyleAllActionButtons(cfg)
  for i = 1, NUM_ACTIONBAR_BUTTONS do
    rButtonTemplate:StyleActionButton(_G["ActionButton"..i],cfg)
    rButtonTemplate:StyleActionButton(_G["MultiBarBottomLeftButton"..i],cfg)
    rButtonTemplate:StyleActionButton(_G["MultiBarBottomRightButton"..i],cfg)
    rButtonTemplate:StyleActionButton(_G["MultiBarRightButton"..i],cfg)
    rButtonTemplate:StyleActionButton(_G["MultiBarLeftButton"..i],cfg)
  end
  for i = 1, 6 do
    rButtonTemplate:StyleActionButton(_G["OverrideActionBarButton"..i],cfg)
  end
  --petbar buttons
  for i=1, NUM_PET_ACTION_SLOTS do
    rButtonTemplate:StyleActionButton(_G["PetActionButton"..i],cfg)
  end
  --stancebar buttons
  for i=1, NUM_STANCE_SLOTS do
    rButtonTemplate:StyleActionButton(_G["StanceButton"..i],cfg)
  end
  --possess buttons
  for i=1, NUM_POSSESS_SLOTS do
    rButtonTemplate:StyleActionButton(_G["PossessButton"..i],cfg)
  end
end

L.rButtonTemplate = rButtonTemplate