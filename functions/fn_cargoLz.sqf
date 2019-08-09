params ["_cargoPos"];

// Random Position für LZ suchen.
_cargoPos params ["_cargoPosX","_cargoPosY"];
private _distToBorder = (abs(worldSize - _cargoPosX)) min (abs(worldSize - _cargoPosY));

//centerpos,distance,direction,closest land,find road - 200m search dist
_GRAD_lz_pos = [_cargoPos,[500,((_distToBorder min 6000) max 1500)],[0,360],false,true,200] call grad_heligame_fnc_findLZ;

(vehicle player) setVariable ["Grad_local_cargoDropOff", _GRAD_lz_pos];

//Eventhandler zum Slingloaden
GRAD_HELIGAME_CARGOEHBREAK = (vehicle player) addEventHandler ["RopeBreak", {
	params ["_object1", "_rope", "_object2"];
    if (_object2 == GRAD_HELIGAME_CARGOOBJECT && ((_object1 distance2D (_object1 getVariable "Grad_local_cargoDropOff"))<= 30)) then {
        _object1 removeEventHandler ["RopeBreak", GRAD_HELIGAME_CARGOEHBREAK];
        [(_object1 getVariable "Grad_local_cargoEndMarker")] call GRAD_heligame_fnc_endCargo;
    }else{
		hint "Du musst das Objekt näher zur LZ fliegen";
	};
}];

// Marker auf die Smokeposition setzen.
_lz_marker = createMarker [str _GRAD_lz_pos, _GRAD_lz_pos];
_lz_marker setMarkerShape "ICON";
_lz_marker setMarkerType "hd_pickup";
_lz_marker setMarkerColor "colorBLUFOR";
_lz_marker setMarkerText format ["Heligame: Cargo Drop Off (%1)",name player];

(vehicle player) setVariable ["Grad_local_cargoEndMarker", _lz_marker];

// Task für den Spieler erstellen
["TaskAssigned",["LZ","Flieg zur Cargo LZ!"]] call BIS_fnc_showNotification;

// Trigger erstellen, um Smoke zu werfen.
_GRAD_smoke_trg = createTrigger ["EmptyDetector", _GRAD_lz_pos];
_GRAD_smoke_trg setTriggerArea [800, 800, 0, false, 500];
_GRAD_smoke_trg setTriggerActivation ["ANY", "PRESENT", false];
_GRAD_smoke_trg setVariable ["_GRAD_localtemp", _GRAD_lz_trg];
_GRAD_smoke_trg setTriggerStatements
[
"this",
format ["
   [%1, '%2'] call GRAD_heligame_fnc_smokespawnCargo;
   deleteVehicle thisTrigger;
",_GRAD_lz_pos, _lz_marker],
"this"
];

[600,[_GRAD_smoke_trg,GRAD_HELIGAME_CARGOOBJECT,_lz_marker]] remoteExec ["GRAD_heligame_fnc_cleanUp",2,false];
