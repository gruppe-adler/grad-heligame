//centerpos,distance,direction,closest land,find road - 200m search dist

params [
    ["_searchPos", [0, 0, 0]],
    ["_dist", [500, 2000, 3500]],
    ["_dir",[0, 180, 360]],
    ["_allowWater", false],
    ["_findRoad", true],
    ["_roadSearchDist", 200]
];

private _isOnWorld = {
    _this params ["_x", "_y"];
    _x > 0 && _x < worldSize && _y > 0 && _y < worldSize
};

private _randomPos = [0, 0, 0];
for [{_j=0},{_j<200},{_j=_j+1}] do {
    private _randomDist = random _dist;
    private _randomDir = random _dir;
    _randomPos = _searchPos getPos [_randomDist, _randomDir];

    if ((!surfaceIsWater _randomPos || _allowWater) && _randomPos call _isOnWorld) exitWith {};
};

if (_findRoad) then {
    _nearestRoad = [_randomPos,_roadSearchDist,[]] call BIS_fnc_nearestRoad;
    diag_log [_nearestRoad];
    if (!isNull _nearestRoad) then {_randomPos = getPos _nearestRoad};
};

_randomPos
