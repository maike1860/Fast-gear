#include "\Loadout\a3_common.hpp"
#include "\Loadout\dialog.hpp"


class CfgPatches
{
    class Gear_Loadout
    {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1;
        requiredAddons[] = {"CBA_Extended_EventHandlers"};
    };
};

class Extended_PreInit_EventHandlers
{
    Init = "[] execVM '\Loadout\init.sqf'";
};
























