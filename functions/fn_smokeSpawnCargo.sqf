params ["_GRAD_lz_pos", "_lz_marker"];

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
 _flareColor = selectRandom
    [
      "F_40mm_Green",
      "F_40mm_White",
      "F_40mm_Red",
      "F_40mm_Cir",
      "F_40mm_Yellow"
    ];

// Smoke spawnen.
_GRAD_lz_smoke = _smokeColor createVehicle _GRAD_lz_pos;
if (daytime >= 19.5 && daytime <= 4.5) then {
    _GRAD_lz_flare = _flareColor createVehicle (_GRAD_lz_pos vectorAdd [0,0,50]);
};
hint "Smoke is on the deck!";
