paraGame = {};

paraGame.ROLE_HUMAN = 0;
paraGame.ROLE_ALIENHOST = 1;
paraGame.ROLE_ALIENSPAWN = 2;

paraGame.ROUND_PRE = 0;
paraGame.ROUND_INPROGRESS = 1;
paraGame.ROUND_POST = 2;

paraGame.ROUNDTIME_PRE = 30;
paraGame.ROUNDTIME_INPROGRESS = 600;
paraGame.ROUNDTIME_POST = 15;

paraGame.roundStatus = paraGame.ROUND_PRE;
paraGame.roundTime = 0;

paraGame.cleanupIgnoreEnts = {};

-- Initialization Functions


function paraGame.SetupPlayer(player)
	local plInfo = {};
	
	-- General
	plInfo.bAugmented = false;
	plInfo.iRole = paraGame.ROLE_HUMAN;
	plInfo.sName = "Joe Schmo";

	-- Needs
	plInfo.iNeed = paraNeeds.NEED_NONE;
	plInfo.iNeedTime = 0;

	-- Skills
	plInfo.skills = paraSkills.SetupPlayerSkills();

	player.para = plInfo;
end

function paraGame.StartPreRound()
	-- Reset map
	game.CleanUpMap(false, this.cleanupIgnoreEnts);
	-- Reset players

	-- Place and spawn players

	-- Set Round Status
	paraGame.roundStatus = paraGame.ROUND_PRE;
	paraGame.roundTime = paraGame.ROUNDTIME_PRE;
end

function paraGame.StartRound()

	-- Select alien hosts


	-- Set Round Status
	paraGame.roundStatus = paraGame.ROUND_INPROGRESS;
	paraGame.roundTime = paraGame.ROUNDTIME_INPROGRESS;

	return;
end

-- 
function paraGame.EndRound()
	-- Set Round Status
	paraGame.roundStatus = paraGame.ROUND_POST;
	paraGame.roundTime = paraGame.ROUNDTIME_POST;
end

-- infect a player
function paraGame.Infect()
	
end

function paraGame.NetRole(player)
	net.Start("para_plRole");
		net.WriteLong(player:UniqueID());
		net.WriteLong(player.para.iRole);
	net.Broadcast();

	return;
end

function paraGame.NetSetup(player)
	net.Start("para_plSetup");
		net.WriteLong(player:UniqueID());
		net.WriteLong(player.para.iRole);
		net.Write
	net.Broadcast();

	return;
end