private [ "_loadouts_data", "_saved_loadouts", "_counter", "_unitselected", "_namestr", "_nextunit","_units_arr","_ply" ];

load_loadout = 0;
edit_loadout = 0;
load_from_unit = -1;
exit_on_load = 0;
ym_gear_target = cursorTarget;
createDialog "ym_Gear_List";

_saved_loadouts = profileNamespace getVariable "bis_fnc_saveInventory_data";
_loadouts_data = [];
_counter = 0;
if ( !isNil "_saved_loadouts" ) then {
	{
		if ( _counter % 2 == 0 ) then {
			_loadouts_data pushback _x;
		};
		_counter = _counter + 1;
	} forEach _saved_loadouts;
};

waitUntil { dialog };

if (!isNull ym_gear_target && {ym_gear_target isKindOf "man"} && {ym_gear_target != player}) then [{
    gear_tag_obj = ym_gear_target;
	ctrlSetText [3647, localize "STR_Gear_Loadout_换装给AI" + (name ym_gear_target)];
},{
    gear_tag_obj = player;
	ctrlSetText [3647, localize "STR_Gear_Loadout_换装给玩家"];
	ctrlEnable [ 5439, false ];
}];//

if ( count _loadouts_data > 0 ) then {

	{ lbAdd [15438, _x]; } forEach _loadouts_data ;

	if ( lbSize 15438 > 0 ) then {
		ctrlEnable [ 202, true ];
		lbSetCurSel [ 15438, 0 ];
	} else {
		ctrlEnable [ 202, false ];
	};

} else {
	ctrlEnable [ 202, false ];
};

gear_loadunits = [];
_units_arr = if (isMultiplayer)then [{allPlayers},{units group player}];
if !(gear_tag_obj in _units_arr) then {_units_arr pushback gear_tag_obj};
{
	//if ( !(name _x in [ "HC1", "HC2", "HC3" ]) )  then {
		gear_loadunits pushback [ name _x, _x ];
	//};
} forEach _units_arr;//获取单位到列表

if ( count gear_loadunits > 0 ) then {

	{
		_nextunit = _x select 1;
		_namestr = "";
		if(count (squadParams _nextunit) != 0) then {
			_namestr = "[" + ((squadParams _nextunit select 0) select 0) + "] ";
		};
		_namestr = _namestr + name _nextunit;

		lbAdd [ 15439, _namestr ];
		lbSetCurSel [ 15439, 0 ];
	} forEach gear_loadunits;

} else {
	ctrlEnable [ 15439, false ];
	ctrlEnable [ 204, false ];
};

((findDisplay 1543637) displayCtrl 15438) ctrlAddEventHandler [ "mouseButtonDblClick" , { exit_on_load = 1; load_loadout = 1; } ];

while { dialog && {edit_loadout == 0} } do {

	if ( load_loadout > 0 ) then {
		private _loaded_loadout = _loadouts_data select (lbCurSel 15438);
        [gear_tag_obj, [profileNamespace, _loaded_loadout]] call bis_fnc_loadInventory;
		
        if (local gear_tag_obj) then [{
            [ gear_tag_obj ] call F_correctLaserBatteries2; //镭射指示器电池
	    },{
	        [ gear_tag_obj,{
				if (!local _this) exitWith {};
				[ _this ] call F_correctLaserBatteries2;
			}] remoteExec ["BIS_fnc_call", 0, false];/////
	    }];
		
		//hint format [ localize "STR_HINT_LOADOUT_LOADED", _loaded_loadout];
		hint format [localize "STR_Gear_Loadout_装备成功载入", _loaded_loadout];//多语化
		if ( exit_on_load == 1 ) then {
			closeDialog 0;
		};
		load_loadout = 0;
	};

	if ( load_from_unit >= 0 ) then {
		_unitselected = ( gear_loadunits select load_from_unit ) select 1;
		if ( !isNull _unitselected ) then [{
			//[ gear_tag_obj,  [ _unitselected, ["repetitive"] ] call F_getLoadout2 ] call F_setLoadout2;
			
			if (local gear_tag_obj) then [{
                [ gear_tag_obj,  _unitselected call F_getLoadout2 ] call F_setLoadout2;
	        },{
	            [[gear_tag_obj, _unitselected],{
				    _tag = _this select 0;
				    if (!local _tag) exitWith {};
					[ _tag, (_this select 1) call F_getLoadout2 ] call F_setLoadout2;
				}] remoteExec ["BIS_fnc_call", 0, false];/////
	        }];
			
			hint format [localize "STR_Gear_Loadout_从AI复制装备", name _unitselected ];
		},{hint localize "STR_Gear_Loadout_无法复制AI被删除"}];
		load_from_unit = -1;
	};

	sleep 0.1;
};

if ( edit_loadout > 0 ) then {///////
	closeDialog 0;
	waitUntil { !dialog };
	if (gear_tag_obj == player) then [{
        [ "Open", true ] spawn BIS_fnc_arsenal;
    },{
		_ply = player;
		player stop true;
		{player disableAI _x} forEach ["MOVE","TARGET","AUTOTARGET","ANIM","CHECKVISIBLE"];
		player allowDamage false;
		player setCaptive true;
		player enableSimulation false;
		selectPlayer gear_tag_obj;
		sleep 0.5;
		[ "Open", true ] spawn BIS_fnc_arsenal;
		waitUntil {!isNull (uiNamespace getVariable ["RscDisplayArsenal", displayNull])};
		waitUntil {isNull (uiNamespace getVariable ["RscDisplayArsenal", displayNull]) || {!alive gear_tag_obj}};//
		if (isNull _ply || {!alive _ply}) exitWith {hint localize "STR_Gear_Loadout_返回失败原先扮演的单位死亡或被删除";};
		selectPlayer _ply;
		player stop false;
		{player enableAI _x} forEach ["MOVE","TARGET","AUTOTARGET","ANIM","CHECKVISIBLE"];
		player allowDamage true;
		player enableSimulation true;
		sleep 3;//
		player setCaptive false;//
    }];
};





