local parent, namespace = ...
local oUF = namespace.oUF
local UI  = namespace.ManrielUI
local LSM = UI.lib.LSM

local props = {
	getSize = function(unit)
		if unit == 'player' or unit == 'target' then
			return UI.config.width, UI.config.height;
		elseif unit == 'targettarget' or unit == 'focus' or unit == 'focustarget' or unit == 'pet' then
			return UI.config.width/2, UI.config.height/1.5
		elseif unit == 'arena1' or unit == 'arena2' or unit == 'arena3' or unit == 'arena4' or unit == 'arena5'
				or unit == 'boss1' or unit == 'boss2' or unit == 'boss3' or unit == 'boss4' or unit == 'boss5' then
			return UI.config.width/1.5, UI.config.height
		else
			return UI.config.width/2, UI.config.height/1.5
		end
	end,

	getBackdrop = function()
		return {
			bgFile   = LSM:Fetch(LSM.MediaType.BACKGROUND, 'Manriel-Background'),
			tile = true,
			tileSize = 256,
			edgeFile = LSM:Fetch(LSM.MediaType.BORDER,     'Manriel-Border-Light'),
			edgeSize = 12,
			insets   = {
				left = 0,
				right = 0,
				top = 0,
				bottom = 0
			}
		}
	end
}

UI.getStyle = function(self, unit)
	
	self:RegisterForClicks("AnyUp")
	self:SetSize(props.getSize(unit))
	self:SetBackdrop(props.getBackdrop())
	self:SetBackdropColor(0,0,0,1)


	if (type(UI.templates.getPortrait) ~= 'nil') then
		self.Portrait        = UI.templates.getPortrait(self, unit)
	end


	if (type(UI.templates.getHealth) ~= 'nil') then
		self.Health          = UI.templates.getHealth(self, unit)
	end
	if (type(UI.templates.getPower) ~= 'nil') then
		self.Power           = UI.templates.getPower(self, unit)
	end
	if (type(UI.templates.getAdditionalPower) ~= 'nil') then
		self.AdditionalPower       = UI.templates.getAdditionalPower(self, unit)
	end
	if (type(UI.templates.getAltPowerBar) ~= 'nil') then
		self.AltPowerBar     = UI.templates.getAltPowerBar(self, unit)
	end


	if (type(UI.templates.getName) ~= 'nil') then
		self.Name            = UI.templates.getName(self, unit)
	end
	if (type(UI.templates.getLvl) ~= 'nil') then 
		self.Lvl             = UI.templates.getLvl(self, unit)
	end
	if (type(UI.templates.getClass) ~= 'nil') then
		self.Class           = UI.templates.getClass(self, unit)
	end
	if (type(UI.templates.getRace) ~= 'nil') then
		self.Race            = UI.templates.getRace(self, unit)
	end

	if (type(UI.templates.getAuras) ~= 'nil') then
		self.Auras           = UI.templates.getAuras(self, unit)
	end
	if (type(UI.templates.getBuffs) ~= 'nil') then
		self.Buffs           = UI.templates.getBuffs(self, unit)
	end
	if (type(UI.templates.getDebuffs) ~= 'nil') then
		self.Debuffs         = UI.templates.getDebuffs(self, unit)
	end

	-- Rogues and Balance druids only
	if (type(UI.templates.getCPoints) ~= 'nil') then
		self.CPoints         = UI.templates.getCPoints(self, unit)
	end
	-- Death Knight only
	if (type(UI.templates.getRunes) ~= 'nil') then
		self.Runes           = UI.templates.getRunes(self, unit)
	end
	-- Monk only
	if (type(UI.templates.getStagger) ~= 'nil') then
		self.Stagger         = UI.templates.getStagger(self, unit)
	end
	--  Shaman totems, Druid mushrooms and Death Knight ghouls.
	if (type(UI.templates.getTotems) ~= 'nil') then
		self.Totems          = UI.templates.getTotems(self, unit)
	end


	if (type(UI.templates.getCastbar) ~= 'nil') then
		self.Castbar         = UI.templates.getCastbar(self, unit)
	end


	if (type(UI.templates.getClassIcons) ~= 'nil') then
		self.ClassIcons      = UI.templates.getClassIcons(self, unit)
	end
	if (type(UI.templates.getCombat) ~= 'nil') then
		self.Combat          = UI.templates.getCombat(self, unit)
	end
	if (type(UI.templates.getPvP) ~= 'nil') then
		self.PvP             = UI.templates.getPvP(self, unit)
	end
	if (type(UI.templates.getResting) ~= 'nil') then
		self.Resting         = UI.templates.getResting(self, unit)
	end
	if (type(UI.templates.getResurrectIcon) ~= 'nil') then
		self.ResurrectIcon   = UI.templates.getResurrectIcon(self, unit)
	end
	if (type(UI.templates.getThreat) ~= 'nil') then
		self.Threat          = UI.templates.getThreat(self, unit)
	end


	if (type(UI.templates.getLFDRole) ~= 'nil') then
		self.LFDRole         = UI.templates.getLFDRole(self, unit)
	end
	if (type(UI.templates.getRaidRole) ~= 'nil') then
		self.RaidRole        = UI.templates.getRaidRole(self, unit)
	end

	if (type(UI.templates.getReadyCheck) ~= 'nil') then
		self.ReadyCheck      = UI.templates.getReadyCheck(self, unit)
	end

	if (type(UI.templates.getPhaseIcon) ~= 'nil') then
		self.PhaseIcon       = UI.templates.getPhaseIcon(self, unit)
	end
	if (type(UI.templates.getQuestIcon) ~= 'nil') then
		self.QuestIcon       = UI.templates.getQuestIcon(self, unit)
	end

	if (type(UI.templates.getLeader) ~= 'nil') then
		self.Leader          = UI.templates.getLeader(self, unit)
	end
	if (type(UI.templates.getAssistant) ~= 'nil') then
		self.Assistant       = UI.templates.getAssistant(self, unit)
	end
	if (type(UI.templates.getMasterLooter) ~= 'nil') then
		self.MasterLooter    = UI.templates.getMasterLooter(self, unit)
	end

	if (type(UI.templates.getRaidIcon) ~= 'nil') then
		self.RaidIcon        = UI.templates.getRaidIcon(self, unit)
	end

	if (type(UI.templates.getRange) ~= 'nil') then
		self.Range           = UI.templates.getRange(self, unit)
	end

	if (type(UI.templates.getElite) ~= 'nil') then
		self.Elite           = UI.templates.getElite(self, unit)
	end

	if (type(UI.templates.getXpRepBar) ~= 'nil') then
		local XpRepBar = UI.templates.getXpRepBar(self, unit)
		if (type(XpRepBar) ~= 'nil') then
			if (type(XpRepBar.Experience) ~= 'nil') then
				self.Experience      = XpRepBar.Experience
			end
			if (type(XpRepBar.Reputation) ~= 'nil') then
				self.Reputation      = XpRepBar.Reputation
			end
		end
	end

	self.onUpdateFrequency = .2

end