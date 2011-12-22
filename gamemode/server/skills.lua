paraSkills = {};

include("../shared/skills.lua");
AddCSLuaFile("./shared/skills.lua");

function paraSkills.SetupPlayerSkills()
	local plSkills = {};
	
	-- Offensive Skills (Lv. 1)
	plSkills[paraSkills.SHARPENEDCLAWS] = 0;		-- Attack Damage (5 Total)
	plSkills[paraSkills.VENOM] = 0;					-- Poison Damage (3 Total)
	plSkills[paraSkills.EXHAUST] = 0;				-- Reduce Need Time (2 Total)

	-- Offsensive Skills (Lv. 2)
	plSkills[paraSkills.ENHANCEDREFLEXES] = 0;		-- Attack Speed (3 Total)
	plSkills[paraSkills.BLOODTHIRST] = 0;			-- Vampiric Regeneration (3 Total)
	plSkills[paraSkills.ENHANCEDSENSES] = 0;		-- Increased Detection Range (2 Total)

	-- Defensive Skills (Lv. 1)
	plSkills[paraSkills.HARDENEDCARAPACE] = 0;		-- Armor (5 Total)
	plSkills[paraSkills.REGENERATIVETISSUE] = 0;	-- HP Regen (5 Total)
	plSkills[paraSkills.REINFORCEDSCALES] = 0;		-- Pistol Rounds Armor (1 Total)

	-- Defensive Skills (Lv. 2)
	plSkills[paraSkills.REINFORCEDSKELETON] = 0;	-- Rifle/Buckshot Rounds Armor (1 Total)
	plSkills[paraSkills.ENDURANCE] = 0;				-- Increased Health (4 Total)

	-- Stealth Skills (Lv. 1)
	plSkills[paraSkills.ADRENALINEGLANDS] = 0;		-- Run Speed (5 Total)
	
	-- Stealth Skills (Lv. 2)
	plSkills[paraSkills.SILENTBREATHING] = 0;		-- Silent Alien Form (1 Total)
	plSkills[paraSkills.ADAPTIVECARAPACE] = 0;		-- Cloaking (3 Total)

	return plSkills;
end

function paraSkills.NetSkill(player, skillId) 
	net.Start("para_plSkill");
		net.WriteLong(skillId);
		net.WriteLong(player.para.skills[skillId]);
	net.Send(player);

	return;
end