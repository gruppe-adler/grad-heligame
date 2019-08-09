
if (!hasInterface) exitWith {};

player addAction ["<t color='#EC9A19'>Heligame!</t>", {[] call GRAD_heligame_fnc_start}, nil, 1.5, true, true, "", "!GRAD_Heligame_inProgress && (vehicle _target) isKindOf 'Helicopter' && (local (vehicle _target))"];

{
    _x params [["_title", ""], ["_action", {}], ["_condition",{true}]];
    player addAction [
        _title,
        _action,
        nil, 1.0, true, true, "",
        format ["_vic = (vehicle _target); (_vic isKindOf ""Helicopter"") && (local _vic) && (_this call %1)", _condition]
    ];
} forEach [
    [
        "<t color='#ff0000'>Break ENG</t>",
        {(vehicle player) setHitPointDamage ["HitEngine", 1.0];},
        {(_vic getHitPointDamage "HitEngine") == 0}
    ],
    [
        "<t color='#ff0000'>Break ATRQ</t>",
        {(vehicle player) setHitPointDamage ["HitVRotor", 1.0];},
        {(_vic getHitPointDamage "HitVRotor") == 0}
    ],
    [
        "<t color='#00ff00'>Repair helicopter</t>",
        {(vehicle player) setDamage 0;}
    ]
];
