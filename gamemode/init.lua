include("shared/util.lua");
include("server/snet.lua");
include("server/data.lua");
include("server/names.lua");
include("server/skills.lua");

function GM:Initialize()
	GData.Connect("127.0.0.1", "root", "happy", "snettest", "para_");

	paraNames.LoadNames();

	PrintTable(paraSkills.SetupPlayerSkills());

	for x=1, 100 do
		print(paraNames.GenerateName(0));
	end
end

function GM:Think()
	
end