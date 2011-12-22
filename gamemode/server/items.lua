GItems = {};

GItems.item = {};
GItems.offset = {};

GItems.world = {};

function GItems.LoadItems()
	

	return;
end

function GItems.RegisterItem(classname, item, dataOffsets)
	local success = false;

	if(GItems.item[classname] == nil) then
		GItems.item[classname] = item;

		GItems.offset[classname] = dataOffsets;

		success = true;
	end

	return success;
end

function GItems.LoadWorld()

end

function GItems.SaveWorld()

end

function GItems.RemoveWorld()

end

function GItems.DeleteWorld()

end

function GItems.CreateItem()

end

function GItems.SetupItem()

end

function GItems.RemoveItem()

end

function GItems.DeleteItem()

end