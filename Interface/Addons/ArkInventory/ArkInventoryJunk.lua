local _G = _G
local select = _G.select
local pairs = _G.pairs
local ipairs = _G.ipairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table


function ArkInventory.JunkIterate( )
	
	local loc_id = ArkInventory.Const.Location.Bag
	local codex = ArkInventory.GetLocationCodex( loc_id )
	
	local bag_id = 1
	local slot_id = 0
	
	local player = ArkInventory.GetPlayerStorage( nil, loc_id )
	local i
	
	local bags = ArkInventory.Global.Location[loc_id].Bags
	local blizzard_id = bags[bag_id]
	local numslots = GetContainerNumSlots( blizzard_id )
	
	local _, isJunk, isLocked, itemCount, itemLink, vendorPrice
	
	
	return function( )
		
		isJunk = false
		itemLink = nil
		itemCount = 0
		vendorPrice = -1
		
		while not isJunk do
			
			if slot_id < numslots then
				slot_id = slot_id + 1
			elseif bag_id < #bags then
				bag_id = bag_id + 1
				blizzard_id = bags[bag_id]
				numslots = GetContainerNumSlots( blizzard_id )
				slot_id = 1
			else
				blizzard_id = nil
				slot_id = nil
				itemCount = nil
				itemLink = nil
				vendorPrice = -1
				break
			end
			
			_, itemCount, isLocked, _, _, _, itemLink, _, _, _ = GetContainerItemInfo( blizzard_id, slot_id )
			
			if not isLocked then
				
				i = player.data.location[loc_id].bag[bag_id].slot[slot_id]
				if i and i.h then
					
					local cat_id = ArkInventory.ItemCategoryGet( i )
					local cat_z, cat_code = ArkInventory.CategoryCodeSplit( cat_id )
					
					isJunk = i.q <= ArkInventory.db.option.junk.raritycutoff and codex.catset.category.junk[cat_z][cat_code] == true
					
					if isJunk then
						vendorPrice = ArkInventory.ObjectInfoVendorPrice( itemLink )
					end
					
				end
				
			end
			
		end
		
		--ArkInventory.Output( itemLink, " / ", itemCount, " / ", vendorPrice )
		return blizzard_id, slot_id, itemLink, itemCount, vendorPrice
		
	end
	
end

function ArkInventory.JunkSell( )
	
	if IsAddOnLoaded( "Scrap" ) or IsAddOnLoaded( "SellJunk" ) then
		-- do not conflict with other selling addons, they have more functionality
		return
	end
	
	ArkInventory.Global.Junk.sold = 0
	ArkInventory.Global.Junk.destroyed = 0
	ArkInventory.Global.Junk.money = 0
	
	if not ArkInventory.db.option.junk.sell then
		return
	end
	
	--ArkInventory.Output( "start amount ", GetMoney( ) )
	ArkInventory.Global.Junk.money = GetMoney( )
	
	local limit = ( ArkInventory.db.option.junk.limit and BUYBACK_ITEMS_PER_PAGE ) or 0
	
	for blizzard_id, slot_id, itemLink, itemCount, vendorPrice in ArkInventory.JunkIterate( ) do
		
		if vendorPrice > 0 then
			
			ArkInventory.Global.Junk.sold = ArkInventory.Global.Junk.sold + 1
			
			if limit > 0 and ArkInventory.Global.Junk.sold > limit then
				
				-- limited to buyback page
				if ArkInventory.db.option.junk.list then
					ArkInventory.Output( string.format( ArkInventory.Localise["CONFIG_JUNK_SELL_NOTIFY_LIMIT"], limit ) )
				end
				
				ArkInventory.Global.Junk.sold = limit
				return
				
			end
			
			if ArkInventory.db.option.junk.list then
				ArkInventory.Output( string.format( ArkInventory.Localise["CONFIG_JUNK_LIST_SELL_TEXT"], itemCount, itemLink, ArkInventory.MoneyText( itemCount * vendorPrice, true ) ) )
			end
			
			if not ArkInventory.db.option.junk.test then
				
				UseContainerItem( blizzard_id, slot_id )
				
				-- this will sometimes fail, without any notifcation, so you cant just add up the values as you go
				-- GetMoney doesnt update in realtime so also cannot be used here
				-- so next best thing, record how much money we had beforehand and how much we have at the next money update
				
			end
			
		elseif vendorPrice == 0 then
			
			if ArkInventory.db.option.junk.delete then
				
				ArkInventory.Global.Junk.destroyed = ArkInventory.Global.Junk.destroyed + 1
				
				if ArkInventory.db.option.junk.list then
					ArkInventory.Output( string.format( ArkInventory.Localise["CONFIG_JUNK_LIST_DESTROY_TEXT"], itemCount, itemLink ) )
				end
				
				if not ArkInventory.db.option.junk.test then
					
					-- might fail, might prompt user if quality is green or higher
					PickupContainerItem( blizzard_id, slot_id )
					DeleteCursorItem( )
					
				end
				
			end
			
		end
		
	end
	
	if ArkInventory.db.option.junk.test and ( ArkInventory.Global.Junk.sold > 0 or ArkInventory.Global.Junk.destroyed > 0 ) then
		ArkInventory.OutputWarning( ArkInventory.Localise["CONFIG_JUNK_TEST_ALERT"] )
	end
	
	--ArkInventory.Output( "tried to sell ", ArkInventory.Global.Junk.sold, " items" )
	-- notifcation is at EVENT_WOW_PLAYER_MONEY
	
end
