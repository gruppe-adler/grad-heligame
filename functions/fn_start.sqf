GRAD_heligame_inProgress = true;
private _heloType = typeOf (vehicle player);
if (selectRandom [true,false] && (isNumber (configFile >> "CfgVehicles" >> _heloType >> "slingLoadMaxCargoMass")) && ((getNumber (configFile >> "CfgVehicles" >> _heloType >> "slingLoadMaxCargoMass")) > 0)) then {
    hint "Heligame Cargo beginnt!";
    [] call GRAD_heligame_fnc_cargoPickup;
}else{
    hint "Heligame beginnt!";
    [] call GRAD_heligame_fnc_lz;
};


[{CBA_missionTime - GRAD_heligame_startTime > 600}, {
    GRAD_heligame_inProgress = false;
    hint "Heligame zu Ende!";
}, []] call CBA_fnc_waitUntilAndExecute;
