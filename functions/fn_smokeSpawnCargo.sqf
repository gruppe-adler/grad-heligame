params ["_GRAD_lz_pos", "_lz_marker"];

// Zufällige Smokefarbe wählen.
private _smokeColor = selectRandom GRAD_heligame_smokeShells;
private _flareColor = selectRandom GRAD_heligame_flareShells;

// Smoke spawnen.
_GRAD_lz_smoke = _smokeColor createVehicle _GRAD_lz_pos;
if ([] call GRAD_heligame_fnc_isNight) then {
    _GRAD_lz_flare = _flareColor createVehicle (_GRAD_lz_pos vectorAdd [0,0,50]);
};
hint "Smoke is on the deck!";
