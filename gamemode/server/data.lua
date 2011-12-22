GData = {};

GData.preConnectHook = {};
GData.postConnectHook = {};

GData.preDisconnectHook = {};
GData.postDisconnectHook = {};

GData.handle = nil;
GData.handleThreaded = nil;

GData.localTablePrefix = "gbon_";
GData.remoteTablePrefix = "gbon_";

require("mysqloo");

function GData.Connect(host, user, pass, schema, prefix)
	-- Forward the Pre-Connect Call.
	local hooks = table.getn(GData.preConnectHook);
	local status;

	for x=1, hooks do
		if(GData.preConnectHook[x] ~= nil) then
			GData.preConnectHook[x]();
		end
	end

	-- Non-Threaded Connection
	GData.handle = mysqloo.connect(host, user, pass, schema, 3306);
	GData.handle:connect();

	GData.handle:wait();

	-- Threaded Connection
	GData.handleThreaded = mysqloo.connect(host, user, pass, schema, 3306);
	GData.handleThreaded:connect();
	
	GData.handleThreaded:wait();

	if(GData.handle:status() ~= 0 and GData.handleThreaded:status() ~= 0) then
		--GStats.error("[GabionRP] SQL Connection Failure.", 3);
	
		status = false;
	else
		--GStats.log("[GabionRP] SQL Connection Established.", 3);
	
		-- Give SNet the connection handle.
		SNet.setConnection(GData.handle);
	
		-- Forward the Post-Connect call.
		hooks = table.getn(GData.postConnectHook);
	
		for x=1, hooks do
			if(GData.postConnectHook[x] ~= nil) then
				GData.postConnectHook[x]();
			end
		end

		GData.remoteTablePrefix = prefix;

		status = true;
	end

	return status;
end

function GData.Disconnect()

end

function GData.ConnectHook(func, post)

end

function GData.DisconnectHook(func, post)

end

function GData.Query(statement)
	local result = nil;
	local rows = 0;

	if(GData.handle:status() == 0) then
		local query = GData.handle:query(statement);
	
		if(namedFields == nil or namedFields == false) then
			query:setOption(mysqloo.OPTION_NUMERIC_FIELDS);
			query:setOption(mysqloo.OPTION_NAMED_FIELDS, false);
		end
		
		query:start();
		query:wait();
		
		result = query:getData();
		
		if(result ~= nil) then
			rows = table.getn(result);
		end
	end
	
	return result, rows;
end

function GData.SimpleQuery(statement)

end

function GData.QueryT(statement, callback, errorcall)

end

-- void GData.SimpleQueryT(string statement)
-- Executes a threaded MySQL query.
function GData.SimpleQueryT(statement)

end

-- string GData.Escape(string var)
-- Cleans/Escapes a string for SQL injection prevention.
function GData.Escape(var)
	local cleanStr;
	
	if(var ~= nil) then
		cleanStr = GData.handle:escape(var);
	end
	
	return cleanStr;
end

-- bool GData.IsConnected()
-- Returns the status on the MySQL connection.
function GData.IsConnected()
	local connected = false;

	return connected;
end

-- string GData.Prefix(bool remote)
-- Returns the specified database table prefix.
function GData.Prefix(remote)
	local prefix = "";

	if(remote == true) then
		prefix = GData.remoteTablePrefix;
	else
		prefix = GData.localTablePrefix;
	end

	return prefix;
end