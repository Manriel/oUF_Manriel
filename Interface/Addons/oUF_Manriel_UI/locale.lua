local parent, ns = ...
local UI = ns.ManrielUI

local locale = GetLocale();
local arStrings = {};
if locale == "ruRU" then
	arStrings = {
		offline = 'Не в сети',
		dead = {
			'Мертв',
			'Мертв',
			'Мертва',
		},
		ghost = 'Призрак',
		target = 'Цель',
		you = 'Вы',
		unsupportedRealm = 'Неподдерживаемый сервер.',
		armoryLink = "Ссылка на оружейную",
	}
else
	arStrings = {
		offline = 'Offline',
		dead = {
			'Dead',
			'Dead',
			'Dead',
		},
		ghost = 'Ghost',
		target = 'Target',
		you = 'You',
		unsupportedRealm = 'Unsupported realm location.',
		armoryLink = "Armory Link",
	}
end

UI.localeStrings = arStrings
