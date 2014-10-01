function AssembleTargetName(TargetName, TargetRealm)
	if TargetRealm == nil then
		TargetRealm = "";
	else
		TargetRealm = "-"..TargetRealm;
	end;
	return TargetName..TargetRealm;
end

function TargetIsMe(TargetName)
	return (IsAltKeyDown() or TargetName == nil or UnitIsUnit("player", "target"));
end

function TargetIsOtherFriendlyPlayer(TargetName)
	return (
		not TargetIsMe(TargetName)
		and UnitPlayerControlled("target") == 1
		and UnitIsFriend("player", "target") == 1
	);
end

function WTT(msg)
	TargetName,TargetRealm = UnitName("target");
	if TargetIsOtherFriendlyPlayer(TargetName) then
		TargetFullName = AssembleTargetName(TargetName, TargetRealm);
		SendChatMessage(msg, "WHISPER", "common", TargetFullName);
	end
end

function Res()
  TargetName,TargetRealm = UnitName("target"); 
  if (TargetName) then 
    genitive, dative, accusative, instrumental, prepositional = DeclineName (TargetName, UnitSex("target"), 1);
	if UnitIsDead("target") then
    	  SendChatMessage("Воскрешаю ".. accusative .."!", "YELL", nil, TargetName); 
	end
  end
end

--  does not works
-- function ChakraSelfCast()
--  if TargetIsMe("target") then
--   RunMacroText("/cast Чакра")
--  elseif TargetIsOtherFriendlyPlayer("target") then
--   RunMacroText("/cast Духовное рвение")
--  end
-- end

