class RscTitles
{
	titles[]={};

	class Default
	{
	   idd = -1;
	   fadein = 0;
	   fadeout = 0;
	   duration = 0;
	};

	class LMBhint
	{
		idd=-1;
		movingEnable=0;
		duration=99999;
		fadein=0.3;
		fadeout=0.3;
		name="LMBhint";
		controls[]={"hintimg"};

		class hintimg
		{
			type=0;
			idc=-1;
			size=1;
			style = 0x30 + 0x800;
			colorBackground[]={0,0,0,0};
			colorText[]={1,1,1,1};
			font="PuristaMedium";
			text="rsc\rallypoint\LMB.paa";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			x = safeZoneX + safeZoneW * 0.49375;
			y = safeZoneY + safeZoneH * 0.71333334;
			w = safeZoneW * 0.0375;
			h = safeZoneH * 0.06111112;
		};
	};
};
