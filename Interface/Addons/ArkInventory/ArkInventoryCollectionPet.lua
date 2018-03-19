local _G = _G
local select = _G.select
local pairs = _G.pairs
local ipairs = _G.ipairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table
local C_PetJournal = _G.C_PetJournal
local C_PetBattles = _G.C_PetBattles

local BreedAvailable = IsAddOnLoaded( "BattlePetBreedID" )

ArkInventory.Collection.Pet = {
	scanning = false,
	ready = false,
	total = 0, -- number of total pets
	owned = 0, -- number of owned pets
	cache = { },	-- [guid] = { } - owned pets only
	species = { }, -- [speciesID] = { } - all pet types
	ability = { }, -- [abilityID] = { } - all pet types
	creature = { },	-- [creatureID] = speciesID
}

local filter = {
	ignore = false,
	search = nil,
	collected = true,
	uncollected = true,
	family = { },
	source = { },
	backup = false,
}

local function FilterGetSearch( )
	return PetJournal.searchBox:GetText( )
end

local function FilterSetSearch( s )
	PetJournal.searchBox:SetText( s )
	C_PetJournal.SetSearchFilter( s )
end

local function FilterSetCollected( value )
	C_PetJournal.SetFilterChecked( LE_PET_JOURNAL_FILTER_COLLECTED, value )
end

local function FilterGetCollected( )
	return C_PetJournal.IsFilterChecked( LE_PET_JOURNAL_FILTER_COLLECTED )
end

local function FilterGetUncollected( )
	return C_PetJournal.IsFilterChecked( LE_PET_JOURNAL_FILTER_NOT_COLLECTED )
end

local function FilterSetUncollected( value )
	C_PetJournal.SetFilterChecked( LE_PET_JOURNAL_FILTER_NOT_COLLECTED, value )
end

local function FilterGetFamilyTypes( )
	return C_PetJournal.GetNumPetTypes( )
end

local function FilterSetFamily( t )
	if type( t ) == "table" then
		for i = 1, FilterGetFamilyTypes( ) do
			C_PetJournal.SetPetTypeFilter( i, t[i] )
		end
	elseif type( t ) == "boolean" then
		for i = 1, FilterGetFamilyTypes( ) do
			C_PetJournal.SetPetTypeFilter( i, t )
			
		end
	else
		assert( false, "parameter is " .. type( t ) .. ", not a table or boolean" )
	end
end

local function FilterGetFamily( t )
	assert( type( t ) == "table", "parameter is not a table" )
	for i = 1, FilterGetFamilyTypes( ) do
		t[i] = C_PetJournal.IsPetTypeChecked( i )
	end
end

local function FilterGetSourceTypes( )
	return C_PetJournal.GetNumPetSources( )
end

local function FilterGetSource( t )
	assert( type( t ) == "table", "parameter is not a table" )
	for i = 1, FilterGetSourceTypes( ) do
		t[i] = C_PetJournal.IsPetSourceChecked( i )
	end
end

local function FilterSetSource( t )
	if type( t ) == "table" then
		for i = 1, FilterGetSourceTypes( ) do
			C_PetJournal.SetPetSourceChecked( i, t[i] )
		end
	elseif type( t ) == "boolean" then
		for i = 1, FilterGetSourceTypes( ) do
			C_PetJournal.SetPetSourceChecked( i, t )
		end
	else
		assert( false, "parameter is not a table or boolean" )
	end
end


local function FilterActionClear( )
	
	FilterSetSearch( "" )
	FilterSetCollected( true )
	FilterSetUncollected( true )
	FilterSetFamily( true )
	FilterSetSource( true )
	
	filter.ignore = true
	
end

local function FilterActionBackup( )
	
	if filter.backup then return end
	
	filter.search = FilterGetSearch( )
	filter.collected = FilterGetCollected( )
	filter.uncollected = FilterGetUncollected( )
	FilterGetFamily( filter.family )
	FilterGetSource( filter.source )
	
	filter.backup = true
	
end

local function FilterActionRestore( )
	
	if not filter.backup then return end
	
	FilterSetSearch( filter.search )
	FilterSetCollected( filter.collected )
	FilterSetUncollected( filter.uncollected )
	FilterSetFamily( filter.family )
	FilterSetSource( filter.source )
	
	filter.ignore = true
	filter.backup = false
	
end


function ArkInventory.Collection.Pet.OnHide( )
	filter.ignore = false
	ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET", "RESCAN" )
end

function ArkInventory.Collection.Pet.IsReady( )
	return ArkInventory.Collection.Pet.ready
end

function ArkInventory.Collection.Pet.GetCount( )
	return ArkInventory.Collection.Pet.owned, ArkInventory.Collection.Pet.total
end

function ArkInventory.Collection.Pet.GetPet( arg1 )
	
	if type( arg1 ) == "number" then
		--ArkInventory.Output( "GetPet( index=", arg1, " ) " )
		for _, obj in ArkInventory.Collection.Pet.Iterate( ) do
			if obj.guid == arg1 then
				return obj
			end
		end
		--ArkInventory.Output( "no pet found at index ", arg1 )
		return
	elseif type( arg1 ) == "string" then
		--ArkInventory.Output( "GetPet( guid=", arg1, " ) " )
		if ArkInventory.Collection.Pet.cache[arg1] then
			return ArkInventory.Collection.Pet.cache[arg1]
		else
			--ArkInventory.Output( "no pet found with guid ", arg1 )
		end
	end
	
end

function ArkInventory.Collection.Pet.Iterate( )
	local t = ArkInventory.Collection.Pet.cache
	return ArkInventory.spairs( t, function( a, b ) return ( t[a].fullname or "" ) < ( t[b].fullname or "" ) end )
end

function ArkInventory.Collection.Pet.CanSummon( arg1 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		return not C_PetJournal.PetIsRevoked( obj.guid ) and not C_PetJournal.PetIsLockedForConvert( obj.guid ) and C_PetJournal.PetIsSummonable( obj.guid )
	end
end

function ArkInventory.Collection.Pet.CanRelease( arg1 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		return C_PetJournal.PetCanBeReleased( obj.guid )
	end
end

function ArkInventory.Collection.Pet.CanTrade( arg1 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		return C_PetJournal.PetIsTradable( obj.guid )
	end
end

function ArkInventory.Collection.Pet.Summon( arg1 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		C_PetJournal.SummonPetByGUID( obj.guid )
	end
end

function ArkInventory.Collection.Pet.GetCurrent( )
	local guid = C_PetJournal.GetSummonedPetGUID( )
	if guid then
		local obj = ArkInventory.Collection.Pet.GetPet( guid )
		if obj then
			return obj.guid, guid, obj
		end
	end
end

function ArkInventory.Collection.Pet.Dismiss( )
	local guid = ArkInventory.Collection.Pet.GetCurrent( )
	if guid then
		C_PetJournal.SummonPetByGUID( guid )
	end
end

function ArkInventory.Collection.Pet.GetStats( arg1 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		return C_PetJournal.GetPetStats( obj.guid )
	end
end

function ArkInventory.Collection.Pet.PickupPet( arg1, arg2 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		return C_PetJournal.PickupPet( obj.guid, arg2 )
	end
end

function ArkInventory.Collection.Pet.IsRevoked( arg1 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		return C_PetJournal.PetIsRevoked( obj.guid )
	end
end

function ArkInventory.Collection.Pet.IsLockedForConvert( arg1 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		return C_PetJournal.PetIsLockedForConvert( obj.guid )
	end
end

function ArkInventory.Collection.Pet.IsFavorite( arg1 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		return C_PetJournal.PetIsFavorite( obj.guid )
	end
end

function ArkInventory.Collection.Pet.IsSlotted( arg1 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		return C_PetJournal.PetIsSlotted( obj.guid )
	end
end

function ArkInventory.Collection.Pet.IsHurt( arg1 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		return C_PetJournal.PetIsHurt( obj.guid )
	end
end

function ArkInventory.Collection.Pet.InBattle( )
	return C_PetBattles.IsInBattle( )
end

function ArkInventory.Collection.Pet.SetName( arg1, arg2 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		C_PetJournal.SetCustomName( obj.guid, arg2 )
	end
end

function ArkInventory.Collection.Pet.IsUnlocked( )
	return C_PetJournal.IsJournalUnlocked( )
end

function ArkInventory.Collection.Pet.SetFavorite( arg1, arg2 )
	-- arg2 = 0 (remove) | 1 (set)
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		C_PetJournal.SetFavorite( obj.guid, arg2 )
	end
end

function ArkInventory.Collection.Pet.IsUsable( arg1 )
	local obj = ArkInventory.Collection.Pet.GetPet( arg1 )
	if obj then
		return ( IsUsableSpell( obj.spell ) )
	end
end


function ArkInventory.Collection.Pet.Scan( )
	
	local thread_id = string.format( ArkInventory.Global.Thread.Format.Collection, "pet" )
	
	if not ArkInventory.Global.Thread.Use then
		local tz = debugprofilestop( )
		ArkInventory.OutputThread( thread_id, " start" )
		ArkInventory.Collection.Pet.Scan_Threaded( )
		tz = debugprofilestop( ) - tz
		ArkInventory.OutputThread( string.format( "%s took %0.0fms", thread_id, tz ) )
		return
	end
	
	local tf = function ( )
		ArkInventory.Collection.Pet.Scan_Threaded( thread_id )
	end
	
	ArkInventory.ThreadStart( thread_id, tf )
	
end

function ArkInventory.Collection.Pet.Scan_Threaded( thread_id )
	
	if ArkInventory.Global.Mode.Combat then
		-- set to scan when leaving combat
		ArkInventory.Global.LeaveCombatRun.PetJournal = true
		return
	end
	
	local update = false
	
	local data = ArkInventory.Collection.Pet
	
	-- warning: total is impacted by the filter settings, owned is not
	local total, owned = C_PetJournal.GetNumPets( )
	
	if total == 0 and owned == 0 then
		--ArkInventory.Output( "pet scan aborted - total=", total, " / owned=", owned )
		return
	end
	
	if filter.ignore then
		--ArkInventory.Output( "IGNORED (PET FILTER CHANGED BY ME)" )
		filter.ignore = false
		return
	end
	
	--ArkInventory.Output( "Pets: Start Scan @ ", time( ) )
	
	data.scanning = true
	
	FilterActionBackup( )
	FilterActionClear( )
	
	-- query data again now that filters have been cleared
	total, owned = C_PetJournal.GetNumPets( )
	
	if data.total ~= total or not data.ready then
		data.total = total
		update = true
	end
	
	if data.owned ~= owned or not data.ready then
		data.owned = owned
		update = true
		wipe( data.cache )
	end
	
	local c = data.cache
	
	for index = 1, total do
		
		local guid, speciesID, owned = C_PetJournal.GetPetInfoByIndex( index, false )
		
		-- species data (all pets)
		local sd = ArkInventory.Collection.Pet.ScanSpecies( speciesID )
		if not sd then
			data.scanning = false
			FilterActionRestore( )
			ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET", "RESCAN" )
			return
		end

		-- creatureid to speciesid lookup (all pets)
		if not data.creature[sd.creatureID] then
			data.creature[sd.creatureID] = speciesID
			--ArkInventory.Output( sd.creatureID, " = ", speciesID )
		end
		
		-- pet data (owned pets)
		if owned then
			local pd, upd = ArkInventory.Collection.Pet.ScanPet( index, guid, update )
			if not pd then
				--ArkInventory.Output( "* pet journal not ready at ", index, " / ", guid )
				data.scanning = false
				FilterActionRestore( )
				ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET", "RESCAN" )
				return
			end
			if not update and upd then
				update = true
			end
		end
		
		ArkInventory.ThreadYield_Scan( thread_id )
		
		if PetJournal:IsVisible( ) then
			-- will rescan when journal is closed
			--ArkInventory.Output( "ABORTED (PET JOURNAL WAS OPENED)" )
			data.scanning = false
			FilterActionRestore( )
			return
		end
		
	end
	
	--ArkInventory.Output( "Pets: End Scan @ ", time( ), " ( ", data.owned, " of ", data.total, " )" )
	
	data.ready = true
	data.scanning = false
	FilterActionRestore( )
	
	if update then
		ArkInventory.ScanCollectionPet( )
	end
	
end

function ArkInventory.Collection.Pet.ScanPet( index, guid, update )
	
	local pd = ArkInventory.Collection.Pet.cache
	local update = update
	
	local speciesID, customName, level, xp, maxXp, did, fav, name, icon, _, cid, _, _, wild, battle, tradable, unique, obtainable = C_PetJournal.GetPetInfoByPetID( guid )
	if ( not name ) then
		--ArkInventory.Output( "no name for pet #", index, ": ", guid )
		return
	end
	
	local sd = ArkInventory.Collection.Pet.GetSpeciesInfo( speciesID )
	if not sd then
		--ArkInventory.Output( "no species data for pet #", index, ": ", guid, " / ", speciesID )
		return  -- will rescan from there
	end
	
	local currentHealth, fullHealth, power, speed, rarity = C_PetJournal.GetPetStats( guid )
	rarity = rarity - 1 -- back down to item colour	
	
	local pet = pd[guid]
	
	if ( not update ) and ( ( not pet ) or ( pet.rarity ~= rarity ) or ( pet.cn ~= customName ) or ( pet.level ~= level ) or ( pet.fav ~= fav ) or ( pet.xp ~= xp ) or ( pet.fullHealth ~= fullHealth ) or ( pet.index ~= index ) ) then
		update = true
	end
	
	pd[guid] = {
		guid = guid,
		index = index,
		link = C_PetJournal.GetBattlePetLink( guid ),
		active = false,
		cn = customName,
		level = level,
		fav = fav,
		rarity = rarity, -- actual pet quality (standard item colour)
		
		xp = xp,
		maxXp = maxXp,
		health = currentHealth,
		maxHealth = fullHealth,
		power = power,
		speed = speed,
		
		breed = nil, -- wipe it every time
		
		sd = ArkInventory.Collection.Pet.species[speciesID], -- species data for this pet
	}
	
	if BreedAvailable then
		pd[guid].breed = GetBreedID_Journal( guid )
	end
	
	pet = pd[guid]
	
	if customName and customName ~= "" then
		pet.fullname = string.format( "%s (%s)", sd.name, customName )
	else
		pet.fullname = sd.name
	end
	
	return pet, update
	
end

function ArkInventory.Collection.Pet.GetSpeciesIDForCreatureID( creatureID )
	return ArkInventory.Collection.Pet.creature[creatureID]
end

function ArkInventory.Collection.Pet.GetSpeciesIDfromGUID( guid )
	
	-- breaks apart a guid to get the battlepet speciesid
	-- Creature-[unknown]-[serverID]-[instanceID]-[zoneUID]-[npcID]-[spawnUID]
	
	-- replaced with UnitBattlePetSpeciesID( unit )
	
	local creatureID = string.match( guid or "", "Creature%-.-%-.-%-.-%-.-%-(.-)%-.-$" )
	--ArkInventory.Output( creatureID, " / ", guid )
	if creatureID then
		creatureID = tonumber( creatureID ) or 0
		return ArkInventory.Collection.Pet.GetSpeciesIDForCreatureID( creatureID )
	end
	
end

function ArkInventory.Collection.Pet.GetSpeciesInfo( speciesID )
	return ArkInventory.Collection.Pet.species[speciesID]
end



local PET_STRONG = { 2, 6, 9, 1, 4, 3, 10, 5, 7, 8 }
--[[
	HUMANOID vs DRAGONKIN
	DRAGONKIN vs MAGIC
	FLYING vs AQUATIC
	UNDEAD vs HUMANOID
	CRITTER vs UNDEAD
	MAGIC vs FLYING
	ELEMENTAL vs MECHANICAL
	BEAST vs CRITTER
	AQUATIC vs ELEMENTAL
	MECHANICAL vs BEAST
]]--

local PET_WEAK = { 8, 4, 2, 8, 1, 10, 5, 3, 6, 7 }
--[[
	HUMANOID vs BEAST
	DRAGONKIN vs UNDEAD
	FLYING vs DRAGONKIN
	UNDEAD vs AQUATIC
	CRITTER vs HUMANOID
	MAGIC vs MECHANICAL
	ELEMENTAL vs CRITTER
	BEAST vs FLYING
	AQUATIC vs MAGIC
	MECHANICAL vs ELEMENTAL
]]--

function ArkInventory.Collection.Pet.ScanSpecies( speciesID )
	
	if ( not speciesID ) or ( type( speciesID ) ~= "number" ) or ( speciesID <= 0 ) then
		error( "invalid speciesID [", speciesID, "]" )
		return
	end
	
	local data = ArkInventory.Collection.Pet.species
	
	if ( not data[speciesID] ) then
		
		local name, icon, petType, creatureID, sourceText, description, isWild, canBattle, tradable, unique = C_PetJournal.GetPetInfoBySpeciesID( speciesID )
		
--		if name and ( name ~= "" ) then
			
			data[speciesID] = {
				speciesID = speciesID,
				name = name or ArkInventory.Localise["UNKNOWN"],
				icon = icon,
				petType = petType,
				strong = PET_STRONG[petType],
				weak = PET_WEAK[petType],
				creatureID = creatureID,
				sourceText = sourceText,
				description = description,
				isWild = isWild,
				canBattle = canBattle,
				tradable = tradable,
				unique = unique,
				abilityID = { },
				abilityLevel = { },
			}
			
			local _, maxAllowed = C_PetJournal.GetNumCollectedInfo( speciesID )
			data[speciesID].maxAllowed = maxAllowed
			
			if canBattle then
				
				C_PetJournal.GetPetAbilityList( speciesID, data[speciesID].abilityID, data[speciesID].abilityLevel )
				--ArkInventory.Output( "id = ", data[speciesID].abilityID )
				--ArkInventory.Output( "level = ", data[speciesID].abilityLevel )
				
				for i, abilityID in ipairs( data[speciesID].abilityID ) do
					ArkInventory.Collection.Pet.ScanAbility( abilityID )
				end
				
			end
			
--		end
		
	end
	
	return data[speciesID]
	
end

function ArkInventory.Collection.Pet.ScanAbility( abilityID )
	
	if ( not abilityID ) or ( type( abilityID ) ~= "number" ) or ( abilityID <= 0 ) then
		error( "invalid abilityID" )
		return
	end
	
	local data = ArkInventory.Collection.Pet.ability
	
	if ( not data[abilityID] ) then
		
		local id, name, icon, maxCooldown, unparsedDescription, numTurns, petType, noStrongWeakHints = C_PetBattles.GetAbilityInfoByID( abilityID )
		
		data[abilityID] = {
			name = name,
			icon = icon,
			petType = petType,
			noStrongWeakHints = noStrongWeakHints,
			strong = PET_STRONG[petType],
			weak = PET_WEAK[petType],
		}
		
	end
	
	return data[abilityID]
	
end

function ArkInventory.Collection.Pet.GetAbilityInfo( abilityID )
	return ArkInventory.Collection.Pet.ability[abilityID]
end


function ArkInventory.Collection.Pet.AttackList( speciesID, level )
	
	local sd = ArkInventory.Collection.Pet.GetSpeciesInfo( speciesID )
	
	local weak = { }
	local strong = { }
	
	local base = ArkInventory.Collection.Pet.PetTypeName( sd.petType )
	
	for i, abilityType in ipairs( sd.abilityType ) do
		if ( sd.abilityLevel[i] <= level ) and ( PET_WEAK[abilityType] ~= sd.weak ) then
			--ArkInventory.Output( ArkInventory.Collection.Pet.PetTypeName( abilityType ), " ability weak against ", ArkInventory.Collection.Pet.PetTypeName( PET_WEAK[abilityType] ) )
			weak[PET_WEAK[abilityType]] = true
		end
	end
	
	--ArkInventory.Output( "-- -- -- -- -- -- --" )

	for i, abilityType in ipairs( sd.abilityType ) do
		
		if ( sd.abilityLevel[i] <= level ) and ( PET_STRONG[abilityType] ~= PET_STRONG[sd.petType] ) then
			
			--ArkInventory.Output( ArkInventory.Collection.Pet.PetTypeName( abilityType ), " ability strong against ", ArkInventory.Collection.Pet.PetTypeName( PET_STRONG[abilityType] ) )
			
			weak[PET_STRONG[abilityType]] = nil
			strong[PET_STRONG[abilityType]] = true
			
--			if PET_STRONG[abilityType] == sd.petType then
--				weak[PET_STRONG[abilityType]] = true
--				strong[PET_STRONG[abilityType]] = nil
--			end
			
		end
	end
	
	--ArkInventory.Output( "-- -- -- -- -- -- --" )
	
	
	local info = ArkInventory.Collection.Pet.PetTypeName( PET_WEAK[sd.petType] )
	local pos = 1
	for abilityType in pairs( weak ) do
		--ArkInventory.Output( "weak ", ArkInventory.Collection.Pet.PetTypeName( abilityType ) )
		if ( pos == 1 ) then
			info = string.format( "%s or %s", info, ArkInventory.Collection.Pet.PetTypeName( abilityType ) )
			pos = pos + 1
		else
			info = string.format( "%s, %s", info, ArkInventory.Collection.Pet.PetTypeName( abilityType ) )
		end
	end
	weak = info
	
	info = ArkInventory.Collection.Pet.PetTypeName( PET_STRONG[sd.petType] )
	pos = 1
	for abilityType in pairs( strong ) do
		--ArkInventory.Output( "strong ", ArkInventory.Collection.Pet.PetTypeName( abilityType ) )
		
		if ( pos == 1 ) then
			info = string.format( ArkInventory.Localise["BATTLEPET_OPPONENT_FORMAT_ABILITY1"], info, ArkInventory.Collection.Pet.PetTypeName( abilityType ) )
			pos = pos + 1
		else
			info = string.format( ArkInventory.Localise["BATTLEPET_OPPONENT_FORMAT_ABILITY2"], info, ArkInventory.Collection.Pet.PetTypeName( abilityType ) )
		end
		
	end
	strong = info
	
	
	
	
	return weak, strong, base
	
--[[

	for index, pd in ArkInventory.Collection.Pet.Iterate( ) do
		
		if ( pd.level >= level ) and ( weak[pd.sd.petType] ) then
			--ArkInventory.Output( pd.link )
			attackResult[index] = true
		end
		
	end
]]--
	
end

function ArkInventory.Collection.Pet.PetTypeName( arg1 )
	return _G[string.format( "BATTLE_PET_NAME_%s", arg1 )] or ArkInventory.Localise["UNKNOWN"]
end

function ArkInventory.Collection.Pet.PetBattleHelp( speciesID, level )
	
	local enemy = ArkInventory.Collection.Pet.ScanSpecies( speciesID )
	if not enemy then
		ArkInventory.Output( "no data returned for speciesID:", speciesID )
		return
	end
	
	local level = level or 25
	
	local strong = { }
	
	local ad
	for i, abilityID in ipairs( enemy.abilityID ) do
		ad = ArkInventory.Collection.Pet.ScanAbility( abilityID )
		--ArkInventory.Output( "strong ability ", i, " = ", ad )
		if not ad.noStrongWeakHints then
			strong[ad.strong] = true
		end
	end
	
	local weak = { }
	weak[enemy.weak] = true
	for i, abilityID in ipairs( enemy.abilityID ) do
		ad = ArkInventory.Collection.Pet.ScanAbility( abilityID )
		--ArkInventory.Output( "weak ability ", i, " = ", ad )
		if not ad.noStrongWeakHints then
			weak[ad.weak] = true
		end
	end
	
	for x in pairs( strong ) do
		weak[strong[x]] = nil
	end
	
--[[
	ArkInventory.Output( "-- -- -- -- -- -- --" )
	ArkInventory.Output( "name = ", enemy.name )
	ArkInventory.Output( "level = ", level )
	
	for x in pairs( strong ) do
		ArkInventory.Output( "strong = ", ArkInventory.Collection.Pet.PetTypeName( x ) )
	end
	for x in pairs( weak ) do
		ArkInventory.Output( "weak = ", ArkInventory.Collection.Pet.PetTypeName( x ) )
	end
]]--
	
	local result, count, bad, good, modifier
	local species = { }
	
	for v = 3, 1, -1 do
		
		result = false
		
		for _, pd in ArkInventory.Collection.Pet.Iterate( ) do
			
			if ( pd.sd.canBattle ) and ( not species[pd.sd.speciesID] ) and ( pd.level >= ( level - 5 ) ) and ( pd.sd.petType == enemy.weak ) and ( not strong[pd.sd.PetType] ) then
				
				-- must be battle capable
				-- cant have been reported already
				-- within 5 levels
				-- pets the enemy is weak against
				
	--			ArkInventory.Output( "checking ", pd.link )
				
				bad = false
				good = false
				count = 0
				modifier = 1.0
				
				--ArkInventory.Output( "pd.sd = ", pd.sd )
				
				for i = 1, 3 do
					
					-- first row abilities
					
					if ( pd.sd.abilityLevel[i] <= level ) then
						
						ad = ArkInventory.Collection.Pet.ScanAbility( pd.sd.abilityID[i] )
						--ArkInventory.Output( "ability ", i, " = ", ad )
						modifier = C_PetBattles.GetAttackModifier( ad.petType, enemy.petType )
						
						if ( ad.noStrongWeakHints or modifier == 1 ) then
							-- neutral ability, dont care
						elseif ( modifier < 1 ) then
							-- weak ability, ignore this pet
							bad = true
						elseif ( modifier > 1 ) then
							-- strong ability, possibly include this pet
							good = true
							count = count + 1
						end
						
					end
					
					-- second row abilities
					if ( ( not good ) or ( bad ) ) and ( pd.sd.abilityLevel[i+3] <= level ) then
						
						ad = ArkInventory.Collection.Pet.ScanAbility( pd.sd.abilityID[i+3] )
						--ArkInventory.Output( "ability ", i, " = ", ad )
						modifier = C_PetBattles.GetAttackModifier( ad.petType, enemy.petType )
						
						if ( ad.noStrongWeakHints or modifier == 1 ) then
							-- neutral ability, dont care
						elseif ( modifier < 1 ) then
							-- weak ability, ignore this pet
							bad = true
						elseif ( modifier > 1 ) then
							-- strong ability, possibly include this pet
							bad = false
							count = count + 1
						end
						
					end
					
				end
				
				if ( not bad ) and ( count >= v ) then
					species[pd.sd.speciesID] = true
					ArkInventory.Output( pd.link, " (", count, ")" )
					result = true
				end
				
			end
			
		end
		
		if result then
			return
		end
		
	end
	
	-- there are no base weak pets
	
	for v = 3, 1, -1 do
		
		result = false
		
		for _, pd in ArkInventory.Collection.Pet.Iterate( ) do
			
			if ( pd.sd.canBattle ) and ( not species[pd.sd.speciesID] ) and ( pd.level >= ( level - 5 ) ) and ( not strong[pd.sd.petType] ) then
				
				-- must be battle capable
				-- cant have been reported already
				-- within 5 levels
				-- pets where the enemy attacks are not strong
				
				--ArkInventory.Output( "checking ", pd.link )
				
				bad = false
				good = false
				count = 0
				modifier = 1.0
				
				--ArkInventory.Output( "pd.sd = ", pd.sd )
				
				for i = 1, 3 do
					
					-- first row abilities
					
					if ( pd.sd.abilityLevel[i] <= level ) then
						
						ad = ArkInventory.Collection.Pet.ScanAbility( pd.sd.abilityID[i] )
						--ArkInventory.Output( "ability ", i, " = ", ad )
						modifier = C_PetBattles.GetAttackModifier( ad.petType, enemy.petType )
						
						if ( ad.noStrongWeakHints or modifier == 1 ) then
							-- neutral ability, dont care
						elseif ( modifier < 1 ) then
							-- weak ability, ignore this pet
							bad = true
						elseif ( modifier > 1 ) then
							-- strong ability, possibly include this pet
							good = true
							count = count + 1
						end
						
					end
					
					-- second row abilities
					if ( ( not good ) or ( bad ) ) and ( pd.sd.abilityLevel[i+3] <= level ) then
						
						ad = ArkInventory.Collection.Pet.ScanAbility( pd.sd.abilityID[i+3] )
						--ArkInventory.Output( "ability ", i, " = ", ad )
						modifier = C_PetBattles.GetAttackModifier( ad.petType, enemy.petType )
						
						if ( ad.noStrongWeakHints or modifier == 1 ) then
							-- neutral ability, dont care
						elseif ( modifier < 1 ) then
							-- weak ability, ignore this pet
							bad = true
						elseif ( modifier > 1 ) then
							-- strong ability, possibly include this pet
							bad = false
							count = count + 1
						end
						
					end
					
				end
				
				if ( not bad ) and ( count >= v ) then
					species[pd.sd.speciesID] = true
					ArkInventory.Output( pd.link, " (", count, ")" )
					result = true
				end
				
			end
			
		end
		
		if result then
			return
		end
		
	end
	
end


function ArkInventory:EVENT_WOW_BATTLEPET_OPENING_DONE( event, ... )
	
	--ArkInventory.Output( "EVENT_WOW_BATTLEPET_OPENING_DONE" )
	-- /run ArkInventory:EVENT_WOW_BATTLEPET_OPENING_DONE( "MANUAL" )
	if not ArkInventory.db.option.message.battlepet.opponent then return end
	
	ArkInventory.Collection.Pet.Scan( )
	
	local help = ...
	local player = 2
	local isnpc = C_PetBattles.IsPlayerNPC( player )
	local opponents = C_PetBattles.GetNumPets( player )
	
--	if opponents > 1 then
		ArkInventory.Output( "--- --- --- --- --- --- ---" )
--	end
	
	if not ArkInventory.Collection.Pet.IsReady( ) then
		ArkInventory.Output( "pet journal not ready" )
		return
	end
	
	for i = 1, opponents do
		
		local name = C_PetBattles.GetName( player, i )
		
		local speciesID = C_PetBattles.GetPetSpeciesID( player, i )
		local level = C_PetBattles.GetLevel( player, i )
		local fullHealth = C_PetBattles.GetMaxHealth( player, i )
		local power = C_PetBattles.GetPower( player, i )
		local speed = C_PetBattles.GetSpeed( player, i )
		local breed = ""
		
		if BreedAvailable then
			breed = string.format( " %s", GetBreedID_Battle( { ["petOwner"] = player, ["petIndex"] = i } ) )
		end
		
		local rarity = C_PetBattles.GetBreedQuality( player, i )
		rarity = ( rarity and ( rarity - 1 ) ) or -1
		
		local info = ""
		local count
		
		local sd = ArkInventory.Collection.Pet.species[speciesID] or ArkInventory.Collection.Pet.ScanSpecies( speciesID )
		
		if not sd then
			
			ArkInventory.Output( YELLOW_FONT_COLOR_CODE, "#", i, ": ", name, " - ", RED_FONT_COLOR_CODE, ArkInventory.Localise["NO_DATA_AVAILABLE"] )
			
		else
			
			if C_PetBattles.IsWildBattle( ) then
				
				--ArkInventory.Output( "wild battle" )
				if not sd.canBattle then
					-- opponent cannot battle (and yet it is), its one of the secondary non-capturabe opponents
					info = string.format( "%s- %s", YELLOW_FONT_COLOR_CODE, ArkInventory.Localise["BATTLEPET_OPPONENT_IMMUNE"] )
				else
					count = true
				end
				
			elseif isnpc then
				
				--ArkInventory.Output( "trainer battle" )
				
			else
				
				--ArkInventory.Output( "pvp battle" )
				
				count = true
				
			end
			
			if help and ( type( help ) == "string" ) and ( help == "PET_BATTLE_HELP" ) then
				--local good, bad = ArkInventory.Collection.Pet.AttackList( speciesID, level )
				--info = string.format( " vs %s", good )
				ArkInventory.Collection.Pet.PetBattleHelp( speciesID, level )
			end
			
			local h = string.format( "%s|Hbattlepet:%s:%s:%s:%s:%s:%s:%s|h[%s]|h|r", select( 5, ArkInventory.GetItemQualityColor( rarity ) ), speciesID, level, rarity, fullHealth, power, speed, "", name )
			
			if ( not count ) then
				
				-- dont do anything
				
			else
				
				local numOwned, maxAllowed = C_PetJournal.GetNumCollectedInfo( speciesID )
				
				if numOwned == 0 then
					
					info = string.format( "%s- %s", RED_FONT_COLOR_CODE, ArkInventory.Localise["NOT_COLLECTED"] )
					
					local h = string.format( "%sbattlepet:%s:%s:%s:%s:%s:%s:%s|h[%s]", select( 5, ArkInventory.GetItemQualityColor( rarity ) ), speciesID, level, rarity, fullHealth, power, speed, "", name )
					
				else
					
					if numOwned >= maxAllowed then
						
						info = string.format( "- %s", ArkInventory.Localise["BATTLEPET_OPPONENT_KNOWN_MAX"] )
						
					elseif C_PetBattles.IsWildBattle( ) then
						
						local upgrade = false
						
						for _, pd in ArkInventory.Collection.Pet.Iterate( ) do
							
							if ( pd.sd.speciesID == speciesID ) then
								
								local q = pd.rarity
								--ArkInventory.Output( "s=[", speciesID, "], ", h, ", [", rarity, "] / ", pd.link, " [", q, "]" )
								if ( rarity >= q ) then
									upgrade = true
								end
								
								if string.len( info ) < 2 then
									info = string.format( "- %s ", ArkInventory.Localise["BATTLEPET_OPPONENT_UPGRADE"] )
									--info = string.format( "- " )
								end
								
								info = string.format( "%s%s", info, pd.link )
								
								if pd.breed then
									info = string.format( "%s  %s", info, pd.breed )
								end
								
							end
							
						end
						
						if not upgrade then
							info = ""
						end
						
					end
					
				end
				
			end
		
			--ArkInventory.Output( YELLOW_FONT_COLOR_CODE, ArkInventory.Localise["BATTLEPET"], " #", i, ": ", h, " ", YELLOW_FONT_COLOR_CODE, info )
			ArkInventory.Output( YELLOW_FONT_COLOR_CODE, "#", i, ": ", h, breed, " ", YELLOW_FONT_COLOR_CODE, info )
		
		end
		
	end
	
end

function ArkInventory:LISTEN_BATTLEPET_UPDATE( )
	
	--ArkInventory.Output( "LISTEN_BATTLEPET_UPDATE" )
	
	local loc_id = ArkInventory.Const.Location.Pet
	ArkInventory.ScanLocation( loc_id )
	--ArkInventory.Frame_Main_Generate( loc_id, ArkInventory.Const.Window.Draw.Recalculate )
	
	ArkInventory.LDB.Pets:Update( )
	
end

function ArkInventory:EVENT_WOW_COLLECTION_PET_UPDATE( event, ... )
	
	--ArkInventory.Output( "EVENT_WOW_COLLECTION_PET_UPDATE( ", event, " )" )
	
	if ( event == "PET_JOURNAL_LIST_UPDATE" ) then
		
		ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET", event )
		
	elseif ( event == "COMPANION_UPDATE" ) then
		
		local c = ...
		if ( c == "CRITTER" ) then
			ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET", event )
		end
		
	else
		
		ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET", event )
		
	end
	
end

function ArkInventory:EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET( events )
	
	--ArkInventory.Output( "EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET( ", events, " )" )
	
	if not ArkInventory:IsEnabled( ) then return end
	
	local loc_id = ArkInventory.Const.Location.Pet
	
	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( "IGNORED (PETS NOT MONITORED)" )
		return
	end
	
	if PetJournal:IsVisible( ) then
		--ArkInventory.Output( "IGNORED (PET JOURNAL IS OPEN)" )
		return
	end
	
	if not ArkInventory.Collection.Pet.scanning then
		ArkInventory.Collection.Pet.Scan( )
	else
		-- wait for current thread to finish
		ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_PET_UPDATE_BUCKET", "RESCAN" )
	end
	
end

-- unit guid, from mouseover = Creature-[unknown]-[serverID]-[instanceID]-[zoneUID]-[creatureID]-[spawnUID]
-- caged battletpet (item) = battlepet:
-- pet journal = battlepet:[speciesID]:16:3:922:185:185:[guid]

--[[

battlepet:1387:1:3:152:12:11:BattlePet-0-000006589760
battlepet:1387:1:3:155:12:10:0000000000000000
item:111660:0:0:0:0:0:0:0:90:0:11:0

]]--
