local mediaLib = LibStub:GetLibrary("LibSharedMedia-3.0");

if not mediaLib then return end;

mediaLib:Register('background', 'Manriel-None', "interface\\AddOns\\aPanels\\media\\blank");
mediaLib:Register('background', 'Manriel-Background', "interface\\AddOns\\aPanels\\media\\halback");
mediaLib:Register('border', 'Manriel-Border', "interface\\AddOns\\aPanels\\media\\border32");
mediaLib:Register('border', 'Manriel-Border-Light', "interface\\AddOns\\aPanels\\media\\border16");

local blank			= mediaLib:Fetch('background', 'Manriel-None');
local background	= mediaLib:Fetch('background', 'Manriel-Background');
local border32		= mediaLib:Fetch('border', 'Manriel-Border');
local border16		= mediaLib:Fetch('border', 'Manriel-Border-Light');

-- local glowTexture	= [=[Interface\Addons\aNamePlates\media\glowTex]=]
local panels, n		= {}, 0;
local aPanels		= CreateFrame("Frame", "aPanels_main", UIParent);

aPanels.PLAYER_LOGIN = function(self)
	-- Chat frames
	for i=1, 10 do
		local cF = _G[("%s%d"):format("ChatFrame", i)]
		
		local panel = CreateFrame('Frame', 'aPanels_ChatFrame'..i, cF);
		panel:SetPoint("BOTTOMRIGHT", "ChatFrame"..i, "BOTTOMRIGHT", 4, -8);
		panel:SetPoint("TOPLEFT", "ChatFrame"..i, "TOPLEFT", -4, 4);
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
		panel:SetBackdrop(backdrop);
		panel:SetFrameStrata("BACKGROUND");
		panel:SetFrameLevel(0);
		panel:Show();
	end
	for i=1, 10 do
		local cF = _G[("%s%d%s"):format("ChatFrame", i, "EditBox")]
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
		cF:SetBackdrop(backdrop);
		cF.focusLeft:SetTexture(nil);
		cF.focusRight:SetTexture(nil);
		cF.focusMid:SetTexture(nil);
	end
	-- Chat end

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
	local panel = CreateFrame('Frame', 'aPanels_Bar1', Bar1_holder);
	panel:SetPoint("BOTTOMRIGHT", Bar1_holder, "BOTTOMRIGHT", 2, -2);
	panel:SetPoint("TOPLEFT", Bar1_holder, "TOPLEFT", -2, 2);
	panel:SetBackdrop(backdrop);
	panel:SetFrameStrata("BACKGROUND");
	panel:SetFrameLevel(0);
	local panel = CreateFrame('Frame', 'aPanels_Bar2', Bar2_holder);
	panel:SetPoint("BOTTOMRIGHT", Bar2_holder, "BOTTOMRIGHT", 2, -2);
	panel:SetPoint("TOPLEFT", Bar2_holder, "TOPLEFT", -2, 2);
	panel:SetBackdrop(backdrop);
	panel:SetFrameStrata("BACKGROUND");
	panel:SetFrameLevel(0);
	local panel = CreateFrame('Frame', 'aPanels_Bar2', Bar3_holder);
	panel:SetPoint("BOTTOMRIGHT", Bar3_holder, "BOTTOMRIGHT", 2, -2);
	panel:SetPoint("TOPLEFT", Bar3_holder, "TOPLEFT", -2, 2);
	panel:SetBackdrop(backdrop);
	panel:SetFrameStrata("BACKGROUND");
	panel:SetFrameLevel(0);

end

aPanels:RegisterEvent("PLAYER_LOGIN")
aPanels:SetScript("OnEvent",function(self,event,...) self[event](self,event,...) end)

--[[
local CreatePanel = function(tag, x, y, width, height, texture, border, point, rpoint, anchor, parent) 
	panels[n] = CreateFrame("frame", tag, parent)
	panels[n]:SetWidth(width)
	panels[n]:SetHeight(height)
	panels[n]:SetPoint(point, anchor, rpoint, x, y)
	local backdrop = {
		bgFile = texture,
        tile = true,
        tileSize = 256,
		edgeFile = border,
		edgeSize = 32,
        insets = {
        	left = 3,
        	right = 3,
        	top = 3,
        	bottom = 3
        }
    }
    if border == border16 then
    	backdrop.edgeSize = 16
    end
  	panels[n]:SetBackdrop(backdrop)
	panels[n]:SetFrameStrata("BACKGROUND") 
	
	panels[n]:Show()
	
	n = n + 1
end

local CreateResizablePanel = function(tag, x, y, x1, y1, texture, border, point, rpoint, point1, rpoint1, anchor, parent) 
	panels[n] = CreateFrame("Frame", tag, parent)
	panels[n]:SetPoint(point, anchor, rpoint, x, y)
	panels[n]:SetPoint(point1, anchor, rpoint1, x1, y1)
  	local backdrop = {
		bgFile = texture,
        tile = true,
        tileSize = 256,
		edgeFile = border,
		edgeSize = 32,
        insets = {
        	left = 3,
        	right = 3,
        	top = 3,
        	bottom = 3
        }
    }
    if border == border16 then
    	backdrop.edgeSize = 16
    end
  	panels[n]:SetBackdrop(backdrop)
	panels[n]:SetFrameStrata("BACKGROUND") 
	
	panels[n]:Show()
	
	n = n + 1
end

local SetBCMTexture = function()
	for i=1, 10 do
		local cF = _G[("%s%d"):format("ChatFrame", i)]
		CreateResizablePanel("aPanels_ChatFrame"..i,-4,4,4,-8,background,border32,"TOPLEFT","TOPLEFT","BOTTOMRIGHT","BOTTOMRIGHT","ChatFrame"..i,cF)
		local cT = _G[("%s%d"):format("aPanels_ChatFrame", i)]
		cT:SetFrameLevel(0)
	end
end


aPanels.PLAYER_LOGIN = function(self)
	--ChatFrame
	SetBCMTexture()

	CreateResizablePanel("aPanels_XpBar1",-3,0,3,0,background,border16,"TOPLEFT","TOPLEFT","BOTTOMRIGHT","BOTTOMRIGHT",XPBarNoneButton,XPBarNoneButton)
	CreateResizablePanel("aPanels_MiniMap1",-3,3,3,-3,background,border32,"TOPLEFT","TOPLEFT","BOTTOMRIGHT","BOTTOMRIGHT","Minimap",Minimap)
	CreateResizablePanel("aPanels_sThreatMeter1",-3,3,3,-3,background,border32,"TOPLEFT","TOPLEFT","BOTTOMRIGHT","BOTTOMRIGHT","sThreatMeter_Main",sThreatMeter_Main)

	--FuBar
	CreatePanel("aPanels_Fubar1",0,438,1876,28,background,border16,"CENTER","CENTER",UIParent,UIParent)
	--ActionButtonsMain
	CreatePanel("aPanels_MButtons1",0,0,556,97,background,border32,"BOTTOM","TOP","aPanels_XpBar1",UIParent)
	--ActionButtonsL
	CreatePanel("aPanels_LButtons1",0,0,113,115,background,border32,"TOPRIGHT","TOPLEFT","aPanels_MButtons1",UIParent)
	--ActionButtonsR
	CreatePanel("aPanels_RButtons1",0,0,113,115,background,border32,"TOPLEFT","TOPRIGHT","aPanels_MButtons1",UIParent)	
	--ActionButtonRR
	CreatePanel("aPanels_SM1",0,0,69,163,background,border32,"BOTTOMLEFT","BOTTOMRIGHT","aPanels_RButtons1",UIParent)
	
	--PetBar
	if BT4BarPetBar then
		CreatePanel("aPanels_PetBar1",-0.25,0,339,42,background,border32,"BOTTOMRIGHT","TOPRIGHT","aPanels_RButtons1",BT4BarPetBar)
	end
	--Recount
	if Recount_MainWindow then
		CreateResizablePanel("aPanels_Recount1",0,-7,0,0,background,border32,"TOPLEFT","TOPLEFT","BOTTOMRIGHT","BOTTOMRIGHT","Recount_MainWindow",Recount_MainWindow)
	end
end

aPanels:RegisterEvent("PLAYER_LOGIN")
aPanels:SetScript("OnEvent",function(self,event,...) self[event](self,event,...) end)
]]