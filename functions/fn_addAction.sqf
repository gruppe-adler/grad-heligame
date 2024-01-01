assert(hasInterface);

player addAction [
    "<t color='#EC9A19'>Heligame!</t>",
    {[false] call GRAD_heligame_fnc_start},
    nil, 1.5, true, true, "",
    "true && " + str {
        !GRAD_Heligame_inProgress &&
            (vehicle _target) isKindOf 'Helicopter' &&
            (local (vehicle _target))
    }
];
player addAction [
    "<t color='#EC9A19'>Heligame with cargo!</t>",
    {[true] call GRAD_heligame_fnc_start},
    nil, 1.5, true, true, "",
    "true && " + str {
        private _vic = vehicle _target;
        !GRAD_Heligame_inProgress &&
            _vic isKindOf 'Helicopter' &&
            (local _vic) &&
            _vic call GRAD_heligame_fnc_canSlingload
    }
];

player addAction [
    "<t color='#ff0000'>Break ENG</t>",
    {(vehicle player) setHitPointDamage ["HitEngine", 1.0];},
    nil, 1.0, true, true, "",
    "true && " + str {
        private _vic = (vehicle _target);
        (_vic isKindOf "Helicopter") && (local _vic) && {(_vic getHitPointDamage "HitEngine") == 0}
    }
];
player addAction [
    "<t color='#ff0000'>Break ATRQ</t>",
    {(vehicle player) setHitPointDamage ["HitVRotor", 1.0];},
    nil, 1.0, true, true, "",
    "true && " + str {
        private _vic = (vehicle _target);
        (_vic isKindOf "Helicopter") && (local _vic) && {(_vic getHitPointDamage "HitVRotor") == 0}
    }
];
player addAction [
    "<t color='#00ff00'>Repair helicopter</t>",
    {(vehicle player) setDamage 0;},
    nil, 1.0, true, true, "",
    "true && " + str {
        private _vic = (vehicle _target);
        (_vic isKindOf "Helicopter") && (local _vic)
    }
];
