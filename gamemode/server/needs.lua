paraNeeds = {};

paraNeeds.NEED_NONE = 0;
paraNeeds.NEED_KILL = 1;
paraNeeds.NEED_SHOWER = 2;
paraNeeds.NEED_SLEEP = 3;
paraNeeds.NEED_PISS = 4;
paraNeeds.NEED_EAT = 5;

function paraNeeds.AssignNeed(player)
	local plInfo = player.para;

	if(plInfo.iNeed == paraNeeds.NEED_NONE) then
		plInfo.iNeed = math.random(2, 5);

		plInfo.iNeedTime = 120;
	end

	paraNeeds.NetNeed(player);

	return;
end

function paraNeeds.CheckNeed(player)

	return;
end

function paraNeeds.NetNeed(player)
	net.Start("para_plNeed");
		net.WriteLong(player.para.iNeed);
	net.Send(player);

	return;
end

function paraNeeds.NetNeedTime(player)
	net.Start("para_plNeedTime");
		net.WriteLong(player.para.iNeedTime);
	net.Send(player);

	return;
end