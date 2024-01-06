GRAD_heligame_startTime = CBA_missionTime;

// Random Position für LZ suchen.

(getPos player) params ["_playerPosX","_playerPosY"];
private _distToBorder = (abs(worldSize - _playerPosX)) min (abs(worldSize - _playerPosY));
_GRAD_lz_pos = [getPos player,[500,((_distToBorder min 5000) max 1000)],[0,360],false,true,200] call grad_heligame_fnc_findLZ;

//centerpos,distance,direction,closest land,find road - 200m search dist

// Marker auf die Startposition setzen.
_start_marker_pos = getpos player;
_start_marker = createMarker [str _start_marker_pos, player];
_start_marker SetMarkerShape "ICON";
_start_marker setMarkerType "hd_start";
_start_marker setMarkerColor "colorBLUFOR";
_start_marker setMarkerText format ["%1 (Heligame)",name player];

// Orientieren des Startmarkers in die richtige Richtung
_marker_winkel = player getDir _GRAD_lz_pos;
_start_marker setMarkerDir _marker_winkel;

// Marker auf die Smokeposition setzen.
_lz_marker = createMarker [str _GRAD_lz_pos, _GRAD_lz_pos];
_lz_marker setMarkerShape "ICON";
_lz_marker setMarkerType "hd_pickup";
_lz_marker setMarkerColor "colorBLUFOR";
_lz_marker setMarkerText format ["%1 (Heligame)",name player];

// Task für den Spieler erstellen
["TaskAssigned",["LZ","Flieg zur LZ!"]] call BIS_fnc_showNotification;

// Trigger erstellen, um Smoke zu werfen.
_GRAD_smoke_trg = createTrigger ["EmptyDetector", _GRAD_lz_pos];
_GRAD_smoke_trg setTriggerArea [1500, 1500, 0, false, 500];
_GRAD_smoke_trg setTriggerActivation ["ANY", "PRESENT", false];
_GRAD_smoke_trg setVariable ["_GRAD_localtemp", _GRAD_lz_trg];
_GRAD_smoke_trg setTriggerStatements
[
"player in thisList || (vehicle player) in thisList",
format ["
   [%1, '%2', '%3'] call GRAD_heligame_fnc_smokespawn;
   deleteVehicle thisTrigger;
",_GRAD_lz_pos, _start_marker, _lz_marker],
"this"
];

[600,[_GRAD_smoke_trg,_start_marker,_lz_marker]] remoteExec ["GRAD_heligame_fnc_cleanUp",2,false];
