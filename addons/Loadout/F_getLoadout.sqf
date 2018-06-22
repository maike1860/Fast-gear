//Old format / code
_primary = primaryWeapon _this;
_launcher = secondaryWeapon _this;
_handgun = handGunWeapon _this;
_magazines = [];
_uniform = uniform _this;
_vest = vest _this;
_backpack = backpack _this;
_uitems = uniformItems _this;
_vitems = VestItems _this;
_bitems = backpackItems _this;
_items = assignedItems _this;
_primitems = primaryWeaponItems _this;
_secitems = secondaryWeaponItems _this;
_handgunitems = handGunItems _this;

_hg = headGear _this;
_gog = goggles _this;

if(count (primaryWeaponMagazine _this) > 0) then
{
	{
		_magazines set[count _magazines,_x];
	} foreach (primaryWeaponMagazine _this);
};

if(count (secondaryWeaponMagazine _this) > 0) then
{
	{
		_magazines set[count _magazines,_x];
	} foreach (secondaryWeaponMagazine _this);
};

if(count (handgunMagazine _this) > 0) then
{
	{
		_magazines set[count _magazines,_x];
	} foreach (handgunMagazine _this);
};

//Hard code for Laser Desigantor batteries
_curWep = currentWeapon _this;
{
    if(_this hasWeapon _x) then
    {
	    _this selectWeapon _x;
	    if(currentMagazine _this != "") then {_magazines set[count _magazines,(currentMagazine _this)]};
    };
} forEach ["Laserdesignator","Laserdesignator_01_khk_F","Laserdesignator_02","Laserdesignator_03","Laserdesignator_02_ghex_F","CUP_LRTV","CUP_SOFLAM"];

_this selectWeapon _curWep;


[_primary,_launcher,_handgun,_magazines,_uniform,_vest,_backpack,_items,_primitems,_secitems,_handgunitems,_uitems,_vitems,_bitems,_hg,_gog]











