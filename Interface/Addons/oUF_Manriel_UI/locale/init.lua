local parent, namespace = ...
local UI = namespace.ManrielUI

local strings = {};
if type(UI.localeStrings[GetLocale()]) ~= nil then
	UI.localeStrings = namespace.ManrielUI.localeStrings[GetLocale()]
else
	UI.localeStrings = namespace.ManrielUI.localeStrings['enUS']
end

BINDING_NAME_MANRIEL_DEBUG = UI.localeStrings.debug