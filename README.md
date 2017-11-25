# GRAD Heligame
Generates random LZs to practice your landing skills.

## Dependencies
* [CBA_A3](https://github.com/CBATeam/CBA_A3)

## Installation
Add the following lines of code to the `description.ext`:

```sqf
#define MODULES_DIRECTORY node_modules
class CfgFunctions {
    #include "node_modules\grad-heligame\cfgFunctions.hpp"
};
```
If you want to name the folder differently than *node_modules*, make sure to change the MODULES_DIRECTORY define as well.

### Manually
1. Create a folder in your mission root folder and name it `node_modules`. Then create one inside there and call it `grad-heligame`.
2. Download the latest release and put it into the directory you just created.

### Via `npm`
_for details about what npm is and how to use it, look it up on [npmjs.com](https://www.npmjs.com/)_

1. Install package `grad-heligame` : `npm install --save grad-heligame`


## Usage
Get into any helicopter and execute the *Heligame!* mouse wheel action. Fly to the LZ (marked on map), land on the smoke, wait until the next LZ is generated. Repeat until you can land like a pro. Will end automatically when you stop completing your LZs.
