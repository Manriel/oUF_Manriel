--[[

License: All Rights Reserved, (c) 2009-2016

$Revision: 1881 $
$Date: 2018-02-12 00:00:17 +1100 (Mon, 12 Feb 2018) $

]]--


local _G = _G
local select = _G.select
local pairs = _G.pairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table


ArkInventoryRules = LibStub( "AceAddon-3.0" ):NewAddon( "ArkInventoryRules" )

ArkInventoryRules.Object = { }
ArkInventoryRules.System = { } -- system rules

function ArkInventoryRules.ItemCacheClear( )
	ArkInventory.ItemCacheClear( )
end

function ArkInventoryRules.OnInitialize( )
	
	ArkInventoryRules.Tooltip = ArkInventory.TooltipInit( "ARKINV_RuleTooltip" )
	
	-- 3rd party addons that require hooking for item updates
	
	-- outfitter: 
	if IsAddOnLoaded( "Outfitter" ) then
		if Outfitter:IsInitialized( ) then
			--ArkInventory.Output( "outfitter was ready" )
			ArkInventoryRules.OutfitterInitialize( true )
		else
			--ArkInventory.Output( "outfitter was not ready, hook and wait" )
			ArkInventory.MySecureHook( Outfitter, "Initialize", ArkInventoryRules.OutfitterInitialize )
		end
	end
	
	-- scrap: http://wow.curse.com/downloads/wow-addons/details/scrap.aspx
	if IsAddOnLoaded( "Scrap" ) then
		
		if ArkInventory.db.option.message.rules.hooked then
			ArkInventory.Output( string.format( "%s: Scrap %s", ArkInventory.Localise["CONFIG_RULE_PLURAL"], ArkInventory.Localise["ENABLED"] ) )
		end
		
		if IsAddOnLoaded( "Scrap_Merchant" ) then
			if Scrap.ToggleJunk then
			
				if ArkInventory.db.option.message.rules.hooked then
					ArkInventory.Output( string.format( "%s: Scrap Merchant %s", ArkInventory.Localise["CONFIG_RULE_PLURAL"], ArkInventory.Localise["ENABLED"] ) )
				end
				
				ArkInventory.MySecureHook( Scrap, "ToggleJunk", ArkInventoryRules.ItemCacheClear )
				
			end
		end
		
	end
	
	-- selljunk: http://wow.curse.com/downloads/wow-addons/details/sell-junk.aspx
	if IsAddOnLoaded( "SellJunk" ) then
		if SellJunk.Add and SellJunk.Rem then
			
			if ArkInventory.db.option.message.rules.hooked then
				ArkInventory.Output( string.format( "%s: SellJunk %s", ArkInventory.Localise["CONFIG_RULE_PLURAL"], ArkInventory.Localise["ENABLED"] ) )
			end
			
			ArkInventory.MySecureHook( SellJunk, "Add", ArkInventoryRules.ItemCacheClear )
			ArkInventory.MySecureHook( SellJunk, "Rem", ArkInventoryRules.ItemCacheClear )
			
		end
	end
	
	-- reagent restocker: http://wow.curse.com/downloads/wow-addons/details/reagent_restocker.aspx
	if IsAddOnLoaded( "ReagentRestocker" ) then
		if ReagentRestocker.addItemToSellingList and ReagentRestocker.deleteItem then
			
			if ArkInventory.db.option.message.rules.hooked then
				ArkInventory.Output( string.format( "%s: ReagentRestocker %s", ArkInventory.Localise["CONFIG_RULE_PLURAL"], ArkInventory.Localise["ENABLED"] ) )
			end
			
			ArkInventory.MySecureHook( ReagentRestocker, "addItemToSellingList", ArkInventoryRules.ItemCacheClear )
			ArkInventory.MySecureHook( ReagentRestocker, "deleteItem", ArkInventoryRules.ItemCacheClear )
			
		end
	end
	
end

function ArkInventoryRules.OnEnable( )
	
	-- update all rules, set non damaged and format correctly, first use of each rule will validate them
	--LEGION TODO
	
	local cat = ArkInventory.db.option.category[ArkInventory.Const.Category.Type.Rule].data
	for k, v in pairs( cat ) do
		v.damaged = false
	end
	
	ArkInventory.MediaFrameDefaultFontSet( ARKINV_Rules )
	
	ArkInventory.ItemCacheClear( )
	ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
	
	ArkInventory.Output( string.format( "%s %s", ArkInventory.Localise["CONFIG_RULE_PLURAL"], ArkInventory.Localise["ENABLED"] ) )
	
	ArkInventory.Global.Rules.Enabled = true
	
end

function ArkInventoryRules.OutfitterInitialize( ... )
	
	local wasReady = ...
	
	if wasReady == true then
		--ArkInventory.Output( "outfitter was ready" )
	else
		--ArkInventory.Output( "outfitter initilised, checking status" )
		wasReady = false
	end
	
	if Outfitter:IsInitialized( ) then
		
		ArkInventory.Output( string.format( "%s: Outfitter %s", ArkInventory.Localise["CONFIG_RULE_PLURAL"], ArkInventory.Localise["ENABLED"] ) )
		
		Outfitter:RegisterOutfitEvent( "ADD_OUTFIT", ArkInventoryRules.ItemCacheClear )
		Outfitter:RegisterOutfitEvent( "DELETE_OUTFIT", ArkInventoryRules.ItemCacheClear )
		Outfitter:RegisterOutfitEvent( "EDIT_OUTFIT", ArkInventoryRules.ItemCacheClear )
		--Outfitter:RegisterOutfitEvent( "WEAR_OUTFIT", ArkInventoryRules.ItemCacheClear )
		--Outfitter:RegisterOutfitEvent( "UNWEAR_OUTFIT", ArkInventoryRules.ItemCacheClear )
		
		if not wasReady then
			ArkInventory.MyUnhook( Outfitter, "Initialize" )
			ArkInventory.ItemCacheClear( )
			ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
		end
		
		--ArkInventory.Global.Rules.Enabled = true
		
	end
	
end

function ArkInventoryRules.OnDisable( )
	
	ArkInventory.Global.Rules.Enabled = false
	
	ArkInventory.ItemCacheClear( )
	ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
	
	ArkInventory.Output( string.format( "%s %s", ArkInventory.Localise["CONFIG_RULE_PLURAL"], ArkInventory.Localise["DISABLED"] ) )
	
end

function ArkInventoryRules.AppliesToItem( i )
	
	if not i then
		return false
	end
	
	local codex = ArkInventory.GetLocationCodex( i.loc_id )
	
	local cat_type = ArkInventory.Const.Category.Type.Rule
	local r = ArkInventory.db.option.category[cat_type].data
	
	ArkInventoryRules.SetObject( i )
	
	local rp, ra, rr
	
	for cat_code in ArkInventory.spairs( r, function(a,b) return ( r[a].order or 1000 ) < ( r[b].order or 1000 ) end ) do
		
		rp = codex.catset.category.active[cat_type][cat_code]
		ra = r[cat_code]
		
		if rp and ra and ra.used == "Y" and not ra.damaged then
			
			local cr, res = loadstring( string.format( "return( %s )", ra.formula ) )
			
			if not cr then
				
				ArkInventory.OutputWarning( res )
				ArkInventory.OutputWarning( string.format( ArkInventory.Localise["RULE_DAMAGED"], cat_code ) )
				ArkInventory.db.option.category[cat_type].data[cat_code].damaged = true
				
			else
				
				setfenv( cr, ArkInventoryRules.Environment )
				local ok, res = pcall( cr )
				
				if ok then
					
					if res == true then
						return ArkInventory.CategoryCodeJoin( cat_type, cat_code )
					end
					
				else
					
					ArkInventory.OutputError( res )
					ArkInventory.OutputWarning( string.format( ArkInventory.Localise["RULE_DAMAGED"], cat_code ) )
					ArkInventory.db.option.category[cat_type].data[cat_code].damaged = true
					
					error(res)
					
				end
				
			end
			
		end
		
	end
	
end


function ArkInventoryRules.System.soulbound( )
	return not not ArkInventoryRules.Object.sb
end

function ArkInventoryRules.System.accountbound( )
	return not not ArkInventoryRules.Object.ab
end

function ArkInventoryRules.System.itemstring( ... )
	
	local fn = "itemstring"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end
	
	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) == "number" then
			arg = string.format( "item:%s", arg )
		end
		
		if type( arg ) == "string" then
			arg = arg .. ":"
		else
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, string.format( "%s or %s", ArkInventory.Localise["STRING"], ArkInventory.Localise["NUMBER"] ) ), 0 )
		end
		
		local e = string.sub( ArkInventoryRules.Object.info.osd.h .. ":", 1, string.len( arg ) )
		if e == arg then
			return true
		end
		
	end
	
	return false
	
end

function ArkInventoryRules.System.type( ... )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local fn = "type"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end
	
	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) == "number" then
			if ArkInventoryRules.Object.info.itemtypeid and ArkInventoryRules.Object.info.itemtypeid == arg then
				return true
			end
		elseif type( arg ) == "string" then
			if ArkInventoryRules.Object.info.itemtype and string.lower( string.trim( ArkInventoryRules.Object.info.itemtype ) ) == string.lower( string.trim( arg ) ) then
				return true
			end
		else
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, string.format( "%s or %s", ArkInventory.Localise["STRING"], ArkInventory.Localise["NUMBER"] ) ), 0 )
		end
		
	end
	
	return false
	
end

function ArkInventoryRules.System.subtype( ... )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local fn = "subtype"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end
	
	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) == "number" then
			if ArkInventoryRules.Object.info.itemsubtypeid and ArkInventoryRules.Object.info.itemsubtypeid == arg then
				return true
			end
		elseif type( arg ) == "string" then
			if ArkInventoryRules.Object.info.itemsubtype and string.lower( string.trim( ArkInventoryRules.Object.info.itemsubtype ) ) == string.lower( string.trim( arg ) ) then
				return true
			end
		else
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, string.format( "%s or %s", ArkInventory.Localise["STRING"], ArkInventory.Localise["NUMBER"] ) ), 0 )
		end
		
	end
	
	return false
	
end

function ArkInventoryRules.System.equip( ... )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local e = string.trim( ArkInventoryRules.Object.info.equiploc or "" )
	if string.len( e ) > 1 then
		e = _G[e]
	end
	e = string.lower( string.trim( e ) )
	
	if e ~= "" then
		
		local fn = "equip"
		
		local ac = select( '#', ... )
		
		if ac == 0 then
			
			-- no args so just check if item can be equipped
			if e == "" then
				return false
			else
				return true
			end
			
		else
			
			for ax = 1, ac do
				
				local arg = select( ax, ... )
				
				if not arg then
					error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
				end
				
				if type( arg ) ~= "string" then
					error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
				end
				
				if e == string.lower( string.trim( arg ) ) then
					return true
				end
				
			end
			
		end
		
	end
	
	return false
	
end

function ArkInventoryRules.System.name( ... )
	
	if not ArkInventoryRules.Object.h then
		return false
	end
	
	local e = string.lower( ArkInventoryRules.Object.info.name or "" )
	
	local fn = "name"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end

	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) ~= "string" then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
		end
		
		if string.find( e, string.lower( string.trim( arg ) ) ) then
			return true
		end
		
	end
	
	return false
	
end

function ArkInventoryRules.System.quality( ... )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	if not ArkInventoryRules.Object.q then
		return false
	end
	
	local fn = "quality"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end

	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if type( arg ) == "number" then
			
			if arg == ArkInventoryRules.Object.q then
				return true
			end
			
		elseif type( arg ) == "string" then
			
			if string.lower( string.trim( arg ) ) == string.lower( _G[string.format( "ITEM_QUALITY%d_DESC", ArkInventoryRules.Object.q )] ) then
				return true
			end
			
		else
			
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, string.format( "%s or %s", ArkInventory.Localise["STRING"], ArkInventory.Localise["NUMBER"] ) ), 0 )
			
		end
		
	end
	
	return false
	
end

function ArkInventoryRules.System.itemlevelstat( ... )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local fn = "itemlevelstat"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end
	
	local arg1, arg2 = ...
	
	if not arg1 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, 1 ), 0 )
	end
	
	if type( arg1 ) ~= "number" then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, 1, ArkInventory.Localise["NUMBER"] ), 0 )
	end
	
	if not arg2 then
		arg2 = arg1
	end
	
	if type( arg2 ) ~= "number" then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, 2, ArkInventory.Localise["NUMBER"] ), 0 )
	end
	
	local level = ArkInventoryRules.Object.info.ilvl
	
	if level and level >= arg1 and level <= arg2 then
		return true
	end
	
	return false
	
end

function ArkInventoryRules.System.itemleveluse( ... )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local fn = "itemleveluse"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end
	
	local arg1, arg2 = ...
	
	if not arg1 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, 1 ), 0 )
	end
	
	if type( arg1 ) ~= "number" then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, 1, ArkInventory.Localise["NUMBER"] ), 0 )
	end
	
	if not arg2 then
		arg2 = arg1
	end
	
	if type( arg2 ) ~= "number" then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, 2, ArkInventory.Localise["NUMBER"] ), 0 )
	end
	
	local level = ArkInventoryRules.Object.info.uselevel or 0
	
	if level >= arg1 and level <= arg2 then
		return true
	end

	return false
	
end

function ArkInventoryRules.System.itemfamily( ... )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local fn = "itemfamily"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end
	
	local itemloc = ArkInventoryRules.Object.info.equiploc
	
	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if type( arg ) ~= "number" then
			
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["NUMBER"] ), 0 )
			
		elseif itemloc ~= "INVTYPE_BAG" then
			
			local it = GetItemFamily( ArkInventoryRules.Object.h ) or 0
			
			if bit.band( it, arg ) > 0 then
				return true
			end
			
		end
		
	end
	
	return false
	
end

function ArkInventoryRules.System.periodictable( ... )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local fn = "periodictable"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end
	
	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) ~= "string" then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
		end
		
		if ArkInventory.Lib.PeriodicTable:ItemInSet( ArkInventoryRules.Object.h, string.trim( arg ) ) then
			return true
		end
		
	end
	
end

function ArkInventoryRules.System.tooltip_old( ... )
	
	if not ArkInventoryRules.Object or not ArkInventoryRules.Object.h or ArkInventoryRules.Object.bag_id == nil or ArkInventoryRules.Object.slot_id == nil then
		return false
	end
	
	ArkInventory.TooltipSetHyperlink( ArkInventoryRules.Tooltip, ArkInventoryRules.Object.h )
	
	local fn = "tooltip"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end

	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) ~= "string" then
			arg = tostring( arg ) or arg
			if type( arg ) ~= "string" then
				error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
			end
		end
		
		arg = string.trim( arg )
		if arg ~= "" then
			if ArkInventory.TooltipContains( ArkInventoryRules.Tooltip, arg, false, false, false, true ) then
				return true
			end
		end
	
	end
	
	return false

end

function ArkInventoryRules.System.tooltip( ... )
	
	if not ArkInventoryRules.Object or not ArkInventoryRules.Object.h or ArkInventoryRules.Object.bag_id == nil or ArkInventoryRules.Object.slot_id == nil then
		return false
	end
	
	if ArkInventoryRules.Object.test_rule or ArkInventory.Global.Location[ArkInventoryRules.Object.loc_id].isOffline then
		-- offline/test mode uses generic item hyperlink tooltip
		ArkInventory.TooltipSetHyperlink( ArkInventoryRules.Tooltip, ArkInventoryRules.Object.h )
	else
		-- online mode uses specific item tooltip
		local bliz_id = ArkInventory.InternalIdToBlizzardBagId( ArkInventoryRules.Object.loc_id, ArkInventoryRules.Object.bag_id )
		ArkInventory.TooltipSetItem( ArkInventoryRules.Tooltip, bliz_id, ArkInventoryRules.Object.slot_id )
	end
	
	local fn = "tooltip"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end

	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) ~= "string" then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
		end
		
		if ArkInventory.TooltipContains( ArkInventoryRules.Tooltip, string.trim( arg ) ) then
			return true
		end
	
	end
	
	return false

end

function ArkInventoryRules.System.outfit( ... )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	if ArkInventoryRules.Object.info.equiploc == "" then
		return false
	end
	
	if ArkInventoryRules.Object.loc_id and ArkInventory.Global.Location[ArkInventoryRules.Object.loc_id].isOffline then
		return false
	end
	
	local fn = "outfit"
	
	local ac = select( '#', ... )
	
	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) ~= "string" then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
		end
		
	end	
	
	if IsAddOnLoaded( "Outfitter" ) and Outfitter:IsInitialized( ) and ArkInventoryRules.System.outfit_outfitter( ... ) then
		return true
	end
	
	if IsAddOnLoaded( "ItemRack" ) and ArkInventoryRules.System.outfit_itemrack( ... ) then
		return true
	end
	
	if C_EquipmentSet.CanUseEquipmentSets( ) then
		return ArkInventoryRules.System.outfit_blizzard( ... )
	end
	
	return false
	
end

function ArkInventoryRules.System.outfit_outfitter( ... )
	
	if not ArkInventoryRules.Object.h then
		return false
	end
	
	local ItemInfo = Outfitter:GetItemInfoFromLink( ArkInventoryRules.Object.h )
	
	if not ItemInfo then
		return false
	end
	
	local Outfits = Outfitter:GetOutfitsUsingItem( ItemInfo )
	
	if not Outfits or next( Outfits ) == nil then
		return false
	end
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		return true
	end
	
	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) ~= "string" then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
		end
		
		for _, o in pairs( Outfits ) do
			if o and o.Name and string.lower( string.trim( o.Name ) ) == string.lower( string.trim( arg ) ) then
				return true
			end
		end
		
	end
	
	return false

end

function ArkInventoryRules.System.outfit_itemrack( ... )

	-- item rack 2.1

	if not ArkInventoryRules.Object.h then
		return false
	end
	
	local id = string.match( ArkInventoryRules.Object.h or "", "item:(.+):%-?%d+" ) or 0
	
	local Outfits = { }
	
	for setname, set in pairs( ItemRackUser.Sets ) do
		--ArkInventory.Output( "setname=[", setname, "]" )
		for k, setitem in pairs( set.equip ) do
			--ArkInventory.Output( "pos=[", k, "], item=[", setitem, "], id=[", id, "]" )
			if not ( setitem == 0 or setitem == nil ) then
				if id == setitem and string.sub( setname, 1, 1 ) ~= "~" then
					tinsert( Outfits, string.trim( setname ) )
					--ArkInventory.Output( "added set [", setname, "] for item [", id, "]" )
					break
				end
			end
		end
	end
	
	if not Outfits or next( Outfits ) == nil then return false end
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		return true
	end
	
	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) ~= "string" then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
		end
		
		for _, o in pairs( Outfits ) do
			if o and string.lower( string.trim( o ) ) == string.lower( string.trim( arg ) ) then
				return true
			end
		end
	
	end
	
	return false

end

function ArkInventoryRules.System.outfit_blizzard( ... )
	
	-- blizzard equipment manager
	
	local equipsets = C_EquipmentSet.GetNumEquipmentSets( )
	if equipsets == 0 then
		return false
	end
	
	local Outfits = { }
	local setids = C_EquipmentSet.GetEquipmentSetIDs( )
	
	-- get a list of outfits the item is in
	for setnum, setid in pairs( setids ) do
		
		local setname = C_EquipmentSet.GetEquipmentSetInfo( setid )
		
		local items = C_EquipmentSet.GetItemLocations( setid )
		--ArkInventory.Output( items )
		
		if items then
			
			local loc_id, bag_id, slot_id, id, player, bank, bags, void, slot, bag, voidtab, voidslot
			
			for k, location in pairs( items ) do
				
				loc_id = nil
				bag_id = nil
				slot_id = nil
				id = nil
				
				player, bank, bags, void, slot, bag, voidtab, voidslot = EquipmentManager_UnpackLocation( location )
				
--				if void then
--					ArkInventory.Output( setname, ":", k, " -> [", player, ", ", bank, ", ", bags, ", ", void, "] [", bag, ".", slot, "] [", voidtab, ".", voidslot, "]" )
--				end
				
				if void and voidtab and voidslot then
					loc_id = ArkInventory.Const.Location.Void
					bag_id = ArkInventory.Const.Offset.Void + voidtab
					slot_id = voidslot
					id = GetVoidItemInfo( voidtab, voidslot )
				elseif ( not bags ) and slot then
					loc_id = ArkInventory.Const.Location.Wearing
					bag_id = ArkInventory.Const.Offset.Wearing + 1
					slot_id = slot
					id = GetInventoryItemID( "player", slot )
				elseif bag and slot then
					loc_id, bag_id = ArkInventory.BlizzardBagIdToInternalId( bag )
					slot_id = slot
					id = GetContainerItemID( bag, slot )
				end
				
				if loc_id and bag_id and slot_id and id and ArkInventoryRules.Object.info.id and ArkInventoryRules.Object.loc_id == loc_id and ArkInventoryRules.Object.bag_id == bag_id and ArkInventoryRules.Object.slot_id == slot_id and id == ArkInventoryRules.Object.info.id then
					--ArkInventory.Output( setname, ":", k, " -> [", ArkInventoryRules.Object.h, " / ", id )
					tinsert( Outfits, string.trim( setname ) )
					--ArkInventory.Output( "found ", ArkInventoryRules.Object.h, " in set [", setname, ":", k, "] [", ArkInventoryRules.Object.loc_id, ".", ArkInventoryRules.Object.bag_id, ".", ArkInventoryRules.Object.slot_id, "]" )
					break
				end
				
			end
			
		end
		
	end
	
	-- not in any outfit
	if next( Outfits ) == nil then
		return false
	end
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		return true
	end
	
	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) ~= "string" then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
		end
		
		for _, o in pairs( Outfits ) do
			if o and string.lower( string.trim( o ) ) == string.lower( string.trim( arg ) ) then
				return true
			end
		end
		
	end	
	
	return false

end

function ArkInventoryRules.System.vendorpriceunder( ... )

	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local fn = "vendorpriceunder"
	
	local arg1 = ...
	
	if not arg1 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, 1 ), 0 )
	end
	
	if type( arg1 ) ~= "number" then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, 1, ArkInventory.Localise["NUMBER"] ), 0 )
	end
	
	return ArkInventoryRules.System.vendorprice( 1, arg1 )
	
end

function ArkInventoryRules.System.vendorpriceover( ... )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local fn = "vendorpriceover"
	
	local arg1 = ...
	
	if not arg1 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, 1 ), 0 )
	end
	
	if type( arg1 ) ~= "number" then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, 1, ArkInventory.Localise["NUMBER"] ), 0 )
	end
	
	return ArkInventoryRules.System.vendorprice( 0, arg1 )
	
end

function ArkInventoryRules.System.vendorprice( opt, t )
	
	-- not called directly
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local price_per = ArkInventoryRules.Object.info.vendorprice
	
	if price_per == nil then
	
		--ArkInventory.Output( "item=[", ArkInventoryRules.Object.h, "], nil sell value" )
		return false
		
	elseif price_per > 0 then
	
		local count = ArkInventoryRules.Object.count or 1
		local price = price_per * count
	
		local v = tonumber( t )
		if type( v ) == "number" then
		
			if opt == 0 then
				
				--ArkInventory.Output( "[", count, "] x [", ArkInventoryRules.Object.h, "] = [", price, "], over=[", v, "]" )
			
				if price >= v then
					return true
				end
				
			elseif opt == 1 then
			
				--ArkInventory.Output( "[", count, "] x [", ArkInventoryRules.Object.h, "] = [", price, "], under=[", v, "]" )
				
				if price <= v then
					return true
				end
				
			end
		
		end
	
	end
	
	return false
	
end

function ArkInventoryRules.System.characterlevelrange( ... )

	-- ( levels below, levels above )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local fn = "characterlevelrange"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end
	
	local arg1, arg2 = ...
	
	if not arg1 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, 1 ), 0 )
	end
	
	if type( arg1 ) ~= "number" then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, 1, ArkInventory.Localise["NUMBER"] ), 0 )
	end
	
	if not arg2 then
		arg2 = arg1
	end
	
	if type( arg2 ) ~= "number" then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, 2, ArkInventory.Localise["NUMBER"] ), 0 )
	end
	
	local clevel = UnitLevel( "player" )
	local ulevel = ArkInventoryRules.Object.info.uselevel or clevel
	
	arg1 = clevel - arg1
	arg2 = clevel + arg2
	
	if ulevel >= arg1 and ulevel <= arg2 then
		return true
	end
	
	return false
	
end

function ArkInventoryRules.System.bag( ... )
	
	-- note, this rule is now just which *internal* bag an item is in, ie its just a number from 1 to x
	
	local fn = "bag"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end
	
	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) ~= "number" then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["NUMBER"] ), 0 )
		end
		
		if arg == ArkInventoryRules.Object.bag_id then
			return true
		end
		
	end
	
	return false
	
end

function ArkInventoryRules.System.location( ... )
	
	if not ArkInventoryRules.Object.loc_id then
		return false
	end
	
	local fn = "location"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end
	
	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) ~= "string" then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
		end
		
		
		local k = string.lower( string.trim( arg ) )
		if k == "bag" or k == string.lower( ArkInventory.Localise["LOCATION_BAG"] ) then
			k = ArkInventory.Const.Location.Bag
		elseif k == "bank" or k == string.lower( ArkInventory.Localise["LOCATION_BANK"] ) then
			k = ArkInventory.Const.Location.Bank
		elseif k == "guild bank" or k == "vault" or k == string.lower( ArkInventory.Localise["LOCATION_VAULT"] ) then
			k = ArkInventory.Const.Location.Vault
		elseif k == "mail" or k == string.lower( ArkInventory.Localise["MAIL"] ) then
			k = ArkInventory.Const.Location.Mail
		elseif k == "wearing" or k == "gear" or k == string.lower( ArkInventory.Localise["LOCATION_WEARING"] ) then
			k = ArkInventory.Const.Location.Wearing
		elseif k == "pet" or k == string.lower( ArkInventory.Localise["PET"] ) then
			k = ArkInventory.Const.Location.Pet
		elseif k == "mount" or k == string.lower( ArkInventory.Localise["MOUNT"] ) then
			k = ArkInventory.Const.Location.Mount
		elseif k == "token" or k == "currency" or k == string.lower( ArkInventory.Localise["CURRENCY"] ) then
			k = ArkInventory.Const.Location.Token
		else
			k = -1
		end
		
		if ArkInventoryRules.Object.loc_id == k then
			return true
		end
	end
	
	return false
	
end

function ArkInventoryRules.System.usable( )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	ArkInventory.TooltipSetHyperlink( ArkInventoryRules.Tooltip, ArkInventoryRules.Object.h )
	
	return ArkInventory.TooltipCanUse( ArkInventoryRules.Tooltip )
	
end

function ArkInventoryRules.System.count( ... )
	
	if not ArkInventoryRules.Object.h then
		return false
	end
	
	local fn = "count"
	
	local arg1 = ...
	
	if not arg1 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, 1 ), 0 )
	end
	
	if type( arg1 ) ~= "number" then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, 1, ArkInventory.Localise["NUMBER"] ), 0 )
	end
	
	if ArkInventoryRules.Object.count >= arg1 then
		return true
	end
	
	return false
	
end

function ArkInventoryRules.System.stacks( )

	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	if ArkInventoryRules.Object.info.stacksize > 1 then
		return true
	end
	
	return false
	
end

function ArkInventoryRules.System.trash( )
	
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	if ArkInventoryRules.Object.q == 0 then
		return true
	end
	
	local id = ArkInventoryRules.Object.info.id
	
	if IsAddOnLoaded( "Scrap" ) then
		if Scrap:IsJunk( id ) then
			return true
		end
	end
	
	if IsAddOnLoaded( "SellJunk" ) then
		local poor = ( ArkInventoryRules.Object.q == 0 )
		if ( ( poor ) and ( not SellJunk:isException( ArkInventoryRules.Object.h ) ) ) or ( ( not poor ) and ( SellJunk:isException( ArkInventoryRules.Object.h ) ) ) then
			return true
		end
	end
	
	if IsAddOnLoaded( "ReagentRestocker" ) then
		if ReagentRestocker:isToBeSold( id ) then
			return true
		end
	end
	
	return false
	
end

function ArkInventoryRules.System.pettype( ... )
	
	if not ArkInventoryRules.Object.h or ( ArkInventoryRules.Object.class ~= "battlepet" ) then
		return false
	end
	
	local fn = "pettype"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end
	
	local e = ArkInventoryRules.Object.info.itemsubtypeid
	e = string.lower( ArkInventory.Collection.Pet.PetTypeName( e ) )
	
	if e then
		
		for ax = 1, ac do
			
			local arg = select( ax, ... )
			
			if not arg then
				error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
			end
			
			if type( arg ) == "number" then
				arg = ArkInventory.Collection.Pet.PetTypeName( arg )
				if not arg then
					error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_INVALID"], fn, ax ), 0 )
				end
			end
			
			if e == string.lower( string.trim( arg ) ) then
				return true
			end
			
		end
		
	end
	
	return false
	
end

function ArkInventoryRules.System.petiswild( ... )
	
	if ( not ArkInventoryRules.Object.h ) or ( ArkInventoryRules.Object.class ~= "battlepet" ) then
		return false
	end
	
	return not not ArkInventoryRules.Object.wp
	
end

function ArkInventoryRules.System.petcanbattle( ... )
	
	if ( not ArkInventoryRules.Object.h ) or ( ArkInventoryRules.Object.class ~= "battlepet" ) then
		return false
	end
	
	return not not ArkInventoryRules.Object.bp
	
end

function ArkInventoryRules.System.mounttype( ... )
	
	if not ArkInventoryRules.Object.h or ( ArkInventoryRules.Object.class ~= "spell" ) then
		return false
	end
	
	local fn = "mounttype"
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end
	
	local md = ArkInventory.Collection.Mount.GetMount( ArkInventoryRules.Object.index )
	
	if md and md.mt then
		
		for ax = 1, ac do
			
			local arg = select( ax, ... )
			
			if not arg then
				error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
			end
			
			if type( arg ) ~= "string" then
				error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
			end
			
			local ex = ArkInventory.Const.MountTypes[string.lower( string.trim( arg ) )]
			if ex == md.mt then
				return true
			end
			
		end
		
	end
	
	return false
	
end

function ArkInventoryRules.System.bonus( ... )
	
	if not ArkInventoryRules.Object.h or not ( ArkInventoryRules.Object.class == "item" or ArkInventoryRules.Object.class == "keystone" ) then
		return false
	end
	
	local fn = "bonus"
	
	local ac = select( '#', ... )
	
	local bid = ArkInventoryRules.Object.info.bonusids
	
	if not bid then
		return
	end
	
	if ac == 0 then
		return true
	end
	
	for ax = 1, ac do
		
		local arg = select( ax, ... )
		
		if type( arg ) ~= "number" then
			
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["NUMBER"] ), 0 )
			
		else
			
			if bid[arg] then
				return true
			end
			
		end
		
	end
	
	return false
	
end

--[[
	
	tsmgroup( ) = in any group
	tsmgroup( "test" ) = is in a group named test
	tsmgroup( "test1", "test2" ) = is in a group named either test1 or test2
	tsmgroup( "test->*" ) = is in a group named test or any of its subgroups
	tsmgroup( "test->sub1" ) = is in a group named test->sub1

]]--

function ArkInventoryRules.System.tsmgroup( ... )
	
	-- always check for a hyperlink and that it's an item
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local fn = "tsmgroup"
	
	if not IsAddOnLoaded( "TradeSkillMaster" ) then
		return false
	end
	
	-- full item string
	local itemString = TSMAPI.Item:ToItemString( ArkInventoryRules.Object.h )
	
	if not itemString then
		return false
	end
	
	local group = TSMAPI.Groups:FormatPath( TSMAPI.Groups:GetPath( itemString ) )
	
	if not group then
		
		-- full item was not in any group, check base item
		itemString = TSMAPI.Item:ToBaseItemString( ArkInventoryRules.Object.h )
		
		if not itemString then
			return false
		end
		
		group = TSMAPI.Groups:FormatPath( TSMAPI.Groups:GetPath( itemString ) )
		
		if not group then
			return false
		end
		
	end
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		-- no groupnames listed, so any group is ok
		return true
	end
	
	local arg
	
	-- loop through arguments
	for ax = 1, ac do
		
		arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) ~= "string" then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
		end
		
		arg = string.trim( arg )
		
		if string.sub( arg, -1 ) == "*" then
			
			-- wildcard match, remove the wildcard
			arg = string.sub( arg, 1, -2 )
			
			if string.len( arg ) == 0 then
				-- match anything
				return true
			end
			
			-- if arg is group->* then specifically check parent group
			if string.sub( arg, -2 ) == "->" and string.lower( string.sub( arg, 1, -3 ) ) == string.lower( group ) then
				return true
			end
			
			-- check for match
			if string.lower( arg ) == string.lower( string.sub( group, 1, string.len( arg ) ) ) then
				return true
			end
			
		else
			
			-- exact match
			
			if string.len( arg ) == 0 then
				error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_INVALID"], fn, ax ), 0 )
			else
				if string.lower( arg ) == string.lower( group ) then
					return true
				end
			end
			
		end
		
	end
	
	return false
	
end

function ArkInventoryRules.System.tsm( ... )
	
	-- always check for a hyperlink and that it's an item
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end
	
	local fn = "tsm"
	
	if not IsAddOnLoaded( "TradeSkillMaster" ) then
		return false
	end
	
	-- full item string
	local itemString = TSMAPI.Item:ToItemString( ArkInventoryRules.Object.h )
	
	if not itemString then
		return false
	end
	
	local group = TSMAPI.Groups:FormatPath( TSMAPI.Groups:GetPath( itemString ) )
	
	if not group then
		
		-- full item was not in any group, check base item
		itemString = TSMAPI.Item:ToBaseItemString( ArkInventoryRules.Object.h )
		
		if not itemString then
			return false
		end
		
		group = TSMAPI.Groups:FormatPath( TSMAPI.Groups:GetPath( itemString ) )
		
		if not group then
			return false
		end
		
	end
	
	local ac = select( '#', ... )
	
	if ac == 0 then
		-- no groupnames listed, so any group is ok
		return true
	end
	
	local arg
	
	-- loop through arguments
	for ax = 1, ac do
		
		arg = select( ax, ... )
		
		if not arg then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NIL"], fn, ax ), 0 )
		end
		
		if type( arg ) ~= "string" then
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, ArkInventory.Localise["STRING"] ), 0 )
		end
		
		if string.find( string.lower( group ), arg ) then
			return true
		end
		
	end
	
	return false
	
end



ArkInventoryRules.Environment = {
	
	i = ArkInventoryRules.Object,
	
	-- rule functions
	
	soulbound = ArkInventoryRules.System.soulbound,
	sb = ArkInventoryRules.System.soulbound,
	
	accountbound = ArkInventoryRules.System.accountbound,
	ab = ArkInventoryRules.System.accountbound,
	
	itemstring = ArkInventoryRules.System.itemstring,
	
	type = ArkInventoryRules.System.type,
	
	subtype = ArkInventoryRules.System.subtype,
	stype = ArkInventoryRules.System.subtype,
	
	equip = ArkInventoryRules.System.equip,
	
	name = ArkInventoryRules.System.name,
	
	quality = ArkInventoryRules.System.quality,
	q = ArkInventoryRules.System.quality,
	
	periodictable = ArkInventoryRules.System.periodictable,
	pt = ArkInventoryRules.System.periodictable,
	
	tooltip = ArkInventoryRules.System.tooltip,
	tt = ArkInventoryRules.System.tooltip,
	
	outfit = ArkInventoryRules.System.outfit,
	
	ilvl = ArkInventoryRules.System.itemlevelstat,
	itemlevel = ArkInventoryRules.System.itemlevelstat,
	statlevel = ArkInventoryRules.System.itemlevelstat,
	
	ireq = ArkInventoryRules.System.itemleveluse,
	uselevel = ArkInventoryRules.System.itemleveluse,
	
	bonus = ArkInventoryRules.System.bonus,
	
	clr = ArkInventoryRules.System.characterlevelrange,
	
	vpu = ArkInventoryRules.System.vendorpriceunder,
	
	vpo = ArkInventoryRules.System.vendorpriceover,
	
	bag = ArkInventoryRules.System.bag,
	
	location = ArkInventoryRules.System.location,
	loc = ArkInventoryRules.System.location,
	
	usable = ArkInventoryRules.System.usable,
	use = ArkInventoryRules.System.usable,
	useable = ArkInventoryRules.System.usable,
	
	count = ArkInventoryRules.System.count,
	
	stacks = ArkInventoryRules.System.stacks,
	
	pettype = ArkInventoryRules.System.pettype,
	ptype = ArkInventoryRules.System.pettype,
	
	petiswild = ArkInventoryRules.System.petiswild,
	
	petcanbattle = ArkInventoryRules.System.petcanbattle,
	
	mounttype = ArkInventoryRules.System.mounttype,
	mtype = ArkInventoryRules.System.mounttype,
	
	itemfamily = ArkInventoryRules.System.itemfamily,
	family = ArkInventoryRules.System.itemfamily,
	
	-- 3rd party addons requried for the following functions to work
	
	trash = ArkInventoryRules.System.trash,
	
	tsmgroup = ArkInventoryRules.System.tsmgroup,
	tsm = ArkInventoryRules.System.tsm,
	
}

function ArkInventoryRules.Register( a, n , f, o ) -- addon, rule name, function, overwrite
	
	local n = string.trim( string.lower( tostring( n ) ) )
	
	if n == "i" then
		ArkInventory.OutputWarning( "Invalid rule registration from ", a:GetName( ), " - ", n, " cannot overwrite environment variable" )
		return false
	end
	
	if not string.match( n, "^%a[%a%d]*$" ) then
		ArkInventory.OutputWarning( "Invalid rule registration from ", a:GetName( ), " - ", n, " is not a valid rule name" )
		return false
	end
	
	if not o and ArkInventoryRules.Environment[n] then
		ArkInventory.OutputWarning( "Invalid rule registration from ", a:GetName( ), " - ", n, " is already registered" )
		return false
	end
	
	ArkInventoryRules.Environment[n] = f
	if ArkInventory.db.option.message.rules.registration then
		ArkInventory.Output( "Successful rule registration from ", a:GetName( ), " - rule function [", n, "] is now active" )
	end
	
	return true
	
end



function ArkInventoryRules.Frame_Rules_Table_Sort_Build( frame )

	local f = frame:GetName( )
	
	local x
	
	--damaged
	x = _G[f .. "_T1"]
	x:ClearAllPoints( )
	x:SetWidth( 32 )
	x:SetPoint( "TOP", 0, 0 )
	x:SetPoint( "BOTTOM", 0, 0 )
	x:SetPoint( "LEFT", 15, 0 )
	x:SetText( ArkInventory.Localise["RULE_LIST_DAMAGED"] )
	x:Show( )
	
	-- id
	x = _G[f .. "_C1"]
	x:ClearAllPoints( )
	x:SetWidth( 50 )
	x:SetPoint( "LEFT", f .. "_T1", "RIGHT", 5, 0 )
	x:SetPoint( "TOP", 0, 0 )
	x:SetPoint( "BOTTOM", 0, 0 )
	x:SetText( ArkInventory.Localise["RULE_LIST_ID"] )
	x:Show( )

	-- order
	x = _G[f .. "_C2"]
	x:ClearAllPoints( )
	x:SetWidth( 50 )
	x:SetPoint( "LEFT", f .. "_C1", "RIGHT", 5, 0 )
	x:SetPoint( "TOP", 0, 0 )
	x:SetPoint( "BOTTOM", 0, 0 )
	x:SetText( ArkInventory.Localise["ORDER"] )
	x:Show( )

	-- description
	x = _G[f .. "_C3"]
	x:ClearAllPoints( )
	x:SetPoint( "LEFT", f .. "_C2", "RIGHT", 5, 0 )
	x:SetPoint( "TOP", 0, 0 )
	x:SetPoint( "BOTTOM", 0, 0 )
	x:SetPoint( "RIGHT", -35, 0 )
	x:SetText( ArkInventory.Localise["DESCRIPTION"] )
	x:Show( )
	
end

function ArkInventoryRules.Frame_Rules_Table_Row_Build( frame )

	local f = frame:GetName( )
	
	local x
	local sz = 18
	
	--damaged
	x = _G[f .. "T1"]
	x:ClearAllPoints( )
	x:SetWidth( sz )
	x:SetHeight( sz )
	x:SetPoint( "LEFT", 17, 0 )
	x:Show( )
	
	-- id
	x = _G[f .. "C1"]
	x:ClearAllPoints( )
	x:SetWidth( 50 )
	x:SetPoint( "LEFT", f .. "T1", "RIGHT", 12, 0 )
	x:SetPoint( "TOP", 0, 0 )
	x:SetPoint( "BOTTOM", 0, 0 )
	x:SetTextColor( 1, 1, 1, 1 )
	x:SetJustifyH( "CENTER", 0, 0 )
	x:Show( )

	-- order
	x = _G[f .. "C2"]
	x:ClearAllPoints( )
	x:SetWidth( 50 )
	x:SetPoint( "LEFT", f .. "C1", "RIGHT", 5, 0 )
	x:SetPoint( "TOP", 0, 0 )
	x:SetPoint( "BOTTOM", 0, 0 )
	x:SetTextColor( 1, 1, 1, 1 )
	x:SetJustifyH( "CENTER", 0, 0 )
	x:Show( )

	-- description
	x = _G[f .. "C3"]
	x:ClearAllPoints( )
	x:SetPoint( "LEFT", f .. "C2", "RIGHT", 5, 0 )
	x:SetPoint( "TOP", 0, 0 )
	x:SetPoint( "BOTTOM", 0, 0 )
	x:SetPoint( "RIGHT", -5, 0 )
	x:SetJustifyH( "LEFT", 0, 0 )
	x:Show( )
	
	-- Highlight
	x = _G[f .. "Highlight"]
	x:Hide( )
	
end

function ArkInventoryRules.Frame_Rules_Table_Build( frame )
	
	local f = frame:GetName( )
	
	local maxrows = tonumber( _G[f .. "MaxRows"]:GetText( ) )
	local rows = maxrows
	local height = 24
	
	if rows > maxrows then rows = maxrows end
	_G[f .. "NumRows"]:SetText( rows )
	
	if height == 0 then
		height = tonumber( _G[f .. "RowHeight"]:GetText( ) )
	end
	_G[f .. "RowHeight"]:SetText( height )

	-- stretch scrollbar to bottom row
	_G[f .. "Scroll"]:SetPoint( "BOTTOM", f .. "Row" .. rows, "BOTTOM", 0, 0 )

	-- set frame height to correct size
	_G[f]:SetHeight( height * rows + 20 )

end

function ArkInventoryRules.Frame_Rules_Table_Row_OnClick( frame )

	local f = frame:GetName( )
	
	-- ArkInventory.Print( "RuleTableClick( " .. f .. " )" )
	local parent = _G[f]:GetParent( ):GetName( )
	
	local cs = _G[parent .. "SelectedRow"]:GetText( )
	local ns = tostring( _G[f]:GetID( ) )

	if ns == "0" then
		ArkInventory.Output( "OOPS: widget [", f, "] has no ID allocated" )
		return false
	end
	
	
		-- show/hide selected background
	
		if cs ~= "-1" then
			_G[parent .. "Row" .. cs .. "Selected"]:Hide( )
		end

		-- second click removes selection		
		if cs == ns then
			_G[parent .. "SelectedRow"]:SetText( "-1" )
			_G[parent .. "SelectedId"]:SetText( "-1" )
			return
		end
	
		_G[parent .. "SelectedRow"]:SetText( ns )
		_G[parent .. "SelectedId"]:SetText( _G[f .. "Id"]:GetText( ) )
	
		_G[f .. "Selected"]:Show( )
		
end

function ArkInventoryRules.Frame_Rules_Table_Reset( f )

	if not f or type( f ) ~= "string" or not _G[f] then
		ArkInventory.OutputError( "OOPS: Invalid value at ArkInventoryRules.Frame_Rules_Table_Reset( [", f, "] )" )
		return
	end

	-- hide and reset all rows
	
	local t = f .. "Table"
	
	local h = tonumber( _G[t .. "RowHeight"]:GetText( ) )
	local r = tonumber( _G[t .. "NumRows"]:GetText( ) )

	_G[t .. "SelectedRow"]:SetText( "-1" )
	for x = 1, r do
		_G[t .. "Row" .. x .. "Selected"]:Hide( )
		_G[t .. "Row" .. x .. "Id"]:SetText( "-1" )
		_G[t .. "Row" .. x]:Hide( )
		_G[t .. "Row" .. x]:SetHeight( h )
	end

end

function ArkInventoryRules.Frame_Rules_Table_Refresh( frame )
	
	local f = frame:GetParent( ):GetParent( ):GetParent( ):GetName( )
	
	f = f .. "View"
	
	local ft = f .. "Table"

	local height = tonumber( _G[ft .. "RowHeight"]:GetText( ) )
	local rows = tonumber( _G[ft .. "NumRows"]:GetText( ) )

	local line
	local lineplusoffset
	
	ArkInventoryRules.Frame_Rules_Table_Reset( f )

	local filter = _G[f .. "SearchFilter"]:GetText( )
	--ArkInventory.Print( "filter = [" .. filter .. "]" )

	local tt = { }
	local tc = 0
	
	local ignore
	
	for k, d in pairs( ArkInventory.db.option.category[ArkInventory.Const.Category.Type.Rule].data ) do

		-- ArkInventory.Output( "k = [", k, "], order = [", d.order, "], name = [", d.name, "], formula = [", d.formula, "]" )
	
		ignore = false
		
		if filter ~= "" then
			if not string.find( string.lower( d.name or "" ), string.lower( filter ) ) then
				ignore = true
			end
		end
		
		if d.used ~= "Y" then
			ignore = true
		end
		
		if not ignore then
			tt[#tt + 1] = {
				["sorted"] = format( "%04i %04i", d.order or 0, k ),
				["id"] = k,
				["order"] = d.order or 0,
				["name"] = d.name or "",
				["formula"] = d.formula or "",
				["damaged"] = d.damaged or false,
			}
			tc = tc + 1
		end

	end
	
	
	FauxScrollFrame_Update( _G[ft .. "Scroll"], tc, rows, height )
	
	if tc == 0 then
		return
	end
	
	-- sort them by name
	table.sort( tt, function( a, b ) return a.sorted < b.sorted end )

	local linename, c, r
	
	for line = 1, rows do

		linename = ft .. "Row" .. line
		
		lineplusoffset = line + FauxScrollFrame_GetOffset( _G[ft .. "Scroll"] )

		if lineplusoffset <= tc then

			c = ""
			r = tt[lineplusoffset]
			
			_G[linename .. "Id"]:SetText( string.format( "%04i", r.id ) )

			if r.damaged then
				ArkInventory.SetTexture( _G[linename .. "T1"], ArkInventory.Const.Texture.No )
			else
				ArkInventory.SetTexture( _G[linename .. "T1"], true, 0, 0, 0, 0 )
			end
			
			_G[linename .. "C1"]:SetText( string.format( "%04i", r.id ) )
			
			c = string.format( r.order )
			_G[linename .. "C2"]:SetText( c )
			
			c = r.name
			if not c then c = "<not set>" end
			_G[linename .. "C3"]:SetText( c )
			
			_G[linename]:Show( )
			
			-- show selected if id is scrolled into view
			if _G[ft .. "SelectedId"]:GetText( ) == r.order then
				_G[ft .. "SelectedRow"]:SetText( line )
				_G[ft .. "Row" .. line .. "Selected"]:Show( )
			end
			
		else
			
			_G[linename .. "Id"]:SetText( "-1" )
			_G[linename]:Hide( )
			
		end
	end

end

function ArkInventoryRules.Frame_Rules_Paint( )

	local frame = ARKINV_Rules
	
	-- frameStrata
	if frame:GetFrameStrata( ) ~= ArkInventory.db.option.ui.rules.strata then
		frame:SetFrameStrata( ArkInventory.db.option.ui.rules.strata )
	end
	
	-- title
	local obj = _G[frame:GetName( ) .. "TitleWho"]
	if obj then
		local t = string.format( "%s: %s %s", ArkInventory.Localise["CONFIG_RULE_PLURAL"], ArkInventory.Const.Program.Name, ArkInventory.Global.Version )
		obj:SetText( t )
	end
	
	-- font
	ArkInventory.MediaFrameDefaultFontSet( frame )
	
	-- scale
	frame:SetScale( ArkInventory.db.option.ui.rules.scale or 1 )
	
	local style, file, size, offset, scale, colour
	
	for _, z in pairs( { frame:GetChildren( ) } ) do
		
		-- background
		local obj = _G[z:GetName( ) .. "Background"]
		if obj then
			style = ArkInventory.db.option.ui.rules.background.style or ArkInventory.Const.Texture.BackgroundDefault
			if style == ArkInventory.Const.Texture.BackgroundDefault then
				colour = ArkInventory.db.option.ui.rules.background.colour
				ArkInventory.SetTexture( obj, true, colour.r, colour.g, colour.b, colour.a )
			else
				file = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Lib.SharedMedia.MediaType.BACKGROUND, style )
				ArkInventory.SetTexture( obj, file )
			end
		end
		
		-- border
		style = ArkInventory.db.option.ui.rules.border.style or ArkInventory.Const.Texture.BorderDefault
		file = ArkInventory.Lib.SharedMedia:Fetch( ArkInventory.Lib.SharedMedia.MediaType.BORDER, style )
		size = ArkInventory.db.option.ui.rules.border.size or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].size
		offset = ArkInventory.db.option.ui.rules.border.offset or ArkInventory.Const.Texture.Border[ArkInventory.Const.Texture.BorderDefault].offset
		scale = ArkInventory.db.option.ui.rules.border.scale or 1
		colour = ArkInventory.db.option.ui.rules.border.colour or { }
		
		ArkInventoryRules.Frame_Rules_Paint_Border( z, file, size, offset, scale, colour.r, colour.g, colour.b, 1 )
		
	end
	
end

function ArkInventoryRules.Frame_Rules_Paint_Border( frame, ... )
	
	if not frame then return end
	
	if frame:GetName( ) then
		local obj = _G[frame:GetName( ) .. "ArkBorder"]
		if obj then
			if ArkInventory.db.option.ui.rules.border.style ~= ArkInventory.Const.Texture.BorderNone then
				ArkInventory.Frame_Border_Paint( obj, false, ... )
				obj:Show( )
			else
				obj:Hide( )
			end
		end
	end
	
	for _, z in pairs( { frame:GetChildren( ) } ) do
		ArkInventoryRules.Frame_Rules_Paint_Border( z, ... )
	end
	
end


function ArkInventoryRules.EntryFormat( data )

	if not data then
		return
	end
	
	local zOrder = 9999
	zOrder = abs( tonumber( data.order ) or zOrder )
	if zOrder > 9999 then
		zOrder = 9999
	end
	
	local zName = "<NEW>"
	zName = string.trim( tostring( data.name or zName ) )
	
	local zFormula = "false"
	zFormula = tostring( data.formula or zFormula )
	--zFormula = string.trim( tostring( data.formula or zFormula ) )
	--zFormula = string.gsub( zFormula, "[\r]", " " ) -- replace carriage return with space
	--zFormula = string.gsub( zFormula, "[\n]", " " ) -- replace new line with space
	--zFormula = string.gsub( zFormula, "%s+", " " ) -- replace multiple spaces with a single space
	
	data.used = "Y"
	data.damaged = false
	data.order = zOrder
	data.name = zName
	data.formula = zFormula
	
	-- purge old data
	data.compiled = nil
	data.enabled = nil
	
	return data
	
end

function ArkInventoryRules.EntryUpdate( rid, data )
	
	local rid = tonumber( rid )
	ArkInventoryRules.EntryFormat( data )
	
	-- save the rule data at the global level
	ArkInventory.db.option.category[ArkInventory.Const.Category.Type.Rule].data[rid].used = "Y"
	for k, v in pairs( data ) do
		ArkInventory.db.option.category[ArkInventory.Const.Category.Type.Rule].data[rid][k] = v
	end
	
	ArkInventory.ItemCacheClear( )
	ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
	
end

function ArkInventoryRules.EntryIsValid( rid, data )
	
	--ArkInventory.Output( "validating rule ", rid )
	
	local ok = true
	local em = string.format( ArkInventory.Localise["RULE_FAILED"], rid )
	
	if not rid then
		return false, string.format( "%s, %s", em, ArkInventory.Localise["RULE_FAILED_KEY_NIL"] )
	end
	
	if not data then
		return false, ArkInventory.Localise["RULE_FAILED_DATA_NIL"]
	end
	
	ArkInventoryRules.EntryFormat( data )
	
	
	if not data.name or string.trim( data.name ) == "" then
		em = string.format( "%s, %s", em, ArkInventory.Localise["RULE_FAILED_DESCRIPTION_NIL"] )
		ok = false
	end
	
	if not data.formula or string.trim( data.formula ) == "" then
		
		em = string.format( "%s, %s", em, ArkInventory.Localise["RULE_FAILED_FORMULA_NIL"] )
		ok = false
		
	else
		
		ArkInventoryRules.SetObject( { test_rule=true, class="item", bag_id=0, slot_id=1, count=1, q=1, sb=1, h=string.format("item:%s:::::::", HEARTHSTONE_ITEM_ID ) } )
		
		local p, pem = loadstring( string.format( "return( %s )", data.formula ) )
		
		if not p then
			
			--ArkInventory.Output( "loadstring failed" )
			
			ok = false
			em = string.format( "%s, loadstring failure: %s", em, pem )
			
		else
			
			--ArkInventory.Output( "loadstring ok" )
			
			setfenv( p, ArkInventoryRules.Environment )
			local pok, pem = pcall( p )
			
			if not pok then
				--ArkInventory.Output( "pcall failed" )
				ok = false
				em = string.format( "%s, %s: %s", em, ArkInventory.Localise["RULE_FAILED_FORMULA_BAD"], pem )
			else
				--ArkInventory.Output( "pcall ok" )
			end
			
		end
		
	end
	
	return ok, em
	
end

function ArkInventoryRules.EntryAdd( data )
	
	local ok, msg = ArkInventoryRules.EntryIsValid( "<NEW>", data )
	if not ok then
		return false, msg
	end
	
	local p, rule = ArkInventory.ConfigInternalCategoryRuleAdd( "new" )
	if p then
		ArkInventoryRules.EntryUpdate( p, data )
		return true
	end
	
end

function ArkInventoryRules.EntryEdit( rid, data )

	local ok, ec = ArkInventoryRules.EntryIsValid( rid, data )
	if not ok then
		return false, ec
	end
	
	ArkInventoryRules.EntryUpdate( rid, data )
	
	return true
	
end

function ArkInventoryRules.EntryRemove( rid )

	if not rid then
		error( "FAILED: key is nil" )
	end
	
	local rid = tonumber( rid )
	ArkInventory.ConfigInternalCategoryRuleDelete( rid )
	
	ArkInventory.ItemCacheClear( )
	ArkInventory.Frame_Main_Generate( nil, ArkInventory.Const.Window.Draw.Recalculate )
	
	return true
	
end


function ArkInventoryRules.Frame_Rules_Button_Modify( frame, t )
	
	local f = frame:GetParent( ):GetParent( ):GetParent( ):GetName( )
	
	local fvt = f .. "ViewTable"

	local fm = f .. "Modify"
	local fmt = fm .. "Title"
	local fmd = fm .. "Data"

	_G[fm .. "Type"]:SetText( t )

	local k = _G[fvt .. "SelectedId"]:GetText( )
	if not k then k = "-1" end
	if t == "A" then k = "-1" end

	local v
	
	if k ~= "-1" then
		local d = ArkInventory.ConfigInternalCategoryRuleGet( tonumber( k ) )
		_G[fmd .. "Id"]:SetText( k )
		_G[fmd .. "Order"]:SetText( d.order or "" )
		_G[fmd .. "Description"]:SetText( d.name or "" )
		_G[fmd .. "ScrollFormula"]:SetText( d.formula or "" )
	else
		_G[fmd .. "Id"]:SetText( "<NEW>" )
		_G[fmd .. "Order"]:SetText( "100" )
		_G[fmd .. "Description"]:SetText( "" )
		_G[fmd .. "ScrollFormula"]:SetText( "false" )
	end

	_G[fmd .. "IdLabel"]:SetText( ArkInventory.Localise["RULE"] .. ":"  )
	_G[fmd .. "OrderLabel"]:SetText( ArkInventory.Localise["ORDER"] .. ":"  )
	_G[fmd .. "DescriptionLabel"]:SetText( ArkInventory.Localise["DESCRIPTION"] .. ":"  )
	_G[fmd .. "FormulaLabel"]:SetText( ArkInventory.Localise["RULE_FORMULA"] .. ":" )
	
	_G[fmd .. "Order"]:Show( )
	_G[fmd .. "Description"]:Show( )
	_G[fmd .. "ScrollFormula"]:Show( )

	_G[fmd .. "OrderReadOnly"]:SetText( _G[fmd .. "Order"]:GetText( ) )
	_G[fmd .. "OrderReadOnly"]:Hide( )
	_G[fmd .. "DescriptionReadOnly"]:SetText( _G[fmd .. "Description"]:GetText( ) )
	_G[fmd .. "DescriptionReadOnly"]:Hide( )
	_G[fmd .. "FormulaReadOnly"]:SetText( _G[fmd .. "ScrollFormula"]:GetText( ) )
	_G[fmd .. "FormulaReadOnly"]:Hide( )

	if t == "R" then

		if k == "-1" then return end

		_G[fmt .. "Text"]:SetText( string.upper( ArkInventory.Localise["REMOVE"] ) )

		_G[fmd .. "Order"]:Hide( )
		_G[fmd .. "OrderReadOnly"]:Show( )

		_G[fmd .. "Description"]:Hide( )
		_G[fmd .. "DescriptionReadOnly"]:Show( )

		_G[fmd .. "ScrollFormula"]:Hide( )
		_G[fmd .. "FormulaReadOnly"]:Show( )

	elseif t == "E" then

		if k == "-1" then return end

		_G[fmt .. "Text"]:SetText( string.upper( ArkInventory.Localise["EDIT"] ) )

	elseif t == "A" then

		_G[fmt .. "Text"]:SetText( string.upper( ArkInventory.Localise["ADD"] ) )

	else
		ArkInventory.Output( RED_FONT_COLOR_CODE, "OOPS: Uncoded argument ArkInventoryRules.Frame_Rules_Button_Modify( ", t, " )" )
		return
	end

	_G[f .. "View"]:Hide( )
	_G[fm]:Show( )

end

function ArkInventoryRules.Frame_Rules_Button_Modify_Ok( frame )

	local f = frame:GetParent( ):GetParent( ):GetParent( ):GetParent( ):GetName( )
	local fm = frame:GetParent( ):GetParent( ):GetName( )
	local fmd = fm .. "Data"
	
	local d = { }
	d["order"] = _G[fmd .. "Order"]:GetText( )
	d["name"] = _G[fmd .. "Description"]:GetText( )
	d["formula"] = _G[fmd .. "ScrollFormula"]:GetText( )
	
	local k = _G[fmd .. "Id"]:GetText( )
	
	f = frame:GetParent( ):GetParent( ):GetParent( ):GetName( )
	fm = frame:GetParent( ):GetParent( ):GetName( )
	
	local t = _G[fm .. "Type"]:GetText( )
	
	if t =="A" then
		local ok, ec = ArkInventoryRules.EntryAdd( d )
		if not ok then
			if ec then
				ArkInventory.OutputError( ec )
			end
			return
		end
		_G[f .. "ViewTableSelectedId"]:SetText( "-1" )
	elseif t == "E" then
		local ok, ec = ArkInventoryRules.EntryEdit( k, d )
		if not ok then
			if ec then
				ArkInventory.OutputError( ec )
			end
			return
		end
	elseif t == "R" then
		local ok, ec = ArkInventoryRules.EntryRemove( k )
		if not ok then
			if ec then
				ArkInventory.OutputError( ec )
			end
			return
		end
		_G[f .. "ViewTableSelectedId"]:SetText( "-1" )
	else
		ArkInventory.OutputError( "OOPS: Uncoded value [", t, "] at ArkInventoryRules.Frame_Rules_Button_Modify_Ok" )
		return
	end
	
	_G[fm]:Hide( )
	_G[f .. "View"]:Show( )
	
end

function ArkInventoryRules.Frame_Rules_Button_Modify_Cancel( frame )

	f = frame:GetParent( ):GetParent( ):GetParent( ):GetName( )
	
	_G[f .. "Modify"]:Hide( )
	_G[f .. "View"]:Show( )

end


function ArkInventoryRules.Frame_Rules_Button_View_Add( frame )
	return ArkInventoryRules.Frame_Rules_Button_Modify( frame, "A" )
end

function ArkInventoryRules.Frame_Rules_Button_View_Edit( frame )
	return ArkInventoryRules.Frame_Rules_Button_Modify( frame, "E" )
end

function ArkInventoryRules.Frame_Rules_Button_View_Remove( frame )
	return ArkInventoryRules.Frame_Rules_Button_Modify( frame, "R" )
end

function ArkInventoryRules.SetObject( tbl )
	
	table.wipe( ArkInventoryRules.Object )
	ArkInventory.Table.Merge( tbl, ArkInventoryRules.Object )
	
	ArkInventoryRules.Object.info = ArkInventory.ObjectInfoArray( ArkInventoryRules.Object.h )
	
	ArkInventoryRules.Object.osd = ArkInventoryRules.Object.info.osd
	
	ArkInventoryRules.Object.class = ArkInventoryRules.Object.osd.class
	
end
