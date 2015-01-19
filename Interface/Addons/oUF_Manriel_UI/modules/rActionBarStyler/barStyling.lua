local addon, ns = ...

local buttonList = {}

for i=1, NUM_ACTIONBAR_BUTTONS do
  local button = _G["ActionButton"..i]
  table.insert(buttonList, button) --add the button object to the list
end

for i=1, NUM_ACTIONBAR_BUTTONS do
  local button = _G["MultiBarBottomLeftButton"..i]
  table.insert(buttonList, button) --add the button object to the list  
end

for i=1, NUM_ACTIONBAR_BUTTONS do
  local button = _G["MultiBarBottomRightButton"..i]
  table.insert(buttonList, button) --add the button object to the list  
end

for i=1, NUM_ACTIONBAR_BUTTONS do
  local button = _G["MultiBarRightButton"..i]
  table.insert(buttonList, button) --add the button object to the list  
end

for i=1, NUM_ACTIONBAR_BUTTONS do
  local button = _G["MultiBarLeftButton"..i]
  table.insert(buttonList, button) --add the button object to the list  
end

for i=1, NUM_PET_ACTION_SLOTS do
  local button = _G["PetActionButton"..i]
  table.insert(buttonList, button) --add the button object to the list  
end

for i=1, NUM_STANCE_SLOTS do
  local button = _G["StanceButton"..i]
  table.insert(buttonList, button) --add the button object to the list  
end

for i=1, NUM_POSSESS_SLOTS do
  local button = _G["PossessButton"..i]
  table.insert(buttonList, button) --add the button object to the list
end

for i=1, 6 do
  local button = _G["OverrideActionBarButton"..i]
  table.insert(buttonList, button) --add the button object to the list  
end

-- local button = _G["rABS_LeaveVehicleButton"]
-- table.insert(buttonList, button)

local gcfg = ns.rabs.cfg
--get some values from the namespace
local cfg = gcfg.buttons

local function SetIconTexture(self, button,  crop)
	if self then
		if crop then self:SetTexCoord(.1, .9, .1, .9) end
		self:SetPoint("TOPLEFT", 2, -2)
		self:SetPoint("BOTTOMRIGHT", -2, 2)
	end
end
local function SetNormalTexture(self)
	if self then
		self:SetTexture(cfg.textures.normal)
		self:SetTexCoord(.05, .95, .05, .95)
		self:SetPoint("TOPLEFT")
		self:SetPoint("BOTTOMRIGHT")
		self:SetVertexColor(unpack(cfg.colors.normal))
		self:ClearAllPoints()
		self:SetAllPoints(self:GetParent())
	end
end
local function SetPushedTexture(self)
	if self then
		self:SetTexture(cfg.textures.pushed)
		self:SetTexCoord(.05, .95, .05, .95)
		self:SetVertexColor(unpack(cfg.colors.pushed))
	end
end
local function SetHighlightTexture(self)
	if self then
		self:SetTexture(cfg.textures.normal)
		self:SetTexCoord(.05, .95, .05, .95)
		self:SetVertexColor(unpack(cfg.colors.highlight))
	end
end
local function SetCheckedTexture(self)
	if self then
		self:SetTexture(cfg.textures.normal)
		self:SetTexCoord(.05, .95, .05, .95)
		self:SetVertexColor(unpack(cfg.colors.checked))
	end
end
local function SetTextures(self)
	if self.icon then
		SetIconTexture(self.icon, self, true)
	end
	SetNormalTexture(self:GetNormalTexture(), self)
	SetPushedTexture(self:GetPushedTexture(), self)
	SetHighlightTexture(self:GetHighlightTexture(), self)
	SetCheckedTexture(self:GetCheckedTexture(), self)
end

local function Stylize(button)
	-- print(button:GetName())
	button.Border:SetTexture(nil)

	SetTextures(button)

	button.cooldown:ClearAllPoints()
	button.cooldown:SetPoint("TOPLEFT", button, "TOPLEFT", 2, -2)
  button.cooldown:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 2)

  -- button.rangeTimer:Hide();

	button.HotKey:SetFont(cfg.fontName, cfg.hotkeyFontSize, "THINOUTLINE")
	button.HotKey:ClearAllPoints()
	button.HotKey:SetPoint("TOPRIGHT", -2, -4)

	button.Count:SetFont(cfg.fontName, cfg.countFontSize, "THINOUTLINE")
	button.Count:ClearAllPoints()
	button.Count:SetPoint("BOTTOMRIGHT", 0, 2)

	button.Name:SetFont(cfg.fontName, cfg.nameFontSize, "THINOUTLINE")
	button.Name:ClearAllPoints()
	button.Name:SetPoint("BOTTOMLEFT", 2, 2)
end

local function updateRange(self, elapsed)

  local icon = _G[self:GetName()..'Icon']
  local normalTexture = _G[self:GetName().."NormalTexture"];
  local action = _G[self:GetName()].action
  if ( not normalTexture ) then
    return;
  end
  if ( not icon ) then
  	return;
  end
   
  local isUsable, notEnoughMana = IsUsableAction(self.action);
  if ( isUsable ) then
    icon:SetVertexColor(1.0, 1.0, 1.0);
    normalTexture:SetVertexColor(1.0, 1.0, 1.0);
  elseif ( notEnoughMana ) then
    icon:SetVertexColor(0.5, 0.5, 1.0);
    normalTexture:SetVertexColor(0.5, 0.5, 1.0);
  else
    icon:SetVertexColor(0.4, 0.4, 0.4);
    normalTexture:SetVertexColor(1.0, 1.0, 1.0);
  end
	
	local inRange = IsActionInRange(action);
  if ( inRange == false ) then
    icon:SetVertexColor(1.0, 0.1, 0.1)
    normalTexture:SetVertexColor(1.0, 0.1, 0.1);
  end

end
hooksecurefunc('ActionButton_OnUpdate', updateRange)

do
	for _, button in pairs(buttonList) do
	  Stylize(button)
	end
	hooksecurefunc('ActionButton_OnUpdate', updateRange)
end
