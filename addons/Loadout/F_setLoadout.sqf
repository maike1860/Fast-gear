
_unit = _this select 0;
_Gear = _this select 1;

//if(count _Gear == 0) exitWith {};
_primary = _Gear select 0;
_launcher = _Gear select 1;
_handgun = _Gear select 2;
_magazines = _Gear select 3;
_uniform = _Gear select 4;
_vest = _Gear select 5;
_backpack = _Gear select 6;
_items = _Gear select 7;
_primitems = _Gear select 8;
_secitems = _Gear select 9;
_handgunitems = _Gear select 10;
_uitems = _Gear select 11;
_vitems = _Gear select 12;
_bitems = _Gear select 13;
_hg = _Gear select 14;
_gog = _Gear select 15;

//Strip the unit down
removeheadGear _unit;
removeGoggles _unit;
removeBackpack _unit;
removeUniform _unit;
removeVest _unit;
removeAllAssignedItems _unit;
removeAllWeapons _unit;

//Add the gear
if(_uniform != "") then {_unit forceAddUniform _uniform;};
if(_vest != "") then {_unit addVest _Vest;};
if(_backpack != "") then {_unit addBackpack _backpack;};
removeAllItemsWithMagazines _unit;

if(count _magazines > 0) then {{_unit addMagazine _x} forEach _magazines;};

if(_primary != "") then {_unit addWeapon _primary; removeAllPrimaryWeaponItems _unit; {_unit addPrimaryWeaponItem _x} forEach _primitems;};
if(_launcher != "") then {_unit addWeapon _launcher; {_unit addSecondaryWeaponItem _x} forEach _secitems;};
if(_handgun != "") then {_unit addWeapon _handgun; removeAllHandgunItems _unit; {_unit addHandgunItem _x} forEach _handgunitems;};

_unit addHeadGear _hg;
_unit addGoggles _gog;

if (_uniform != "")then{{_unit addItemtouniform _x} forEach _uitems;};
if (_vest != "")then{{_unit addItemToVest _x} forEach _vitems;};
if (_backpack != "")then{{_unit addItemToBackpack _x} forEach _bitems;};

{_unit addWeapon _x} forEach _items;

if (primaryWeapon _unit != "")then{_unit selectWeapon (primaryWeapon _unit)};








