class RscTitles
{
	class Default
	{
	   idd = -1;
	   fadein = 0;
	   fadeout = 0;
	   duration = 0;
	};
	class EMF_rallyPointDialog
	{
		idd = -1;
		duration = 9999;

		class ControlsBackground
		{
			class LeftMouseIcon
			{
				type = 0;
				idc = -1;
				x = safeZoneX + safeZoneW * 0.461875;
				y = safeZoneY + safeZoneH * 0.57777778;
				w = safeZoneW * 0.016875;
				h = safeZoneH * 0.03;
				style = 0+48;
				text = "rsc\rallypoint\mouse_left_ca.paa";
				colorBackground[] = {0,0,0,1};
				colorText[] = {1,1,1,1};
				font = "PuristaMedium";
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

			};
			class leftMouseDescription
			{
				type = 0;
				idc = 0;
				x = safeZoneX + safeZoneW * 0.48;
				y = safeZoneY + safeZoneH * 0.56666667;
				w = safeZoneW * 0.1125;
				h = safeZoneH * 0.05;
				style = 0;
				text = "Confirm Deployment";
				colorBackground[] = {1,1,1,0};
				colorText[] = {1,1,1,1};
				font = "PuristaMedium";
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

			};
			class rightMouseIcon
			{
				type = 0;
				idc = -1;
				x = safeZoneX + safeZoneW * 0.462;
				y = safeZoneY + safeZoneH * 0.628;
				w = safeZoneW * 0.016875;
				h = safeZoneH * 0.03;
				style = 0+48;
				text = "rsc\rallypoint\mouse_right_ca.paa";
				colorBackground[] = {0.2392,0.1333,0.4078,1};
				colorText[] = {0.7608,0.8667,0.5922,1};
				font = "PuristaMedium";
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

			};
			class rightMouseDescription
			{
				type = 0;
				idc = 0;
				x = safeZoneX + safeZoneW * 0.48;
				y = safeZoneY + safeZoneH * 0.61555556;
				w = safeZoneW * 0.1125;
				h = safeZoneH * 0.05;
				style = 0;
				text = "Cancel";
				colorBackground[] = {1,1,1,0};
				colorText[] = {1,1,1,1};
				font = "PuristaMedium";
				sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);

			};

		};
		class Controls
		{

		};
	};
	class Controls
	{

	};

};
