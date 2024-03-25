::Const.Tactical.Actor.GoblinWolfrider <- {
	XP = 100,
	ActionPoints = 13,
	Hitpoints = 80,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 160,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};

::B.Info[::Const.EntityType.GoblinWolfrider] <- {
    Level = 8,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
        ["D", 6],
        ["T", 3],
    ],
	LevelUps = [
		["Fatigue", 7, 0, 2],
		["Ranged Defense", 7, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/goblin_spear",
		],
		[
			"scripts/items/weapons/greenskins/goblin_falchion",
		]
	],
	Builds = {},
	BuildsChance = 0
};