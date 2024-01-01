private _heloType = typeOf _this;
private _cfgSlingLoadMaxCargoMass = configFile >> "CfgVehicles" >> _heloType >> "slingLoadMaxCargoMass";

(isNumber _cfgSlingLoadMaxCargoMass) && ((getNumber _cfgSlingLoadMaxCargoMass) > 0)
