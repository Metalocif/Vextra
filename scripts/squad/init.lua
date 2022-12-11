--To Do
--Replace Smoke Icon with Green Smoke Icon?
--Submerged Broken Sprites


local mod = mod_loader.mods[modApi.currentMod]
local resourcePath = mod.resourcePath
local scriptPath = mod.scriptPath
local readPath = scriptPath.."squad/"

local sprites = require(scriptPath.."libs/sprites")

sprites.addMechs(
  {
    Name = "DNT_dragonfly_mech",
    Default =           { PosX = -30, PosY = -16},
    Animated =          { PosX = -30, PosY = -16, NumFrames = 8},
    Broken =            { PosX = -30, PosY = -16},
    --Submerged =         { PosX = -20, PosY = 0 }, --FLYING
    --SubmergedBroken =   { PosX = -20, PosY = -0 }, --NEEDS SUBMERGED BROKEN
    Icon =              {},
  },
  {
    Name = "DNT_stinkbug_mech",
    Default =           { PosX = -24, PosY = -3},
    Animated =          { PosX = -24, PosY = -3, NumFrames = 4},
    Broken =            { PosX = -24, PosY = -3},
    Submerged =         { PosX = -24, PosY = 2 },
    --SubmergedBroken =   { PosX = -20, PosY = -0 }, --NEEDS SUBMERGED BROKEN
    Icon =              {},
  },
  {
    Name = "DNT_fly_mech",
    Default =           { PosX = -26, PosY = -16},
    Animated =          { PosX = -26, PosY = -16, NumFrames = 4},
    Broken =            { PosX = -26, PosY = -16},
    --Submerged =         { PosX = -20, PosY = 0 }, --FLYING
    --SubmergedBroken =   { PosX = -20, PosY = -0 }, --NEEDS SUBMERGED BROKEN
    Icon =              {},
  }
)

require(readPath.."weapons")
require(readPath.."pawns")
