params ["_GRAD_lz_pos", "_start_marker", "_lz_marker"];

// Zufällige Smokefarbe wählen.
_smokeColor = selectRandom
  [
    "SmokeShellBlue",
    "SmokeShellOrange",
    "SmokeShellYellow",
    "SmokeShellRed",
    "SmokeShellPurple",
    "SmokeShellGreen"
  ];

// Smoke spawnen.
_GRAD_lz_smoke = _smokeColor createVehicle _GRAD_lz_pos;
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
      [] call GRAD_heligame_fnc_lz;
      deleteVehicle thisTrigger;
    ",
    "this"
  ];

[600,[_GRAD_lz_trg]] remoteExec ["GRAD_heligame_fnc_cleanUp",2,false];
