local parent, ns = ...
local oUF = ns.oUF
local UI = ns.ManrielUI
local config = UI.config

local BuffFrame = _G["BuffFrame"]
local ConsolidatedBuffs = _G["ConsolidatedBuffs"]

local lsBuffHeader = CreateFrame("Frame", "lsBuffHeader", UIParent)
lsBuffHeader:SetSize(28, 28)
lsBuffHeader:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -6, -30)

local lsDebuffHeader = CreateFrame("Frame", "lsDebuffHeader", UIParent)
lsDebuffHeader:SetSize(28, 28)
lsDebuffHeader:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -6, -140)

local lsTemporaryEnchantHeader = CreateFrame("Frame", "lsTemporaryEnchantHeader", UIParent)
lsTemporaryEnchantHeader:SetSize(28, 28)
lsTemporaryEnchantHeader:SetPoint("TOPRIGHT", "UIParent", "TOPRIGHT", -6, -180)

function AuraSort (a)
	local tmpA = a
	local resultA = {}

	for i = 1, #a do
		resultA[i] = i
	end

	local zeroCount = 0

	for i = 1, #a do
		for j = i, #a do

			if tmpA[i] ~= false and tmpA[j] ~= false and (i ~= j) and (tmpA[i] < tmpA[j]) then
				local tmp = tmpA[i]
				tmpA[i] = tmpA[j]
				tmpA[j] = tmp

				tmp = resultA[i]
				resultA[i] = resultA[j]
				resultA[j] = tmp
			end

		end

		if a[i] ~= false and a[i] == 0 then
			zeroCount = zeroCount + 1
		end
	end

	local tmpB = {}
	local resultB = {}
	local counter = 1
	
	for i = 1, #a do
		if tmpA[i] and tmpA[i] > 0 then
			tmpB[i+zeroCount] = tmpA[i]
			resultB[i+zeroCount] = resultA[i]
		elseif tmpA[i] and tmpA[i] == 0 then
			tmpB[counter] = tmpA[i]
			resultB[counter] = resultA[i]
			counter = counter + 1
		end
	end

	return resultB
end

local function SetDurationText(duration, arg1, arg2)
	duration:SetText('|cffffffff'..format(gsub(arg1, "[ .]", ""), arg2)..'|r')
end

local function UpdateBuffAnchors()
	local numBuffs, slack = 0, 0
	local button, previous, above

	if IsInGroup() and GetCVarBool("consolidateBuffs") then
		slack = 1
	end

	local a = {}

	for index = 1, BUFF_MAX_DISPLAY do
		local unit = PlayerFrame.unit
	    local name, rank, texture, count, debuffType, duration, expirationTime, _, _, shouldConsolidate, spellId = UnitAura(unit, index, filter);

	    if name then
	    	local timeLeft = expirationTime - GetTime()
	    	if timeLeft > 0 then
	    		a[index] = timeLeft
	    	else 
	    		a[index] = 0
	    	end
	    else
	    	a[index] = false
	    end
	end

	local aSort = AuraSort(a)

	for i = 1, BUFF_ACTUAL_DISPLAY do
		local j = aSort[i]
		button = _G["BuffButton"..j]

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

			if index > 1 and (mod(index, 11) == 1) then
				if index == 12 then
					button:SetPoint("TOP", ConsolidatedBuffs, "BOTTOM", 0, -16)
				else
					button:SetPoint("TOP", above, "BOTTOM", 0, -16)
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
		bBorder = button:CreateTexture(name.."Border", "BORDER", nil, 0)
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