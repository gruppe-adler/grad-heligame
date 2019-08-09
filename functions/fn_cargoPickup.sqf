GRAD_heligame_startTime = CBA_missionTime;

//Positon zum Spawnen des Cargos
private _cargoPos = getPos grad_heligame_cargoSpawn;
private _cargoType = selectRandom ["B_Quadbike_01_F"];
private _cargo = createVehicle [_cargoType, _cargoPos, [], 0, "CAN_COLLIDE"];
_cargo setPos _cargoPos;
GRAD_HELIGAME_CARGOOBJECT = _cargo;

// Marker auf die Cargoposition setzen.
_lz_marker = createMarker [str _cargoPos, _cargoPos];
_lz_marker setMarkerShape "ICON";
_lz_marker setMarkerType "hd_pickup";
_lz_marker setMarkerColor "colorBLUFOR";
_lz_marker setMarkerText format ["Heligame: Pickup Cargo (%1)",name player];

//Clean Up
(vehicle player) setVariable ["Grad_local_startMarker", _lz_marker];

//Eventhandler zum Slingloaden
GRAD_HELIGAME_CARGOEH = (vehicle player) addEventHandler ["RopeAttach", {
	params ["_object1", "_rope", "_object2"];
    if (_object2 == GRAD_HELIGAME_CARGOOBJECT && (count(ropes _object1) == 4) && (((ropes _object1) select 3) == _rope)) then {
		deleteMarker (_object1 getVariable "Grad_local_startMarker");
        _object1 removeEventHandler ["RopeAttach", GRAD_HELIGAME_CARGOEH];
        [(getPos GRAD_HELIGAME_CARGOOBJECT)] call GRAD_heligame_fnc_cargoLz;
    };
}];
