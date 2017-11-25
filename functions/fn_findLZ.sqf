//centerpos,distance,direction,closest land,find road - 200m search dist

params ["_searchPos","_dist",["_dir",[0,360]],["_allowWater",false],["_findRoad",true],["_roadSearchDist",200]];

private ["_minDist","_maxDist"];
if (_dist isEqualType []) then {
    _minDist = _dist param [0,0];
    _maxDist = _dist param [1,1000];
} else {
    _minDist = 0;
    _maxDist = _dist;
};

_dir params [["_minDir",0],["_maxDir",360]];

private _randomPos = [0,0,0];
for [{_j=0},{_j<200},{_j=_j+1}] do {
    private _randomDist = (random (_maxDist - _minDist)) + _minDist;
    private _randomDir = (random (_maxDir - _minDir)) + _minDir;
    _randomPos = _searchPos getPos [_randomDist,_randomDir];

    if (!surfaceIsWater _randomPos || _allowWater) exitWith {};
};

if (_findRoad) then {
    _nearestRoad = [_randomPos,_roadSearchDist,[]] call BIS_fnc_nearestRoad;
    diag_log [_nearestRoad];
    if (!isNull _nearestRoad) then {_randomPos = getPos _nearestRoad};
};

_randomPos
