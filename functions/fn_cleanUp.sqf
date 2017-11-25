params ["_waitTime","_objects"];
[{
    {
        if (_x isEqualType objNull && {!isNull _x}) then {
            deleteVehicle _x;
        } else {
            if (_x isEqualType "") then {
                deleteMarker _x;
            };
        };
    } forEach _this;
}, _objects, _waitTime] call CBA_fnc_waitAndExecute;
