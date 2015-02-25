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
		wowheadQuestLink = 'Показать на Wowhead',
		cursor = 'Указатель',

	}

	BINDING_NAME_MANRIEL_DEBUG = 'Дебаг интерфейса'
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
		wowheadQuestLink = 'Show quest on Wowhead',
		cursor = 'Cursor',

	}
	
	BINDING_NAME_MANRIEL_DEBUG = 'ManrielUI Debug'
end

UI.localeStrings = arStrings
