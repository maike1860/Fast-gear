//by 啤酒冲米二 2017.03.03

#define ym_Gear_Button1_x1 -0.059 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH))
#define ym_Gear_Button1_x2 0.068 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH))
#define ym_Gear_Button1_x3 0.196 + (6.25 / 40) + (1 / 250 / (safezoneW / safezoneH))
#define ym_Gear_Button_y1 0.1
#define ym_Gear_Button_w1 (11.36 / 91)
#define ym_Gear_Button_w2 (11.36 / 92)

class ym_Gear_List {
	idd = 1543637;
	name= "YMGearList";
	movingEnable = 1;
	enableSimulation = true;
	onLoad = "";
	
	class controlsBackground {
		class ym_Gear_Background : A3_RscText_1 {
			colorBackground[] = {0.1,0.15,0,0.5};
			idc = -1;
			x = 0.1;
			y = 0.2
			w = 0.379;
			h = 0.785;
			moving = 1;
		};
	};
	
	class controls {

		class ym_Gear_Title : A3_RscTitle_1 {
			colorBackground[] = {0,0,0,0.9};
			idc = 3647;
			text = "";
			x = 0.1;
			y = 0.2;
			w = 0.379;
			h = (1 / 25);
			moving = 1;
		};
		
		class ym_Gear_List : A3_RscListBox_1 { //列表
			idc = 15438;
			colorBackground[] = {0,0,0,0};
			colorSelect[] = {0,0,0,1};//
			colorSelect2[] = {0,0,0,1};//
			colorSelectBackground[] = {1,1,1,0.8};
			colorSelectBackground2[] = {1,1,1,0.3};
			text = "";
			sizeEx = 0.030;
			onLBSelChanged = "";
			x = 0.13; y = 0.26;
			w = 0.32; h = 0.64;//
		};

		class ym_Gear_Button1 : A3_RscButtonMenu_1 {
			idc = 203;
			text = "$STR_Gear_Loadout_军火库";
			tooltip = "$STR_Gear_Loadout_到军火库中选取";
			x = ym_Gear_Button1_x1;
			y = 0.803 + ym_Gear_Button_y1;
			w = ym_Gear_Button_w1;
			h = (1 / 25);
			action = "if(isNull gear_tag_obj || {!alive gear_tag_obj})exitWith{hint localize 'STR_Gear_Loadout_目标单位无效'}; if(gear_tag_obj != player && {isPlayer gear_tag_obj})exitWith{hint localize 'STR_Gear_Loadout_该单位是在线玩家无法使用'}; edit_loadout = 1;";
		};
		
		class ym_Gear_Button2 : A3_RscButtonMenu_1 {
			idc = 5439;
			text = "$STR_Gear_Loadout_AI还是玩家";
			tooltip = "$STR_Gear_Loadout_切换AI还是玩家";
			onButtonClick = "if(isNil 'Gear_Title_sw')then{Gear_Title_sw = true};Gear_Title_sw = !Gear_Title_sw; ctrlSetText [3647, localize 'STR_Gear_Loadout_换装给AI'+ (if(Gear_Title_sw)then[{name ym_gear_target},{localize 'STR_Gear_Loadout_玩家'}])]; gear_tag_obj = if(Gear_Title_sw)then[{ym_gear_target},{player}]";
			x = ym_Gear_Button1_x2;
			y = 0.803 + ym_Gear_Button_y1;
			w = ym_Gear_Button_w1;
			h = (1 / 25);
		};
		
		class ym_Gear_Button3 : A3_RscButtonMenu_1 {
			idc = 202;
			text = "$STR_Gear_Loadout_确定";
			x = ym_Gear_Button1_x3;
			y = 0.803 + ym_Gear_Button_y1;
			w = ym_Gear_Button_w2;
			h = (1 / 25);
			action = "if(isNull gear_tag_obj)exitWith{hint localize 'STR_Gear_Loadout_目标单位被删除'}; load_loadout = 1;";
		};
		
		class ym_Gear_Combo : A3_StdCombo_1 { //组合列表框
			idc = 15439;
			x = ym_Gear_Button1_x1;
			y = 0.846 + ym_Gear_Button_y1;
			w = ym_Gear_Button_w1;
			h = (1 / 25);
			colorBackground[] = {0,0,0,0.8};
			colorSelect[] = {0,0,0,1}; //{ 1, 0.5, 0, 1 }黄色
			colorSelectBackground[] = {1,1,1,0.8};
			sizeEx = 0.02 * safezoneH;
		};
		
		class ym_Gear_Button4 : A3_RscButtonMenu_1 {
			idc = 204;
			text = "$STR_Gear_Loadout_复制";
			tooltip = "$STR_Gear_Loadout_从单位复制装备";
			x = ym_Gear_Button1_x2;
			y = 0.846 + ym_Gear_Button_y1;
			w = ym_Gear_Button_w1;
			h = (1 / 25);
			action = "if(isNull gear_tag_obj)exitWith{hint localize 'STR_Gear_Loadout_目标单位被删除'}; load_from_unit = lbCurSel 15439;";
		};
		
		class ym_Gear_Button5 : A3_RscButtonMenu_1 {
			idc = -1;
			text = "$STR_Gear_Loadout_关闭";
			onButtonClick = "closeDialog 0;";
			x = ym_Gear_Button1_x3;
			y = 0.846 + ym_Gear_Button_y1;
			w = ym_Gear_Button_w2;
			h = (1 / 25);
		};
	};
};



