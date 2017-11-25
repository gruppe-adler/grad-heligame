GRAD_Heligame_inProgress = false;

if (hasInterface) then {
    [{!isNull player}, {
        [] call GRAD_heligame_fnc_addAction;
        player addEventHandler ["Respawn", {[] call GRAD_heligame_fnc_addAction}];
    },[]] call CBA_fnc_waitUntilAndExecute;
};
