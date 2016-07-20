local parent, ns = ...
local UI = ns.ManrielUI
local arStrings = UI.localeStrings
local config = UI.config

local Coordinates_UpdateInterval = 0.2
local timeSinceLastUpdate = 0

local coordinatesFrame = CreateFrame("Frame", nil, WorldMapFrame)
coordinatesFrame:SetPoint('BOTTOMLEFT', WorldMapFrame, 'BOTTOMLEFT', 4, 4)
coordinatesFrame:SetScale(1)
coordinatesFrame:SetHeight(20)
coordinatesFrame:SetWidth(250)

coordinatesFrame:SetFrameStrata("HIGH")
coordinatesFrame:SetFrameLevel(5)

local selfValue = coordinatesFrame:CreateFontString(nil, 'OVERLAY')
selfValue:SetPoint('BOTTOMLEFT')
selfValue:SetFont(config.fontName, config.baseFontSize, 'OUTLINE')
coordinatesFrame.selfValue = selfValue;

local cursorValue = coordinatesFrame:CreateFontString(nil, 'OVERLAY')
cursorValue:SetPoint('BOTTOMLEFT', selfValue, 'TOPLEFT')
cursorValue:SetFont(config.fontName, config.baseFontSize, 'OUTLINE')
coordinatesFrame.cursorValue = cursorValue;

function coordinatesFrame:VARIABLES_LOADED()
	coordinatesFrame:SetScript("OnUpdate", function(self, elapsed) Coordinates_OnUpdate(self, elapsed) end)
end
function coordinatesFrame:ZONE_CHANGED_NEW_AREA()
	Coordinates_UpdateCoordinates()
end

function coordinatesFrame:ZONE_CHANGED_INDOORS()
	Coordinates_UpdateCoordinates()
end

function coordinatesFrame:ZONE_CHANGED()
	Coordinates_UpdateCoordinates()
end

--OnUpdate
function Coordinates_OnUpdate(self, elapsed)
	timeSinceLastUpdate = timeSinceLastUpdate + elapsed
	if (timeSinceLastUpdate > Coordinates_UpdateInterval) then
		-- Update the update time
		timeSinceLastUpdate = 0
		Coordinates_UpdateCoordinates()
	end
end

function Coordinates_UpdateCoordinates()
	-- Get the cursor's coordinates
	local cursorX, cursorY = GetCursorPosition()

	-- Calculate cursor position
	local scale = WorldMapDetailFrame:GetEffectiveScale()
	cursorX = cursorX / scale
	cursorY = cursorY / scale
	local width = WorldMapDetailFrame:GetWidth()
	local height = WorldMapDetailFrame:GetHeight()
	local left = WorldMapDetailFrame:GetLeft()
	local top = WorldMapDetailFrame:GetTop()
	cursorX = (cursorX - left) / width * 100
	cursorY = (top - cursorY) / height * 100
	if cursorX > 100 then cursorX = 100 end
	if cursorX < 0 then cursorX = 0 end
	if cursorY > 100 then cursorY = 100 end
	if cursorY < 0 then cursorY = 0 end
	local cursorCoord = ""
	if ( cursorY >= 100 or cursorY <= 0 or cursorX >= 100 or cursorX <= 0 ) then
		cursorCoord = ""
	else
		cursorCoord = arStrings.cursor..": "..format("%.0f, %.0f", cursorX, cursorY)
	end

	-- Player position
	local px, py = GetPlayerMapPosition("player")
	local playerCoord = ""
	if ( px == 0 and py == 0 ) then
		playerCoord = ""
	else
		playerCoord = STATUS_TEXT_PLAYER..": "..format("%.0f, %.0f", px * 100, py * 100)
	end

	-- Add text
	coordinatesFrame.selfValue:SetText(playerCoord);
	coordinatesFrame.cursorValue:SetText(cursorCoord);
end

coordinatesFrame:RegisterEvent("VARIABLES_LOADED")
coordinatesFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
coordinatesFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
coordinatesFrame:RegisterEvent("ZONE_CHANGED")
coordinatesFrame:SetScript("OnEvent",function(self,event,...) self[event](self,event,...);end)

WorldMapFrame.coord = coordinatesFrame