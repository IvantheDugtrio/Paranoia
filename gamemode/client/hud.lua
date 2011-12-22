paraHud = {};

paraHud.SUPER_SIZE = 0.05/2;			-- 3D Hud Scale (Def: 0.05)
paraHud.SUPER_DISTANCE = 25/2;			-- 3D Hud Distance (Def: 25)
paraHud.SUPER_ANGLE = 20;				-- 3D Hud Angle (Def: 20)

paraHud.SUPER_COLOR = Color(229, 178, 85, 255);

paraHud.ScreenWidth = 0;
paraHud.ScreenHeight = 0;
paraHud.ScreenFOV = 0;

-- 15 DEGREES

-- 16:9 FOV90 (2/2/1) 0.4 DIFF
-- 16:9 FOV75 (2.4/2/1)

-- 16:10 FOV90 (2.15/2/1) 0.45 DIFF
-- 16:10 FOV75 (2.6/2/1)

-- 4:3 FOV90 (2.6/2/1) 0.55 DIFF
-- 4:3 FOV75 (3.15/2/1)

function GM:HUDPaint()
	--paraHud.Health();
	--paraHud.Need();
	--paraHud.Test3D();

	paraHud.CheckDimensions();

	-- Draw 3D Hud
	cam.Start3D(EyePos(), EyeAngles())
		--paraHud.SuperHud();
	cam.End3D()
	--paraHud.GetPlayerInfo();
end

function GM:HUDShouldDraw(name)
	local draw = true;

	if(name == "CHudHealth" or name == "CHudBattery" or name == "CHudAmmo" or name == "CHudSecondaryAmmo") then
		draw = false;
	end
	
	return draw;
end

function paraHud.CheckDimensions()
	local width = ScrW();
	local height = ScrH();
	local fov = LocalPlayer():GetFOV();
	
	if(paraHud.ScreenWidth ~= width or paraHud.ScreenHeight ~= height or (fov >= 75 and paraHud.ScreenFOV ~= fov)) then
		paraHud.ChangeRatios(width, height, fov);
	end

	return;
end

function paraHud.ChangeRatios(width, height, fov)
	local fovDiff = fov - 75;

	if(width / height == 16 / 9) then
		paraHud.SUPER_SIZE = 0.05 / (2.4 - 0.4 * (fovDiff / 15));
		print("Changed to 16:9 mode!");
	elseif(width / height == 16 / 10) then
		paraHud.SUPER_SIZE = 0.05 / (2.6 - 0.45 * (fovDiff / 15));
		print("Changed to 16:10 mode!");
	else
		paraHud.SUPER_SIZE = 0.05 / (3.15 - 0.55 * (fovDiff / 15));
		print("Changed to 4:3 mode!");
	end

	paraHud.ScreenWidth = width;
	paraHud.ScreenHeight = height;
	paraHud.ScreenFOV = fov;

	return;
end

function paraHud.Health3D(pl, pos, ang)
	local health = pl:Health();
	
	cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/4 );
		draw.DrawText(health, "gab_test5", -440*4, 182*4, paraHud.SUPER_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER );
	cam.End3D2D();

	surface.SetFont("gab_test5");

	cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/2 );
		draw.DrawText("/100", "gab_test2", (-440*2)+(surface.GetTextSize(health)/2), 194*2, paraHud.SUPER_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER );
		draw.DrawText("Alien Host", "gab_test2", -440*2, 212*2, paraHud.SUPER_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER );
	cam.End3D2D();

	return;
end

function paraHud.Weapon3D(pl, pos, ang)
	local weapon = pl:GetActiveWeapon();

	if(weapon ~= nil) then
		local weaponType = weapon:GetPrintName();
		local weaponMag = weapon:Clip1();
		local weaponAmmo = pl:GetAmmoCount(weapon:GetPrimaryAmmoType());

		if(weaponMag < 0) then
			if(weaponAmmo > 0) then
				-- Basic
				cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/4 );
					draw.DrawText(weaponAmmo, "gab_test5", 440*4, 182*4, paraHud.SUPER_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER );
				cam.End3D2D();

				cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/2 );
					draw.DrawText(weaponType, "gab_test2", 440*2, 212*2, paraHud.SUPER_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER );
				cam.End3D2D();
			else
				-- Melee
				cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/2 );
					draw.DrawText(weaponType, "gab_test2", 440*2, 212*2, paraHud.SUPER_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER );
				cam.End3D2D();
			end
		elseif(weaponAmmo < 1 and weaponMag < 1) then
			-- No Ammo
			cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/2 );
				draw.DrawText(weaponType, "gab_test2", 440*2, 212*2, paraHud.SUPER_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER );
			cam.End3D2D();
		else
			-- Full

			cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/2 );
				draw.DrawText("/"..weaponAmmo, "gab_test2", 440*2, 194*2, paraHud.SUPER_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER );
				draw.DrawText(weaponType, "gab_test2", 440*2, 212*2, paraHud.SUPER_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER );
			cam.End3D2D();

			surface.SetFont("gab_test2");
			
			cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/4 );
				draw.DrawText(weaponMag, "gab_test5", (440*4)-(surface.GetTextSize("/"..weaponAmmo)*2), 182*4, paraHud.SUPER_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER );
			cam.End3D2D();
		end
	end

	return;
end

function paraHud.Need3D(pl, pos, ang)
	cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/(4*1.1) );
		draw.DrawText("KILL", "gab_test5", -460*4, -257*4, paraHud.SUPER_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP );
	cam.End3D2D();

	surface.SetFont("gab_test5");

	cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/(2*1.1) );
		draw.DrawText("10x", "gab_test2", (-458*2)+(surface.GetTextSize("PISS")/2), -255*2, paraHud.SUPER_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP );
		draw.DrawText("Need", "gab_test2", -460*2, -270*2, paraHud.SUPER_COLOR, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP );
	cam.End3D2D();
end

function paraHud.Time3D(pl, pos, ang)
	cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/(4*1.1) );
		draw.DrawText("5:12", "gab_test5", 460*4, -255*4, paraHud.SUPER_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP );
	cam.End3D2D();

	surface.SetFont("gab_test5");

	cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/(2*1.1) );
		draw.DrawText("Extraction", "gab_test2", 460*2, -270*2, paraHud.SUPER_COLOR, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP );
	cam.End3D2D();
end

function paraHud.Inventory3D(pl, pos, ang)

	cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/4 );
		draw.DrawText("1234567890", "gab_test5", 0, 300*4, paraHud.SUPER_COLOR, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER );
		surface.SetDrawColor(paraHud.SUPER_COLOR);

		surface.DrawLine(-200*4, 285*4, 200*4, 285*4); -- Top
		surface.DrawLine(-200*4, 360*4, 200*4, 360*4); -- Bottom
		surface.DrawLine(-200*4, 285*4, -200*4, 360*4); -- Left
		surface.DrawLine(200*4, 285*4, 200*4, 360*4); -- Right
	cam.End3D2D();

	return;
end

function paraHud.SuperHud()
	local pl = LocalPlayer();
	local plAng = EyeAngles();
	local plPos = EyePos();

	local pos = plPos;
	local centerAng = Angle(plAng.p, plAng.y, 0);

	pos = pos + (centerAng:Forward() * paraHud.SUPER_DISTANCE);

	centerAng:RotateAroundAxis( centerAng:Right(), 90 );
	centerAng:RotateAroundAxis( centerAng:Up(), -90 );

	local leftAng = Angle(centerAng.p, centerAng.y, centerAng.r);
	local rightAng = Angle(centerAng.p, centerAng.y, centerAng.r);

	leftAng:RotateAroundAxis( leftAng:Right(), paraHud.SUPER_ANGLE*-1 );
	rightAng:RotateAroundAxis( rightAng:Right(), paraHud.SUPER_ANGLE );

	local centerAngUp = Angle(plAng.p, plAng.y, 0);

	centerAngUp:RotateAroundAxis( centerAngUp:Right(), 98 );
	centerAngUp:RotateAroundAxis( centerAngUp:Up(), -90 );

	local leftAngUp = Angle(centerAngUp.p, centerAngUp.y, centerAngUp.r);
	local rightAngUp = Angle(centerAngUp.p, centerAngUp.y, centerAngUp.r);

	leftAngUp:RotateAroundAxis( leftAngUp:Right(), paraHud.SUPER_ANGLE*-1 );
	rightAngUp:RotateAroundAxis( rightAngUp:Right(), paraHud.SUPER_ANGLE );

	if(pl:Alive() == true and pl:Health() > 0) then
		cam.Start3D(plPos, plAng);
			cam.IgnoreZ(true);
			paraHud.Health3D(pl, pos, leftAng);
			paraHud.Weapon3D(pl, pos, rightAng);
			paraHud.Need3D(pl, pos, leftAngUp);
			paraHud.Time3D(pl, pos, rightAngUp);
			--paraHud.Inventory3D(pl, pos, centerAng);
			cam.IgnoreZ(false);
		cam.End3D();
	end
end
--hook.Add("PostDrawTranslucentRenderables","HoloHud",paraHud.SuperHud);
--hook.Add("PostDrawOpaqueRenderables","HoloHud2",paraHud.SuperHud);
hook.Add("PostDrawViewModel","HoloHud",paraHud.SuperHud);

function paraHud.Health()
	local health = LocalPlayer():Health();

	if(health > 0) then
		draw.SimpleText( "F", "gab_test4", 16, ScrH() - 16, Color(229, 178, 85,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER);
		draw.SimpleText( health.."/100", "gab_test2", 96, ScrH() - 20, Color(229, 178, 85,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM);

		--draw.RoundedBoxEx( 7, 16, ScrH() - 66, 250, 50, Color(229*0.5,178*0.5,85*0.5,150), true, true, true, true );

		--draw.RoundedBoxEx( 7, 20, ScrH() - 62, 242, 42, Color(0,0,0,200), true, true, true, true );
		--draw.RoundedBoxEx( 7, 20, ScrH() - 62, 242*(health/100), 42, Color(255*(health/100),0,0,255), true, true, true, true );
	
		--draw.SimpleText( health.."/100", "gab_test2", 141, ScrH() - 40, Color(229, 178, 85,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	end
end

function paraHud.Need()
	draw.SimpleText( "Need: KILL", "gab_test2", 16, 12, Color(229, 178, 85,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);
end

function paraHud.Time()
	
end

function paraHud.HumansWin()
	draw.SimpleText( "GHIJKLMNOPQRSTUVWXYZ", "gab_test4", ScrW()/2, ScrH() - 32, Color(229, 178, 85,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	draw.SimpleText( "- HUMANS WIN -", "gab_test3", ScrW()/2 - 512, ScrH() - 256, Color(229, 178, 85,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
end

function paraHud.AliensWin()
	draw.SimpleText( "GHIJKLMNOPQRSTUVWXYZ", "gab_test4", ScrW()/2, ScrH() - 32, Color(229, 178, 85,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	draw.SimpleText( "- ALIENS WIN -", "gab_test3", ScrW()/2 - 512, ScrH() - 256, Color(229, 178, 85,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
end

function paraHud.RandomText()
	for x=1, 100 do
		local randomNum1 = math.random(1,1000);
		local randomNum2 = math.random(-750,750);
		local randomNum3 = math.random(1,3);
		local text = "LOL";

		if(randomNum3 == 1) then
			cam.Start3D2D( pos, rightAng, 0.05/2 );
				draw.DrawText(text, "gab_test2", randomNum1, randomNum2, Color(229, 178, 85,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER );
			cam.End3D2D();
		else
			cam.Start3D2D( pos, leftAng, 0.05/2 );
				draw.DrawText(text, "gab_test2", randomNum1*-1, randomNum2, Color(229, 178, 85,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER );
			cam.End3D2D();
		end
	end
end

paraHud.testVar = 5;
function paraHud.PrintVec(vector, name)
	if(paraHud.testVar > 0) then
		print("VECTOR "..name.."\n");
		print("X: "..vector.x.."\n");
		print("Y: "..vector.y.."\n");
		print("Z: "..vector.z.."\n");

		paraHud.testVar = paraHud.testVar - 1;
	end

	return;
end

function paraHud.PrintAng(angle, name)
	if(paraHud.testVar > 0) then
		print("ANGLE "..name.."\n");
		print("R: "..angle.r.."\n");
		print("P: "..angle.p.."\n");
		print("Y: "..angle.y.."\n");

		paraHud.testVar = paraHud.testVar - 1;
	end

	return;
end

function paraHud.Test3D()
	local pl = LocalPlayer();
	local plPos = pl:GetShootPos();
	local targetPos = Vector(0,0,0);
	local hudPos = Vector(0,0,0);
	
	paraHud.PrintVec(targetPos, "targetPos");
	paraHud.PrintVec(plPos, "plPos");
	--hudPos.x = (targetPos.x * -1.0) + plPos.x;
	--hudPos.y = (targetPos.y * -1.0) + plPos.y;
	--hudPos.z = (targetPos.z * -1.0) + plPos.z;

	hudPos.x = targetPos.x - plPos.x;
	hudPos.y = targetPos.y - plPos.y;
	hudPos.z = targetPos.z - plPos.z;
	paraHud.PrintVec(hudPos, "hudPos");
	hudPos:Mul(-1);

	local hypoYaw = math.sqrt(math.pow(hudPos.x,2) + math.pow(hudPos.y,2));
	local hypoPitch = math.sqrt(math.pow(hudPos.x,2) + math.pow(hudPos.y,2));
	
	--local distance = math.sqrt(math.pow((plPos.x - targetPos.x),2) + math.pow((plPos.y - targetPos.y),2) + math.pow((plPos.z - targetPos.z),2));
	--local ratio = 5 / distance;

	--local pos = Vector(plPos.x - (plPos.x * ratio), plPos.y - (plPos.y * ratio), plPos.z - (plPos.z * ratio));
	
	local ang = Angle(0,0,0);
	-- Yaw (Left to Right) X Y
	ang.y = math.Rad2Deg(math.asin(hudPos.y / hypoYaw));
	
	if(ang.y < 0) then
		if(hudPos.x < 0) then 
			ang.y = 180.0 + math.abs(ang.y);
		else
			ang.y = ang.y + 360.0;
		end
	else
		if(hudPos.x < 0) then
			ang.y = 180.0 - ang.y;
		end
	end

	ang.y = ang.y + 90.0;

	-- Pitch (Up to Down) X Z
	ang.r = math.Rad2Deg(math.atan2(hudPos.z,hypoPitch));

	--ang.r = ang.r + 45.0;

	/*if(ang.r < 0) then
		if(hudPos.z < 0) then 
			ang.r = 180.0 + math.abs(ang.r);
		else
			ang.r = ang.r + 360.0;
		end
	else
		if(hudPos.z < 0) then
			ang.r = 180.0 - ang.r;
		end
	end*/

	print(ang.r.."\n");

	--draw.SimpleText( "pos: "..pos.x.." "..pos.y.." "..pos.z, "gab_test2", 16, 64, Color(229, 178, 85,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP);

	hudPos:Normalize();
	hudPos:Mul(-5);
	paraHud.PrintVec(hudPos, "hudPos norm");

	local pos = Vector(0,0,0)
	pos.x = plPos.x + hudPos.x;
	pos.y = plPos.y + hudPos.y;
	pos.z = plPos.z + hudPos.z;
	
	paraHud.PrintVec(pos, "pos");
	cam.Start3D2D( pos, ang, 0.009*10 );
		draw.DrawText("SUP", "gab_test1", 0, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER );
		draw.DrawText("HEY", "gab_test1", -1024, -512, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER );
		draw.DrawText("Health: ", "gab_test1", -1024, 512, Color(255, 255, 0, 255), TEXT_ALIGN_CENTER );
    cam.End3D2D();

	cam.Start3D2D( Vector(0,0,0), ang, 1.0 );
		draw.DrawText("ORIGIN", "gab_test3", 0, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER );
	cam.End3D2D();
end
--hook.Add("PostDrawTranslucentRenderables","HoloHud",paraHud.Test3D)

function paraHud.Health3D2(pl, pos, ang)
	local health = pl:Health();
	
	cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE );
		surface.SetDrawColor(Color(0, 0, 0,156));
		surface.DrawRect(-450, 150, 200, 40);

		surface.SetDrawColor(Color(229, 178, 85,255));
		surface.DrawLine(-450, 150, -250, 150); -- top
		surface.DrawLine(-450, 189, -250, 189); -- bottom
		surface.DrawLine(-450, 150, -450, 189); -- left
		surface.DrawLine(-250, 150, -250, 189); -- right

		surface.SetDrawColor(Color(255*(health/100), 0, 0,100));
		surface.DrawRect(-449, 151, 199*(health/100), 38);

		--draw.DrawText(health.."/100", "gab_test2", -410, 152, Color(229, 178, 85,255), TEXT_ALIGN_MIDDLE, TEXT_ALIGN_CENTER );
	cam.End3D2D();

	cam.Start3D2D( pos, ang, paraHud.SUPER_SIZE/4 );
		draw.DrawText(health.."/100", "gab_test5", -410*4, 152*4, Color(229, 178, 85,255), TEXT_ALIGN_MIDDLE, TEXT_ALIGN_CENTER );
	cam.End3D2D();

	return;
end