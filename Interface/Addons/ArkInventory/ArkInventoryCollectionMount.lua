local _G = _G
local select = _G.select
local pairs = _G.pairs
local ipairs = _G.ipairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table
local C_MountJournal = _G.C_MountJournal

local PLAYER_MOUNT_LEVEL = 20

ArkInventory.Collection.Mount = {
	scanning = false,
	ready = false,
	numtotal = 0,
	numowned = 0,
	cache = { },
	
	owned = { }, -- array of all mounts of that type that you own, updated here when scanned
	usable = { }, -- array of all mounts of that type that you can use at the location you called it, updated via LDB
}

	
-- the UI filters have no impact on the C_MountJournal returns so we can skip checking them

function ArkInventory.Collection.Mount.OnHide( )
	ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_MOUNT_UPDATE_BUCKET", "RESCAN" )
end

function ArkInventory.Collection.Mount.IsReady( )
	return ArkInventory.Collection.Mount.ready
end

function ArkInventory.Collection.Mount.GetCount( mta )
	if mta then
		return ArkInventory.Table.Elements( ArkInventory.Collection.Mount.usable[mta] ), ArkInventory.Table.Elements( ArkInventory.Collection.Mount.owned[mta] )
	else
		return ArkInventory.Collection.Mount.numowned, ArkInventory.Collection.Mount.numtotal
	end
end

function ArkInventory.Collection.Mount.GetMount( index )
	if type( index ) == "number" then
		return ArkInventory.Collection.Mount.cache[index]
	end
end

function ArkInventory.Collection.Mount.GetMountBySpell( spell )
	for _, v in pairs( ArkInventory.Collection.Mount.cache ) do
		if v.spell == spell then
			return v
		end
	end
end

function ArkInventory.Collection.Mount.IterateAll( )
	return ArkInventory.spairs( ArkInventory.Collection.Mount.cache, function( a, b ) return ( ArkInventory.Collection.Mount.cache[a].name or "" ) < ( ArkInventory.Collection.Mount.cache[b].name or "" ) end )
end

function ArkInventory.Collection.Mount.Iterate( mta )
	if mta and ArkInventory.Collection.Mount.owned[mta] then
		return ArkInventory.spairs( ArkInventory.Collection.Mount.owned[mta], function( a, b ) return ( ArkInventory.Collection.Mount.owned[mta][a].name or "" ) < ( ArkInventory.Collection.Mount.owned[mta][b].name or "" ) end )
	end
end

function ArkInventory.Collection.Mount.Dismiss( )
	C_MountJournal.Dismiss( )
end

function ArkInventory.Collection.Mount.Summon( id )
	local obj = ArkInventory.Collection.Mount.GetMount( id )
	if obj then
		C_MountJournal.SummonByID( obj.index )
	end
end

function ArkInventory.Collection.Mount.GetFavorite( id )
	local obj = ArkInventory.Collection.Mount.GetMount( id )
	if obj then
		return C_MountJournal.GetIsFavorite( obj.index )
	end
end

function ArkInventory.Collection.Mount.SetFavorite( id, value )
	-- value = true|false
	local obj = ArkInventory.Collection.Mount.GetMount( id )
	--ArkInventory.Output( id, " / ", value, " (", type(value), ") / ", obj )
	if obj then
		C_MountJournal.SetIsFavorite( obj.index, value )
	end
end

function ArkInventory.Collection.Mount.IsUsable( id )
	
	local md = ArkInventory.Collection.Mount.GetMount( id )
	if md then
		local mu = select( 5, C_MountJournal.GetMountInfoByID( id ) ) -- is not always correct
		return IsOutdoors( ) and mu and ( IsUsableSpell( md.spell ) ) -- so check outdoors, mount, and spell
	end
	
end

function ArkInventory.Collection.Mount.SkillLevel( )
	
	local skill = 1 -- the chauffer and sea tutle mounts can be ridden by anyone reagrdless of riding skill
	
	if UnitLevel( "player" ) >= PLAYER_MOUNT_LEVEL then
		
		if IsSpellKnown( 90265 ) then
			-- master
			-- level 80
			-- 310% flying
			-- 100% ground
			skill = 310
		elseif IsSpellKnown( 34091 ) then
			-- artisan
			-- level 70
			-- 280% flying
			-- 100% ground
			skill = 300
		elseif IsSpellKnown( 34090 ) then
			-- expert
			-- level 60
			-- 150% flying
			-- 100% ground
			skill = 225
		elseif IsSpellKnown( 33391 ) then
			-- journeyman
			-- level 40
			-- 100% ground
			skill = 150
		elseif IsSpellKnown( 33388 ) then
			-- apprentice
			-- level 20
			-- 60% ground
			skill = 75
		end
		
	end
	
	return skill
	
end

function ArkInventory.Collection.Mount.UpdateOwned( )
	
	for mta, mt in pairs( ArkInventory.Const.MountTypes ) do
		if not ArkInventory.Collection.Mount.owned[mta] then
			ArkInventory.Collection.Mount.owned[mta] = { }
		else
			wipe( ArkInventory.Collection.Mount.owned[mta] )
		end
	end
	
	for _, md in ArkInventory.Collection.Mount.IterateAll( ) do
		if md.owned then
			ArkInventory.Collection.Mount.owned[md.mta][md.index] = md
		end
	end
	
end

function ArkInventory.Collection.Mount.UpdateUsable( )
	
	for mta in pairs( ArkInventory.Const.MountTypes ) do
		if not ArkInventory.Collection.Mount.usable[mta] then
			ArkInventory.Collection.Mount.usable[mta] = { }
		else
			wipe( ArkInventory.Collection.Mount.usable[mta] )
		end
	end
	
	if not ArkInventory.Collection.Mount.IsReady( ) then return end
	
	local n = ArkInventory.Collection.Mount.GetCount( )
	if n == 0 then return end
	
	local me = ArkInventory.GetPlayerCodex( )
	
	for mta, mt in pairs( ArkInventory.Const.MountTypes ) do
		
		for _, md in ArkInventory.Collection.Mount.Iterate( mta ) do
			
			local usable = true
			
			if me.player.data.ldb.mounts.type[mta].selected[md.spell] == false then
				usable = false
			elseif not me.player.data.ldb.mounts.type[mta].useall then
				usable = me.player.data.ldb.mounts.type[mta].selected[md.spell]
			end
			
			if usable then
				usable = ArkInventory.Collection.Mount.IsUsable( md.index )
			end
			
			if usable then
				ArkInventory.Collection.Mount.usable[mta][md.index] = md
			end
			
		end
		
		--ArkInventory.Output( "usable ", mta, " = ", ArkInventory.Collection.Mount.usable[mta] )
		
	end
	
end

function ArkInventory.Collection.Mount.ApplyUserCorrections( )
	
	-- apply user corrections (these are global settings so the mount may not exist for this character)
	
	for _, md in ArkInventory.Collection.Mount.IterateAll( ) do
		
		local correction = ArkInventory.db.option.mount.correction[md.spell]
		
		if correction ~= nil then -- check for nil as we use both true and false
			if correction == md.mto then
				-- code has been updated, clear correction
				--ArkInventory.Output( "clearing mount correction ", md.spell, ": system=", md.mt, ", correction=", correction )
				ArkInventory.db.option.mount.correction[md.spell] = nil
				md.mt = md.mto
			else
				-- apply correction
				--ArkInventory.Output( "correcting mount ", md.spell, ": system=", md.mt, ", correction=", correction )
				md.mt = correction
				
				for mta, mt in pairs( ArkInventory.Const.MountTypes ) do
					if md.mt == mt then
						md.mta = mta
						break
					end
				end
				
			end
		end
		
	end
	
	ArkInventory.Collection.Mount.UpdateOwned( )
	
end

function ArkInventory.Collection.Mount.Scan( )
	
	local thread_id = string.format( ArkInventory.Global.Thread.Format.Collection, "mount" )
	
	if not ArkInventory.Global.Thread.Use then
		local tz = debugprofilestop( )
		ArkInventory.OutputThread( thread_id, " start" )
		ArkInventory.Collection.Mount.Scan_Threaded( )
		tz = debugprofilestop( ) - tz
		ArkInventory.OutputThread( string.format( "%s took %0.0fms", thread_id, tz ) )
		return
	end

	local tf = function ( )
		ArkInventory.Collection.Mount.Scan_Threaded( thread_id )
	end
	
	ArkInventory.ThreadStart( thread_id, tf )
	
end

function ArkInventory.Collection.Mount.Scan_Threaded( thread_id )
	
	if ArkInventory.Global.Mode.Combat then
		-- set to scan when leaving combat
		ArkInventory.Global.LeaveCombatRun.Mount = true
		return
	end
	
	local update = false
	
	local data = ArkInventory.Collection.Mount
	
	local total = C_MountJournal.GetNumMounts( )
	
	if total == 0 then
		return
	end
	
	--ArkInventory.Output( "Mount: Start Scan @ ", time( ) )
	
	data.scanning = true
	
	if data.numtotal ~= total or not data.ready then
		data.numtotal = total
		update = true
	end
	
	data.numowned = 0
	
	local c = data.cache
	
	for _, i in pairs( C_MountJournal.GetMountIDs( ) ) do
		
		local name, spell, icon, active, usable, source, fav, factionSpecific, faction, hide, owned, id = C_MountJournal.GetMountInfoByID( i )
		
		if factionSpecific and not hide then
			-- faction is either 0 = horde / 1 = alliance
			-- cater for pandaren who are unaligned until they choose a faction
			local f0 = -1
			local f1, f2 = UnitFactionGroup( "player" )
			f2 = f2 or FACTION_OTHER
			if f2 == FACTION_HORDE then
				f0 = 0
			elseif f2 == FACTION_ALLIANCE then
				f0 = 1
			end
			if faction ~= f0 then
				hide = true
			end
		end
		
		if not hide then
			
			-- only look at the bits for this toon, not any variants that are hidden or faction specific
			
			if owned then
				data.numowned = data.numowned + 1
			end
			
			if ( not update ) and ( not c[i] or c[i].numowned ~= owned or c[i].fav ~= fav or c[i].usable ~= usable or c[i].active ~= active ) then
				update = true
			end
			
			if not c[i] then
				
				local display, description, source, self, mt = C_MountJournal.GetMountInfoExtraByID( i )
				
				c[i] = {
					index = i,
					name = name,
					spell = spell,
					link = GetSpellLink( spell ),
					desc = description,
					src = source,
					did = display,
				}
				
				local mta = "x"
				if mt == 230 or mt == 241 or mt == 284 then
					-- land
					mta = "l"
				elseif mt == 248 or mt == 247 or mt == 242 then
					-- flying
					mta = "a"
				elseif mt == 231 or mt == 232 or mt == 254 then
					--underwater
					mta = "u"
				elseif mt == 269 then
					-- surface
					mta = "s"
				end
				
				--ArkInventory.Output( i, " = ", spell, " / ", string.format("%.12f",spell) )
				
				c[i].mta = mta
				c[i].mt = ArkInventory.Const.MountTypes[mta]
				c[i].mto = c[i].mt -- save original mount type (user corrections can override the other value)
				
			end
			
			c[i].owned = owned
			c[i].fav = fav
			c[i].usable = usable
			c[i].active = active
			
		else
			--ArkInventory.Output( "hidden = ", spell, " / ", name )
		end
		
		ArkInventory.ThreadYield_Scan( thread_id )
		
	end
	
	--ArkInventory.Output( "Mounts: End Scan @ ", time( ), " ( ", data.numowned, " of ", data.numtotal, " )" )
	
	ArkInventory.Collection.Mount.ApplyUserCorrections( )
	
	data.ready = true
	data.scanning = false
	
	if update then
		ArkInventory.ScanCollectionMount( )
	end
	
end


function ArkInventory:EVENT_WOW_COLLECTION_MOUNT_UPDATE( event )
	
	if event ~= "COMPANION_UPDATE" then
		ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_MOUNT_UPDATE_BUCKET", event )
	end
	
end

function ArkInventory:EVENT_ARKINV_COLLECTION_MOUNT_UPDATE_BUCKET( events )
	
	--ArkInventory.Output( "EVENT_ARKINV_COLLECTION_MOUNT_UPDATE_BUCKET( ", events, " )" ) -- ****
	
	if not ArkInventory:IsEnabled( ) then return end
	
	local loc_id = ArkInventory.Const.Location.Mount
	
	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( "IGNORED (MOUNTS NOT MONITORED)" )
		return
	end
	
	if MountJournal and MountJournal:IsVisible( ) then
		--ArkInventory.Output( "IGNORED (MOUNT JOURNAL IS OPEN)" )
		return
	end
	
	if not ArkInventory.Collection.Mount.scanning then
		ArkInventory.Collection.Mount.Scan( )
	else
		-- wait for current thread to finish
		ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_MOUNT_UPDATE_BUCKET", "RESCAN" )
	end
	
end
