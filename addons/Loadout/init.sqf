F_correctLaserBatteries2 = compileFinal preprocessFileLineNumbers "\Loadout\F_correctLaserBatteries.sqf";
F_getLoadout2 = compileFinal preprocessFileLineNumbers "\Loadout\F_getLoadout.sqf";
F_setLoadout2 = compileFinal preprocessFileLineNumbers "\Loadout\F_setLoadout.sqf";
if (isMultiplayer) then {
	publicVariable "F_correctLaserBatteries2";
	publicVariable "F_getLoadout2";
	publicVariable "F_setLoadout2";
};

ym_Gear_Act = 
{
	/*private ["_target"];
	_return = false;
	_target = ;//
	if((!isNull _target)&&{(_target distance player)<5}&&{alive _target}&&{vehicle player == player})then
	{
		_return = true;
	};//滚轮菜单显示条件(可选)*/
	_return = true;//按条件显示则删除这行
	_return
};

waitUntil {!isNull player};
[]spawn
{
private ["_ply", "_ply2", "_idx"];
_idx = -1;
while {true} do
{
   _ply = vehicle player;
   
   if (_idx == -1) then
   {
        _idx = _ply addAction [format ["<t color='#FF8c00'>%1</t>", localize "STR_Gear_Loadout_快速换装"], "\Loadout\open_dialog.sqf", [], -100, false, true, "", "call ym_Gear_Act"];
			
        _ply2 = _ply;
   };
   if (_ply != _ply2) then
   {
        _ply2 removeAction _idx;
	    _idx = -1;
   };
   
   sleep 1;
};};

















