local parent, namespace = ...
local UI = namespace.ManrielUI
local arStrings = UI.localeStrings
local config = UI.config
local LSM = UI.lib.LSM

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
selfValue:SetFont(LSM:Fetch(LSM.MediaType.FONT, 'San Francisco (Semi-bold)'), 11, 'OUTLINE')
coordinatesFrame.selfValue = selfValue;

local cursorValue = coordinatesFrame:CreateFontString(nil, 'OVERLAY')
cursorValue:SetPoint('BOTTOMLEFT', selfValue, 'TOPLEFT')
cursorValue:SetFont(LSM:Fetch(LSM.MediaType.FONT, 'San Francisco (Semi-bold)'), 11, 'OUTLINE')
coordinatesFrame.cursorValue = cursorValue;

function coordinatesFrame:VARIABLES_LOADED()
	coordinatesFrame:SetScript("OnUpdate", function(self, elapsed) Coordinates_OnUpdate(self, elapsed) end)
end

function coordinatesFrame:ZONE_CHANGED_NEW_AREA()
	Coordinates_UpdateCoordinates()
end

function coordinatesFrame:MAP_EXPLORATION_UPDATED()
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
	if (WorldMapFrame:IsShown()) then
		-- Get the cursor's coordinates
		local cursorX, cursorY = GetCursorPosition()

		-- Calculate cursor position
		local WorldMapTextureContainer = WorldMapFrame.ScrollContainer.Child
		local scale = WorldMapTextureContainer:GetEffectiveScale()
		local cursorCoord = ""
		if (type(cursorX) ~= 'nil' and type(WorldMapTextureContainer) ~= 'nil') then
			cursorX = cursorX / scale
			cursorY = cursorY / scale
			local width = WorldMapTextureContainer:GetWidth()
			local height = WorldMapTextureContainer:GetHeight()
			local left = WorldMapTextureContainer:GetLeft()
			local top = WorldMapTextureContainer:GetTop()
			cursorX = (cursorX - left) / width * 100
			cursorY = (top - cursorY) / height * 100
			if cursorX > 100 then cursorX = 100 end
			if cursorX < 0 then cursorX = 0 end
			if cursorY > 100 then cursorY = 100 end
			if cursorY < 0 then cursorY = 0 end
			if ( cursorY >= 100 or cursorY <= 0 or cursorX >= 100 or cursorX <= 0 ) then
				cursorCoord = ""
			else
				cursorCoord = arStrings.cursor..": "..format("%.0f, %.0f", cursorX, cursorY)
			end
		end

		-- Player position
		local mapId = WorldMapFrame.mapID
		local playerPosition = C_Map.GetPlayerMapPosition(mapId, "player")
		local playerCoord = ""
		if (type(playerPosition) ~= 'nil') then
			local px, py = playerPosition:GetXY()
			playerCoord = STATUS_TEXT_PLAYER..": "..format("%.0f, %.0f", px * 100, py * 100)
		end

		-- Add text
		coordinatesFrame.selfValue:SetText(playerCoord);
		coordinatesFrame.cursorValue:SetText(cursorCoord);
	end
end

coordinatesFrame:RegisterEvent("VARIABLES_LOADED")
coordinatesFrame:RegisterEvent("MAP_EXPLORATION_UPDATED")
coordinatesFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
coordinatesFrame:RegisterEvent("ZONE_CHANGED_INDOORS")
coordinatesFrame:RegisterEvent("ZONE_CHANGED")
coordinatesFrame:SetScript("OnEvent",function(self,event,...) self[event](self,event,...);end)

WorldMapFrame.coord = coordinatesFrame