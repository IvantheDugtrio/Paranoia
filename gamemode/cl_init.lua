include("client/hud.lua");

gabion = {};

local trans = 0;
local maxtrans = 180;
local oldOrigin = Vector(0,0,0);
local oldAngle = Angle(0,0,0);

surface.CreateFont("arial", 128, 550, true, false, "gab_test1", false, false, 0);
surface.CreateFont("Denton", 32, 550, true, false, "gab_test2", false, false, 0);
surface.CreateFont("Denton", 64, 550, true, false, "gab_test3", false, false, 0);
surface.CreateFont("Denton", 128, 550, true, false, "gab_test5", false, false, 0);
surface.CreateFont("csd", 80, 550, true, false, "gab_test4", false, false, 0);

/*
function MainPlayerHud()
	local ply = LocalPlayer();
	local origin = ply:GetShootPos();
	--origin = ply:EyePos();
	local angle = ply:EyeAngles();
	local health = ply:Health();
	local BoneIndx = ply:LookupBone("ValveBiped.Bip01_Head1");
	--origin = ply:GetBonePosition( BoneIndx );

	--draw.DrawText("Origin: "..origin.x.." "..origin.y.." "..origin.z, "ScoreboardText", 4, 0, Color(255, 255, 0, 255), TEXT_ALIGN_LEFT )
	
	-- MORBUS
	
	if trans < maxtrans then
		trans = math.Clamp(trans+5,0,maxtrans)
    elseif status == false && trans > 0 then
		trans = math.Clamp(trans-5,0,maxtrans)
    end

   local ftrans = 0
   local mul = math.sin(RealTime()*4)/8
   if trans > 0 then
      ftrans = math.Clamp(trans + (trans*(mul)),trans-30,trans+30)
   end

   local BoxSize = 512
   local Offset = BoxSize / 2;

   local ang = Angle((angle.p),(angle.y),0)
   local pos = origin;
   pos = origin + ang:Forward() * 15
   --pos.z = pos.z + 65;


   ang:RotateAroundAxis( ang:Right(), 90 )
   ang:RotateAroundAxis( ang:Up(), -90 )
   ang:RotateAroundAxis( ang:Right(), -20 )
	
	-- END MORBUS
	
	--pos.x = 860;
	--pos.y = -555;
	--pos.z = -143;
	
	cam.Start3D2D( pos, ang, 0.009*1000	)
		draw.DrawText("HEY", "gab_test1", -1024, -512, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER );
		draw.DrawText("Health: "..health, "gab_test1", -1024, 512, Color(255, 255, 0, 255), TEXT_ALIGN_CENTER );
		draw.DrawText(angle.x.." "..angle.y.." ", "gab_test1", 0, 0, Color(255, 255, 0, 255), TEXT_ALIGN_CENTER );
    cam.End3D2D()
	
	--gabion.OriginCam();
end

hook.Add("PostDrawOpaqueRenderables","HoloHud",MainPlayerHud)

function gabion.OriginCam()
	local CamData = {}
	CamData.angles = Angle(90,LocalPlayer():EyeAngles().yaw,0)
	CamData.origin = LocalPlayer():GetPos()+Vector(0,0,500)
	CamData.x = 0
	CamData.y = 0
	CamData.w = ScrW() / 3
	CamData.h = ScrH() / 3
	render.RenderView( CamData )
end*/

