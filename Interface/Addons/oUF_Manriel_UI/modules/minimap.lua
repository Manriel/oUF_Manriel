local parent, namespace = ...
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

props = {
    scale            = 1,     -- Minimap scale
    classColorBorder = false, -- Should border around minimap be classcolored? Enabling it disables color settings below
    color = {                 -- Border colors and alhpa. More info: http://www.wowwiki.com/API_Frame_SetBackdropColor
        r = 0,
        g = 0,
        b = 0,
        a = 1,
    },
    backdrop = {
        bgFile   = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Background'),
        tile     = true,
        tileSize = 256,
        edgeFile = LSM:Fetch(LSM.MediaType.BORDER,     'Manriel-Border-Light'),
        edgeSize = 12,
        insets   = {
            left   = 0,
            right  = 0,
            top    = 0,
            bottom = 0
        }
    },
    font = LSM:Fetch(LSM.MediaType.FONT, 'San Francisco (Bold)'),
    fontSize = 11
}

-- Shape, location and scale
function GetMinimapShape() return "SQUARE" end

Minimap:SetParent(UIParent)
Minimap:ClearAllPoints()
Minimap:SetPoint('BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', -2, 2)
Minimap:SetSize(164, 164)
Minimap:SetScale(props.scale)

MinimapBackdrop:ClearAllPoints()
MinimapBackdrop:SetPoint('TOPLEFT', -3, 3)
MinimapBackdrop:SetPoint('BOTTOMRIGHT', 3, -3)
MinimapBackdrop:SetBackdrop(props.backdrop)
MinimapBackdrop:SetBackdropColor(unpack(props.color))
MinimapBackdrop:SetFrameLevel(1)

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
--    "MiniMapVoiceChatFrame",
    "MiniMapWorldMapButton",
    
    "MiniMapMailBorder",
--    "MiniMapBattlefieldBorder",
--    "FeedbackUIButton",
--  "MinimapBackdrop",
}

for i in pairs(frames) do
    _G[frames[i]]:Hide()
    _G[frames[i]].Show = dummy
end
MinimapCluster:EnableMouse(false)

-- MiniMapRecordingButton
-- - MiniMapWorldIcon
-- - MiniMapRecordingBorder

-- Tracking
MiniMapTrackingBackground:SetAlpha(0)
MiniMapTrackingButton:SetAlpha(0)
MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("BOTTOMLEFT", Minimap, -5, -7)

-- BG icon
--MiniMapBattlefieldFrame:ClearAllPoints()
--MiniMapBattlefieldFrame:SetPoint("TOP", Minimap, "TOP", 2, 8)

-- LFG icon
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("TOP", Minimap, "TOP", 1, 8)
QueueStatusMinimapButtonBorder:Hide()
-- QueueStatusMinimapButtonBorder:SetFrameStrata("MEDIUM")

-- Instance Difficulty flag
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 2, 2)
MiniMapInstanceDifficulty:SetScale(1)
MiniMapInstanceDifficulty:SetFrameStrata("LOW")

-- Guild Instance Difficulty flag
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 2, 2)
GuildInstanceDifficulty:SetScale(1)
GuildInstanceDifficulty:SetFrameStrata("LOW")

-- MiniMapChallengeMode
MiniMapChallengeMode:ClearAllPoints()
MiniMapChallengeMode:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 2, 2)
MiniMapChallengeMode:SetScale(1)
MiniMapChallengeMode:SetFrameStrata("LOW")

-- Mail icon
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 2, -6)
MiniMapMailIcon:SetTexture("Interface\\Addons\\oUF_Manriel_UI\\textures\\mail")

-- Invites Icon
GameTimeCalendarInvitesTexture:ClearAllPoints()
GameTimeCalendarInvitesTexture:SetParent("Minimap")
GameTimeCalendarInvitesTexture:SetPoint("TOPRIGHT")

if StreamingIcon then
StreamingIcon:ClearAllPoints()
StreamingIcon:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 6, 6)
StreamingIcon:SetScale(1)
end

GarrisonLandingPageMinimapButton:SetParent(MinimapCluster)
GarrisonLandingPageMinimapButton:ClearAllPoints()
GarrisonLandingPageMinimapButton:SetPoint("BOTTOMRIGHT", MinimapCluster, "BOTTOM", 0, 0)

-- Creating right click menu
local menuFrame = CreateFrame("Frame", "m_MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
    {text = CHARACTER_BUTTON,
    notCheckable = true,
    func = function() ToggleCharacter("PaperDollFrame") end},
    {text = SPELLBOOK_ABILITIES_BUTTON,
    notCheckable = true,
    func = function() ToggleSpellBook("spell") end},
    {text = TALENTS_BUTTON,
    notCheckable = true,
    func = function() ToggleTalentFrame() end},
    {text = ACHIEVEMENT_BUTTON,
    notCheckable = true,
    func = function() ToggleAchievementFrame() end},
    {text = QUESTLOG_BUTTON,
    notCheckable = true,
    func = function() ToggleWorldMap() end},
    {text = FRIENDS,
    notCheckable = true,
    func = function() ToggleFriendsFrame(1) end},
    {text = GUILD,
    notCheckable = true,
    func = function() ToggleGuildFrame(1) end},
    {text = PLAYER_V_PLAYER,
    notCheckable = true,
    func = function() TogglePVPUI() end},
    {text = DUNGEONS_BUTTON,
    notCheckable = true,
    func = function() ToggleLFDParentFrame() end},
    {text = COLLECTIONS,
    notCheckable = true,
    func = function() ToggleCollectionsJournal(1) end},
    {text = ENCOUNTER_JOURNAL,
    notCheckable = true,
    func = function() ToggleEncounterJournal() end},
    {text = GAMETIME_TOOLTIP_TOGGLE_CALENDAR,
    notCheckable = true,
    func = function()
    if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
        Calendar_Toggle()
    end},
    {text = GAMEMENU_HELP,
    notCheckable = true,
    func = function() ToggleHelpFrame() end},
}
if ( C_StorePublic.IsEnabled() and not IsTrialAccount() and StoreMicroButton ) then
    item = {
        text = BLIZZARD_STORE,
        notCheckable = true,
        func = 
            function()
                if StoreMicroButton then
                    StoreMicroButton:Click()
                end
            end
    }
    table.insert(menuList, #menuList, item);
end

-- Click func
Minimap:SetScript("OnMouseUp", function(_, btn)
    if(btn=="MiddleButton") then
        ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, "cursor", 0, 0)
    elseif(btn=="RightButton") then
        EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 1)
    else
        local x, y = GetCursorPosition()
        x = x / Minimap:GetEffectiveScale()
        y = y / Minimap:GetEffectiveScale()
        local cx, cy = Minimap:GetCenter()
        x = x - cx
        y = y - cy
        if ( sqrt(x * x + y * y) < (Minimap:GetWidth() / 2) ) then
            Minimap:PingLocation(x, y)
        end
        Minimap_SetPing(x, y, 1)
    end
end) 

-- Clock
if not IsAddOnLoaded("Blizzard_TimeManager") then
    LoadAddOn("Blizzard_TimeManager")
end
local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
clockFrame:Hide()
clockTime:SetFont(props.font, props.fontSize, "THINOUTLINE")
clockTime:SetTextColor(1,1,1)
TimeManagerClockButton:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, -2)
TimeManagerClockButton:SetScript("OnClick", function(_,btn)
    if btn == "LeftButton" then
        TimeManager_Toggle()
    end 
    if btn == "RightButton" then
        if not CalendarFrame then
            LoadAddOn("Blizzard_Calendar")
        end
        Calendar_Toggle()
    end
end)

-- Zone text
local zoneTextFrame = CreateFrame("Frame", nil, UIParent)
zoneTextFrame:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, zoneTextYOffset)
zoneTextFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, zoneTextYOffset)
zoneTextFrame:SetHeight(19)
zoneTextFrame:SetAlpha(0)
MinimapZoneText:SetParent(zoneTextFrame)
MinimapZoneText:ClearAllPoints()
MinimapZoneText:SetPoint("LEFT", 2, 1)
MinimapZoneText:SetPoint("RIGHT", -2, 1)
MinimapZoneText:SetFont(props.font, props.fontSize, "THINOUTLINE")
Minimap:SetScript("OnEnter", function(self)
    UIFrameFadeIn(zoneTextFrame, 0.3, 0, 1)
end)
Minimap:SetScript("OnLeave", function(self)
    UIFrameFadeOut(zoneTextFrame, 0.3, 1, 0)
end)