--[[
local function scriptPath()
	return debug.getinfo(2, "S").source:sub(2):match("(.*[/\\])")
end
require(scriptPath().."easyEdit/easyEdit")
]]--
local function init(self)
	--init variables
	local mod = mod_loader.mods[modApi.currentMod]
	local resourcePath = mod.resourcePath
	local scriptPath = mod.scriptPath
	local options = mod_loader.currentModContent[mod.id].options
	--Add randomization for easyEdit enemy lists at least until the fix goes through in the modloader
	--Although leaving this here never hurt anything
	--https://github.com/itb-community/ITB-Easy-Edit/pull/6/commits/852c8391b25abf504b2ad817959a309824c864d1
	math.randomseed(os.time())
	math.random()

	--A list of all the vek, to hopefully make the init process smooth. This is global
	DNT_Vextra_VekList = {
		-- READ BELOW COMMENT FOR INFO
		-- {name, does it have a load (for hooks), what category it is in, does it have a tip}
		{"Mantis",false,"Core",false},
		{"Pillbug",false,"Unique",true},
		{"Thunderbug",false,"Unique",false},
		{"Silkworm",false,"Core",false},
		{"Dragonfly",false,"Unique",false},
		{"Antlion",false,"Core",false},
		{"Termites",false,"Unique",false},
		{"Stinkbug",false,"Core",true},
		{"Cockroach",false,"Unique",true},
		{"Anthill",false,"Unique",true},
		{"IceCrawler",false,"Unique",false},
		{"Fly",false,"Core",false},
		{"Ladybug",true,"None",true},
		{"Junebug",true,"None",true},
		{"Haste",false,"Leaders",false},
		{"Acid",false,"Leaders",false},
		{"Reactive",false,"Leaders",false},
		{"Nurse",false,"Leaders",false},
		{"Winter",false,"Leaders",false},
	}

	--[[ModApiExt
	if modApiExt then
		-- modApiExt already defined. This means that the user has the complete
		-- ModUtils package installed. Use that instead of loading our own one.
		DNT_Vextra_ModApiExt = modApiExt
	else
		-- modApiExt was not found. Load our inbuilt version
		local extDir = self.scriptPath.."modApiExt/"
		DNT_Vextra_ModApiExt = require(extDir.."modApiExt")
		DNT_Vextra_ModApiExt:init(extDir)
	end
	]]--
	self.libs = {}
	self.libs.modApiExt = modapiext
	DNT_Vextra_ModApiExt = self.libs.modApiExt --I'm assuming this is safe
	require(self.scriptPath.."enemies")
	require(self.scriptPath.."enemyList")
	require(self.scriptPath.."bosses")
	require(self.scriptPath.."bossList")
	require(self.scriptPath.."tips")
	require(self.scriptPath.."spawnerfix")
	-- require(self.scriptPath.."modApiExt_fix")

	--Scripts
	for _, table in ipairs(DNT_Vextra_VekList) do
		local name = table[1]
		require(self.scriptPath .. "enemies/" .. string.lower(name))
	end

	--Weapon Texts (probably not for this project

end


local function load(self,options,version)
	--DNT_Vextra_ModApiExt:load(self, optoins, version)
	--require(self.scriptPath .."weaponPreview/api"):load()
	require(self.scriptPath .. "tips"):load(self.libs.modApiExt)

	--Hooks
	for _, table in ipairs(DNT_Vextra_VekList) do
		if table[2] then
			local name = table[1]
			require(self.scriptPath .. "enemies/" .. string.lower(name)):load(DNT_Vextra_ModApiExt)
		end
	end

	--Reset Tips
	if options.resetTutorials and options.resetTutorials.enabled then
		require(self.scriptPath .."libs/tutorialTips"):ResetAll()
		options.resetTutorials.enabled = false
	end
end

local function metadata()
	modApi:addGenerationOption(
		"resetTutorials",
		"Reset Tutorial Tooltips",
		"Check to reset all tutorial tooltips for this profile.",
		{ enabled = false }
	)

	-- The O stands for Option
	-- "DNT_Vextra_O" .. name
	--Since we require you to change the list an island pulls from, there's really no point in having this, since you can edit the lists directly
	--[[
	modApi:addGenerationOption(
		"DNT_Vextra_OLadybug",
		"Enable Ladybug",
		"Puts the ladybug into the Vek pool. Restart required.",
		{enabled = true}
	)]]--
end

return {
  id = "Djinn_NAH_Tatu_Vextra",
  name = "Vextra",
	icon = "modIcon.png",
	description = "VEK + EXTRA",
	modApiVersion = "2.8.0",
	gameVersion = "1.2.83",
  version = "0.3.0", --BETA
	requirements = { "kf_ModUtils" },
	dependencies = {
		modApiExt = "1.17",
		memedit = "1.0.1",
		easyEdit = "2.0.3",
	},
	metadata = metadata,
	load = load,
	init = init
}
