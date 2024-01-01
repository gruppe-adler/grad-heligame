params ["_GRAD_lz_pos", "_start_marker", "_lz_marker"];

// Zufällige Smokefarbe wählen.
private _smokeColor = selectRandom GRAD_heligame_smokeShells;
private _flareColor = selectRandom GRAD_heligame_flareShells;

// Smoke spawnen.
_GRAD_lz_smoke = _smokeColor createVehicle _GRAD_lz_pos;
if ([] call GRAD_heligame_fnc_isNight) then {
    _GRAD_lz_flare = _flareColor createVehicle (_GRAD_lz_pos vectorAdd [0,0,50]);
};
hint "Smoke is on the deck!";

// Trigger erstellen, um den Smoke zu löschen
_GRAD_lz_trg = createTrigger ["EmptyDetector", _GRAD_lz_pos];
_GRAD_lz_trg setTriggerArea [30, 30, 0, false, 30];
_GRAD_lz_trg setTriggerActivation ["ANY", "PRESENT", false];
_GRAD_lz_trg setVariable ["GRAD_local_start_marker", _start_marker];
_GRAD_lz_trg setVariable ["GRAD_local_lz_marker", _lz_marker];
_GRAD_lz_trg setTriggerTimeout [10, 15, 20, true];
_GRAD_lz_trg setTriggerStatements
  [
    "this",
    "
      ['TaskSucceeded',['','LZ abgeschlossen!']] call BIS_fnc_showNotification;
      deleteMarker (thisTrigger getVariable 'GRAD_local_start_marker');
      deleteMarker (thisTrigger getVariable 'GRAD_local_lz_marker');
      [] call GRAD_heligame_fnc_start;
      deleteVehicle thisTrigger;
    ",
    "this"
  ];

[600,[_GRAD_lz_trg]] remoteExec ["GRAD_heligame_fnc_cleanUp",2,false];
