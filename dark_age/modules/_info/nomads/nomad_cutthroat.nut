//Bandit Thug
//Lvl 5 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.NomadCutthroat <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 10,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.NomadCutthroat] <- {
    Level = 5,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
    ],
	LevelUps = [
		["Health", 4, 0, 2],
		["Fatigue", 4, 0, 2],
	],
    Trait = [],
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

::B.Info[::Const.EntityType.NomadCutthroat].Builds["1H Shield"] <- {
	Name = "1H Shield",
	Pattern = [
        ["scripts/skills/perks/perk_rotation"],
        ["T", 3],
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4],
    ],
	LevelUps = [
		["Health", 4, 0, 2],
		["Ranged Defense", 4, 0, 2],
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

