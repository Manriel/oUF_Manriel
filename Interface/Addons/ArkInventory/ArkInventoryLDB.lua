local _G = _G
local select = _G.select
local pairs = _G.pairs
local ipairs = _G.ipairs
local string = _G.string
local type = _G.type
local error = _G.error
local table = _G.table


ArkInventory.LDB = {
	Bags = ArkInventory.Lib.DataBroker:NewDataObject( string.format( "%s_%s", ArkInventory.Const.Program.Name, "Bags" ), {
		type = "data source",
		icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Bag].Texture,
		text = ArkInventory.Const.Slot.Data[ArkInventory.Const.Location.Bag].name,
	} ),
	Money = ArkInventory.Lib.DataBroker:NewDataObject( string.format( "%s_%s", ArkInventory.Const.Program.Name, "Money" ), {
		type = "data source",
		icon = [[Interface\Icons\INV_Misc_Coin_02]],
		text = "Money",
	} ),
	--Companion = { },
	Pets = ArkInventory.Lib.DataBroker:NewDataObject( string.format( "%s_%s", ArkInventory.Const.Program.Name, "Pets" ), {
		type = "data source",
		icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].Texture,
		text = "",
		next = 0,
	} ),
	Mounts = ArkInventory.Lib.DataBroker:NewDataObject( string.format( "%s_%s", ArkInventory.Const.Program.Name, "Mounts" ), {
		type = "data source",
		icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Mount].Texture,
		text = "",
		next = 0,
	} ),
	Tracking_Currency = ArkInventory.Lib.DataBroker:NewDataObject( string.format( "%s_%s_%s", ArkInventory.Const.Program.Name, "Tracking", "Currency" ), {
		type = "data source",
		icon = nil,
		text = "Track Currency",
	} ),
	Tracking_Item = ArkInventory.Lib.DataBroker:NewDataObject( string.format( "%s_%s_%s", ArkInventory.Const.Program.Name, "Tracking", "Item" ), {
		type = "data source",
		icon = nil,
		text = "Track Items",
	} ),
}

local companionTable = { }



function ArkInventory.LDB.Bags:OnClick( button )
	if button == "RightButton" then
		ArkInventory.MenuLDBBagsOpen( self )
	else
		ArkInventory.Frame_Main_Toggle( ArkInventory.Const.Location.Bag )
	end
end

function ArkInventory.LDB.Bags:Update( )
	local me = ArkInventory.GetPlayerCodex( )
	local loc_id = ArkInventory.Const.Location.Bag
	--ArkInventory.LDB.Bags.icon = ArkInventory.Global.Location[loc_id].Texture
	self.text = ArkInventory.Frame_Status_Update_Empty( loc_id, me, true )
end



function ArkInventory.LDB.Money:Update( )
	self.text = ArkInventory.MoneyText( GetMoney( ) )
end

function ArkInventory.LDB.Money.OnTooltipShow( frame )
	ArkInventory.MoneyFrame_Tooltip( frame )
end



function ArkInventory.LDB.Tracking_Currency:Update( )
	
	self.text = ""
	local hasText = false
	
	local numTokenTypes = GetCurrencyListSize( )
	
	-- expand all token headers
	for j = numTokenTypes, 1, -1 do
		local name, isHeader, isExpanded = GetCurrencyListInfo( j )
		if isHeader and not isExpanded then
			ExpandCurrencyList( j, 1 )
		end
	end
	
	numTokenTypes = GetCurrencyListSize( )
	
	for j = 1, numTokenTypes do
		
		local name, isHeader, isExpanded, isUnused, isWatched, count, icon = GetCurrencyListInfo( j )
		
		if not isHeader then
			local h = GetCurrencyListLink( j )
			local osd = ArkInventory.ObjectStringDecode( h )
			local id = osd.id
			local me = ArkInventory.GetPlayerCodex( )
			if me.player.data.ldb.tracking.currency.tracked[id] then
				self.text = string.format( "%s  |T%s:0|t %s", self.text, icon or ArkInventory.Const.Texture.Missing, FormatLargeNumber( count or 0 ) )
				hasText = true
			end
		end
		
	end
	
	if hasText then
		self.text = string.trim( self.text )
	else
		self.text = string.format( "|T%s:0|t", ArkInventory.Global.Location[ArkInventory.Const.Location.Token].Texture )
	end
	
end

function ArkInventory.LDB.Tracking_Currency.OnClick( frame, button )
	if button == "RightButton" then
		ArkInventory.MenuLDBTrackingCurrencyOpen( frame )
	else
		ArkInventory.Frame_Main_Toggle( ArkInventory.Const.Location.Token )
	end
end

function ArkInventory.LDB.Tracking_Currency:OnTooltipShow( )
	
	self:AddLine( string.format( "%s: %s", ArkInventory.Localise["TRACKING"], ArkInventory.Localise["LDB_TRACKING_CURRENCY"] ) )
	
	local numTokenTypes = GetCurrencyListSize( )
	
	-- expand all currency headers
	for j = numTokenTypes, 1, -1 do
		name, isHeader, isExpanded = GetCurrencyListInfo( j )
		if isHeader and not isExpanded then
			ExpandCurrencyList( j, 1 )
		end
	end
	
	numTokenTypes = GetCurrencyListSize( )
	
	for j = 1, numTokenTypes do
		
		local name, isHeader, isExpanded, isUnused, isWatched, count, icon, maximum, hasWeeklyLimit, weeklyCount, unknown = GetCurrencyListInfo( j )
		--ArkInventory.Output( { GetCurrencyListInfo( j ) } )
		
		-- local name, amount, texturePath, earnedThisWeek, weeklyMax, totalMax, isDiscovered, quality = GetCurrencyInfo(id)
		
		if isHeader then
			self:AddLine( " " )
			self:AddLine( name )
		else
			
			local h = GetCurrencyListLink( j )
			local osd = ArkInventory.ObjectStringDecode( h )
			local id = osd.id
			local me = ArkInventory.GetPlayerCodex( )
			
			local txt = FormatLargeNumber( count )
			
			if maximum and maximum > 0 then
				txt = string.format( "%s/%s", FormatLargeNumber( count ), FormatLargeNumber( maximum ) )
			end
			
			if me.player.data.ldb.tracking.currency.tracked[id] then
				self:AddDoubleLine( name, txt, 0, 1, 0, 0, 1, 0 )
			else
				self:AddDoubleLine( name, txt, 1, 1, 1, 1, 1, 1 )
			end
			
			if hasWeeklyLimit and weeklyCount and weeklyCount > 0 then
				
				--txt = string.format( "%s/%s", FormatLargeNumber( weeklyCount ), FormatLargeNumber( hasWeeklyLimit ) )
				txt = string.format( "%s/???", FormatLargeNumber( weeklyCount ) )
				
				if me.player.data.ldb.tracking.currency.tracked[id] then
					self:AddDoubleLine( string.format( "  * %s", ArkInventory.Localise["WEEKLY"] ), txt, 0, 1, 0, 0, 1, 0 )
				else
					self:AddDoubleLine( string.format( "  * %s", ArkInventory.Localise["WEEKLY"] ), txt, 1, 1, 1, 1, 1, 1 )
				end
				
			end
			
		end
		
	end
	
	self:Show( )
	
end



function ArkInventory.LDB.Tracking_Item:Update( )
	
	self.text = ""
	local hasText = false
	local me = ArkInventory.GetPlayerCodex( )
	for k in ArkInventory.spairs( ArkInventory.db.option.tracking.items )  do
		if me.player.data.ldb.tracking.item.tracked[k] then
			local count = GetItemCount( k, true )
--[[
			if ( k == 6265 ) then
				-- soul shards for cataclysm
				count = UnitPower( "player", 7 ) or 0
			end
]]--
			local icon = select( 10, GetItemInfo( k ) )
			self.text = string.format( "%s  |T%s:0|t %s", self.text, icon or ArkInventory.Const.Texture.Missing, FormatLargeNumber( count or 0 ) )
			hasText = true
		end
	end
	
	if hasText then
		self.text = string.trim( self.text )
	else
		self.text = string.format( "|T%s:0|t", [[Interface\Icons\Ability_Tracking]] )
	end
	
end

function ArkInventory.LDB.Tracking_Item:OnClick( button )
	if button == "RightButton" then
		ArkInventory.MenuLDBTrackingItemOpen( self )
	end
end

function ArkInventory.LDB.Tracking_Item:OnTooltipShow( )
	
	self:AddLine( string.format( "%s: %s", ArkInventory.Localise["TRACKING"], ArkInventory.Localise["ITEMS"] ) )
	
	self:AddLine( " " )
	
	local me = ArkInventory.GetPlayerCodex( )
	for k in ArkInventory.spairs( ArkInventory.db.option.tracking.items )  do
		
		local count = GetItemCount( k, true )
--[[
		if k == 6265 then
			-- soul shards for cataclysm
			count = UnitPower( "player", 7 ) or 0
		end
]]--
		local name = GetItemInfo( k )
		
		local checked = me.player.data.ldb.tracking.item.tracked[k]
		
		if checked then
			self:AddDoubleLine( name, count, 0, 1, 0, 0, 1, 0 )
		else
			self:AddDoubleLine( name, count, 1, 1, 1, 1, 1, 1 )
		end
		
	end
	
	self:Show( )
	
end



function ArkInventory.LDB.Pets.Cleanup( )
	
	if ArkInventory.Collection.Pet.IsReady( ) then
		
		-- check for and remove any selected companions we no longer have (theyve either been caged or released)
		local me = ArkInventory.GetPlayerCodex( )
		local selected = me.player.data.ldb.pets.selected
		for k, v in pairs( selected ) do
			if v ~= nil and not ArkInventory.Collection.Pet.GetPet( k ) then
				selected[k] = nil
				--ArkInventory.Output( "removing selected pet we dont have any more - ", k )
			end
		end
		
--[[
		-- if all companions are selected then deselect them all
		local selected = me.player.data.ldb.pets.selected
		local n1 = ArkInventory.Collection.Pet.GetCount( )
		local n2 = ArkInventory.Table.Elements( selected )
		
		--ArkInventory.Output( "pet / ", n1, " / ", n2, " / ", selected )
		
		if n1 == n2 then
			for k, v in pairs( selected ) do
				if v == true then
					selected[k] = nil
				end
			end
		end
]]--
		
	end
	
end

function ArkInventory.LDB.Pets.BuildList( ignoreActive )
	
	table.wipe( companionTable )
	
	if not ArkInventory.Collection.Pet.IsReady( ) then
		return
	end
	
	local n = ArkInventory.Collection.Pet.GetCount( )
	--ArkInventory.Output( "pet count = ", n )
	if n == 0 then return end
	
	local me = ArkInventory.GetPlayerCodex( )
	local selected = me.player.data.ldb.pets.selected
	local selectedCount = 0
	for k, v in pairs( selected ) do
		if v == true then
			selectedCount = selectedCount + 1
		end
	end
	
	if selectedCount < 2 then
		ignoreActive = true
	end
	
	--ArkInventory.Output( "count = ", selectedCount, ", selected = ", selected )
	
	local count = 0
	local _, _, activePet = ArkInventory.Collection.Pet.GetCurrent( )
	local activeSpecies = activePet and activePet.sd.speciesID
	
	for index, pd in ArkInventory.Collection.Pet.Iterate( ) do
		if ( not activePet or ignoreActive ) and ( pd.sd.speciesID ~= activeSpecies ) and ( selectedCount == 0 or selected[index] == true ) and ArkInventory.Collection.Pet.CanSummon( pd.guid ) then
			-- cannot be same current species as active pet, if one was active
			-- must be summonable
			if selected[index] == false then
				-- never summon
			else
				count = count + 1
				companionTable[count] = index
			end
		end
	end
	
end

function ArkInventory.LDB.Pets:Update( )
	
	ArkInventory.LDB.Pets.Cleanup( )
	
	local total = ArkInventory.Collection.Pet.GetCount( )
	
	if total < 1 then
		self.icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Pet].Texture
		return
	end
	
	local me = ArkInventory.GetPlayerCodex( )
	local selected = me.player.data.ldb.pets.selected
	local count = ArkInventory.Table.Elements( selected )
	
	if count == 0 then
		--all companions
		self.icon = [[Interface\Icons\INV_Misc_Dice_01]]
		return
	end
	
	if count > 1 then
		-- partial selection
		self.icon = [[Interface\Icons\INV_Misc_Dice_02]]
		return
	end
	
	-- just one
	for k, v in pairs( selected ) do
		if v then
			local pd = ArkInventory.Collection.Pet.GetPet( k )
			self.icon = pd.sd.icon
			return
		end
	end
	
end

function ArkInventory.LDB.Pets:OnTooltipShow( )
	
	if not ArkInventory.Collection.Pet.IsReady( ) then
		self:AddLine( "journal not ready", 1, 0, 0 )
		return
	end
	
	self:AddDoubleLine( MODE, ArkInventory.Localise["SELECTION"] )
	
	local total = ArkInventory.Collection.Pet.GetCount( )
	
	if total < 1 then
		self:AddDoubleLine( ArkInventory.Localise["PET"], ArkInventory.Localise["LDB_COMPANION_NONE"], 1, 1, 1, 1, 1, 1 )
		return
	end
	
	local me = ArkInventory.GetPlayerCodex( )
	local selected = me.player.data.ldb.pets.selected
	local count = ArkInventory.Table.Elements( selected )
	local selectedCount = 0
	for k, v in pairs( selected ) do
		if v == true then
			selectedCount = selectedCount + 1
		end
	end
	
	if count == 0 then
		
		self:AddDoubleLine( ArkInventory.Localise["PET"], string.format( "%s (%s)", ArkInventory.Localise["ALL"], total ), 1, 1, 1, 1, 1, 1 )
		
	elseif selectedCount == 1 then
		
		-- just the one selected, there may be ignored but they dont matter
		for k, v in pairs( selected ) do
			if v == true then
				local pd = ArkInventory.Collection.Pet.GetPet( k )
				local name = pd.sd.name
				if pd.cn and pd.cn ~= "" then
					name = string.format( "%s (%s)", name, pd.cn )
				end
				self:AddDoubleLine( ArkInventory.Localise["PET"], string.format( "%s: %s", ArkInventory.Localise["SELECTION"], name ), 1, 1, 1, 1, 1, 1 )
			end
		end
	
	else
	
		-- random selection, possibly some ignored
		
		if selectedCount == 0 then
			-- none selected so must be ignored
			self:AddDoubleLine( ArkInventory.Localise["PET"], string.format( "%s (%s %s)", ArkInventory.Localise["ALL"], ArkInventory.Localise["IGNORE"], count - selectedCount ), 1, 1, 1, 1, 1, 1 )
		else
			-- more than one selected, there may be ignored but they dont matter
			self:AddDoubleLine( ArkInventory.Localise["PET"], string.format( "%s (%s)", ArkInventory.Localise["SELECTION"], selectedCount ), 1, 1, 1, 1, 1, 1 )
		end
		
	end

end

function ArkInventory.LDB.Pets:OnClick( button )
	
	if not ArkInventory.Collection.Pet.IsReady( ) then
		return
	end
	
	if IsModifiedClick( "CHATLINK" ) then
		-- dismiss current pet
		ArkInventory.Collection.Pet.Dismiss( )
		return
	end
	
	ArkInventory.LDB.Pets:Update( )
	
	if button == "RightButton" then
		
		ArkInventory.MenuLDBPetsOpen( self )
		
	else
		
		if ArkInventory.Collection.Pet.GetCount( ) == 0 then
			ArkInventory.Output( string.format( ArkInventory.Localise["NONE_OWNED"], ArkInventory.Localise["PETS"] ) )
			return
		end
		
		ArkInventory.LDB.Pets.BuildList( true )
		
		--ArkInventory.Output( #companionTable, " usable pets" )
		
		if #companionTable == 0 then
			
			ArkInventory.Output( string.format( ArkInventory.Localise["NONE_USABLE"], ArkInventory.Localise["PETS"] ) )
			return
			
		else
			
			local me = ArkInventory.GetPlayerCodex( )
			local userandom = me.player.data.ldb.pets.randomise
			
			if #companionTable <= 3 then
				userandom = false
			end
			
			if userandom then
				ArkInventory.LDB.Pets.next = random( 1, #companionTable )
			else
				ArkInventory.LDB.Pets.next = ArkInventory.LDB.Pets.next + 1
				if ArkInventory.LDB.Pets.next > #companionTable then
					ArkInventory.LDB.Pets.next = 1
				end
			end
			
			--ArkInventory.Output( ArkInventory.LDB.Pets.next, " = ", companionTable[ArkInventory.LDB.Pets.next] )
			ArkInventory.Collection.Pet.Summon( companionTable[ArkInventory.LDB.Pets.next] )
			
		end
		
	end
	
end



function ArkInventory.LDB.Mounts.Cleanup( )
	
	-- remove any selected mounts we no longer have (not sure how but just in case)
	
	if ArkInventory.Collection.Mount.IsReady( ) then
		
		--ArkInventory.Output( "mount journal ready" )
		
		local me = ArkInventory.GetPlayerCodex( )
		
		for mta, mt in pairs( ArkInventory.Const.MountTypes ) do
			
			if mta ~= "x" then
				
				local selected = me.player.data.ldb.mounts.type[mta].selected
				
				for spell, value in pairs( selected ) do
					local md = ArkInventory.Collection.Mount.GetMountBySpell( spell )
					if value ~= nil and not md then
						ArkInventory.OutputWarning( "removing a selected mount [", spell, "] as you dont have it any more" )
						selected[spell] = nil
					elseif md and md.mt ~= mt then
						ArkInventory.OutputWarning( "removing a selected mount ", md.link, " that has changed type" )
						selected[spell] = nil
					end
				end
				
			end
			
		end
		
	else
		--ArkInventory.Output( "mount journal NOT ready" )
	end
	
end

function ArkInventory.LDB.Mounts.IsFlyable( )
	
	if IsIndoors( ) or ArkInventory.Collection.Mount.SkillLevel( ) < 225 then
		return false
	end
	
	local IsFlyable = IsFlyableArea( )  -- its dynamic based off skill and location but its got some issues.  its usually only wrong about flying zones but it got worse in 7.3.5
	
	--local name, instanceType, difficulty, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, instanceMapId, instanceGroupSize, lfgID = GetInstanceInfo( )
	local imid = select( 8, GetInstanceInfo( ) )
	--ArkInventory.OutputDebug( "instance map id [", imid, "]" )
	
	local flyreq = {
		["never"] = {
			[1191] = true, -- Ashran (PvP)
			[1265] = true, -- Tanaan Jungle Intro
			[1463] = true, -- Helheim Exterior Area
			[1669] = true, -- Argus
			
			[1107] = true, -- Dreadscar Rift (Warlock)
			[1469] = true, -- The Heart of Azeroth (Shaman)
			[1479] = true, -- Skyhold (Warrior)
			[1514] = true, -- The Wandering Isle (Monk)
			[1519] = true, -- The Fel Hammer (Demon Hunter)
			
			[1557] = true, -- Class Trial Boost
		},
		["achieve"] = {
			[1116] = 10018, -- Draenor / Draenor Pathfinder
			[1464] = 10018, -- Tanaan Jungle
			[1152] = 10018, -- Horde Garrison Level 1
			[1330] = 10018, -- Horde Garrison Level 2
			[1153] = 10018, -- Horde Garrison Level 3
			[1154] = 10018, -- Horde Garrison Level 4
			[1158] = 10018, -- Alliance Garrison Level 1
			[1331] = 10018, -- Alliance Garrison Level 2
			[1159] = 10018, -- Alliance Garrison Level 3
			[1160] = 10018, -- Alliance Garrison Level 4
			
			[1220] = 11446, -- Broken Isles / Broken Isles Pathfinder Part 2
		},
		["spell"] = {
			
		},
		["bug735"] = {
			[0] = true, -- Eastern Kingdoms
			[1] = true, -- Kalimdor
--			[530] = true, -- Outland (appears to be working now)
			[571] = true, -- Northrend
			[730] = true, -- Maelstrom (Deepholm)
--			[870] = true, -- Pandaria (appears to be working now)
		},
	}
	
	if IsFlyable then
		
		--ArkInventory.Output( "blizzard says this is a flyable area" )
		
		if flyreq.never[imid] then
			
			IsFlyable = false
			
		elseif flyreq.achieve[imid] then
			
			local known = select( 4, GetAchievementInfo( flyreq.achieve[imid] ) )
			
			if not known then
				
				--ArkInventory.Output( imid, " but you dont have the achievement ", flyreq.achieve[imid] )
				IsFlyable = false
				
			end
			
		elseif flyreq.spell[imid] then
			
			local known = IsSpellKnown( flyreq.spell[imid] )
			
			if not known then
				
				--ArkInventory.Output( imid, " but you dont have the spell ", flyreq.achieve[imid] )
				IsFlyable = false
				
			end
			
		end
		
	else
		
		--ArkInventory.Output( "blizzard says this is NOT a flyable area" )
		
		-- /run ArkInventory.Output(IsFlyableArea())
		-- /run ArkInventory.Output({GetInstanceInfo()})
		
		if flyreq.bug735[imid] then
			--ArkInventory.Output( "Overriding blizzard IsFlyableArea, you can fly here" )
			IsFlyable = true
		end
		
	end
	
	if IsFlyable then
		
		-- world pvp battle in progress?
		
		for index = 1, GetNumWorldPVPAreas( ) do
			
			local pvpID, pvpZone, isActive = GetWorldPVPAreaInfo( index )
			--ArkInventory.Output( pvpID, " / ", pvpZone, " / ", isActive )
			
			if isActive and GetRealZoneText( ) == pvpZone then
				-- ArkInventory.Output( "battle in progress, no flying allowed" )
				IsFlyable = false
				break
			end
			
		end
		
	end
	
	return IsFlyable
	
end



local function helper_companionTable_update( tbl )
	
	if type( tbl ) ~= "table" then return end
	
	local count = #companionTable
	
	for index, md in pairs( tbl ) do
		count = count + 1
		companionTable[count] = md.index
	end
	
end

function ArkInventory.LDB.Mounts.GetUsable( forceAlternative )
	
	-- builds companionTable and returns the type
	
	wipe( companionTable )
	
	if not ArkInventory.Collection.Mount.IsReady( ) then return end
	
	ArkInventory.Collection.Mount.UpdateUsable( )
	
	if IsSwimming( ) then
		if not forceAlternative then
			--ArkInventory.Output( "check underwater" )
			if ArkInventory.Collection.Mount.GetCount( "u" ) > 0 then
				helper_companionTable_update( ArkInventory.Collection.Mount.usable["u"] )
				return "u"
			end
			--ArkInventory.Output( "check surface" )
			if ArkInventory.Collection.Mount.GetCount( "s" ) > 0 then
				helper_companionTable_update( ArkInventory.Collection.Mount.usable["s"] )
				return "s"
			end
		else
			--ArkInventory.Output( "ignore underwater, force flying" )
		end
	end
	
	if ArkInventory.LDB.Mounts.IsFlyable( ) then
		--ArkInventory.Output( "can fly here" )
		if ( not forceAlternative ) or ( forceAlternative and IsSwimming( ) ) then
			--ArkInventory.Output( "check flying" )
			if ArkInventory.Collection.Mount.GetCount( "a" ) > 0 then
				helper_companionTable_update( ArkInventory.Collection.Mount.usable["a"] )
				return "a"
			end
		else
			--ArkInventory.Output( "ignore flying, force land" )
		end
	end
	
	--ArkInventory.Output( "check land" )
	if ArkInventory.Collection.Mount.GetCount( "l" ) > 0 then
		
		helper_companionTable_update( ArkInventory.Collection.Mount.usable["l"] )
		
		local me = ArkInventory.GetPlayerCodex( )
		
		if me.player.data.ldb.mounts.type.l.usesurface and ArkInventory.Collection.Mount.GetCount( "s" ) > 0 then
			helper_companionTable_update( ArkInventory.Collection.Mount.usable["s"] )
		end
		
		if me.player.data.ldb.mounts.type.l.useflying and ArkInventory.Collection.Mount.GetCount( "a" ) > 0 then
			helper_companionTable_update( ArkInventory.Collection.Mount.usable["a"] )
		end
		
		return "l"
		
	end
	
	--fallback
	
--	if ArkInventory.db.option.message.mount.warnings then
--		ArkInventory.OutputWarning( "no land mounts available, checking surface mounts for fallback" )
--	end
	if ArkInventory.Collection.Mount.GetCount( "s" ) > 0 then
		helper_companionTable_update( ArkInventory.Collection.Mount.usable["s"] )
		return "s"
	end
	
--	if ArkInventory.db.option.message.mount.warnings then
--		ArkInventory.OutputWarning( "no land mounts available, checking flying mounts for fallback" )
--	end
	if ArkInventory.Collection.Mount.GetCount( "a" ) > 0 then
		helper_companionTable_update( ArkInventory.Collection.Mount.usable["a"] )
		return "a"
	end
	
--	if ArkInventory.db.option.message.mount.warnings then
--		ArkInventory.OutputWarning( "no land or flying mounts available, checking underwater mounts for fallback" )
--	end
	if ArkInventory.Collection.Mount.GetCount( "u" ) > 0 then
		helper_companionTable_update( ArkInventory.Collection.Mount.usable["u"] )
		return "u"
	end
	
end

function ArkInventory.LDB.Mounts:Update( )
	
	ArkInventory.LDB.Mounts.Cleanup( )
	
	ArkInventory.LDB.Mounts.IsFlyable( )
	
	local mountType = ArkInventory.LDB.Mounts.GetUsable( )
	
	if not mountType then
		-- no usable mounts
		self.icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Mount].Texture
		return
	end
	
	local numusable, numtotal = ArkInventory.Collection.Mount.GetCount( mountType )
	
	--ArkInventory.Output( mountType, " / ", #companionTable, " / ", total )
	
	if numtotal < 1 then
		self.icon = ArkInventory.Global.Location[ArkInventory.Const.Location.Mount].Texture
		return
	end
	
	local me = ArkInventory.GetPlayerCodex( )
	
	local useall = me.player.data.ldb.mounts.type[mountType].useall
	
	local selected = me.player.data.ldb.mounts.type[mountType].selected
	local numselected = 0
	for k, v in pairs( selected ) do
		if v == true then
			numselected = numselected + 1
		end
	end
	
	if useall or numselected == 0 then
		-- all mounts
		self.icon = [[Interface\Icons\INV_Misc_Dice_01]]
		return
	end
	
	if numselected > 1 then
		-- partial selection
		self.icon = [[Interface\Icons\INV_Misc_Dice_02]]
		return
	end
	
	-- single mount
	for k, v in pairs( selected ) do
		if v then
			self.icon = select( 3, GetSpellInfo( k ) )
			return
		end
	end
	
end

function ArkInventory.LDB.Mounts:OnTooltipShow( ... )
	
	if not ArkInventory.Collection.Mount.IsReady( ) then
		self:AddLine( "journal not ready", 1, 0, 0 )
		return
	end
	
	ArkInventory.Collection.Mount.UpdateUsable( )
	
	self:AddDoubleLine( MODE, ArkInventory.Localise["SELECTION"] )
	
	local me = ArkInventory.GetPlayerCodex( )
	
	for mta in pairs( ArkInventory.Const.MountTypes ) do
		
		local mode = ArkInventory.Localise[string.upper( string.format( "LDB_MOUNTS_TYPE_%s", mta ) )]
		local numusable, numtotal = ArkInventory.Collection.Mount.GetCount( mta )
		
		--ArkInventory.Output( mta, " / ", mode, " / ", numusable, " / ", numtotal )
		
		if mta ~= "x" then
			
			if numtotal == 0 then
				
				self:AddDoubleLine( mode, ArkInventory.Localise["NONE"], 1, 1, 1, 1, 0, 0 )
				
			else
				
				local selected = me.player.data.ldb.mounts.type[mta].selected
				local numselected = 0
				for k, v in pairs( selected ) do
					if v == true then
						numselected = numselected + 1
					end
				end
				
				if me.player.data.ldb.mounts.type[mta].useall then
					
					self:AddDoubleLine( mode, string.format( "%s (%s)", ArkInventory.Localise["ALL"], numtotal ), 1, 1, 1, 1, 1, 1 )
					
				elseif numselected == 0 then
					
					self:AddDoubleLine( mode, ArkInventory.Localise["NONE"], 1, 1, 1, 1, 1, 1 )
					
				elseif numselected == 1 then
					
					-- just the one selected, there may be ignored but they dont matter
					for k, v in pairs( selected ) do
						if v then
							local name = GetSpellInfo( k )
							self:AddDoubleLine( mode, string.format( "%s: %s", ArkInventory.Localise["SELECTION"], name ), 1, 1, 1, 1, 1, 1 )
						end
					end
					
				else
					
					-- more than one selected, there may be ignored but they dont matter
					self:AddDoubleLine( mode, string.format( "%s (%s/%s)", ArkInventory.Localise["SELECTION"], numselected, numtotal ), 1, 1, 1, 1, 1, 1 )
					
				end
				
			end
			
		end
		
	end
	
end

function ArkInventory.LDB.Mounts:OnClick( button )
	
	if button == "RightButton" then
		
		ArkInventory.MenuLDBMountsOpen( self )
		
	else
		
		if UnitInVehicle( "player" ) then return end
		
		if IsIndoors( ) then
			-- you shouldnt be able to mount here at all
			ArkInventory.Output( ArkInventory.Localise["LDB_MOUNTS_NOT_HERE"] )
			return
		end
		
		local me = ArkInventory.GetPlayerCodex( )
		
		if IsMounted( ) then
			
			if IsFlying( ) then
				if not me.player.data.ldb.mounts.type.a.dismount then
					ArkInventory.OutputWarning( ArkInventory.Localise["LDB_MOUNTS_FLYING_DISMOUNT_WARNING"] )
					return
				end
			end
			
			ArkInventory.Collection.Mount.Dismiss( )
			
			return
			
		end
		
		if InCombatLockdown( ) or IsFlying( ) or not ArkInventory.Collection.Mount.IsReady( ) then return end
		
		if ArkInventory.Collection.Mount.GetCount( ) == 0 then
			--ArkInventory.Output( "you don't own any mounts" )
			return
		end
		
		local forceAlternative = IsModifiedClick( "CHATLINK" )
		ArkInventory.LDB.Mounts.GetUsable( forceAlternative )
		
		--ArkInventory.Output( #companionTable, " usable mounts", companionTable )
		
		if #companionTable == 0 then
			
			ArkInventory.Output( string.format( ArkInventory.Localise["NONE_USABLE"], ArkInventory.Localise["MOUNTS"] ) )
			return
			
		else
			
			local userandom = me.player.data.ldb.mounts.randomise
			
			if #companionTable <= 3 then
				userandom = false
			end
			
			if userandom then
				-- random
				ArkInventory.LDB.Mounts.next = random( 1, #companionTable )
			else
				-- cycle
				ArkInventory.LDB.Mounts.next = ArkInventory.LDB.Mounts.next + 1
				if ArkInventory.LDB.Mounts.next > #companionTable then
					ArkInventory.LDB.Mounts.next = 1
				end
			end
			
			local i = companionTable[ArkInventory.LDB.Mounts.next]
			--local md = ArkInventory.Collection.Mount.GetMount( i )
			--ArkInventory.Output( "use mount ", i, ": ", md.link, " ", ArkInventory.LDB.Mounts.next, " / ", #companionTable, " / usable=", (IsUsableSpell( md.spell )), " / flight=", IsFlyableArea( ) )
			ArkInventory.Collection.Mount.Summon( i )
		end
		
	end
	
end
