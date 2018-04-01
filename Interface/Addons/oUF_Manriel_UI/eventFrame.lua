local parent, namespace = ...

local UI = namespace.ManrielUI

local function HideBlizzardAuraFrames()
   -- Initially seperated out to provide better Entering/Exiting Vehicle support, but that currently taints. Leaving it in because hey why not, it saves an if statement.
   
   BuffFrame:UnregisterEvent("UNIT_AURA")
   BuffFrame:Hide()

   TemporaryEnchantFrame:UnregisterEvent("UNIT_AURA")
   TemporaryEnchantFrame:Hide()
end

local eventFrame = CreateFrame("Frame")
eventFrame.PLAYER_ENTERING_WORLD = function(self)
	local scale = GetScreenWidth() * UIParent:GetEffectiveScale() / 1920
	-- print(GetScreenWidth());
	-- print(scale);
	UIParent:SetScale(scale)
	HideBlizzardAuraFrames()
end

eventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eventFrame:SetScript("OnEvent", function(self, event, ...) eventFrame[event](self, ...) end)


-- local texture = eventFrame:CreateTexture(nil, 'OVERLAY');
-- texture:SetTexture([[Interface\Addons\oUF_Manriel_UI\textures\flame]])
-- texture:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 30, -30)
-- texture:SetSize(56, 128);

-- local updateTexture = function( self, elapsed )
-- 	AnimateTexCoords(texture, 512, 128, 56, 128, 9, elapsed, 0.05)
-- end

-- eventFrame:SetScript("OnUpdate", function( ... ) updateTexture( ... ) end)


UI.events = eventFrame;

if (not IsAddOnLoaded('Blizzard_DebugTools')) then
	LoadAddOn('Blizzard_DebugTools');
end