//TODO: desert_devil
//Lvl 6 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.NomadCutthroat <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 35,
	Stamina = 95,
	MeleeSkill = 56,
	RangedSkill = 40,
	MeleeDefense = 3,
	RangedDefense = 3,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.NomadCutthroat] <- {
    Level = 6,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
    ],
	LevelUps = [
		["Health", 5, 0, 2],
		["Melee Skill", 5, 0, 2],
		["Melee Defense", 5, 0, 2],
	],
    Trait = [],
    Outfit = [
		[
			1,
			"bandit_thug_outfit_00"
		]
	],
	Loadout = [
		[
			"scripts/items/weapons/oriental/saif",
		],
		[
			"scripts/items/weapons/oriental/nomad_mace",
		],
		[
			"scripts/items/weapons/militia_spear",
		]
	],
	Builds = {},
	BuildsChance = 15
};

::B.Info[::Const.EntityType.BanditRaider].Builds["1H Shield"] <- {
	Name = "1H Shield",
	Pattern = [
        ["scripts/skills/perks/perk_rotation"],
        ["T", 3],
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4],
        ["T", 5],
    ],
	LevelUps = [
		["Health", 5, 0, 2],
		["Melee Skill", 5, 0, 2],
		["Melee Defense", 5, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/oriental/saif",
			"scripts/items/shields/oriental/southern_light_shield"
		],
		[
			"scripts/items/weapons/oriental/nomad_mace",
			"scripts/items/shields/oriental/southern_light_shield"
		],
		[
			"scripts/items/weapons/militia_spear",
			"scripts/items/shields/oriental/southern_light_shield"
		],
	]
};

