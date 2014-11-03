-- CONFIG
local widescreen = true
-- END CONFIG

local point, width

if widescreen then
	point = { "BOTTOMRIGHT", -173, 14.5 }
	width = 166
else
	point = { "BOTTOMRIGHT", -173, 14.5 }
	width = 146
end

local data = {
	Point = point,
	-- Wo soll der erste Balken hin? http://www.wowwiki.com/API_Region_SetPoint
	Direction = "down",
	-- Wohin sollen sich die Balken aufbauen? "down" = Nach unten, "up" = Nach oben.
	Spacing = 0.5,
	-- Abstand zwischen den Balken.
	Width = width,
	-- Die länge der Balken.
	Height = 19,
	-- Die höhe der Balken.
	Texture = "Interface\\AddOns\\sThreatMeter2\\statusbar",
	-- Die Textur für die Balken.
	Color = "class",
	-- Balken in Klassenfarbe oder eigene Farbe? "class" = Klassenfarbe, { a, g, b[, a] } = Eigene Farbe in RGB(A).
	BackgroundColor = { 0.5, 0.5, 0.5, 0.7 },
	-- Balkenhintergrundsfarbe in RGB(A).
	Bars = 8,
	-- Wieviele Balken willst du haben?
	
	Font = { "Interface\\AddOns\\sThreatMeter2\\calibrib.ttf", 12 },
	-- Deine Schrift. http://www.wowwiki.com/API_FontInstance_SetFont
	
	TextLeft = "$name",
	-- Was willst du bei deinen linken Text stehen haben? 
	TextRight = "$threatvalue [$threatperc%]",
	-- Was willst du bei deinen rechten Text stehen haben?
	
	-- $name = Der Name des Spielers
	-- $threatvalue = Der Bedrohungswert des Spielers
	-- $threatperc = Die Bedrohungsprozentzahl des Spielers
};

local threatguid, threatunit, threatlist, threatbars = "", "target", {}, {};

local function comma_value(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

local function ColorGradient(perc, ...)
	if perc >= 1 then
		local r, g, b = select(select('#', ...) - 2, ...)
		return r, g, b
	elseif perc <= 0 then
		local r, g, b = ...
		return r, g, b
	end

	local num = select('#', ...) / 3

	local segment, relperc = math.modf(perc*(num-1))
	local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

	return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

local function GetThreat(unit, pet)
	if ( UnitName(pet or unit) == UNKNOWN or not UnitIsVisible(pet or unit) ) then
		return;
	end
	
	local isTanking, state, scaledPercent, rawPercent, threatValue = UnitDetailedThreatSituation(pet or unit, threatunit);
	
	for index, value in ipairs(threatlist) do
		if ( pet and value.name == UnitName(unit)..": "..UnitName(pet) or value.name == UnitName(unit) ) then
			tremove(threatlist, index);
			break;
		end
	end
	if tvalue and tvalue < 0 then
		tvalue = tvalue + 410065408;
	end
	table.insert(threatlist, {
		name = ( pet ) and UnitName(unit) .. ": " .. UnitName(pet) or UnitName(unit),
		class = select(2, UnitClass(unit)),
		scaledPercent = scaledPercent or 0,
		threatValue = threatValue or 0,
	});
end

local function AddThreat(unit, pet)
	if ( UnitExists(pet) ) then
		GetThreat(unit);
		GetThreat(unit, pet);
	else
		if ( GetNumPartyMembers() > 0 or GetNumPartyMembers() > 0 ) then
			GetThreat(unit);
		end
	end
end

local function UpdateThreatBars()
	for index, value in ipairs(threatbars) do
		value:Hide();
	end
	table.sort(threatlist, function(a, b)
		if ( string.lower(data.Direction) == "down" ) then
			return a.scaledPercent > b.scaledPercent;
		end
		return a.scaledPercent < b.scaledPercent;
	end);
	local container, bar, class, r, g, b, text;
	if ( not container ) then
		container = CreateFrame("Frame", "sThreatMeter_Main", UIParent);
		container:SetWidth(data.Width);
		container:SetHeight( (data.Height*data.Bars) + (data.Spacing*(data.Bars-1)) );
		container:SetPoint(unpack(data.Point));
	end
	for index, value in ipairs(threatlist) do
		if ( index > data.Bars ) then
			return;
		end
		bar = threatbars[index];
		if ( not bar ) then
			bar = CreateFrame("StatusBar", "sThreatMeterBar"..index, container);
			bar:SetWidth(data.Width);
			bar:SetHeight(data.Height);
			bar:SetStatusBarTexture(data.Texture);
			bar:SetMinMaxValues(0, 100);
			bar:SetValue(0);
			if ( index == 1 ) then
				if ( string.lower(data.Direction) == "down" ) then
					bar:SetPoint("TOP", container, "TOP", 0, 0);
				else
					bar:SetPoint("BOTTOM", container, "BOTTOM", 0, 0);
				end
			else
				if ( string.lower(data.Direction) == "down" ) then
					bar:SetPoint("TOP", threatbars[index-1], "BOTTOM", 0, -data.Spacing);
				else
					bar:SetPoint("BOTTOM", threatbars[index-1], "TOP", 0, data.Spacing);
				end
			end
			
			bar.background = bar:CreateTexture("$parentBackground", "BACKGROUND");
			bar.background:SetAllPoints();
			bar.background:SetTexture(data.Texture);
			
			bar.textright = bar:CreateFontString("$parentTextRight", "ARTWORK");
			bar.textright:SetFont(unpack(data.Font));
			bar.textright:SetShadowOffset(1, -1);
			bar.textright:SetJustifyH("RIGHT");
			bar.textright:SetPoint("RIGHT", -1, 1);
			
			bar.textleft = bar:CreateFontString("$parentTextLeft", "ARTWORK");
			bar.textleft:SetFont(unpack(data.Font));
			bar.textleft:SetShadowOffset(1, -1);
			bar.textleft:SetJustifyH("LEFT");
			bar.textleft:SetPoint("LEFT", 1, 1);
			bar.textleft:SetPoint("RIGHT", bar.textright, "LEFT", -1, 1);
			
			tinsert(threatbars, bar);
		end
		
		bar:SetValue(value.scaledPercent);
		if ( type(data.Color) == "string" ) then
			class = RAID_CLASS_COLORS[value.class] or { 1, 0, 1 };
			bar:SetStatusBarColor(class.r, class.g, class.b, 1);
		else
			bar:SetStatusBarColor(unpack(data.Color));
		end
		if ( value.name == UnitName("player") ) then
			bar.background:SetVertexColor(1, 0, 0, data.BackgroundColor[4] or 1);
		else
			bar.background:SetVertexColor(unpack(data.BackgroundColor));
		end
		
		r, g, b = ColorGradient(((value.scaledPercent > 100 and 100 or value.scaledPercent)/100), 0, 1, 0, 1, 1, 0, 1, 0, 0);
		text = string.gsub(data.TextRight, "$threatvalue", comma_value(value.threatValue/100));
		text = string.gsub(text, "$threatperc", string.format("|cff%02x%02x%02x%d|r", r*255, g*255, b*255, value.scaledPercent));
		text = string.gsub(text, "$name", value.name);
		bar.textright:SetText(text);
		
		text = string.gsub(data.TextLeft, "$threatvalue", comma_value(value.threatValue/100));
		text = string.gsub(text, "$threatperc", string.format("|cff%02x%02x%02x%d|r", r*255, g*255, b*255, value.scaledPercent));
		text = string.gsub(text, "$name", value.name);
		bar.textleft:SetText(text);
		
		bar:Show();
	end
end

local frame = CreateFrame("Frame");
frame:RegisterEvent("UNIT_THREAT_LIST_UPDATE");
frame:RegisterEvent("PLAYER_TARGET_CHANGED");
frame:RegisterEvent("PLAYER_REGEN_ENABLED");
frame:SetScript("OnEvent", function(self, event, ...)
	--myPrint(event, ...);
	if ( event == "UNIT_THREAT_LIST_UPDATE" ) then
		local unit = ...;
		if ( unit and UnitExists(unit) and UnitGUID(unit) == threatguid and UnitCanAttack("player", threatunit)) then
			if ( GetNumRaidMembers() > 0 ) then
				for i=1, GetNumRaidMembers(), 1 do
					AddThreat("raid"..i, "raid"..i.."pet");
				end
			elseif ( GetNumPartyMembers() > 0 ) then
				AddThreat("player", "pet");
				for i=1, GetNumPartyMembers(), 1 do
					AddThreat("party"..i, "party"..i.."pet");
				end
			else
				AddThreat("player", "pet");
			end
			UpdateThreatBars();
		end
	elseif ( event == "PLAYER_TARGET_CHANGED" ) then
		if ( UnitExists("target") and not UnitIsDead("target") and not UnitIsPlayer("target") ) then
			threatguid = UnitGUID("target");
			--[[threatunit = "target";
		elseif ( UnitExists("targettarget") and not UnitIsDead("targettarget") and not UnitIsPlayer("targettarget") and UnitCanAttack("player", "targettarget") ) then
			threatguid = UnitGUID("targettarget");
			threatunit = "targettarget";]] -- Mhhh... Man kann die Ziel des Ziels Bedrohnung auslesen, aber das Event dazu (UNIT_THREAT_LIST_UPDATE) feuert nicht... Keine Lust auf ein OnUpdate. :x
		else
			threatguid = "";
		end
		wipe(threatlist);
		UpdateThreatBars();
	elseif ( event == "PLAYER_REGEN_ENABLED" ) then
		wipe(threatlist);
		UpdateThreatBars();
	end
end);

table.insert(threatlist, { name = "Shantalya", class = "WARRIOR", scaledPercent = 100, threatValue = 100*1000*1000 });
table.insert(threatlist, { name = "Noxila", class = "HUNTER", scaledPercent = 90, threatValue = 90*1000*1000 });
table.insert(threatlist, { name = "Runalya", class = "DEATHKNIGHT", scaledPercent = 70, threatValue = 70*1000*1000 });
table.insert(threatlist, { name = "Toxila", class = "MAGE", scaledPercent = 60, threatValue = 60*1000*1000 });
table.insert(threatlist, { name = "Nidora", class = "SHAMAN", scaledPercent = 50, threatValue = 50*1000*1000 });
table.insert(threatlist, { name = "Noxila", class = "HUNTER", scaledPercent = 40, threatValue = 40*1000*1000 });
table.insert(threatlist, { name = "Runalya", class = "DEATHKNIGHT", scaledPercent = 30, threatValue = 30*1000*1000 });
table.insert(threatlist, { name = "Toxila", class = "MAGE", scaledPercent = 20, threatValue = 20*1000*1000 });
table.insert(threatlist, { name = "Nidora", class = "SHAMAN", scaledPercent = 10, threatValue = 10*1000*1000 });

UpdateThreatBars();
