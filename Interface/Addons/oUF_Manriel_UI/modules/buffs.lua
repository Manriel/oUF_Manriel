local parent, ns = ...
local oUF = ns.oUF
local UI = ns.ManrielUI
local config = UI.config

local BuffFrame = _G["BuffFrame"]
local ConsolidatedBuffs = _G["ConsolidatedBuffs"]

local lsBuffHeader = CreateFrame("Frame", "lsBuffHeader", UIParent)
lsBuffHeader:SetSize(28, 28)
lsBuffHeader:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -6, -60)

local lsDebuffHeader = CreateFrame("Frame", "lsDebuffHeader", UIParent)
lsDebuffHeader:SetSize(28, 28)
lsDebuffHeader:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -6, -140)

local lsTemporaryEnchantHeader = CreateFrame("Frame", "lsTemporaryEnchantHeader", UIParent)
lsTemporaryEnchantHeader:SetSize(28, 28)
lsTemporaryEnchantHeader:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -6, -180)

local function SetDurationText(duration, arg1, arg2)
	duration:SetText(format(gsub(arg1, "[ .]", ""), arg2))
end

local function UpdateBuffAnchors()
	local numBuffs, slack = 0, 0
	local button, previous, above

	if IsInGroup() and GetCVarBool("consolidateBuffs") then
		slack = 1
	end

	for i = 1, BUFF_ACTUAL_DISPLAY do
		button = _G["BuffButton"..i]

		if not button.consolidated then
			numBuffs = numBuffs + 1
			index = numBuffs + slack

			if button.parent ~= BuffFrame then
				button.count:SetFont(config.fontName, 12, "THINOUTLINE")
				button:SetParent(BuffFrame)
				button.parent = BuffFrame
			end

			button:ClearAllPoints()
			button:SetSize(28, 28)

			if index > 1 and (mod(index, 16) == 1) then
				if index == 17 then
					button:SetPoint("TOP", ConsolidatedBuffs, "BOTTOM", 0, -8)
				else
					button:SetPoint("TOP", above, "BOTTOM", 0, -8)
				end

				above = button
			elseif index == 1 then
				button:SetPoint("TOPRIGHT", BuffFrame, "TOPRIGHT", 0, 0)

				above = button
			else
				if numBuffs == 1 then
					button:SetPoint("RIGHT", ConsolidatedBuffs, "LEFT", -8, 0)
				else
					button:SetPoint("RIGHT", previous, "LEFT", -8, 0)
				end
			end

			previous = button
		end
	end
end

local function UpdateDebuffAnchors(buttonName, index)
	local rows = ceil(BUFF_ACTUAL_DISPLAY / 16)
	local button = _G[buttonName..index]

	button:ClearAllPoints()
	button:SetSize(28, 28)
	button:Hide()

	if index == 1 then
		button:SetPoint("TOPRIGHT", lsDebuffHeader, "TOPRIGHT", 0, 0)
	else
		button:SetPoint("RIGHT", _G[buttonName..(index - 1)], "LEFT", -4, 0)
	end
end

local function UpdateTemporaryEnchantAnchors(self)
	local previous
	for i = 1, NUM_TEMP_ENCHANT_FRAMES do
		local button = _G["TempEnchant"..i]
		if button then
			button:ClearAllPoints()
			button:SetSize(28, 28)

			if i == 1 then
				button:SetPoint("TOPRIGHT", self, "TOPRIGHT", 0, 0)
			else
				button:SetPoint("RIGHT", previous, "LEFT", -4, 0)
			end

			previous = button
		end
	end
end

local function SetAuraButtonStyle(btn, index, atype)
	local name = btn..(index or "")
	local button = _G[name]

	if not button then return end
	if button.styled then return end

	local bBorder = _G[name.."Border"]
	local bIcon = _G[name.."Icon"]
	local bCount = _G[name.."Count"]
	local bDuration = _G[name.."Duration"]

	if bIcon then
		bIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		bIcon:SetDrawLayer("BACKGROUND", 0)
		bIcon:ClearAllPoints()
		bIcon:SetPoint("TOPLEFT", button, "TOPLEFT", 0, 0)
		bIcon:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, 0)
		if atype == "CONSOLIDATED" then
			bIcon:SetTexCoord(18 / 128, 46 / 128, 18 / 64, 46 / 64)
		end
	end

	if bCount then
		bCount:SetFont(config.fontName, config.baseFontSize, "THINOUTLINE")
		bCount:ClearAllPoints()
		bCount:SetPoint("TOPRIGHT", 0, 0)
	end

	if bDuration then
		bDuration:SetFont(config.fontName, config.baseFontSize, "THINOUTLINE")
		bDuration:ClearAllPoints()
		bDuration:SetPoint("TOP", button, "BOTTOM", 0, -2)
		hooksecurefunc(bDuration, "SetFormattedText", SetDurationText)
	end

	if not bBorder then
		bBorder = button:CreateTexture(nil, "BORDER", nil, 0)
	end

	bBorder:SetTexture(config.textureBorder)
	-- bBorder:SetTexCoord(14 / 64, 50 / 64, 14 / 64, 50 / 64)
	bBorder:ClearAllPoints()
	bBorder:SetPoint("TOPLEFT", button, "TOPLEFT", -3, 3)
	bBorder:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 3, -3)

	bBorder:SetDrawLayer("BACKGROUND", 1)

	if atype == "HELPFUL" then
		bBorder:SetVertexColor(.5, .5, .5, 1)
	elseif atype == "TEMPENCHANT" then
		bBorder:SetVertexColor(1, 1, 1, 1)
	end

	button.styled = true
end

do
	BuffFrame:SetParent(lsBuffHeader)
	BuffFrame:ClearAllPoints()
	BuffFrame:SetPoint("TOPRIGHT", 0, 0)

	TemporaryEnchantFrame:SetParent(lsTemporaryEnchantHeader)
	TemporaryEnchantFrame:ClearAllPoints()
	TemporaryEnchantFrame:SetPoint("TOPRIGHT", 0, 0)

	UpdateTemporaryEnchantAnchors(lsTemporaryEnchantHeader)

	hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)
	hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuffAnchors)
	hooksecurefunc("AuraButton_Update", SetAuraButtonStyle)

	for i = 1, NUM_TEMP_ENCHANT_FRAMES do
		SetAuraButtonStyle("TempEnchant", i, "TEMPENCHANT")
	end

	SetAuraButtonStyle("ConsolidatedBuffs", nil, "CONSOLIDATED")
	ConsolidatedBuffsTooltip:SetScale(1)
end