::Const.Tactical.Actor.GoblinAmbusher <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.GoblinAmbusher] <- {
    Level = 5,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
    ],
	LevelUps = [
		["Initiative", 4, 0, 2],
		["Fatigue", 4, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/goblin_heavy_bow",
		],
		[
			"scripts/items/weapons/greenskins/goblin_bow",
		]
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_goblin_heavy_bow",
		]
	],
	Builds = {},
	BuildsChance = 0
};