paraNames = {};

paraNames.firstNames = {};
paraNames.lastNames = {};

paraNames.maleNames = 0;
paraNames.femaleNames = 0;
paraNames.numFirstNames = 0;
paraNames.numLastNames = 0;

function paraNames.LoadNames()
	local result;
	local rows;
	result, rows = GData.Query("SELECT name,male,female FROM para_firstnames;");
	
	local firstName = {};

	paraNames.maleNames = 0;
	paraNames.femaleNames = 0;

	for x=1, rows do
		firstName.name = result[x][1];
		firstName.male = result[x][2];
		firstName.female = result[x][3];
		
		if(firstName.male == 1) then
			paraNames.maleNames = paraNames.maleNames + 1;
		end

		if(firstName.female == 1) then
			paraNames.femaleNames = paraNames.femaleNames + 1;
		end

		paraNames.firstNames[x] = GUtil.copy(firstName);
	end
	
	paraNames.numFirstNames = paraNames.maleNames + paraNames.femaleNames;

	result, rows = GData.Query("SELECT name FROM para_lastnames;");

	paraNames.numLastNames = 0;
	
	for x=1, rows do
		paraNames.lastNames[x] = result[x][1];
		print(paraNames.numLastNames.."\n");
		paraNames.numLastNames = paraNames.numLastNames + 1;
	end
	
	return;
end

function paraNames.GenerateName(gender)
	local firstNameId;
	local lastNameId;
	local name = "";

	if(gender == 0) then
		firstNameId = math.random(0, paraNames.maleNames-1);
	else
		firstNameId = math.random(0, paraNames.femaleNames-1);
	end
	
	for x=1, paraNames.numFirstNames do
		if(gender == 0) then
			if(paraNames.firstNames[x].male == 1) then
				if(firstNameId == 0) then
					name = name .. paraNames.firstNames[x].name;

					break;
				else
					firstNameId = firstNameId - 1;
				end
			end
		else
			if(paraNames.firstNames[x].female == 1) then
				if(firstNameId == 0) then
					name = name .. paraNames.firstNames[x].name;

					break;
				else
					firstNameId = firstNameId - 1;
				end
			end
		end
	end
	
	while true do
		lastNameId = math.random(1, paraNames.numLastNames);

		if(paraNames.lastNames[lastNameId] ~= name) then
			name = name .. " " .. paraNames.lastNames[lastNameId];

			break;
		end
	end
	
	return name;
end