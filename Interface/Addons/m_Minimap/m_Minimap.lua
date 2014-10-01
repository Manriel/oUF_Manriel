-- Config
local Scale = 1.095              -- Minimap scale
local ClassColorBorder = false  -- Should border around minimap be classcolored? Enabling it disables color settings below
local r, g, b, a = 0, 0, 0, 1   -- Border colors and alhpa. More info: http://www.wowwiki.com/API_Frame_SetBackdropColor
local BGThickness = 0           -- Border thickness in pixels
local MapPosition = {"BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -4, 4}

-- Shape, location and scale
function GetMinimapShape() return "SQUARE" end
Minimap:ClearAllPoints()
Minimap:SetPoint(MapPosition[1], MapPosition[2], MapPosition[3], MapPosition[4] / Scale, MapPosition[5] / Scale)
MinimapCluster:SetScale(Scale)
--Minimap:SetFrameStrata("BACKGROUND")
Minimap:SetFrameLevel(10)

-- Mask texture hint => addon will work with Carbonite
local hint = CreateFrame("Frame")
local total = 0
local SetTextureTrick = function(self, elapsed)
    total = total + elapsed
    if(total > 2) then
        Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8X8")
        hint:SetScript("OnUpdate", nil)
    end
end

hint:RegisterEvent("PLAYER_LOGIN")
hint:SetScript("OnEvent", function()
    hint:SetScript("OnUpdate", SetTextureTrick)
end)

-- Background
Minimap:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground", insets = {
    top = -BGThickness / Scale,
    left = -BGThickness / Scale,
    bottom = -BGThickness / Scale,
    right = -BGThickness / Scale
}})
if(ClassColorBorder==true) then
    local _, class = UnitClass("player")
    local t = RAID_CLASS_COLORS[class]
    Minimap:SetBackdropColor(t.r, t.g, t.b, a)
else
    Minimap:SetBackdropColor(r, g, b, a)
end

-- Mousewheel zoom
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(_, zoom)
    if zoom > 0 then
        Minimap_ZoomIn()
    else
        Minimap_ZoomOut()
    end
end)

-- Hiding ugly things
local dummy = function() end
local _G = getfenv(0)

local frames = {
    "GameTimeFrame",
    "MinimapBorderTop",
    "MinimapNorthTag",
    "MinimapBorder",
    "MinimapZoneTextButton",
    "MinimapZoomOut",
    "MinimapZoomIn",
    "MiniMapVoiceChatFrame",
    "MiniMapWorldMapButton",
    "MiniMapMailBorder",
    -- "MiniMapBattlefieldBorder",
    -- "FeedbackUIButton",
}

for i in pairs(frames) do
    _G[frames[i]]:Hide()
    _G[frames[i]].Show = dummy
end
MinimapCluster:EnableMouse(false)

-- Tracking
MiniMapTrackingBackground:SetAlpha(0)
MiniMapTrackingButton:SetAlpha(0)
MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("BOTTOMLEFT", Minimap, -5, -7)

-- BG icon
-- MiniMapBattlefieldFrame:ClearAllPoints()
-- MiniMapBattlefieldFrame:SetPoint("TOP", Minimap, "TOP", 2, 8)

-- Random Group icon
-- MiniMapLFGFrame:ClearAllPoints()
-- MiniMapLFGFrameBorder:SetAlpha(0)
-- MiniMapLFGFrame:SetPoint("TOP", Minimap, "TOP", 1, 8)
-- MiniMapLFGFrame:SetFrameStrata("MEDIUM")

-- BG and LFG frames combines into Queue Status Button
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("TOP", Minimap, "TOP", 2, 8)

-- Instance Difficulty flag
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 2, 2)
MiniMapInstanceDifficulty:SetScale(0.75)
MiniMapInstanceDifficulty:SetFrameStrata("LOW")

-- Guild Instance Difficulty flag
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 2, 2)
GuildInstanceDifficulty:SetScale(0.75)
GuildInstanceDifficulty:SetFrameStrata("LOW")

-- Mail icon
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 2, -6)
MiniMapMailIcon:SetTexture("Interface\\AddOns\\m_Minimap\\mail")

-- Invites Icon
GameTimeCalendarInvitesTexture:ClearAllPoints()
GameTimeCalendarInvitesTexture:SetParent("Minimap")
GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT")

if FeedbackUIButton then
FeedbackUIButton:ClearAllPoints()
FeedbackUIButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 6, -6)
FeedbackUIButton:SetScale(0.8)
end

if StreamingIcon then
StreamingIcon:ClearAllPoints()
StreamingIcon:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 8, 8)
StreamingIcon:SetScale(0.8)
end

-- Creating right click menu
local menuFrame = CreateFrame("Frame", "m_MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
    {text = "Character",
    func = function() ToggleCharacter("PaperDollFrame") end},
    {text = "Spells",
    func = function() ToggleSpellBook("spell") end},
    {text = "Talents",
    func = function() ToggleTalentFrame() end},
    {text = "Achievements",
    func = function() ToggleAchievementFrame() end},
    {text = "Quests",
    func = function() ToggleFrame(QuestLogFrame) end},
    {text = "Friends",
    func = function() ToggleFriendsFrame(1) end},
    {text = "Guild",
    func = function() ToggleGuildFrame(1) end},
    {text = "PvP",
    func = function() ToggleFrame(PVPFrame) end},
    {text = "LFDungeon",
    func = function() ToggleFrame(LFDParentFrame) end},
    {text = "LFRaid",
    func = function() ToggleFrame(LFRParentFrame) end},
    {text = "Help",
    func = function() ToggleHelpFrame() end},
    {text = "Calendar",
    func = function()
    if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
        Calendar_Toggle()
    end},
}

-- Click func
 Minimap:SetScript("OnMouseDown", function(_, button)
    if(button=="MiddleButton") then
        ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, "cursor", 0, 0)
    elseif(button=="RightButton") then
        EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
    end
end) 

-- Clock
if not IsAddOnLoaded("Blizzard_TimeManager") then
    LoadAddOn("Blizzard_TimeManager")
end
local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
clockFrame:Hide()
clockTime:SetFont("Fonts\\FRIZQT__.ttf", 12, "THINOUTLINE")
clockTime:SetTextColor(1,1,1)
TimeManagerClockButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -3)
TimeManagerClockButton:Hide()
TimeManagerClockButton:SetScript("OnMouseDown", function(_,click)
        if click == "RightButton" then
        if not CalendarFrame then
            LoadAddOn("Blizzard_Calendar")
        end
            CalendarFrame:Show()
        end
    end)
    