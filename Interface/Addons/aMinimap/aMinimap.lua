-- config
scale = 1.15
position = "BOTTOMRIGHT"
position_x = -4
position_y = 4

-- quest tracker config
qparent = Minimap
qanchor = "BOTTOMRIGHT"
qheight = 500               -- height of the quest tracker
qposition_x = 0             -- X offset
qposition_y = -50           -- Y offset

-- set square, border and scale
Minimap:ClearAllPoints()
Minimap:SetPoint(position, UIParent, position_x, position_y)
Minimap:SetScale(scale)
Minimap:SetMaskTexture("Interface\\ChatFrame\\ChatFrameBackground")
Minimap:SetFrameStrata("BACKGROUND")
Minimap:SetClampedToScreen(true)

-- move battleground icon
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 0, 0)

-- new mail icon
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 3, 3)
MiniMapMailFrame:SetScale(1.25)
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\aMinimap\\mail")

-- hide tracking icon
MiniMapTracking:Hide()

-- hide border
MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- hide zoom buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- hide calendar
GameTimeFrame:Hide()

-- hide voice chat
MiniMapVoiceChatFrame:Hide()

-- hide north texture
MinimapNorthTag:SetTexture(nil)

-- hide world map icon
MiniMapWorldMapButton:Hide()

-- quest tracker
-- WatchFrame:ClearAllPoints()	
-- WatchFrame.ClearAllPoints = function() end
-- WatchFrame:SetPoint("TOPRIGHT", qparent, qanchor, qposition_x, qposition_y)
-- WatchFrame.SetPoint = function() end
-- WatchFrame:SetClampedToScreen(true)
-- WatchFrame:SetHeight(qheight)

-- hide zone text
MinimapZoneTextButton:Hide()

-- hide instance difficulty flag
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:Hide()

-- set minimap buttons to square
function GetMinimapShape() return 'SQUARE' end

-- enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

-- right click menu
Minimap:SetScript("OnMouseUp", function(self, bt)
	if bt == "RightButton" then
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self)
	elseif bt == "MiddleButton" then
		ToggleCalendar()
    else
        Minimap_OnClick(self)
    end
end)
