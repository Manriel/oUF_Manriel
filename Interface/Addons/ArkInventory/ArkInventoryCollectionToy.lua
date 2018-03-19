local _G = _G
local select = _G.select
local pairs = _G.pairs
local ipairs = _G.ipairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table
local C_PetJournal = _G.C_PetJournal
local C_ToyBox = _G.C_ToyBox

ArkInventory.Collection.Toybox = {
	scanning = false,
	ready = false,
	total = 0,
	owned = 0,
	cache = { },
}


local filter = {
	ignore = false,
	search = nil,
	collected = true,
	uncollected = true,
	usable = true,
	source = { },
	expansion = { },
	backup = false,
}

local function FilterGetSearch( )
	return ToyBox.searchBox:GetText( )
end

local function FilterSetSearch( s )
	ToyBox.searchBox:SetText( s )
	C_ToyBox.SetFilterString( s )
end

local function FilterGetCollected( )
	return C_ToyBox.GetCollectedShown( )
end

local function FilterSetCollected( value )
	C_ToyBox.SetCollectedShown( value )
end

local function FilterGetUncollected( )
	return C_ToyBox.GetUncollectedShown( )
end

local function FilterSetUncollected( value )
	C_ToyBox.SetUncollectedShown( value )
end

local function FilterGetUsable( )
	return C_ToyBox.GetUnusableShown( )
end

local function FilterSetUsable( value )
	C_ToyBox.SetUnusableShown( value )
end

local function FilterNumSource( )
	return C_PetJournal.GetNumPetSources( )
end

local function FilterSetSource( t )
	if type( t ) == "table" then
		for i = 1, FilterNumSource( ) do
			C_ToyBox.SetSourceTypeFilter( i, t[i] )
		end
	elseif type( t ) == "boolean" then
		for i = 1, FilterNumSource( ) do
			C_ToyBox.SetSourceTypeFilter( i, t )
		end
	else
		assert( false, "parameter is not a table or boolean" )
	end
end

local function FilterGetSource( t )
	assert( type( t ) == "table", "parameter is not a table" )
	for i = 1, FilterNumSource( ) do
		t[i] = not C_ToyBox.IsSourceTypeFilterChecked( i )
	end
end

local function FilterNumExpansion( )
	return GetNumExpansions( )
end

local function FilterSetExpansion( t )
	if type( t ) == "table" then
		for i = 1, FilterNumExpansion( ) do
			C_ToyBox.SetExpansionTypeFilter( i, t[i] )
		end
	elseif type( t ) == "boolean" then
		for i = 1, FilterNumExpansion( ) do
			C_ToyBox.SetExpansionTypeFilter( i, t )
		end
	else
		assert( false, "parameter is not a table or boolean" )
	end
end

local function FilterGetExpansion( t )
	assert( type( t ) == "table", "parameter is not a table" )
	for i = 1, FilterNumExpansion( ) do
		t[i] = not C_ToyBox.IsExpansionTypeFilterChecked( i )
	end
end


local function FilterActionClear( )
	
	FilterSetSearch( "" )
	FilterSetCollected( true )
	FilterSetUncollected( true )
	FilterSetUsable( true )
	FilterSetSource( true )
	FilterSetExpansion( true )
	
	filter.ignore = true
	
end

local function FilterActionBackup( )
	
	if filter.backup then return end
	
	filter.search = FilterGetSearch( )
	filter.collected = FilterGetCollected( )
	filter.uncollected = FilterGetUncollected( )
	filter.usable = FilterGetUsable( )
	FilterGetSource( filter.source )
	FilterGetExpansion( filter.expansion )
	
	filter.backup = true
	
end

local function FilterActionRestore( )
	
	if not filter.backup then return end
	
	FilterSetSearch( filter.search )
	FilterSetCollected( filter.collected )
	FilterSetUncollected( filter.uncollected )
	FilterSetUsable( filter.usable )
	FilterSetSource( filter.source )
	FilterSetExpansion( filter.expansion )
	
	filter.ignore = true
	filter.backup = false
	
end


function ArkInventory.Collection.Toybox.Scan( )
	
	local thread_id = string.format( ArkInventory.Global.Thread.Format.Collection, "toybox" )
	
	if not ArkInventory.Global.Thread.Use then
		local tz = debugprofilestop( )
		ArkInventory.OutputThread( thread_id, " start" )
		ArkInventory.Collection.Toybox.Scan_Threaded( )
		tz = debugprofilestop( ) - tz
		ArkInventory.OutputThread( string.format( "%s took %0.0fms", thread_id, tz ) )
		return
	end
	
	local tf = function ( )
		ArkInventory.Collection.Toybox.Scan_Threaded( thread_id )
	end
	
	ArkInventory.ThreadStart( thread_id, tf )
	
end

function ArkInventory.Collection.Toybox.Scan_Threaded( thread_id )
	
	if ArkInventory.Global.Mode.Combat then
		-- set to scan when leaving combat
		ArkInventory.Global.LeaveCombatRun.Toybox = true
		return
	end
	
	local update = false
	
	local data = ArkInventory.Collection.Toybox
	
	-- not impacted by filters
	local total = C_ToyBox.GetNumTotalDisplayedToys( )
	local owned = C_ToyBox.GetNumLearnedDisplayedToys( )
	
	if total == 0 and owned == 0 then
		--ArkInventory.Output( "toybox scan aborted - total=", total, " / owned=", owned )
		return
	end
	
	if filter.ignore then
		--ArkInventory.Output( "IGNORED (TOYBOX FILTER CHANGED BY ME)" )
		filter.ignore = false
		return
	end
	
	--ArkInventory.Output( "Toybox: Start Scan @ ", time( ) )
	
	data.scanning = true
	
	FilterActionBackup( )
	FilterActionClear( )
	
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
		
		local i = C_ToyBox.GetToyFromIndex( index )
		
		if i > 0 then
			
			local i, name, icon = C_ToyBox.GetToyInfo( i )
			local hastoy = PlayerHasToy( i )
			local fav = C_ToyBox.GetIsFavorite( i )
			
--			if index == total then
--				ArkInventory.Output( index, "/", total, " = ", i, " / ", name )
--			end
			
			if ( not update ) and ( ( not c[i] ) or ( c[i].owned ~= hastoy or c[i].fav ~= fav ) ) then
				update = true
			end
			
			if not c[i] then
				c[i] = {
					index = index,
					item = i,
					name = name,
					link = C_ToyBox.GetToyLink( i ),
					texture = icon,
				}
			end
			
			c[i].owned = hastoy
			c[i].fav = fav
			
		end
		
		ArkInventory.ThreadYield_Scan( thread_id )
		
		if ToyBox:IsVisible( ) then
			-- will rescan when journal is closed
			--ArkInventory.Output( "ABORTED (TOYBOX WAS OPENED)" )
			data.scanning = false
			FilterActionRestore( )
			return
		end
		
	end
	
	--ArkInventory.Output( "Toybox: End Scan @ ", time( ), " ( ", data.owned, " of ", data.total, " ) update=", update )
	
	data.ready = true
	data.scanning = false
	FilterActionRestore( )
	
	if update then
		ArkInventory.ScanCollectionToybox( )
	end
	
end


function ArkInventory.Collection.Toybox.OnHide( )
	filter.ignore = false
	ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_TOYBOX_UPDATE_BUCKET", "RESCAN" )
end

function ArkInventory.Collection.Toybox.IsReady( )
	return ArkInventory.Collection.Toybox.ready
end

function ArkInventory.Collection.Toybox.GetCount( )
	return ArkInventory.Collection.Toybox.owned, ArkInventory.Collection.Toybox.total
end

function ArkInventory.Collection.Toybox.GetToy( value )
	if type( value ) == "number" then
		return ArkInventory.Collection.Toybox.cache[value]
	end
end

function ArkInventory.Collection.Toybox.Iterate( )
	return ArkInventory.spairs( ArkInventory.Collection.Toybox.cache, function( a, b ) return ( ArkInventory.Collection.Toybox.cache[a].item or 0 ) < ( ArkInventory.Collection.Toybox.cache[b].item or 0 ) end )
end

function ArkInventory.Collection.Toybox.Summon( index )
	local obj = ArkInventory.Collection.Toybox.GetToy( index )
	if obj then
		--UseToy( obj.item ) -- secure action now, so cant be done
	end
end

function ArkInventory.Collection.Toybox.GetFavorite( index )
	local obj = ArkInventory.Collection.Toybox.GetToy( index )
	if obj then
		return C_ToyBox.GetIsFavorite( obj.item )
	end
end

function ArkInventory.Collection.Toybox.SetFavorite( index, value )
	local obj = ArkInventory.Collection.Toybox.GetToy( index )
	if obj then
		C_ToyBox.SetIsFavorite( obj.item, value )
	end
end



function ArkInventory:EVENT_WOW_COLLECTION_TOYBOX_UPDATE( event, ... )
	
	--ArkInventory.Output( "EVENT_WOW_COLLECTION_TOYBOX_UPDATE( ", event, " )" )
	
	ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_TOYBOX_UPDATE_BUCKET", event )
	
end

function ArkInventory:EVENT_ARKINV_COLLECTION_TOYBOX_UPDATE_BUCKET( events )
	
	--ArkInventory.Output( "EVENT_ARKINV_COLLECTION_TOYBOX_UPDATE_BUCKET( ", events, " )" )
	
	if not ArkInventory:IsEnabled( ) then return end
	
	local loc_id = ArkInventory.Const.Location.Toybox
	
	if not ArkInventory.LocationIsMonitored( loc_id ) then
		--ArkInventory.Output( "IGNORED (TOYBOX NOT MONITORED)" )
		return
	end
	
	if ToyBox and ToyBox:IsVisible( ) then
		--ArkInventory.Output( "IGNORED (TOYBOX IS OPEN)" )
		return
	end
	
	if not ArkInventory.Collection.Toybox.scanning then
		ArkInventory.Collection.Toybox.Scan( )
	else
		-- wait for current thread to finish
		ArkInventory:SendMessage( "EVENT_ARKINV_COLLECTION_TOYBOX_UPDATE_BUCKET", "RESCAN" )
	end
	
end
