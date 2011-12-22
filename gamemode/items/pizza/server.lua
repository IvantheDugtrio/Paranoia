local OFFSETS = {};

OFFSETS.iSlices = 1;
OFFSETS.sSliceClass = 2;

local ITEM = {};

ITEM.superClass = nil;

-- Pizza-Specific Data
ITEM.data = {};

ITEM.data[OFFSETS.iSlices] = 8;
ITEM.data[OFFSETS.sSliceClass] = "PizzaSlice";

-- Global Item Info
ITEM.name = "Pizza";
ITEM.shortName = "PIZZA";
ITEM.amount = 1;
ITEM.weight = 10;
ITEM.description = "It's a pizza that can be sliced into different pieces.";
ITEM.icon = "N/A";

function ITEM:MaxAmount()
	return 100;
end

function ITEM:Transmit()
	local dataTable = {};

	return dataTable;
end

function ITEM:Remove()

end

function ITEM:Delete()

end

function ITEM:Action()
	local dataTable = {};

	return false, dataTable;
end

function ITEM:Use(pl)

end

function ITEM:Drop(pl)

end

function ITEM:Give(oldOwner, newOwner)

end

GItems.RegisterItem("Pizza", ITEM, OFFSETS);