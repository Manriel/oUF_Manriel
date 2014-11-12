local parent, ns = ...
local UI = ns.ManrielUI
local LSM = UI.lib.LSM

local blank			= LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-None');
local background	= LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Background');
local border32		= LSM:Fetch(LSM.MediaType.BORDER, 'Manriel-Border');
local border16		= LSM:Fetch(LSM.MediaType.BORDER, 'Manriel-Border-Light');

local Panels		= CreateFrame("Frame", "oUF_ManrielUI_Panels", oUF_ManrielUI);
Panels:SetAllPoints(oUF_ManrielUI);

Panels.PLAYER_LOGIN = function(self)

	-- Bars
	local backdrop = {
		bgFile = background,
		tile = true,
		tileSize = 256,
		edgeFile = border32,
		edgeSize = 32,
		insets = {
			left = 3,
			right = 3,
			top = 3,
			bottom = 3
		}
	};
	if Bar1_holder then
		local panel = CreateFrame('Frame', 'Panel_Bar1', Bar1_holder);
		panel:SetPoint("BOTTOMRIGHT", Bar1_holder, "BOTTOMRIGHT", 2, -2);
		panel:SetPoint("TOPLEFT", Bar1_holder, "TOPLEFT", -2, 2);
		panel:SetBackdrop(backdrop);
		panel:SetFrameStrata("BACKGROUND");
		panel:SetFrameLevel(0);
	end;
	if Bar2_holder then
		local panel = CreateFrame('Frame', 'Panel_Bar2', Bar2_holder);
		panel:SetPoint("BOTTOMRIGHT", Bar2_holder, "BOTTOMRIGHT", 2, -2);
		panel:SetPoint("TOPLEFT", Bar2_holder, "TOPLEFT", -2, 2);
		panel:SetBackdrop(backdrop);
		panel:SetFrameStrata("BACKGROUND");
		panel:SetFrameLevel(0);
	end;
	if Bar3_holder then
		local panel = CreateFrame('Frame', 'Panel_Bar3', Bar3_holder);
		panel:SetPoint("BOTTOMRIGHT", Bar3_holder, "BOTTOMRIGHT", 2, -2);
		panel:SetPoint("TOPLEFT", Bar3_holder, "TOPLEFT", -2, 2);
		panel:SetBackdrop(backdrop);
		panel:SetFrameStrata("BACKGROUND");
		panel:SetFrameLevel(0);
	end;

	-- Chat frames

	local backdrop = {
		bgFile = background,
		tile = true,
		tileSize = 256,
		edgeFile = border32,
		edgeSize = 32,
		insets = {
			left = 3,
			right = 3,
			top = 3,
			bottom = 3
		}
	};

	ChatFrames = CreateFrame('Frame', 'ChatFramesParent', Panels);
	ChatFrames:SetScale(.71);
	ChatFrames:SetPoint('TOPRIGHT', Panel_Bar2, 'TOPLEFT', -4/0.71, -3/0.71)
	ChatFrames:SetPoint('BOTTOMLEFT', oUF_ManrielUI_Panels, 'BOTTOMLEFT', 4/0.71, 7/0.71)
	for i=1, 10 do
		local cF = _G[("%s%d"):format("ChatFrame", i)]
		if cF then
			cF:SetParent(ChatFrames);
			cF:SetAllPoints(ChatFrames);
			local panel = CreateFrame('Frame', 'Panel_ChatFrame'..i, cF);
			panel:SetPoint("BOTTOMRIGHT", "ChatFrame"..i, "BOTTOMRIGHT", 4, -8);
			panel:SetPoint("TOPLEFT", "ChatFrame"..i, "TOPLEFT", -4, 4);
			panel:SetBackdrop(backdrop);
			panel:SetFrameStrata("BACKGROUND");
			panel:SetFrameLevel(0);
			panel:Show();
		end;
	end

	local backdrop = {
		bgFile = background,
		tile = true,
		tileSize = 256,
		edgeFile = border16,
		edgeSize = 10,
		insets = {
			left = 2,
			right = 2,
			top = 2,
			bottom = 2
		}
	};
	for i=1, 10 do
		local cF = _G[("%s%d%s"):format("ChatFrame", i, "EditBox")]
		if cF then
			cF:SetParent(ChatFrames);
			cF:SetHeight(26);
			cF:SetBackdrop(backdrop);
			cF.focusLeft:SetTexture(nil);
			cF.focusRight:SetTexture(nil);
			cF.focusMid:SetTexture(nil);
		end
	end
	-- Chat end

--[[
	if sThreatMeter_Main then
		sThreatMeter_Main:SetPoint("TOPLEFT", Bar3_holder, "TOPRIGHT", 6, 0);
		panel = CreateFrame('Frame', 'Panel_ThreatMeter', sThreatMeter_Main);
		panel:SetPoint("TOPLEFT", sThreatMeter_Main, "TOPLEFT", -2, 2);
		panel:SetPoint("BOTTOMRIGHT", sThreatMeter_Main, "BOTTOMRIGHT", 2, -2);
		panel:SetBackdrop(backdrop);
	end;
]]

	if Recount_MainWindow then
		Recount_MainWindow:SetBackdrop(backdrop)
		Recount_MainWindow.Title:SetHeight(20);
		Recount_MainWindow:SetPoint('TOPLEFT', Panel_Bar3, 'TOPRIGHT', 2, 0)
		Recount_MainWindow:SetPoint('BOTTOMLEFT', Panel_Bar3, 'BOTTOMRIGHT', 2, 0)
	end;
end

Panels:RegisterEvent("PLAYER_LOGIN")
Panels:SetScript("OnEvent",function(self,event,...) self[event](self,event,...) end)

ns.ManrielUI.panels = Panels
