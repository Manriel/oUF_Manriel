local parent, ns = ...
local UI = ns.ManrielUI

local props = {
    getFont = function()
        return UI.config.fontNameAlt;
    end,

    getFontSize = function()
        return (UI.config.baseFontSize / 12) * 11;
    end,

    getOffset = function()
        return UI.config.offset;
    end,

    getTexture = function()
        return UI.config.textureHealthBar;
    end,

    getBackdrop = function()
        return {
            bgFile   = UI.config.texturePanel,
            tile = true,
            tileSize = 256,
            edgeFile = UI.config.textureCastBarBorder,
            edgeSize = 12,
            insets   = {
                left = 3,
                right = 3,
                top = 3,
                bottom = 3
            }
        }
    end,
}

local ImprovedNameplatesDB = {
                showAllNames = true,
                showLevels = false,
                showRealmNames = false,
                numbersDisplayOthers = "Numeric Value",
                numbersDisplaySelf = "Numeric Value",
                nameFontSmall = 11,
                nameFontLarge = 16,
                healthFontSmall = 9,
                healthFontLarge = 11,
            }

-- Moves enemy debuffs down closer to their nameplate; credits to whatisxml on mmo-champion
local function fn(...)
    for _,v in pairs(C_NamePlate.GetNamePlates()) do
        local bf = v.UnitFrame.BuffFrame
        bf.baseYOffset = 0
        bf:UpdateAnchor()
    end
end
NamePlateDriverFrame:HookScript("OnEvent",fn)

-- Moving the health bar over to the side to accomodate for the new level display; huge thanks to maunot @ Freenode / #wowuidev
local function offset(f, ox, oy)
    for i=1,f:GetNumPoints() do
        local p, rf, rp, x, y= f:GetPoint(i)
        if p~="LEFT" or p~="RIGHT" then
            f:SetPoint(p, rf, rp, ox, oy)
        end
    end
end

local offsetNameplate = CreateFrame("Frame")
offsetNameplate:RegisterEvent("NAME_PLATE_UNIT_ADDED")
offsetNameplate:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
offsetNameplate:SetScript("OnEvent", function(self, event, unit)
    local p = C_NamePlate.GetNamePlateForUnit(unit).UnitFrame
    if event == "NAME_PLATE_UNIT_ADDED" then
        if UnitGUID(unit) ~= UnitGUID("player") then
            if ImprovedNameplatesDB.showLevels then
                if InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:GetValue() == "1" then
                    offset(p.name, 15, 6)
                    offset(p.healthBar, -15, 3)
                elseif InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:GetValue() == "0" then
                    offset(p.name, 9, 6)
                    offset(p.healthBar, -9, 3)
                end
            end
            p.healthBar:SetStatusBarTexture(props.getTexture())
            p.healthBar:SetWidth(300)
            p.healthBar:SetHeight(11)
            
            p.castBar:SetStatusBarTexture(props.getTexture())
        else -- Thanks Blizzard...
            local fontName, fontHeight, fontFlags = p.castBar.Text:GetFont()
            p.castBar.Text:SetFont(fontName, fontHeight, "OUTLINE")
            p.castBar:SetStatusBarTexture(props.getTexture())
        end
    elseif event == "NAME_PLATE_UNIT_REMOVED" then
        p.healthBar:ClearAllPoints()
    end
end)

-- Formatting the health numbers.
local function formatNumbers(amount)
    return UI.fn.formatVal(amount)
end

-- Initialize the AddOn and Saved Variables.
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == parent then
        -- Our saved variables, if they exist, have been loaded at this point.
        ImprovedNameplatesDB = Manriel_UI_Config.ImprovedNameplatesDB

        if ImprovedNameplatesDB == nil then
            ImprovedNameplatesDB = {
                showAllNames = true,
                showLevels = true,
                showRealmNames = false,
                numbersDisplayOthers = "Numeric Value",
                numbersDisplaySelf = "Numeric Value",
                nameFontSmall = 11,
                nameFontLarge = 16,
                healthFontSmall = 9,
                healthFontLarge = 11,
            }
        else
            if ImprovedNameplatesDB.showAllNames == nil then ImprovedNameplatesDB.showAllNames = true end
            if ImprovedNameplatesDB.showLevels == nil then ImprovedNameplatesDB.showLevels = true end
            if ImprovedNameplatesDB.showRealmNames == nil then ImprovedNameplatesDB.showRealmNames = false end
            if ImprovedNameplatesDB.numbersDisplaySelf == nil then ImprovedNameplatesDB.numbersDisplaySelf = "Numeric Value" end
            if ImprovedNameplatesDB.numbersDisplayOthers == nil then ImprovedNameplatesDB.numbersDisplayOthers = "Numeric Value" end
            if ImprovedNameplatesDB.nameFontSmall == nil then ImprovedNameplatesDB.nameFontSmall = 11 end
            if ImprovedNameplatesDB.nameFontLarge == nil then ImprovedNameplatesDB.nameFontLarge = 16 end
            if ImprovedNameplatesDB.healthFontSmall == nil then ImprovedNameplatesDB.healthFontSmall = 8 end
            if ImprovedNameplatesDB.healthFontLarge == nil then ImprovedNameplatesDB.healthFontLarge = 11 end
        end

        -- Makes Personal Resource Display click-through.
        C_NamePlate.SetNamePlateSelfClickThrough(true)

        ImprovedNameplates_OptionPanel() -- Set up Options Panel. (L#112)
    end
end)

-- Set some CVars for better functionality.
SetCVar("nameplateMaxAlpha", 1) -- Makes nameplates...
SetCVar("nameplateMinAlpha", 1) -- ... completely opaque.
SetCVar("nameplateMaxScale", 1) -- Just in case.
SetCVar("nameplateMinScale", 1) -- Prevent nameplates from getting smaller when you move away.

-- Thanks to FlexYourHead (Work_Complete) for the very easy to understand code.
-- And to the makers of AdvancedInterfaceOptions for the very compact and easy to understand way of creating Dropdown Menus. Fuck UIDropDownMenu taint, Blizzard can fix it themselves.

function ImprovedNameplates_OptionPanel() -- Creating the Option Panel.
    local INP_Options = CreateFrame("frame", "ImprovedNameplates_Options")
    INP_Options.name = "Nameplates"
    InterfaceOptions_AddCategory(INP_Options)

    StaticPopupDialogs["NAMEPLATESCONFIRMRELOAD"] = {
        text = "Changing this option requires a /reload. Reload?",
        button1 = YES,
        button2 = NO,
        OnAccept = function()
            ReloadUI()
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
    }

    local INP_Title = INP_Options:CreateFontString("Title", "ARTWORK", "GameFontNormalLarge")
    INP_Title:SetPoint("TOPLEFT", 16, -16)
    INP_Title:SetText("Improved Nameplates")

    local NPCNamesCheckbox = CreateFrame("CheckButton", "NPCNamesCheckbox", INP_Options, "ChatConfigCheckButtonTemplate")
    NPCNamesCheckbox:SetPoint("TOPLEFT", 15, -40)
    NPCNamesCheckbox:SetWidth(30)
    NPCNamesCheckbox:SetHeight(30)
    _G[NPCNamesCheckbox:GetName().."Text"]:SetText("Show all names")
    NPCNamesCheckbox.tooltip = "Ignore or Respect the NPC Names setting, under Interface --> Names"
    NPCNamesCheckbox:SetChecked(ImprovedNameplatesDB.showAllNames)
    NPCNamesCheckbox:SetScript("OnClick", function()
        ImprovedNameplatesDB.showAllNames = NPCNamesCheckbox:GetChecked()
        Manriel_UI_Config.ImprovedNameplatesDB = ImprovedNameplatesDB;
    end)

    local levelDisplayCheckbox = CreateFrame("CheckButton", "levelDisplayCheckbox", INP_Options, "ChatConfigCheckButtonTemplate")
    levelDisplayCheckbox:SetPoint("TOPLEFT", 15, -75)
    levelDisplayCheckbox:SetWidth(30)
    levelDisplayCheckbox:SetHeight(30)
    _G[levelDisplayCheckbox:GetName().."Text"]:SetText("Show level display")
    levelDisplayCheckbox.tooltip = "Show or hide the level display on nameplates"
    levelDisplayCheckbox:SetChecked(ImprovedNameplatesDB.showLevels)
    levelDisplayCheckbox:SetScript("OnClick", function()
        ImprovedNameplatesDB.showLevels = levelDisplayCheckbox:GetChecked()
        StaticPopup_Show("NAMEPLATESCONFIRMRELOAD")
        Manriel_UI_Config.ImprovedNameplatesDB = ImprovedNameplatesDB;
    end)

    local realmDisplayCheckbox = CreateFrame("CheckButton", "realmDisplayCheckbox", INP_Options, "ChatConfigCheckButtonTemplate")
    realmDisplayCheckbox:SetPoint("TOPLEFT", 15, -110)
    realmDisplayCheckbox:SetWidth(30)
    realmDisplayCheckbox:SetHeight(30)
    _G[realmDisplayCheckbox:GetName().."Text"]:SetText("Show realm names")
    realmDisplayCheckbox.tooltip = "Show or hide realm names on nameplates"
    realmDisplayCheckbox:SetChecked(ImprovedNameplatesDB.showRealmNames)
    realmDisplayCheckbox:SetScript("OnClick", function()
        ImprovedNameplatesDB.showRealmNames = realmDisplayCheckbox:GetChecked()
        Manriel_UI_Config.ImprovedNameplatesDB = ImprovedNameplatesDB;
    end)

    local numericDisplaySelfLabel = INP_Options:CreateFontString("numericDisplaySelfLabel", "ARTWORK", "GameFontHighlightSmall")
    numericDisplaySelfLabel:SetPoint("TOPLEFT", 15, -150)
    numericDisplaySelfLabel:SetText("Numeric Display (Self)")

    local numericDisplaySelfDropdown = CreateFrame("Frame", "numericDisplaySelfDropdown", INP_Options, "UIDropDownMenuTemplate")
    numericDisplaySelfDropdown:SetPoint("TOPLEFT", 0, -163)
    numericDisplaySelfDropdown.initialize = function(dropdown)
        local sortMode = { "Numeric Value", "Current", "Percentage", "Both", "Hide" }
        for i, mode in next, sortMode do
            local info = UIDropDownMenu_CreateInfo()
            info.text = sortMode[i]
            info.value = sortMode[i]
            info.func = function(self)
                ImprovedNameplatesDB.numbersDisplaySelf = self.value
                UIDropDownMenu_SetSelectedValue(dropdown, self.value)
                Manriel_UI_Config.ImprovedNameplatesDB = ImprovedNameplatesDB;
            end
            UIDropDownMenu_AddButton(info)
        end
        UIDropDownMenu_SetSelectedValue(dropdown, ImprovedNameplatesDB.numbersDisplaySelf)
    end
    numericDisplaySelfDropdown:HookScript("OnShow", numericDisplaySelfDropdown.initialize)
    UIDropDownMenu_SetText(numericDisplaySelfDropdown, ImprovedNameplatesDB.numbersDisplaySelf)

    local numericDisplayOthersLabel = INP_Options:CreateFontString("numericDisplayOthersLabel", "ARTWORK", "GameFontHighlightSmall")
    numericDisplayOthersLabel:SetPoint("TOPLEFT", 15, -203)
    numericDisplayOthersLabel:SetText("Numeric Display (Others)")

    local numericDisplayOthersDropdown = CreateFrame("Frame", "numericDisplayOthersDropdown", INP_Options, "UIDropDownMenuTemplate")
    numericDisplayOthersDropdown:SetPoint("TOPLEFT", 0, -216)
    numericDisplayOthersDropdown.initialize = function(dropdown)
        local sortMode = { "Numeric Value", "Current", "Percentage", "Both", "Hide" }
        for i, mode in next, sortMode do
            local info = UIDropDownMenu_CreateInfo()
            info.text = sortMode[i]
            info.value = sortMode[i]
            info.func = function(self)
                ImprovedNameplatesDB.numbersDisplayOthers = self.value
                UIDropDownMenu_SetSelectedValue(dropdown, self.value)
                Manriel_UI_Config.ImprovedNameplatesDB = ImprovedNameplatesDB;
            end
            UIDropDownMenu_AddButton(info)
        end
        UIDropDownMenu_SetSelectedValue(dropdown, ImprovedNameplatesDB.numbersDisplayOthers)
    end
    numericDisplayOthersDropdown:HookScript("OnShow", numericDisplayOthersDropdown.initialize)
    UIDropDownMenu_SetText(numericDisplayOthersDropdown, ImprovedNameplatesDB.numbersDisplayOthers)

    local nameFontSmallSlider = CreateFrame("Slider", "nameFontSmallSlider", INP_Options, "OptionsSliderTemplate")
    nameFontSmallSlider:ClearAllPoints()
    nameFontSmallSlider:SetPoint("TOPLEFT", 15, -275)
    nameFontSmallSlider:SetMinMaxValues(5, 20)
    nameFontSmallSlider:SetValue(ImprovedNameplatesDB.nameFontSmall)
    nameFontSmallSlider:SetValueStep(1)
    nameFontSmallSlider:SetObeyStepOnDrag(true)
    nameFontSmallSlider:SetOrientation("HORIZONTAL")
    _G[nameFontSmallSlider:GetName() .. "Low"]:SetText("5")
    _G[nameFontSmallSlider:GetName() .. "High"]:SetText("20")
    _G[nameFontSmallSlider:GetName() .. "Text"]:SetText("Name Font Size (Small)")
    nameFontSmallSlider:SetScript("OnValueChanged", function() ImprovedNameplatesDB.nameFontSmall = nameFontSmallSlider:GetValue(); Manriel_UI_Config.ImprovedNameplatesDB = ImprovedNameplatesDB; nameFontSmallLabel:SetText("Selected: " .. nameFontSmallSlider:GetValue()) end)

    local nameFontSmallLabel = INP_Options:CreateFontString("nameFontSmallLabel", "ARTWORK", "GameFontHighlightSmall")
    nameFontSmallLabel:SetPoint("LEFT", nameFontSmallSlider, "RIGHT", 20, 0)
    nameFontSmallLabel:SetText("Selected: " .. ImprovedNameplatesDB.nameFontSmall)

    local nameFontLargeSlider = CreateFrame("Slider", "nameFontLargeSlider", INP_Options, "OptionsSliderTemplate")
    nameFontLargeSlider:ClearAllPoints()
    nameFontLargeSlider:SetPoint("TOPLEFT", 15, -325)
    nameFontLargeSlider:SetMinMaxValues(5, 20)
    nameFontLargeSlider:SetValue(ImprovedNameplatesDB.nameFontLarge)
    nameFontLargeSlider:SetValueStep(1)
    nameFontLargeSlider:SetObeyStepOnDrag(true)
    nameFontLargeSlider:SetOrientation("HORIZONTAL")
    _G[nameFontLargeSlider:GetName() .. "Low"]:SetText("5")
    _G[nameFontLargeSlider:GetName() .. "High"]:SetText("20")
    _G[nameFontLargeSlider:GetName() .. "Text"]:SetText("Name Font Size (Large)")
    nameFontLargeSlider:SetScript("OnValueChanged", function() ImprovedNameplatesDB.nameFontLarge = nameFontLargeSlider:GetValue(); Manriel_UI_Config.ImprovedNameplatesDB = ImprovedNameplatesDB; nameFontLargeLabel:SetText("Selected: " .. nameFontLargeSlider:GetValue()) end)

    local nameFontLargeLabel = INP_Options:CreateFontString("nameFontLargeLabel", "ARTWORK", "GameFontHighlightSmall")
    nameFontLargeLabel:SetPoint("LEFT", nameFontLargeSlider, "RIGHT", 20, 0)
    nameFontLargeLabel:SetText("Selected: " .. ImprovedNameplatesDB.nameFontLarge)

    local healthFontSmallSlider = CreateFrame("Slider", "healthFontSmallSlider", INP_Options, "OptionsSliderTemplate")
    healthFontSmallSlider:ClearAllPoints()
    healthFontSmallSlider:SetPoint("TOPLEFT", 15, -375)
    healthFontSmallSlider:SetMinMaxValues(5, 20)
    healthFontSmallSlider:SetValue(ImprovedNameplatesDB.healthFontSmall)
    healthFontSmallSlider:SetValueStep(1)
    healthFontSmallSlider:SetObeyStepOnDrag(true)
    healthFontSmallSlider:SetOrientation("HORIZONTAL")
    _G[healthFontSmallSlider:GetName() .. "Low"]:SetText("5")
    _G[healthFontSmallSlider:GetName() .. "High"]:SetText("20")
    _G[healthFontSmallSlider:GetName() .. "Text"]:SetText("Health Font Size (Small)")
    healthFontSmallSlider:SetScript("OnValueChanged", function() ImprovedNameplatesDB.healthFontSmall = healthFontSmallSlider:GetValue(); Manriel_UI_Config.ImprovedNameplatesDB = ImprovedNameplatesDB; healthFontSmallLabel:SetText("Selected: " .. healthFontSmallSlider:GetValue()) end)

    local healthFontSmallLabel = INP_Options:CreateFontString("healthFontSmallLabel", "ARTWORK", "GameFontHighlightSmall")
    healthFontSmallLabel:SetPoint("LEFT", healthFontSmallSlider, "RIGHT", 20, 0)
    healthFontSmallLabel:SetText("Selected: " .. ImprovedNameplatesDB.healthFontSmall)

    local healthFontLargeSlider = CreateFrame("Slider", "healthFontLargeSlider", INP_Options, "OptionsSliderTemplate")
    healthFontLargeSlider:ClearAllPoints()
    healthFontLargeSlider:SetPoint("TOPLEFT", 15, -425)
    healthFontLargeSlider:SetMinMaxValues(5, 20)
    healthFontLargeSlider:SetValue(ImprovedNameplatesDB.healthFontLarge)
    healthFontLargeSlider:SetValueStep(1)
    healthFontLargeSlider:SetObeyStepOnDrag(true)
    healthFontLargeSlider:SetOrientation("HORIZONTAL")
    _G[healthFontLargeSlider:GetName() .. "Low"]:SetText("5")
    _G[healthFontLargeSlider:GetName() .. "High"]:SetText("20")
    _G[healthFontLargeSlider:GetName() .. "Text"]:SetText("Health Font Size (Large)")
    healthFontLargeSlider:SetScript("OnValueChanged", function() ImprovedNameplatesDB.healthFontLarge = healthFontLargeSlider:GetValue(); Manriel_UI_Config.ImprovedNameplatesDB = ImprovedNameplatesDB; healthFontLargeLabel:SetText("Selected: " .. healthFontLargeSlider:GetValue()) end)

    local healthFontLargeLabel = INP_Options:CreateFontString("healthFontLargeLabel", "ARTWORK", "GameFontHighlightSmall")
    healthFontLargeLabel:SetPoint("LEFT", healthFontLargeSlider, "RIGHT", 20, 0)
    healthFontLargeLabel:SetText("Selected: " .. ImprovedNameplatesDB.healthFontLarge)

    local instructionsLabel = INP_Options:CreateFontString("instructionsLabel", "ARTWORK", "GameFontHighlightSmall")
    instructionsLabel:SetPoint("TOPLEFT", 15, -475)
    instructionsLabel:SetText("You may need to refresh nameplates before some of the settings take effect.\n(Press V/Shift+V once to disable nameplates, then press it again to re-enable them.)")
end

-- Initializing variables for the level display.
local levelTextSize = nil
local levelTextureWidth = nil
local levelTextureHeight = nil
local levelTextureOffsetX = nil
local levelTextureOffsetY = nil

-- Set up level display, also current target visibility.
hooksecurefunc("CompactUnitFrame_SetUnit", function(frame, unit)
    if frame.optionTable.colorNameBySelection and unit and not frame:IsForbidden() then
        local level = UnitLevel(unit) -- Gets level of unit associated with frame.
        local difficultyColor = GetQuestDifficultyColor(level) -- Gets difficulty color of unit compared to player's level.

        -- Add a level display to the nameplate.
        if ImprovedNameplatesDB.showLevels then
            -- Initialize sizes for level display.
            if InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:GetValue() == "1" then -- If 'Larger Nameplates' option is enabled.
                levelTextSize = 11
                levelTextureWidth = 30
                levelTextureHeight = 15
                levelTextureOffsetX = 30
                levelTextureOffsetY = 0
            else
                levelTextSize = 8
                levelTextureWidth = 18
                levelTextureHeight = 8
                levelTextureOffsetX = 18
                levelTextureOffsetY = 0
            end

            if not frame.level then
                frame.level = CreateFrame("Frame", nil, frame) -- Setting up level display frames.
                frame.level.texture = frame.level:CreateTexture(nil, "OVERLAY") -- Creating the texture that will appear behind the level display.
                frame.level.texture:SetTexture(props.getTexture())
                frame.level.texture:SetVertexColor(0, 0, 0, 1)
                frame.level.text = frame.level.text or frame.level:CreateFontString(nil, "OVERLAY") -- Creating the text string that holds level.
                frame.level.text:SetPoint("CENTER", frame.level.texture)
                frame.level:SetFrameStrata("HIGH")

                frame.skull = CreateFrame("Frame", nil, frame.level) -- Setting up skull level display for boss mobs and/or higher level units.
                frame.skull.texture = frame.skull:CreateTexture(nil, "OVERLAY")
                frame.skull.texture:SetAllPoints(frame.level)
                frame.skull.texture:SetTexture("Interface\\AddOns\\ImprovedNameplates\\UI-Skull.tga")
                frame.skull:SetFrameStrata("HIGH")
                frame.skull:SetPoint("CENTER")
            end

            frame.level:SetSize(levelTextureWidth, levelTextureHeight)
            frame.level.texture:SetPoint("RIGHT", frame.healthBar, levelTextureOffsetX, levelTextureOffsetY)
            frame.level.texture:SetSize(levelTextureWidth, levelTextureHeight)
            frame.level.text:SetFont(props.getFont(), levelTextSize, "OUTLINE")
            frame.level:SetPoint("RIGHT", frame.healthBar, levelTextureOffsetX, levelTextureOffsetY)

            if C_NamePlate.GetNamePlateForUnit(unit) == C_NamePlate.GetNamePlateForUnit("player") then -- Hide the level text and background texture from Personal Resource Display (Thanks Blizzard)
                frame.level.text:SetText()
                frame.level.texture:Hide()
                frame.skull.texture:Hide()
            else
                frame.level.text:SetText(level)
                frame.level.texture:Show()
                frame.skull.texture:Hide()

                -- If unit is friendly, keep level display yellow, else color it by difficulty.
                if UnitIsFriend("player", unit) then
                    frame.level.text:SetVertexColor(1, 0.82, 0)
                else
                    frame.level.text:SetVertexColor(difficultyColor.r, difficultyColor.g, difficultyColor.b)
                end

                -- Replace level with a skull if the unit is hostile and is 10 levels or higher, or if the API returns -1 = boss mobs.
                if level >= UnitLevel("player") + 10 or level == -1 then
                    if UnitIsEnemy("player", unit) or level == -1 then
                        frame.skull.texture:Show()
                        frame.level.text:SetText()
                    end
                end
            end
        end

        -- Extension of PLAYER_TARGET_CHANGED-registered frame.
        if not UnitIsUnit(unit, "target") and UnitExists("target") and not UnitIsUnit(unit, "player") then
            frame:SetAlpha(0.5)
        else
            frame:SetAlpha(1)
        end
    end
end)

-- Health numbers.
hooksecurefunc("CompactUnitFrame_UpdateHealth", function(frame)
    if frame.optionTable.colorNameBySelection and not frame:IsForbidden() then
        local healthPercentage = ceil((UnitHealth(frame.displayedUnit) / UnitHealthMax(frame.displayedUnit) * 100)) -- Calculating a percentage value for health.

        if not frame.health then
            frame.health = CreateFrame("Frame", nil, frame) -- Setting up health display frames.
            frame.health:SetSize(300,16)
            frame.health.text = frame.health.text or frame.health:CreateFontString(nil, "OVERLAY")
            frame.health.text:SetAllPoints(true)
            frame.health:SetFrameStrata("HIGH")
            frame.health:SetPoint("CENTER", frame.healthBar)
            frame.health.text:SetVertexColor(1, 1, 1)
        end

        if frame == C_NamePlate.GetNamePlateForUnit("player") then -- If Unit is Player (nameplate = Personal Resource Display.)
            if InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:GetValue() == "1" then -- If 'Larger Nameplates' option is enabled.
                frame.health.text:SetFont(props.getFont(), ImprovedNameplatesDB.healthFontLarge, "OUTLINE")
                frame.health.text:Show()
            else
                frame.health.text:SetFont(props.getFont(), ImprovedNameplatesDB.healthFontSmall, "OUTLINE")
                frame.health.text:Hide()
            end

            -- Set up the health text for Personal Resource Display depending on display option.
            if ImprovedNameplatesDB.numbersDisplaySelf == "Numeric Value" then
                frame.health.text:SetText(formatNumbers(UnitHealth(frame.unit)) .. " / " .. formatNumbers(UnitHealthMax(frame.unit))) -- Update health numbers (player.)
            elseif ImprovedNameplatesDB.numbersDisplaySelf == "Current" then
                frame.health.text:SetText(formatNumbers(UnitHealth(frame.unit))) -- Update health numbers (player, current value only.)
            elseif ImprovedNameplatesDB.numbersDisplaySelf == "Percentage" then
                frame.health.text:SetText(healthPercentage .. "%") -- Update health percentages (player.)
            elseif ImprovedNameplatesDB.numbersDisplaySelf == "Both" then
                frame.health.text:SetText(formatNumbers(UnitHealth(frame.unit)) .. " - " .. healthPercentage .. "%") -- Update health numbers + percentages (player.)
            elseif ImprovedNameplatesDB.numbersDisplaySelf == "Hide" then
                frame.health.text:SetText()
            end
        else -- If Unit is anything other than player (nameplate = regular nameplates.)
            if InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:GetValue() == "1" then -- If 'Larger Nameplates' option is enabled.
                frame.health.text:SetFont(props.getFont(), ImprovedNameplatesDB.healthFontLarge, "OUTLINE")
            else
                frame.health.text:SetFont(props.getFont(), ImprovedNameplatesDB.healthFontSmall, "OUTLINE")
            end

            frame.health.text:Show() -- Thanks Blizzard...

            -- Set up the health text for other units' nameplates depending on display option.
            if ImprovedNameplatesDB.numbersDisplayOthers == "Numeric Value" then
                frame.health.text:SetText(formatNumbers(UnitHealth(frame.unit)) .. " / " .. formatNumbers(UnitHealthMax(frame.unit))) -- Update health numbers (others.)
            elseif ImprovedNameplatesDB.numbersDisplayOthers == "Current" then
                frame.health.text:SetText(formatNumbers(UnitHealth(frame.unit)))
            elseif ImprovedNameplatesDB.numbersDisplayOthers == "Percentage" then
                frame.health.text:SetText(healthPercentage .. "%") -- Update health percentages (others.)
            elseif ImprovedNameplatesDB.numbersDisplayOthers == "Both" then
                frame.health.text:SetText(formatNumbers(UnitHealth(frame.unit)) .. " - " .. healthPercentage .. "%") -- Update health numbers + percentages (others.)
            elseif ImprovedNameplatesDB.numbersDisplayOthers == "Hide" then
                frame.health.text:SetText()
            end
        end
    end
end)

-- Current target visibility, see also L#366.
local targetFrame = CreateFrame("frame")
targetFrame:RegisterEvent("PLAYER_TARGET_CHANGED")
targetFrame:SetScript("OnEvent", function(self, event)
    for _, frame in pairs(C_NamePlate.GetNamePlates()) do
        if frame == C_NamePlate.GetNamePlateForUnit("target") or not UnitExists("target") or frame == C_NamePlate.GetNamePlateForUnit("player") then
            frame.UnitFrame:SetAlpha(1)
        else
            frame.UnitFrame:SetAlpha(0.5)
        end
    end
end)

-- Threat display.
hooksecurefunc("CompactUnitFrame_UpdateHealthBorder", function(frame)
    if frame.optionTable.colorNameBySelection and not frame:IsForbidden() then
        -- Colorize unit frame depending on threat.
        local threat = UnitThreatSituation("player", frame.unit) -- Gets unit threat level, 3 = tanking, 2 = insecurely tanking/losing threat, 1/0 = not tanking.

        if C_NamePlate.GetNamePlateForUnit(frame.unit) ~= C_NamePlate.GetNamePlateForUnit("player") and frame.level then
            if threat == 3 then --3 = Securely tanking; make borders red.
                if ImprovedNameplatesDB.showLevels then
                    frame.level.texture:SetVertexColor(1, 0, 0, 1)
                end
                frame.healthBar.border:SetVertexColor(1, 0, 0, 1)
            elseif threat == 2 then -- 2 = Tanking, but somebody else has higher threat (losing threat); make borders orange.
                if ImprovedNameplatesDB.showLevels then
                    frame.level.texture:SetVertexColor(1, 0.5, 0, 1)
                end
                frame.healthBar.border:SetVertexColor(1, 0.5, 0, 1)
            elseif threat == 1 then -- 1 = Not tanking, but higher threat than tank; make borders yellow.
                if ImprovedNameplatesDB.showLevels then
                    frame.level.texture:SetVertexColor(1, 1, 0.4, 1)
                end
                frame.healthBar.border:SetVertexColor(1, 1, 0.4, 1)
            else -- 0 = Not tanking; make borders black.
                if ImprovedNameplatesDB.showLevels then
                    frame.level.texture:SetVertexColor(0, 0, 0, 1)
                end
                frame.healthBar.border:SetVertexColor(0, 0, 0, 1)
            end
        else
            frame.healthBar.border:SetVertexColor(frame.optionTable.defaultBorderColor:GetRGBA()) -- Thanks Blizzard...
        end
    end
end)

--Power numbers
hooksecurefunc("ClassNameplateManaBar_OnUpdate", function(self)
    local powerPercentage = ceil((UnitPower("player") / UnitPowerMax("player") * 100)) -- Calculating a percentage value for primary resource (Rage/Mana/Focus/etc.)

    if (ClassNameplateManaBar) then
        if not ClassNameplateManaBar.powerNumbers then
        ClassNameplateManaBar.powerNumbers = CreateFrame("Frame", nil, ClassNameplateManaBar) -- Setting up resource display frame.
        ClassNameplateManaBar.powerNumbers:SetSize(300,16)
        ClassNameplateManaBar.powerNumbers.text = ClassNameplateManaBar.powerNumbers.text or ClassNameplateManaBar.powerNumbers:CreateFontString(nil, "OVERLAY")
        ClassNameplateManaBar.powerNumbers.text:SetAllPoints(true)
        ClassNameplateManaBar.powerNumbers:SetFrameStrata("HIGH")
        ClassNameplateManaBar.powerNumbers:SetPoint("CENTER", ClassNameplateManaBarFrame)
        ClassNameplateManaBar.powerNumbers.text:SetFont(props.getFont(), 11, "OUTLINE")
        ClassNameplateManaBar.powerNumbers.text:SetVertexColor(1, 1, 1)
    else
        if InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:GetValue() == "1" then -- If 'Larger Nameplates' option is enabled.
            if ImprovedNameplatesDB.numbersDisplaySelf == "Numeric Value" then
                ClassNameplateManaBar.powerNumbers.text:SetText(formatNumbers(UnitPower("player")) .. " / " .. formatNumbers(UnitPowerMax("player"))) -- Update resource numbers.
            elseif ImprovedNameplatesDB.numbersDisplaySelf == "Current" then
                ClassNameplateManaBar.powerNumbers.text:SetText(formatNumbers(UnitPower("player")))
            elseif ImprovedNameplatesDB.numbersDisplaySelf == "Percentage" then
                ClassNameplateManaBar.powerNumbers.text:SetText(powerPercentage .. "%") -- Update resource percentages.
            elseif ImprovedNameplatesDB.numbersDisplaySelf == "Both" then
                ClassNameplateManaBar.powerNumbers.text:SetText(formatNumbers(UnitPower("player")) .. " - " .. powerPercentage .. "%") -- Update resource numbers + percentage.
            elseif ImprovedNameplatesDB.numbersDisplaySelf == "Hide" then
                ClassNameplateManaBar.powerNumbers.text:SetText()
            end
            ClassNameplateManaBar.powerNumbers.text:Show()
        else
            ClassNameplateManaBar.powerNumbers.text:Hide() -- Not enough space on regular-sized nameplates to have text on resource bar alongside health bar text, so we disable that.
        end
    end
    end
    
end)

-- Improve the font for readability.
hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
    if frame.optionTable.colorNameBySelection and not frame:IsForbidden() then
        if InterfaceOptionsNamesPanelUnitNameplatesMakeLarger:GetValue() == "1" then -- Check if Larger Nameplates option is checked.
            if strfind(GetUnitName(frame.unit, true), "[\208-\209]") ~= nil then
                frame.name:SetFont(props.getFont(), ImprovedNameplatesDB.nameFontLarge, "OUTLINE") -- Russian.
            else
                frame.name:SetFont(props.getFont(), ImprovedNameplatesDB.nameFontLarge, "OUTLINE")
            end
        else
            if strfind(GetUnitName(frame.unit, true), "[\208-\209]") ~= nil then
                frame.name:SetFont(props.getFont(), ImprovedNameplatesDB.nameFontSmall, "OUTLINE") -- Russian.
            else
                frame.name:SetFont(props.getFont(), ImprovedNameplatesDB.nameFontSmall, "OUTLINE")
            end
        end

        if ImprovedNameplatesDB.showRealmNames then
            frame.name:SetText(GetUnitName(frame.unit, true))
        else
            frame.name:SetText(GetUnitName(frame.unit, false))
        end

        -- Always show names on nameplates, except Personal Resource Display (hfhhfhflskjhfkasjsgdlkasgldkajsgfdklasdhlaskdjhl !'s and @'s and #'s and $'s)
        if UnitGUID(frame.unit) ~= UnitGUID("player") and ImprovedNameplatesDB.showAllNames then
            frame.name:Show()
        else
            frame.name:Hide()
        end

        frame.name:SetVertexColor(1, 1, 1) -- Colors all names white.

        -- Colorize unit name when they are in combat.
        if CompactUnitFrame_IsTapDenied(frame) then -- If unit has been tapped (opposite faction, or 5+ players of your faction.)
            frame.name:SetVertexColor(0.5, 0.5, 0.5, 1) -- Grey.
        elseif UnitAffectingCombat(frame.unit) and UnitCanAttack("player", frame.unit) and not UnitIsPlayer(frame.unit) then -- If unit is in combat, only for attackable NPCs.
            frame.name:SetVertexColor(1, 0, 0, 1) -- Red.
        else -- If unit not in combat.
            frame.name:SetVertexColor(1, 1, 1, 1) -- White.
        end

        --Fix BuffFrame placement.
        frame.BuffFrame:SetPoint("BOTTOM", frame.BuffFrame:GetParent(), "TOP")
    end
end)

-- Fix for Blizzard's sloppy code...
hooksecurefunc("CompactUnitFrame_UpdateClassificationIndicator", function(frame)
    if frame.optionTable.colorNameBySelection and not frame:IsForbidden() then
        if ( frame.optionTable.showClassificationIndicator ) then
            local classification = UnitClassification(frame.unit)
            if (classification == "elite" or classification == "worldboss") then
                frame.classificationIndicator:SetAtlas("nameplates-icon-elite-gold")
                frame.classificationIndicator:Show()
            elseif (classification == "rareelite"  or classification == "rare") then
                frame.classificationIndicator:SetAtlas("nameplates-icon-elite-silver")
                frame.classificationIndicator:Show()
            else
                frame.classificationIndicator:Hide()
            end
        elseif ( frame.classificationIndicator ) then
            frame.classificationIndicator:Hide()
        end
    end
end)
