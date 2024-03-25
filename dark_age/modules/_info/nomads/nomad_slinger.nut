//Lvl 5 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.NomadSlinger <- {
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

::B.Info[::Const.EntityType.NomadSlinger] <- {
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
			"scripts/items/weapons/oriental/nomad_sling",
		]
	],
	Builds = {},
	BuildsChance = 0
};