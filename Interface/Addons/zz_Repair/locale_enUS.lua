local addonname, addon = ...
local name = "zz_Repair"
local L = LibStub("AceLocale-3.0"):NewLocale(name, "enUS", true)
if L then
  L[name] = name
  L[name..' Settings'] = name..' Settings'
  L['Autorepair'] = 'Automatic repair'
  L['Show lowest'] = 'Show lowest'
  L['Show durability of your lowest item only'] = 'Show durability of your lowest item only'
  L['Show all slots'] = 'Show all slots'
  L['Show all slots in the tooltip instead of damaged only'] ='Show all slots in the tooltip instead of damaged only'
  L["HeadSlot"] = 'Head'
  L["NeckSlot"] = 'Neck'
  L["ShoulderSlot"] = 'Shoulder'
  L["BackSlot"] = 'Back'
  L["ChestSlot"] = 'Chest'
  L["ShirtSlot"] = 'Shirt'
  L["TabardSlot"] = 'Tabard'
  L["WristSlot"] = 'Wrist'
  L["HandsSlot"] = 'Hands'
  L["WaistSlot"] = 'Waist'
  L["LegsSlot"] = 'Legs'
  L["FeetSlot"] = 'Feet'
  L["Finger0Slot"] = 'First Ring'
  L["Finger1Slot"] = 'Second Ring'
  L["Trinket0Slot"] = 'First Trinket'
  L["Trinket1Slot"] = 'Second Trinket'
  L["MainHandSlot"] = 'Main Hand'
  L["SecondaryHandSlot"] = 'Offhand'
  L["RangedSlot"] = 'Ranged'
  L["AmmoSlot"] = 'Munition'
  L["Bag0Slot"] = 'First Bag'
  L["Bag1Slot"] = 'Second Bag'
  L["Bag2Slot"] = 'Third Bag'
  L["Bag3Slot"] = 'Fourth Bag'
  L['repaircost'] = function(r) return "Wasted money for repairs: "..addon['buildMoneyString'](r) end
  L['repaircostgb'] = function(r) return "Wasted guildvaults money for repairs: "..addon['buildMoneyString'](r) end
  L["Repair Charts"] = "Repair Charts"
  L['Allow Guildbank Repair'] = true
  L['Money low'] = "No fund for repair!"
  L['HINT3'] = "|c0000ff00Shift-Leftclick|r |c00fffffftoggles minimap icon|r"
end