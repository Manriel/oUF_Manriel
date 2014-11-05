local parent, ns = ...

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
		target = 'Цель'
		you = 'Вы',
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
		target = 'Target'
		you = 'You',
	}
end

ns.ManrielUI.localeStrings = arStrings
