-- SchmoNet Integration Script --

-- This script provides easy database integration for SchmoNet-based applications.

SNet = {};

SNet.handle = nil;

CreateConVar("sn_testmode", "0");
CreateConVar("sn_useip", "0");

-- void SNet.setConnection()
-- Gives SNet the proper connection handle in order to function properly.
function SNet.setConnection(conHandle)
	SNet.handle = conHandle;
	
	return;
end

function SNet.connect(serverId, auth)

end

-- Log a player into their appropiate SNet account.
-- Returns their account id, their root access boolean, and their "friendly" id.
function SNet.login(cl)
	local test = 0;			-- Is User Test Account?
	local ip = 0;			-- Is User IP Auth?
	local type = 0;			-- User Account Type
	local authid = "";		-- User Auth
	local fid = "";			-- User Friendly ID
	local query = "";		-- MySQL Query Var
	
	if(SinglePlayer() or GetConVarNumber("sv_lan") > 0 or GetConVarNumber("sn_testmode") > 0) then
		-- Test Account
		test = 1;
	end
	
	if(GetConVarNumber("sn_useip") > 0) then
		-- IP Auth
		ip = 2;
		
		local location = string.find(ip,':');
		authid = SNet.handle:escape(string.sub(ip,0,location-1));
	else
		authid = SNet.handle:escape(cl:SteamID());
	end
	
	local query = SNet.handle:query("SELECT id,type FROM snet_players WHERE authid = \""..authid.."\" AND type&1="..test.." AND type&2="..ip.." LIMIT 1;");
	
	query:start();
	query:wait();
	
	local result = query:getData();
	
	if(table.getn(result) < 1) then
		-- Create account.
		type = test + ip;
	
		query = SNet.handle:query("INSERT INTO snet_players (authid,type) VALUES (\""..authid.."\","..type..");");
		
		query:start();
		query:wait();
		
		query = SNet.handle:query("SELECT id FROM snet_players WHERE authid = \""..authid.."\" AND type="..type.." LIMIT 1;");
		
		query:start();
		query:wait();
		
		result = query:getData();
		
		fid = "SNID_"..type..":"..result[1]["id"];
		
		print("[SchmoNet] "..authid.." has been added to the database under "..fid..".");
	else
		-- Retrieve account info.
		type = result[1]["type"];
		
		fid = "SNID_"..type..":"..result[1]["id"];
	end
	
	
	
	print("[SchmoNet] "..authid.." has been logged in under "..fid..".");
	
	return result[1]["id"], type, fid;
end

-- Set a player's account type.  Uses a bitwise integer to store flags.
-- 1: Test Account
-- 2: IP Auth
-- 4: Root Access
function SNet.SetType(id, type)
	if(type <= 7 and type >= 0) then
		local query = SNet.handle:query("UPDATE snet_players SET type = \""..SNet.handle:escape(type).."\" WHERE id = \""..SNet.handle:escape(id).."\";");
		
		query:start();
		query:wait();
	end
	
	return;
end

function SNet.SetAuth(id, authid)
	local query = SNet.handle:query("UPDATE snet_players SET authid = \""..SNet.handle:escape(authid).."\" WHERE id =\""..SNet.handle:escape(id).."\";");
	
	query:start();
	query:wait();
	
	return;
end