if (!hasInterface) exitWith {};

player addAction ["Heligame!", {[] call GRAD_heligame_fnc_start}, nil, 1.5, true, true, "", "!GRAD_Heligame_inProgress && (vehicle _target) isKindOf 'Air'"];
