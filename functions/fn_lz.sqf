GRAD_heligame_startTime = CBA_missionTime;

// Random Position für LZ suchen.

(getPos player) params ["_playerPosX","_playerPosY"];
private _GRAD_lz_pos = [getPos player, GRAD_heligame_LZ_distance] call grad_heligame_fnc_findLZ;

// Marker auf die Startposition setzen.
private _start_marker_pos = getPos player;
private _start_marker = createMarker [str _start_marker_pos, player];
_start_marker setMarkerShape "ICON";
_start_marker setMarkerType "hd_start";
_start_marker setMarkerColor "colorBLUFOR";
_start_marker setMarkerText format ["%1 (Heligame)", name player];

// Orientieren des Startmarkers in die richtige Richtung
_marker_winkel = player getDir _GRAD_lz_pos;
_start_marker setMarkerDir _marker_winkel;

// Marker auf die Smokeposition setzen.
private _lz_marker = createMarker ["grad_heligame_" + str _GRAD_lz_pos, _GRAD_lz_pos];
_lz_marker setMarkerShape "ICON";
_lz_marker setMarkerType "hd_pickup";
_lz_marker setMarkerColor "colorBLUFOR";
_lz_marker setMarkerText format ["%1 (Heligame)",name player];

// Task für den Spieler erstellen
["TaskAssigned",["LZ","Flieg zur LZ!"]] call BIS_fnc_showNotification;

// Trigger erstellen, um Smoke zu werfen.
GRAD_heligame_smokeTrigger = createTrigger ["EmptyDetector", _GRAD_lz_pos];
GRAD_heligame_smokeTrigger setTriggerArea [GRAD_heligame_smokeDist, GRAD_heligame_smokeDist, 0, false, 500];
GRAD_heligame_smokeTrigger setTriggerActivation ["ANY", "PRESENT", false];
GRAD_heligame_smokeTrigger setVariable ["_GRAD_localtemp", _GRAD_lz_trg];
GRAD_heligame_smokeTrigger setTriggerStatements
[
   "player in thisList || (vehicle player) in thisList",
   format ["
      [%1, '%2', '%3'] call GRAD_heligame_fnc_smokespawn;
      deleteVehicle thisTrigger;
   ",_GRAD_lz_pos, _start_marker, _lz_marker],
   "this"
];

[600, [GRAD_heligame_smokeTrigger,_start_marker,_lz_marker]] remoteExec ["GRAD_heligame_fnc_cleanUp",2,false];
