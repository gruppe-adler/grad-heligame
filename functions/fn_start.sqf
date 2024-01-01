params [
    ["_withCargo", false, [false]]
];

if (isNil "GRAD_heligame_smokeShells") then {
    GRAD_heligame_smokeShells = [
        "SmokeShellBlue",
        "SmokeShellOrange",
        "SmokeShellYellow",
        "SmokeShellRed",
        "SmokeShellPurple",
        "SmokeShellGreen"
  ];
};
if (isNil "GRAD_heligame_flareShells") then {
    GRAD_heligame_flareShells = [
      "F_40mm_Green",
      "F_40mm_White",
      "F_40mm_Red",
      "F_40mm_Cir",
      "F_40mm_Yellow"
    ];
};
if (isNil "GRAD_heligame_smokeDist") then {
    GRAD_heligame_smokeDist = 1000;
};
if (isNil "GRAD_heligame_LZ_distance") then {
    GRAD_heligame_LZ_distance = [1000, 1500, 6000];
};
if (isNil "GRAD_heligame_timeout") then {
    GRAD_heligame_timeout = 600;
};

GRAD_heligame_inProgress = true;
if (_withCargo) then {
    hint "Heligame Cargo beginnt!";
    [] call GRAD_heligame_fnc_cargoPickup;
}else{
    hint "Heligame beginnt!";
    [] call GRAD_heligame_fnc_lz;
};


[{CBA_missionTime - GRAD_heligame_startTime > GRAD_heligame_timeout}, {
    GRAD_heligame_inProgress = false;
    hint "Heligame zu Ende!";
}, []] call CBA_fnc_waitUntilAndExecute;
