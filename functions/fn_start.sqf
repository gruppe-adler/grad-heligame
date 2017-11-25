GRAD_heligame_inProgress = true;
hint "Heligame beginnt!";
[] call GRAD_heligame_fnc_lz;

[{CBA_missionTime - GRAD_heligame_startTime > 600}, {
    GRAD_heligame_inProgress = false;
    hint "Heligame zu Ende!";
}, []] call CBA_fnc_waitUntilAndExecute;
