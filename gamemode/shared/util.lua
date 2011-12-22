GUtil = {};

function GUtil.copy(object)
	local object2 = {};
	for k,v in pairs(object) do
		object2[k] = v;
	end
	
	return object2;
end