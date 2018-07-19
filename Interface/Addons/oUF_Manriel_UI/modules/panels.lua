local parent, ns = ...
local UI = ns.ManrielUI
local LSM = UI.lib.LSM

local blank			= LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-None');
local background	= LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Background');
local border32		= LSM:Fetch(LSM.MediaType.BORDER, 'Manriel-Border');
local border16		= LSM:Fetch(LSM.MediaType.BORDER, 'Manriel-Border-Light');

local Panels		= CreateFrame("Frame", "oUF_ManrielUI_Panels", UIParent);
Panels:SetAllPoints(UIParent);

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

	-- Chat frames
	ChatFrames = CreateFrame('Frame', 'ChatFramesParent', Panels);
	ChatFrames:SetPoint('TOPRIGHT', parent.."Bar2", 'TOPLEFT', -3, -3)
	ChatFrames:SetPoint('BOTTOMLEFT', Panels, 'BOTTOMLEFT', 3, 3)
	for i=1, 10 do
		local cF = _G[("%s%d"):format("ChatFrame", i)]
		if cF then
			cF:SetParent(ChatFrames);
			cF:SetAllPoints(ChatFrames);
			local panel = CreateFrame('Frame', 'Panel_ChatFrame'..i, cF);
			panel:SetPoint("TOPLEFT", "ChatFrame"..i, "TOPLEFT", -3, 3);
			panel:SetPoint("BOTTOMRIGHT", "ChatFrame"..i, "BOTTOMRIGHT", 3, -3);
			panel:SetBackdrop(backdrop);
			panel:SetFrameStrata("LOW");
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
		Recount_MainWindow:ClearAllPoints()
		Recount_MainWindow:SetFrameStrata('LOW')
		Recount_MainWindow:SetBackdrop(backdrop)
		Recount_MainWindow.Title:SetHeight(20);
		Recount_MainWindow:SetPoint('TOPLEFT', parent.."Bar3", 'TOPRIGHT', 0, 0)
		Recount_MainWindow:SetPoint('BOTTOMRIGHT', Minimap, 'BOTTOMLEFT', -3, -3)
	end;

end

--Panels.flame = Panels:CreateTexture(nil, 'OVERLAY');
--Panels.flame:SetTexture([[Interface\Addons\oUF_Manriel_UI\textures\flame]]);
--Panels.flame:SetPoint('TOPLEFT', Panels, 'TOPLEFT', 30, -30)
--Panels.flame:SetSize(56, 128);

--local flameUpdate = function( self, elapsed )
--	AnimateTexCoords(Panels.flame, 512, 128, 56, 128, 9, elapsed, 0.05)
--end

Panels:RegisterEvent("PLAYER_LOGIN")
Panels:SetScript("OnEvent",function(self,event,...) self[event](self,event,...) end)

--Panels:SetScript("OnUpdate", function(...) flameUpdate(...) end);

ns.ManrielUI.panels = Panels
