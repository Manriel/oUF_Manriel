local addonname, addon = ...
local name = "zz_Repair"
local L = LibStub("AceLocale-3.0"):NewLocale(name, "deDE", false)
if L then
  L[name] = name
  L[name..' Settings'] = name..' Einstellungen'
  L['Autorepair'] = 'Automatisch reparieren'
  L['Show lowest'] = 'Zeige Niedrigstes'
  L['Show durability of your lowest item only'] = 'Zeigt die Haltbarkeit des niedrigsten Ausr\195\188stungsgegenstands statt dem Durchschnitt'
  L['Show all slots'] = 'Zeige alle Slots'
  L['Show all slots in the tooltip instead of damaged only'] ='Zeigt im Tooltip auch nicht besch\195\164digte Items'
  L["HeadSlot"] = 'Kopf'
  L["NeckSlot"] = 'Hals'
  L["ShoulderSlot"] = 'Schulter'
  L["BackSlot"] = 'R\195\188cken'
  L["ChestSlot"] = 'Brust'
  L["ShirtSlot"] = 'Hemd'
  L["TabardSlot"] = 'Wappenrock'
  L["WristSlot"] = 'Handgelenk'
  L["HandsSlot"] = 'H\195\164nde'
  L["WaistSlot"] = 'Taille'
  L["LegsSlot"] = 'Beine'
  L["FeetSlot"] = 'F\195\188\195\159e'
  L["Finger0Slot"] = 'Erster Ring'
  L["Finger1Slot"] = 'Zweiter Ring'
  L["Trinket0Slot"] = 'Erstes Schmuckst\195\188ck'
  L["Trinket1Slot"] = 'Zweites Schmuckst\195\188ck'
  L["MainHandSlot"] = 'Waffenhand'
  L["SecondaryHandSlot"] = 'Nebenhand'
  L["RangedSlot"] = 'Fernkampf'
  L["AmmoSlot"] = 'Munition'
  L["Bag0Slot"] = 'Erste Tasche'
  L["Bag1Slot"] = 'Zweite Tasche'
  L["Bag2Slot"] = 'Dritte Tasche'
  L["Bag3Slot"] = 'Vierte Tasche'
  L['repaircost'] = function(r) return "Verschwendete Reparaturkosten: "..addon['buildMoneyString'](r) end
  L['repaircostgb'] = function(r) return "Verschwendete Reparaturkosten zu Lasten der Gildenbank: "..addon['buildMoneyString'](r) end
  L["Repair Charts"] = "Repair Charts"
  L['Allow Guildbank Repair'] = "Repariere aus Gildenbank"
  L['Money low'] = "Nicht genug Geld f\195\188r Reparatur!"
  L['HINT3'] = "|c0000ff00Shift-Linksklick|r |c00ffffffschaltet Minimapicon an/aus|r"
end

-- ö \195\182 ß \195\159
-- ü \195\188 ä \195\164
-- Ä \195\132
-- ö \195\182
-- Ü \195\156