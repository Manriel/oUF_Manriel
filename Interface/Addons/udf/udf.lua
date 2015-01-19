local parent, ns = ...

function Res()
  TargetName,TargetRealm = UnitName("target"); 
  if (TargetName) then 
    genitive, dative, accusative, instrumental, prepositional = DeclineName (TargetName, UnitSex("target"), 1);
	if UnitIsDead("target") then
    	  SendChatMessage("Воскрешаю ".. accusative .."!", "YELL", nil, TargetName); 
	end
  end
end

function MakeRulers() 
	local panel = _G['Manriel_Rulers'];
	if not panel then
		panel = CreateFrame('Frame', 'Manriel_Rulers', UIParent)
		panel:SetAllPoints(UIParent)
		panel:SetFrameStrata("FULLSCREEN_DIALOG")
		-- panel:SetFrameLevel(1)
		panel:Show()

		-- Main Rulers START
		local verticalMiddle = panel:CreateTexture('VerticalMiddle', 'HIGHLIGHT')
		verticalMiddle:SetDrawLayer("OVERLAY")
		verticalMiddle:SetSize(1, UIParent:GetHeight())
		verticalMiddle:SetPoint('CENTER', 0, 0)
		verticalMiddle:SetTexture(1,0,0,1)
		verticalMiddle:Show()
		panel.verticalMiddle = verticalMiddle

		local verticalLEFT = panel:CreateTexture('VerticalLEFT', 'HIGHLIGHT')
		verticalLEFT:SetDrawLayer("OVERLAY")
		verticalLEFT:SetSize(1, UIParent:GetHeight())
		verticalLEFT:SetPoint('LEFT', 0, 0)
		verticalLEFT:SetTexture(1,0,0,1)
		verticalLEFT:Show()
		panel.verticalLEFT = verticalLEFT

		local verticalHALFLEFT = panel:CreateTexture('VerticalHALFLEFT', 'HIGHLIGHT')
		verticalHALFLEFT:SetDrawLayer("OVERLAY")
		verticalHALFLEFT:SetSize(1, UIParent:GetHeight())
		verticalHALFLEFT:SetPoint('LEFT', UIParent:GetWidth()/4, 0)
		verticalHALFLEFT:SetTexture(1,0,0,1)
		verticalHALFLEFT:Show()
		panel.verticalHALFLEFT = verticalHALFLEFT

		local verticalRIGHT = panel:CreateTexture('VerticalRIGHT', 'HIGHLIGHT')
		verticalRIGHT:SetDrawLayer("OVERLAY")
		verticalRIGHT:SetSize(1, UIParent:GetHeight())
		verticalRIGHT:SetPoint('RIGHT', 0, 0)
		verticalRIGHT:SetTexture(1,0,0,1)
		verticalRIGHT:Show()
		panel.verticalRIGHT = verticalRIGHT


		local verticalHALFRIGHT = panel:CreateTexture('VerticalHALFRIGHT', 'HIGHLIGHT')
		verticalHALFRIGHT:SetDrawLayer("OVERLAY")
		verticalHALFRIGHT:SetSize(1, UIParent:GetHeight())
		verticalHALFRIGHT:SetPoint('RIGHT', -UIParent:GetWidth()/4, 0)
		verticalHALFRIGHT:SetTexture(1,0,0,1)
		verticalHALFRIGHT:Show()
		panel.verticalHALFRIGHT = verticalHALFRIGHT

		local horizontalMiddle = panel:CreateTexture('horizontalMiddle', 'HIGHLIGHT')
		horizontalMiddle:SetDrawLayer("OVERLAY")
		horizontalMiddle:SetSize(UIParent:GetWidth(), 1)
		horizontalMiddle:SetPoint('CENTER', 0, 0)
		horizontalMiddle:SetTexture(1,0,0,1)
		horizontalMiddle:Show()
		panel.horizontalMiddle = horizontalMiddle

		local horizontalTOP = panel:CreateTexture('horizontalTOP', 'HIGHLIGHT')
		horizontalTOP:SetDrawLayer("OVERLAY")
		horizontalTOP:SetSize(UIParent:GetWidth(), 1)
		horizontalTOP:SetPoint('TOP', 0, 0)
		horizontalTOP:SetTexture(1,0,0,1)
		horizontalTOP:Show()
		panel.horizontalTOP = horizontalTOP

		local horizontalHALFTOP = panel:CreateTexture('horizontalHALFTOP', 'HIGHLIGHT')
		horizontalHALFTOP:SetDrawLayer("OVERLAY")
		horizontalHALFTOP:SetSize(UIParent:GetWidth(), 1)
		horizontalHALFTOP:SetPoint('TOP', 0, -UIParent:GetHeight()/4)
		horizontalHALFTOP:SetTexture(1,0,0,1)
		horizontalHALFTOP:Show()
		panel.horizontalHALFTOP = horizontalHALFTOP

		local horizontalTop = panel:CreateTexture('horizontalBOTTOM', 'HIGHLIGHT')
		horizontalBOTTOM:SetDrawLayer("OVERLAY")
		horizontalBOTTOM:SetSize(UIParent:GetWidth(), 1)
		horizontalBOTTOM:SetPoint('BOTTOM', 0, 0)
		horizontalBOTTOM:SetTexture(1,0,0,1)
		horizontalBOTTOM:Show()
		panel.horizontalBOTTOM = horizontalBOTTOM

		local horizontalHALFBOTTOM = panel:CreateTexture('horizontalHALFBOTTOM', 'HIGHLIGHT')
		horizontalHALFBOTTOM:SetDrawLayer("OVERLAY")
		horizontalHALFBOTTOM:SetSize(UIParent:GetWidth(), 1)
		horizontalHALFBOTTOM:SetPoint('BOTTOM', 0, UIParent:GetHeight()/4)
		horizontalHALFBOTTOM:SetTexture(1,0,0,1)
		horizontalHALFBOTTOM:Show()
		panel.horizontalHALFBOTTOM = horizontalHALFBOTTOM
		-- Main Rulers END

		-- Custon Rulers START
		local ManrielBottomHorizontal = panel:CreateTexture('ManrielBottomHorizontal', 'HIGHLIGHT')
		ManrielBottomHorizontal:SetDrawLayer("OVERLAY")
		ManrielBottomHorizontal:SetSize(UIParent:GetWidth(), 1)
		ManrielBottomHorizontal:SetPoint('BOTTOM', 0, 190)
		ManrielBottomHorizontal:SetTexture(0,1,0,1)
		ManrielBottomHorizontal:Show()
		panel.ManrielBottomHorizontal = ManrielBottomHorizontal

		local ManrielTopHorizontal = panel:CreateTexture('ManrielTopHorizontal', 'HIGHLIGHT')
		ManrielTopHorizontal:SetDrawLayer("OVERLAY")
		ManrielTopHorizontal:SetSize(UIParent:GetWidth(), 1)
		ManrielTopHorizontal:SetPoint('TOP', 0, -25)
		ManrielTopHorizontal:SetTexture(0,1,0,1)
		ManrielTopHorizontal:Show()
		panel.ManrielTopHorizontal = ManrielTopHorizontal
		-- Custom Rulers END

		panel:Hide()
	end

	if panel:IsVisible() then
		panel:Hide()
	else
		panel:Show()
	end
end
SlashCmdList["MAKERULERS"] = function() MakeRulers() end
SLASH_MAKERULERS1 = "/rulers"

function Overlay(cmd) 
	local overlay = _G['ManrielOverlay']
	if not overlay then
		overlay = CreateFrame('Frame', 'ManrielOverlay', UIParent)
		overlay:SetFrameStrata("BACKGROUND")
		overlay:SetAllPoints(UIParent)
		local texture = overlay:CreateTexture(nil, 'BACKGROUND')
		texture:SetDrawLayer("ARTWORK")
		texture:SetTexture(1,1,1,1)
		texture:SetAllPoints(overlay)

		overlay.texture = texture
		overlay:Hide()
	end

	cmd = tonumber(cmd)
	if cmd == nil then cmd = 0 end
	cmd = cmd/100
	if cmd < 0 then cmd = 0 end
	if cmd > 1 then cmd = 1 end
	if cmd == 0 then overlay:Hide() else
		overlay.texture:SetAlpha(cmd);
		overlay:Show()
	end
end
SlashCmdList["OVERLAY"] = function(cmd) Overlay(cmd) end
SLASH_OVERLAY1 = "/overlay"