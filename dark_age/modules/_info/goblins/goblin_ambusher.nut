::Const.Tactical.Actor.GoblinAmbusher <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 40,
	Bravery = 55,
	Stamina = 100,
	MeleeSkill = 60,
	RangedSkill = 65,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.GoblinAmbusher] <- {
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
		["Ranged Skill", 5, 0, 2],
		["Melee Defense", 5, 0, 2],
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