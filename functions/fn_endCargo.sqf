params ["_marker"];

['TaskSucceeded',['','Cargo LZ abgeschlossen!']] call BIS_fnc_showNotification;
deleteVehicle GRAD_HELIGAME_CARGOOBJECT;
deleteMarker _marker;
[] call GRAD_heligame_fnc_start;
